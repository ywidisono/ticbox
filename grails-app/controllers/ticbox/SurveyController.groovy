package ticbox

import com.sun.org.apache.xerces.internal.impl.dv.util.Base64

class SurveyController {

    def surveyService

    def index() { }

    def easySurvey() {

    }

    def respondentFilter(){
        def profileItems = surveyService.profileItemsForRespondentFilter

        [profileItems : profileItems]
    }

    def surveyGenerator(){

    }

    def viewLogo = {
        def survey = Survey.findById(params.surveyId)
        def imageByte
        if (survey.logo) {
            imageByte = Base64.decode(survey.logo)
        }
        response.outputStream << imageByte
    }

}
