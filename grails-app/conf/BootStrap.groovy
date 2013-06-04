import org.apache.shiro.crypto.hash.Sha256Hash
import ticbox.Role
import ticbox.Survey
import ticbox.User

class BootStrap {

    def bootstrapService

    def init = { servletContext ->

        if(Role.count <= 0) {
            def adminRole = new Role(name: "Surveyor")
            adminRole.addToPermissions("survey:*")
            adminRole.addToPermissions("ajaxUpload:*")
            adminRole.save()

            def respondentRole = new Role(name: "Respondent")
            respondentRole.addToPermissions("respondent:*")
            respondentRole.addToPermissions("ajaxUpload:*")
            respondentRole.save()

            def defaultUser = new User(username: "user123", passwordHash: new Sha256Hash("password").toHex())
            defaultUser.addToRoles(adminRole).save()
        }

        if(Survey.count <= 0) {
            for (int i = 0; i < 2; i++) {
                def surveyName = "Trust Survey " + i;
                def trustSurvey = new Survey(name: surveyName, pointType: Survey.POINT_TYPE.TRUST, point: i, target: i*100, current: i*10).save()
            }
            for (int i = 0; i < 3; i++) {
                def surveyName = "Gold Survey " + i;
                def goldSurvey = new Survey(name: surveyName, pointType: Survey.POINT_TYPE.GOLD, point: i, target: i*100, current: i*10).save()
            }
        }

        bootstrapService.init()

    }

    def destroy = {

        bootstrapService.destroy()

    }
}
