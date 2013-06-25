import org.apache.shiro.crypto.hash.Sha256Hash
import ticbox.Parameter
import ticbox.Role
import ticbox.Survey
import ticbox.User

class BootStrap {

    def bootstrapService

    def init = { servletContext ->

        // users & roles
        def adminRole = Role.findByName('Surveyor')?:new Role(name: "Surveyor")
        adminRole.permissions = []
        adminRole.addToPermissions("survey:*")
        adminRole.addToPermissions("ajaxUpload:*")
        adminRole.save()

        def respondentRole = Role.findByName('Respondent')?:new Role(name: "Respondent")
        respondentRole.permissions = []
        respondentRole.addToPermissions("respondent:*")
        respondentRole.addToPermissions("ajaxUpload:*")
        respondentRole.save()

        def defaultUser = User.findByUsername('user123')?:new User(username: "user123", passwordHash: new Sha256Hash("password").toHex())
        defaultUser.addToRoles(adminRole).save()

        // parameters
        if (Parameter.count <= 0) {
            new Parameter(code:"GOLD_RATE_IDR", value: "1000").save()
            new Parameter(code:"GOLD_MIN_REDEMPTION", value: "50").save()
        }

        bootstrapService.init()

    }

    def destroy = {

        bootstrapService.destroy()

    }
}
