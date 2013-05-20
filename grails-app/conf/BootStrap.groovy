import org.apache.shiro.crypto.hash.Sha256Hash
import ticbox.Role
import ticbox.User

class BootStrap {

    def bootstrapService

    def init = { servletContext ->

        if(Role.count <= 0) {
            def adminRole = new Role(name: "Surveyor")
            adminRole.addToPermissions("*:*").save()
            def respondentRole = new Role(name: "Respondent")
            respondentRole.addToPermissions("*:*").save()
            def defaultUser = new User(username: "user123", passwordHash: new Sha256Hash("password").toHex())
            defaultUser.addToRoles(adminRole).save()
        }

        bootstrapService.init()

    }

    def destroy = {

        bootstrapService.destroy()

    }
}
