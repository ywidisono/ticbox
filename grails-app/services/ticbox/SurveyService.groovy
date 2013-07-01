package ticbox

import com.mongodb.BasicDBObject
import com.mongodb.DBObject
import org.bson.types.ObjectId
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

    def submitRespondentFilter(String filterItemsJSON, String surveyType, Survey survey){
        if (survey) {
            DBObject dbObject = (DBObject) com.mongodb.util.JSON.parse(filterItemsJSON)

            survey[Survey.COMPONENTS.RESPONDENT_FILTER] = dbObject
            survey.type = surveyType

            survey.save()
        }
    }

    def submitSurvey(def params, Survey survey){
        if (survey) {
            DBObject dbObject = (DBObject) com.mongodb.util.JSON.parse(params.questionItems)

            survey[Survey.COMPONENTS.QUESTION_ITEMS] = dbObject
            survey.title = params.surveyTitle

            if(params.logoResourceId){
                def userResource = UserResource.findById(new ObjectId(params.logoResourceId))
                if (userResource) {
                    survey[Survey.COMPONENTS.LOGO] = userResource.id
                }
            }

            survey.save()
        }
    }

    def finalizeAndPublishSurvey(def params, Survey survey){

        switch (survey.type){
            case Survey.SURVEY_TYPE.EASY :

                def filteredRespondents = getFilteredRespondents(survey)

                break
            case Survey.SURVEY_TYPE.FREE :

                break
        }

    }

    def getFilteredRespondents(Survey survey){
        if(survey && survey[Survey.COMPONENTS.RESPONDENT_FILTER]){

            def c = RespondentProfile.createCriteria()

            c.list {

                survey[Survey.COMPONENTS.RESPONDENT_FILTER].each{filter ->
                    switch(filter.type){

                        case ProfileItem.TYPES.CHOICE :

                            profileItems {
                                filter.checkItems?.each{item ->
                                    or {
                                        like filter.code, "%${item instanceof  Map ? item.key : item}%"
                                    }
                                }
                            }

                            break

                        case ProfileItem.TYPES.DATE :

                            profileItems {
                                gte filter.code, Date.parse('dd/MM/yyyy', filter.valFrom)
                                lte filter.code, Date.parse('dd/MM/yyyy', filter.valTo)
                            }

                            break

                        case ProfileItem.TYPES.LOOKUP :

                            profileItems {
                                filter.checkItems?.each{item ->
                                    or {
                                        like filter.code, "%${item instanceof  Map ? item.key : item}%"
                                    }
                                }
                            }

                            break

                        case ProfileItem.TYPES.NUMBER :

                            profileItems {
                                gte filter.code, Double.valueOf(filter.valFrom)
                                lte filter.code, Double.valueOf(filter.valTo)
                            }

                            break

                        case ProfileItem.TYPES.STRING :

                            profileItems {
                                like filter.code, "%${filter.val}%" //TODO should be a wildcard query
                            }

                            break

                        default :

                            break

                    }
                }

            }

            println c

        }

        return null
    }

    def saveResponse(String responseJSON, String surveyId, String respondentId){
        SurveyResponse surveyResponse = SurveyResponse.findBySurveyIdAndRespondentId(surveyId, respondentId) ?: new SurveyResponse(surveyId: surveyId, respondentId: respondentId).save()
        DBObject dbObject = (DBObject) com.mongodb.util.JSON.parse(responseJSON)
        surveyResponse["response"] = dbObject
        surveyResponse.save()
    }

}
