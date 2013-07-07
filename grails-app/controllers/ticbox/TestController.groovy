package ticbox

import com.mongodb.BasicDBList
import com.mongodb.DBCollection
import grails.converters.JSON
import org.springframework.data.mongodb.core.query.BasicQuery

class TestController {

    def mongo

    def index() {

        def user = User.findByUsername('user123')
        def defaultRespondentProfile = user?.respondentProfile?:new RespondentProfile()

        def profileItems = defaultRespondentProfile.profileItems
        profileItems.put('PI_ADDR001', 'nowhere')
        profileItems.put('PI_OCCUPATION001', 'jobless')
        profileItems.put('PI_COUNTRY001', 'ID')
        profileItems.put('PI_DOB001', Date.parse('dd/MM/yyyy', '30/06/1985').getTime())
        profileItems.put('PI_HEIGHT001', 300)
        profileItems.put('PI_WEIGHT001', 105)
        profileItems.put('PI_EDU001', 'DEGREE')
        profileItems.put('PI_HOBBY001', 'Game')

        user.respondentProfile = defaultRespondentProfile
        user.save()

        String query = """
            {
                respondentProfile: {
                    profileItems: {
                        PI_COUNTRY001: "ID"
                    }
                }
            }
        """
        DBCollection coll = User.collection
        def found = coll.findOne(com.mongodb.util.JSON.parse(query)) as User

        //def found = User.findByRespondentProfile(defaultRespondentProfile)

        render found?.respondentProfile?.profileItems?:[:] as JSON
    }
}
