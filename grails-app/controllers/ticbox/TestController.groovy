package ticbox

import com.mongodb.BasicDBList
import com.mongodb.DBCollection
import grails.converters.JSON
import org.springframework.data.mongodb.core.query.BasicQuery

class TestController {

    def mongo

    def index() {

        /*def user = User.findByUsername('user123')
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

        defaultRespondentProfile.save()

        user.respondentProfile = defaultRespondentProfile
        user.save()*/

        String query = """
            {
                'profileItems.PI_COUNTRY001': 'ID'
            }
        """
        DBCollection coll = RespondentProfile.collection
        def found = coll.findOne(com.mongodb.util.JSON.parse(query)) as RespondentProfile

        found = null

        found = RespondentProfile.createCriteria().list {
            //eq 'profileItems.PI_COUNTRY001', 'ID'

            /*or{
                like "profileItems.PI_COUNTRY001", "%ID%"
                like "profileItems.PI_COUNTRY001", "%SG%"
            }*/

            gte "profileItems.PI_DOB001", Date.parse('dd/MM/yyyy', '06/01/1985').getTime()
            lte "profileItems.PI_DOB001", Date.parse('dd/MM/yyyy', '07/31/2013').getTime()
        }

        render found?.profileItems?:[:] as JSON
    }

    def testService

    def testEmail(){
        testService.testSendEmail()

        render 'email sent'
    }
}
