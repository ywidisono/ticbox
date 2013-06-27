package ticbox

import com.mongodb.DBObject
import org.codehaus.groovy.grails.web.util.WebUtils

class SurveyService {

    def surveyorService

    def surveyList(){

        return Survey.findAllBySurveyor(surveyorService.getCurrentSurveyor())
    }

    Survey createSurvey(def params){
        SurveyorProfile surveyor = surveyorService.getCurrentSurveyor()

        Survey survey = new Survey(surveyId: UUID.randomUUID().toString(), name: params.surveyName, surveyor: surveyor).save();

        WebUtils.retrieveGrailsWebRequest().session.putAt('current-edited-survey-id', survey?.surveyId)

        return survey
    }

    Survey getCurrentEditedSurvey(){
        //TODO should be fetching from current surveyor's edited survey
        def surveyId = WebUtils.retrieveGrailsWebRequest().session.getAt('current-edited-survey-id')
        Survey survey = surveyId?Survey.findBySurveyId("${surveyId}"):null

        //TODO should be fetching from global conf and keep save per survey for locking
        /*survey[Survey.COMPONENTS.SUMMARY_DETAIL] = com.mongodb.util.JSON.parse(
        """{
            chargePerRespondent : "15000",
                totalRespondent : "200"
        }""")*/

        return survey
    }

    def getSurveyForRespondent(String surveyId) {
        return Survey.findBySurveyId(surveyId)
    }

    def getProfileItemsForRespondentFilter(){
        return ProfileItem.list()?.sort{it.seq}
    }

    def submitRespondentFilter(String filterItemsJSON, Survey survey){
        if (survey) {
            DBObject dbObject = (DBObject) com.mongodb.util.JSON.parse(filterItemsJSON)

            survey[Survey.COMPONENTS.RESPONDENT_FILTER] = dbObject

            survey.save()
        }
    }

    def submitQuestionItems(String questionItemsJSON, String title, Survey survey){
        if (survey) {
            DBObject dbObject = (DBObject) com.mongodb.util.JSON.parse(questionItemsJSON)

            survey[Survey.COMPONENTS.QUESTION_ITEMS] = dbObject
            survey.title = title

            survey.save()
        }
    }

    def saveResponse(String responseJSON, String surveyId, String respondentId){
        SurveyResponse surveyResponse = SurveyResponse.findBySurveyIdAndRespondentId(surveyId, respondentId) ?: new SurveyResponse(surveyId: surveyId, respondentId: respondentId).save()
        DBObject dbObject = (DBObject) com.mongodb.util.JSON.parse(responseJSON)
        surveyResponse["response"] = dbObject
        surveyResponse.save()
    }

}
