package ticbox

import org.apache.shiro.crypto.hash.Sha256Hash

class UserService {
    def respondentService

    def createUser(Map params) throws Exception {
        User newUser = new User(username: params.username, passwordHash: new Sha256Hash(params.password).toHex(), email: params.email).save()
        if ("surveyor".equalsIgnoreCase(params.userType)) {
            Role surveyorRole = Role.findByName("Surveyor")
            newUser.addToRoles(surveyorRole).save()
            new SurveyorProfile(
                    email: params.email,
                    companyName: params.company,
                    userAccount: newUser
            ).save()
        } else if ("respondent".equalsIgnoreCase(params.userType)) {
            def respondentRole = Role.findByName("Respondent")
            def respondentProfile = respondentService.getRespondentProfileFromParams(params)
            newUser.respondentProfile = respondentProfile
            newUser.addToRoles(respondentRole).save()

            // reference point
            respondentService.processReference(params.referrer, newUser)
        } else if ("admin".equalsIgnoreCase(params.userType)) {
            Role adminRole = Role.findByName("Admin")
            newUser.addToRoles(adminRole).save()
        }

        if (!newUser) {
            throw new Exception("Unable to create user")
        } else if (newUser.hasErrors()) {
            throw new Exception(newUser.errors.allErrors.first())
        }

        return newUser
    }

    def deleteUsers(String[] ids) throws Exception {
        List<Long> delIds = getListOfLong(ids)
        def users = User.findAll{
            inList("_id", delIds)
        }
        if (users) {
            User.deleteAll(users)
        } else {
            throw new Exception("No user was found")
        }
    }

    private List<Long> getListOfLong(String[] ids) {
        def res = []
        for (String id : ids) {
            res << Long.parseLong(id)
        }
        return res
    }
}
