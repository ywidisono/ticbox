package ticbox

import com.mongodb.DBObject

class SurveyService {

    def serviceMethod() {

    }

    Survey getEditedSurvey(){
        //TODO should be fetching from current surveyor's edited survey
        Survey survey = Survey.findBySurveyId('TEST001')?:new Survey(surveyId: 'TEST001').save()

        println survey.surveyId + ' : ' + survey[Survey.COMPONENTS.RESPONDENT_FILTER]

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
