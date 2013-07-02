package ticbox

import com.sun.org.apache.xerces.internal.impl.dv.util.Base64
import grails.converters.JSON
import org.apache.shiro.SecurityUtils
import org.springframework.web.multipart.MultipartFile
import org.springframework.web.multipart.MultipartHttpServletRequest
import uk.co.desirableobjects.ajaxuploader.exception.FileUploadException

class RespondentController {
    def respondentService
    def surveyService
    def goldService
    def mailService

    def index() {
        def surveyList = Survey.all
        def principal = SecurityUtils.subject.principal
        def respondent = User.findByUsername(principal.toString())
        [surveyList:surveyList, respondent: respondent]
    }

    def profileForm() {
        def profileItems = respondentService.getProfileItems()
        def principal = SecurityUtils.subject.principal
        def respondent = User.findByUsername(principal.toString())
        [profileItems: profileItems, respondent: respondent]
    }

    def modify = {
        def respondent
        try {
            respondent = User.findById(params.id)
            def respondentProfile = respondentService.getRespondentProfileFromParams(params)
            respondent.respondentProfile = respondentProfile
            respondent.save()
            flash.message = message(code: "general.create.success.message")
        } catch (Exception e) {
            flash.message = message(code: "general.create.failed.message")
            log.error(e.message)
        }
        forward(action: "profileForm")
    }

    def uploadImage = {
        def message
        try {
            def inputStream
            if (request instanceof MultipartHttpServletRequest) {
                MultipartFile multipartFile = ((MultipartHttpServletRequest) request).getFile("qqfile")
                inputStream = multipartFile.inputStream
            } else {
                inputStream = request.inputStream
            }

            // update user
            def user = User.findById(params.respondentId)
            user.pic = Base64.encode(inputStream.bytes)
            user.save()

            if (user.hasErrors()) {
                throw new Exception(user.errors.allErrors.first())
            }

            return render(text: [success:true] as JSON, contentType:'text/json')
        } catch (FileUploadException e) {
            message = "Failed to upload file."
            log.error(message, e)
        } catch (Exception e) {
            message = "Failed to save respondent"
            log.error(message, e)
        }
        return render(text: [success:false, message: message] as JSON, contentType:'text/json')
    }

    def viewImage = {
        def user = User.findById(params.respondentId)
        def imageByte
        if (user?.pic) {
            imageByte = Base64.decode(user?.pic)
        }
        response.outputStream << imageByte
    }

    def takeSurvey = {
        def survey = surveyService.getSurveyForRespondent(params.surveyId)
        def principal = SecurityUtils.subject.principal
        def respondent = User.findByUsername(principal.toString())
        [survey: survey, respondent: respondent]
    }

    def getSurvey = {
        def survey = surveyService.getSurveyForRespondent(params.surveyId)
        def questions = com.mongodb.util.JSON.serialize(survey[Survey.COMPONENTS.QUESTION_ITEMS])
        render questions
    }

    def viewSurveyLogo() {
        def survey = surveyService.getSurveyForRespondent(params.surveyId)

        if (survey[Survey.COMPONENTS.LOGO]) {
            def imageByte
            imageByte = Base64.decode(survey[Survey.COMPONENTS.LOGO])
            response.outputStream << imageByte
        }
    }

    def saveResponse(){
        try {
            def surveyResponse = params.surveyResponse
            surveyService.saveResponse(surveyResponse, params.surveyId, params.respondentId)
            respondentService.saveSurveyReward(params.respondentId, params.surveyId)
            render 'SUCCESS'
        } catch (Exception e) {
            log.error(e.message, e)
            render 'FAILED'
        }
    }

    def goldHistory = {
        def principal = SecurityUtils.subject.principal
        def respondent = User.findByUsername(principal.toString())
        def goldHistory = respondent.respondentProfile?.goldHistory
        [goldHistory:goldHistory, respondent: respondent]
    }

    def redeemGold = {
        def principal = SecurityUtils.subject.principal
        def respondent = User.findByUsername(principal.toString())

        def goldRateValue = Double.parseDouble(Parameter.findByCode("GOLD_RATE_IDR")?.value)
        def goldRate = formatNumber(number: goldRateValue, formatName: "app.currency.format")

        def balanceGoldValue = respondent.respondentProfile?.gold;
        def balanceValue = balanceGoldValue * goldRateValue
        def balance = formatNumber(number: balanceValue, formatName: "app.currency.format")

        def minRedemptionPointValue = Double.parseDouble(Parameter.findByCode("GOLD_MIN_REDEMPTION")?.value)
        def minRedemptionValue = minRedemptionPointValue * goldRateValue

        [maxRedemption: balanceValue, minRedemption:minRedemptionValue, goldRate:goldRate, balance:balance, respondent: respondent]
    }

    def requestRedemption = {
        try {
            def principal = SecurityUtils.subject.principal
            def respondent = User.findByUsername(principal.toString())
            params.respondentId = respondent.id
            goldService.saveRedemptionRequest(params)
            render 'SUCCESS'
        } catch (Exception e) {
            log.error(e.message, e)
            render 'FAILED'
        }
    }

    def inviteFriends = {
        def principal = SecurityUtils.subject.principal
        def respondent = null
        def fbAppId = null
        try {
            respondent = User.findByUsername(principal.toString())
            fbAppId = grailsApplication.config.oauth.providers.facebook.key
        } catch (Exception e) {
            log.error(e.message, e)
        }
        [respondent: respondent, refLink: getRespondentReferenceLink(respondent), fbAppId:fbAppId]
    }

    def inviteByEmail = {
        def principal = SecurityUtils.subject.principal
        def respondent = User.findByUsername(principal.toString())
        def emails = prepareEmails(params.friendEmails)
        def emailFrom = message(code: "ticbox.respondent.invite.email.from")
        def emailSubject = message(code: "ticbox.respondent.invite.email.subject")
        def emailBody = message(code: "ticbox.respondent.invite.email.body", args: [getRespondentReferenceLink(respondent)])
        try {
            mailService.sendMail {
                to emails
                from emailFrom
                subject emailSubject
                html emailBody
            }
            render 'SUCCESS'
        } catch (Exception e) {
            log.error(e.message, e)
            render 'FAILED'
        }
    }

    private String[] prepareEmails(String rawEmails) {
        def res = null
        if (rawEmails) {
            def arrayEmails = rawEmails.split(",")
            for (int i = 0; i < arrayEmails.length; i++) {
                arrayEmails[i] = arrayEmails[i].trim().replaceAll(" ","")
            }
            res = (arrayEmails.length > 0) ? arrayEmails : null
        }
        return res;
    }

    private String getRespondentReferenceLink(User respondent) {
        return "${g.createLink(controller: 'auth', action: 'registerRespondent', absolute: true)}?ref=${respondent.username}"
    }
}
