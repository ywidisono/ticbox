import com.mongodb.BasicDBList
import com.mongodb.DBObject
import org.apache.shiro.crypto.hash.Sha256Hash
import org.springframework.data.mongodb.UncategorizedMongoDbException
import ticbox.Parameter
import ticbox.RespondentProfile
import ticbox.Role
import ticbox.User

class BootStrap {

    def bootstrapService

    def init = { servletContext ->

        // todo for dev only
        Role.collection.drop()
        User.collection.drop()
        Parameter.collection.drop()

        // users & roles
        def adminRole = new Role(name: "Admin")
        adminRole.permissions = []
        adminRole.addToPermissions("*:*")
                 .save()

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
        defaultUser.addToRoles(surveyorRole)
                   .addToRoles(respondentRole)
                   .save()

        def defaultAdmin = new User(username: "admin", passwordHash: new Sha256Hash("admin").toHex())
        defaultAdmin.addToRoles(adminRole).save()

        bootstrapService.init()

        //parameters
        Parameter.findByCode('GOLD_RATE_IDR')?:new Parameter(code:"GOLD_RATE_IDR", value: "1000").save()
        Parameter.findByCode('GOLD_MIN_REDEMPTION')?:new Parameter(code:"GOLD_MIN_REDEMPTION", value: "50").save()


        println 'should be ok!!....'
    }

    def destroy = {

        bootstrapService.destroy()

    }
}
