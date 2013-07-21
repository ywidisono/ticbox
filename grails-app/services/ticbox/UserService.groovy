package ticbox

import org.apache.shiro.crypto.hash.Sha256Hash

class UserService {
    def respondentService

    def createUser(Map params) throws Exception {
        User newUser = new User(
            username: params.username,
            passwordHash: new Sha256Hash(params.password).toHex(),
            email: params.email
        )

        if ("surveyor".equalsIgnoreCase(params.userType)) {
            Role surveyorRole = Role.findByName("Surveyor")
            newUser.addToRoles(surveyorRole)

            new SurveyorProfile(
                email: params.email,
                companyName: params.company,
                userAccount: newUser
            ).save()
        } else if ("respondent".equalsIgnoreCase(params.userType)) {
            def respondentRole = Role.findByName("Respondent")
            newUser.addToRoles(respondentRole)

            RespondentProfile respondentProfile = respondentService.getRespondentProfileFromParams(params)
            respondentProfile.userAccount = newUser
            respondentProfile.save()

            // reference point
            respondentService.processReference(params.referrer, respondentProfile)
        } else if ("admin".equalsIgnoreCase(params.userType)) {
            Role adminRole = Role.findByName("Admin")
            newUser.addToRoles(adminRole)
        }

        newUser.save()

        if (!newUser) {
            throw new Exception("Unable to create user")
        } else if (newUser.hasErrors()) {
            throw new Exception("${newUser.errors.allErrors}")
        }

        return newUser
    }

    def deleteUsers(String[] ids) throws Exception {
        List<Long> delIds = HelperService.getListOfLong(ids)
        def users = User.findAll{
            inList("_id", delIds)
        }
        if (users) {
            User.deleteAll(users)
        } else {
            throw new Exception("No user was found")
        }
    }

}
