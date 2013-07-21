package ticbox

import com.mongodb.BasicDBList
import com.mongodb.DBCollection
import grails.converters.JSON
import org.springframework.data.mongodb.core.query.BasicQuery

class TestController {

    def mongo
    def userService
    
    def index() {
        
    }

    def createRespondents() {
        
        userService.createUser([
                username : 'arnold',
                email : 'arnold.palar@gmail.com',
                password : 'password',
                userType : 'respondent',
                'PI_ADDR001': 'nowhere',
                'PI_OCCUPATION001': 'jobless',
                'PI_COUNTRY001': 'ID',
                'PI_DOB001': '01/24/1985', //Date.parse('dd/MM/yyyy', '01/24/1985').getTime(),
                'PI_HEIGHT001': 169,
                'PI_WEIGHT001': 60,
                'PI_EDU001': 'DEGREE',
                'PI_HOBBY001': 'Game,Programming,Photography'
        ]).save()

        userService.createUser([
                username : 'respondent1',
                email : 'respondent1@mail.com',
                password : 'password',
                userType : 'respondent',
                'PI_ADDR001': 'nowhere',
                'PI_OCCUPATION001': 'jobless',
                'PI_COUNTRY001': 'ID',
                'PI_DOB001': '01/24/1985', //Date.parse('dd/MM/yyyy', '01/24/1985').getTime(),
                'PI_HEIGHT001': 169,
                'PI_WEIGHT001': 60,
                'PI_EDU001': 'DEGREE',
                'PI_HOBBY001': 'Game,Programming,Photography'
        ]).save()

        userService.createUser([
                username : 'respondent2',
                email : 'respondent2@mail.com',
                password : 'password',
                userType : 'respondent',
                'PI_ADDR001': 'nowhere',
                'PI_OCCUPATION001': 'jobless',
                'PI_COUNTRY001': 'ID',
                'PI_DOB001': '01/24/1985', //Date.parse('dd/MM/yyyy', '01/24/1985').getTime(),
                'PI_HEIGHT001': 169,
                'PI_WEIGHT001': 60,
                'PI_EDU001': 'DEGREE',
                'PI_HOBBY001': 'Game,Programming,Photography'
        ]).save()

        /*String query = """
            {
                'profileItems.PI_COUNTRY001': 'ID'
            }
        """
        DBCollection coll = RespondentProfile.collection
        def found = coll.findOne(com.mongodb.util.JSON.parse(query)) as RespondentProfile
        println found*/

        def found = RespondentProfile.createCriteria().list {
            eq 'profileItems.PI_COUNTRY001', 'ID'

            or{
                like "profileItems.PI_COUNTRY001", "%ID%"
                like "profileItems.PI_COUNTRY001", "%SG%"
            }

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
