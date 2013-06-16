package ticbox

import com.mongodb.DBObject

class SurveyService {

    def serviceMethod() {

    }

    Survey getEditedSurvey(){
        //TODO should be fetching from current surveyor's edited survey
        Survey survey = Survey.findBySurveyId('TEST001')?:new Survey(surveyId: 'TEST001', name: 'Survey Test 001').save()

        //TODO should be fetching from global conf and keep save per survey for locking
        survey[Survey.COMPONENTS.SUMMARY_DETAIL] = com.mongodb.util.JSON.parse("""{
            chargePerRespondent : "15000",
                totalRespondent : "200"
        }""")

        return survey
    }

    def getProfileItemsForRespondentFilter(){
        return ProfileItem.list()?.sort{it.seq}
    }

    def submitRespondentFilter(String filterItemsJSON){
        Survey survey = getEditedSurvey()

        DBObject dbObject = (DBObject) com.mongodb.util.JSON.parse(filterItemsJSON)

        survey[Survey.COMPONENTS.RESPONDENT_FILTER] = dbObject

        survey.save()
    }

    def submitQuestionItems(String questionItemsJSON, String title){
        Survey survey = getEditedSurvey()

        DBObject dbObject = (DBObject) com.mongodb.util.JSON.parse(questionItemsJSON)

        survey[Survey.COMPONENTS.QUESTION_ITEMS] = dbObject
        survey.title = title

        survey.save()
    }
}
