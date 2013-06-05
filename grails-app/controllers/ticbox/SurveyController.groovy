package ticbox

import grails.converters.JSON
import com.sun.org.apache.xerces.internal.impl.dv.util.Base64

class SurveyController {

    def surveyService

    def index() { }

    def easySurvey() {

    }

    def getEditedSurvey() {
        render surveyService.getEditedSurvey() as JSON
    }

    def getRespondentFilter() {
        render surveyService.getEditedSurvey()[Survey.COMPONENTS.RESPONDENT_FILTER] as JSON
    }

    def respondentFilter(){

        [survey : surveyService.getEditedSurvey(), profileItems : surveyService.profileItemsForRespondentFilter]
    }

    def submitRespondentFilter() {
        def filterItemsJSON = params.filterItemsJSON

        surveyService.submitRespondentFilter(filterItemsJSON)

        render 'SUCCESS'
    }

    def surveyGenerator(){

        [survey : surveyService.getEditedSurvey()]
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
