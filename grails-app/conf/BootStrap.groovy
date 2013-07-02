import org.apache.shiro.crypto.hash.Sha256Hash
import ticbox.Parameter
import ticbox.RespondentProfile
import ticbox.Role
import ticbox.Survey
import ticbox.User

class BootStrap {

    def bootstrapService

    def init = { servletContext ->

        // todo for dev only
        Role.collection.drop()
        User.collection.drop()
        Parameter.collection.drop()


        // users & roles
        def surveyorRole = new Role(name: "Surveyor")
        surveyorRole.permissions = []
        surveyorRole.addToPermissions("survey:*")
                    .addToPermissions("ajaxUpload:*")
                    .save()

        def respondentRole = new Role(name: "Respondent")
        respondentRole.permissions = []
        respondentRole.addToPermissions("respondent:*")
                      .addToPermissions("ajaxUpload:*")
                      .save()

        def defaultUser = new User(username: "user123", passwordHash: new Sha256Hash("password").toHex())
        def profile = new RespondentProfile()
        profile.profileItems = [
                PI_ADDR001 : 'nowhere somewhere everywhere wherever',
                PI_OCCUPATION001 : 'jobless',
                PI_COUNTRY001 : 'ID',
                PI_DOB001 : Date.parse('dd/MM/yyyy', '30/06/2013'),
                PI_HEIGHT001 : 179,
                PI_WEIGHT001 : 65,
                PI_EDU001 : 'DEGREE',
                PI_HOBBY001 : 'Game'
        ]
        defaultUser.addToRoles(surveyorRole)
                   .addToRoles(respondentRole)
                   .respondentProfile = profile
        defaultUser.save()

        // parameters
        new Parameter(code:"GOLD_RATE_IDR", value: "1000", desc: "Conversion rate gold to IDR").save()
        new Parameter(code:"GOLD_MIN_REDEMPTION", value: "50", desc: "Minimum redemption in gold").save()
        new Parameter(code:"REFERRER_REWARD", value: "1", desc: "Gold reward to referrer on reference survey completion").save()

        bootstrapService.init()

    }

    def destroy = {

        bootstrapService.destroy()

    }
}
