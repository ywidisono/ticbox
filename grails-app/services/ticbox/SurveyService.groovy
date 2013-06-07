package ticbox

import com.mongodb.DBObject

class SurveyService {

    def serviceMethod() {

    }

    Survey getEditedSurvey(){
        //TODO should be fetching from current surveyor's edited survey
        Survey survey = Survey.findBySurveyId('TEST001')?:new Survey(surveyId: 'TEST001', name: 'Survey Test 001').save()

        survey[Survey.COMPONENTS.SUMMARY_DETAIL] = [
                chargePerRespondent : 15000, //TODO should be fetching from global conf and keep save per survey for locking
                totalRespondent : 200
        ]

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
}
