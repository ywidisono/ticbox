package ticbox

import grails.converters.JSON
import grails.plugin.shiro.oauth.FacebookOAuthToken
import grails.plugin.shiro.oauth.GoogleOAuthToken
import grails.plugin.shiro.oauth.TwitterOAuthToken
import org.apache.shiro.SecurityUtils
import org.apache.shiro.authc.AuthenticationException
import org.apache.shiro.authc.UsernamePasswordToken
import org.apache.shiro.crypto.hash.Sha256Hash
import org.apache.shiro.web.util.WebUtils
import org.apache.shiro.grails.ConfigUtils
import org.scribe.model.Token
import uk.co.desirableobjects.oauth.scribe.OauthService

class AuthController {
    def respondentService
    def oauthService

    def index = { redirect(action: "login", params: params) }

    def login = {
        return [username: params.username, rememberMe: (params.rememberMe != null), targetUri: params.targetUri]
    }

    def signIn = {
        def authToken = new UsernamePasswordToken(params.username, params.password as String)

        // Support for "remember me"
        if (params.rememberMe) {
            authToken.rememberMe = true
        }

        // If a controller redirected to this page, redirect back
        // to it. Otherwise redirect to the root URI.
        def targetUri = params.targetUri ?: "/"

        // Handle requests saved by Shiro filters.
        def savedRequest = WebUtils.getSavedRequest(request)
        if (savedRequest) {
            targetUri = savedRequest.requestURI - request.contextPath
            if (savedRequest.queryString) targetUri = targetUri + '?' + savedRequest.queryString
        }

        try {
            // Perform the actual login. An AuthenticationException
            // will be thrown if the username is unrecognised or the
            // password is incorrect.
            SecurityUtils.subject.login(authToken)

            log.info "Redirecting to '${targetUri}'."
            redirect(uri: targetUri)
        }
        catch (AuthenticationException ex) {
            // Authentication failed, so display the appropriate message
            // on the login page.
            log.info "Authentication failure for user '${params.username}'."
            flash.message = message(code: "login.failed")

            // Keep the username and "remember me" setting so that the
            // user doesn't have to enter them again.
            def m = [username: params.username]
            if (params.rememberMe) {
                m["rememberMe"] = true
            }

            // Remember the target URI too.
            if (params.targetUri) {
                m["targetUri"] = params.targetUri
            }

            // Now redirect back to the login page.
            redirect(uri: "/", params: m)
        }
    }

    def signOut = {
        // Log the user out of the application.
        def principal = SecurityUtils.subject?.principal
        SecurityUtils.subject?.logout()
        // For now, redirect back to the home page.
        if (ConfigUtils.getCasEnable() && ConfigUtils.isFromCas(principal)) {
            redirect(uri: ConfigUtils.getLogoutUrl())
        } else {
            redirect(uri: "/")
        }
        ConfigUtils.removePrincipal(principal)
    }

    def unauthorized = {
        flash.message = message(code: "general.auth.notauthorized.message")
        redirect(uri: "/")
    }

    def linkAccount = {
        def cloudUserInfo
        def cloudResponse
        def user
        Token token
        String sessionKey
        def authToken = session["shiroAuthToken"]
        try {
            def adminRole = Role.findByName("Surveyor")
            if (authToken instanceof FacebookOAuthToken) {
                sessionKey = oauthService.findSessionKeyForAccessToken('facebook')
                token = session[sessionKey]
                cloudResponse = oauthService.getFacebookResource(token, 'https://graph.facebook.com/me')
                cloudUserInfo = JSON.parse(cloudResponse.body)
                user = User.findByUsername(cloudUserInfo.username)
                if (user == null) {
                    user = new User(username: cloudUserInfo.username, passwordHash: new Sha256Hash(cloudUserInfo.username).toHex(), email: cloudUserInfo.email)
                }
            } else if (authToken instanceof TwitterOAuthToken) {
                user = User.findByUsername(authToken.principal)
                if (user == null) {
                    user = new User(username: authToken.principal, passwordHash: new Sha256Hash(authToken.principal).toHex())
                }
            } else if (authToken instanceof GoogleOAuthToken) {
                sessionKey = oauthService.findSessionKeyForAccessToken('google')
                token = session[sessionKey]
                cloudResponse = oauthService.getGoogleResource(token, 'https://www.googleapis.com/oauth2/v2/userinfo')
                cloudUserInfo = JSON.parse(cloudResponse.body)
                user = User.findByUsername(cloudUserInfo.name)
                if (user == null) {
                    user = new User(username: cloudUserInfo.name, passwordHash: new Sha256Hash(cloudUserInfo.name).toHex(), email: cloudUserInfo.email)
                }
            }
            user.addToRoles(adminRole).save()
            forward controller: "shiroOAuth", action: "linkAccount", params: [userId: user.id, targetUri: "/"]
        } catch (Exception e) {
            flash.message = message(code: "app.error.sso.message") + ". " + e.message
            redirect(uri: "/")
        }
    }

    def registerSurveyor = {}

    def registerRespondent = {
        def profileItemList = respondentService.getProfileItems()
        [profileItemList : profileItemList, ref: params.ref]
    }

    def register = {
        def newUser
        def errorAction
        try {
            if ("surveyor".equalsIgnoreCase(params.userType)) {
                errorAction = "registerSurveyor"
                Role surveyorRole = Role.findByName("Surveyor")
                newUser = new User(username: params.username, passwordHash: new Sha256Hash(params.password).toHex(), email: params.email)
                newUser.addToRoles(surveyorRole).save()
                new SurveyorProfile(
                        email: params.email,
                        companyName: params.company,
                        userAccount: newUser
                ).save()
            } else if ("respondent".equalsIgnoreCase(params.userType)) {
                errorAction = "registerRespondent"
                def respondentRole = Role.findByName("Respondent")
                def respondentProfile = respondentService.getRespondentProfileFromParams(params)
                newUser = new User(username: params.username, passwordHash: new Sha256Hash(params.password).toHex(), email: params.email, company: params.company, respondentProfile: respondentProfile)
                newUser.addToRoles(respondentRole).save()
                respondentService.processReference(params.referrer, newUser)
            }

            if (newUser.hasErrors()) {
                throw new Exception(newUser.errors.allErrors.first())
            }

            flash.message = message(code: "general.create.success.message")
            redirect(uri: "/")
        } catch (Exception e) {
            flash.message = message(code: "general.create.failed.message")
            log.error(e.message, e)
        }
        forward(action: errorAction)
    }

    def changePassword = {
        def result
        def success = false
        def message
        if (params.id) {
            if (params.oldPassword && params.newPassword && params.confirmPassword) {
                if (params.newPassword == params.confirmPassword) {
                    def oldPasswordHash = new Sha256Hash(params.oldPassword).toHex()
                    def newPasswordHash = new Sha256Hash(params.newPassword).toHex()
                    def user = User.findByIdAndPasswordHash(params.id, oldPasswordHash)
                    if (user) {
                        user.passwordHash = newPasswordHash
                        user.save()
                        success = true
                        message = "Password successfully changed"
                    } else {
                        message = "Invalid password"
                    }
                } else {
                    message = "New password mismatch"
                }
            } else {
                message = "Please provide all details"
            }
        } else {
            message = "invalid user"
        }
        result = [success: success, message: message]
        render result  as JSON
    }

}
