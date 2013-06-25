package ticbox

import grails.converters.JSON
import com.sun.org.apache.xerces.internal.impl.dv.util.Base64
import org.springframework.web.multipart.MultipartFile
import org.springframework.web.multipart.MultipartHttpServletRequest
import uk.co.desirableobjects.ajaxuploader.exception.FileUploadException

class SurveyController {

    def surveyService

    def index() {
        [surveys : Survey.list()]
    }

    def createSurvey(){

        surveyService.createSurvey(params)

        redirect action: 'respondentFilter'
    }

    def editSurvey(){
        session.putAt('current-edited-survey-id', params.surveyId)

        redirect action: 'respondentFilter'
    }

    def getSurveySummary() {
        def jsonStr = com.mongodb.util.JSON.serialize(surveyService.getEditedSurvey()[Survey.COMPONENTS.SUMMARY_DETAIL])

        render jsonStr
    }

    def getRespondentFilter() {
        def jsonStr = com.mongodb.util.JSON.serialize(surveyService.getEditedSurvey()[Survey.COMPONENTS.RESPONDENT_FILTER])

        render jsonStr
    }

    def getQuestionItems(){
        def jsonStr = com.mongodb.util.JSON.serialize(surveyService.getEditedSurvey()[Survey.COMPONENTS.QUESTION_ITEMS])

        render jsonStr
    }

    def respondentFilter(){

        [survey : surveyService.getEditedSurvey(), profileItems : surveyService.profileItemsForRespondentFilter]
    }

    def submitRespondentFilter() {
        try {
            def filterItemsJSON = params.filterItemsJSON

            surveyService.submitRespondentFilter(filterItemsJSON)

            render filterItemsJSON
        } catch (Exception e) {
            e.printStackTrace()
            render 'FAILED'
        }
    }

    def surveyGenerator(){
        def survey = surveyService.getEditedSurvey()

        [survey : survey]
    }

    def submitQuestionItems(){
        try {
            def questionItemsJSON = params.questionItems

            surveyService.submitQuestionItems(questionItemsJSON, params.surveyTitle)

            render 'SUCCESS'
        } catch (Exception e) {
            e.printStackTrace()
            render 'FAILED'
        }
    }

    def uploadLogo(){

        def rend = [:]
        try {
            def inputStream
            if (request instanceof MultipartHttpServletRequest) {
                MultipartFile multipartFile = ((MultipartHttpServletRequest) request).getFile("qqfile")
                inputStream = multipartFile.inputStream
            } else {
                inputStream = request.inputStream
            }

            def survey = surveyService.getEditedSurvey()
            survey[Survey.COMPONENTS.LOGO] = Base64.encode(inputStream.bytes)
            survey.save()

            if (survey.hasErrors()) {
                throw new Exception("${survey.errors.allErrors.first()}")
            }

            rend.success = true

        } catch (Exception e) {
            rend.success = false
            rend.message = "Failed to save logo"
            log.error("${e.class}, ${e.message?:e.cause.message}")
        }

        render rend as JSON

    }
    
    def viewLogo() {
        def survey = surveyService.getEditedSurvey()

        if (survey[Survey.COMPONENTS.LOGO]) {
            def imageByte
            imageByte = Base64.decode(survey[Survey.COMPONENTS.LOGO])
            response.outputStream << imageByte
        }
    }

}
