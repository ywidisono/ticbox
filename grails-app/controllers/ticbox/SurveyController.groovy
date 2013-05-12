package ticbox

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
}
