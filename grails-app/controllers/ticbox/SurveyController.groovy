package ticbox

import grails.converters.JSON
import com.sun.org.apache.xerces.internal.impl.dv.util.Base64
import org.bson.types.ObjectId
import org.springframework.web.multipart.MultipartFile
import org.springframework.web.multipart.MultipartHttpServletRequest

class SurveyController {

    def surveyService
    def surveyorService

    def index() {
        /*if(!surveyorService.getCurrentSurveyor()){
            flash.message = 'Your profile as surveyor cannot be found'

            redirect uri: '/'
        }*/


        [
            drafts : Survey.findAllBySurveyorAndStatus(surveyorService.currentSurveyor, Survey.STATUS.DRAFT),
            inProgress : Survey.findAllBySurveyorAndStatus(surveyorService.currentSurveyor, Survey.STATUS.IN_PROGRESS),
            completes : Survey.findAllBySurveyorAndStatus(surveyorService.currentSurveyor, Survey.STATUS.COMPLETED)
        ]
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
        def jsonStr = com.mongodb.util.JSON.serialize(surveyService.getCurrentEditedSurvey()[Survey.COMPONENTS.SUMMARY_DETAIL])

        render jsonStr
    }

    def getRespondentFilter() {
        def jsonStr = com.mongodb.util.JSON.serialize(surveyService.getCurrentEditedSurvey()[Survey.COMPONENTS.RESPONDENT_FILTER])

        render jsonStr
    }

    def getQuestionItems(){
        def jsonStr = com.mongodb.util.JSON.serialize(surveyService.getCurrentEditedSurvey()[Survey.COMPONENTS.QUESTION_ITEMS])

        render jsonStr
    }

    def respondentFilter(){

        Survey survey = surveyService.getCurrentEditedSurvey()

        if(!survey){
            redirect action: 'index'
        }

        [survey : survey, profileItems : surveyService.profileItemsForRespondentFilter]
    }

    def submitRespondentFilter() {
        try {
            def filterItemsJSON = params.filterItemsJSON

            surveyService.submitRespondentFilter(filterItemsJSON, params.surveyType, surveyService.getCurrentEditedSurvey())

            render filterItemsJSON
        } catch (Exception e) {
            e.printStackTrace()
            render 'FAILED'
        }
    }

    def surveyGenerator(){
        Survey survey = surveyService.getCurrentEditedSurvey()

        if(!survey){
            redirect action: 'index'
        }

        [survey : survey]
    }

    def submitSurvey(){
        try {

            surveyService.submitSurvey(params, surveyService.getCurrentEditedSurvey())

            render 'SUCCESS'
        } catch (Exception e) {
            e.printStackTrace()
            render 'FAILED'
        }
    }

    def finalizeAndPublishSurvey(){
        surveyService.finalizeAndPublishSurvey(params, surveyService.getCurrentEditedSurvey())

        redirect action: 'index'
    }

    def getLogoIds(){
        def ids = UserResource.findAllByUserAndKind(surveyorService.getCurrentSurveyor()?.userAccount, Survey.COMPONENTS.LOGO)?.collect {
            it.id.toStringMongod()
        }

        render ids as JSON
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

            def userResource = new UserResource(user: surveyorService.getCurrentSurveyor()?.userAccount, kind: Survey.COMPONENTS.LOGO).save()
            userResource[Survey.COMPONENTS.LOGO] = Base64.encode(inputStream.bytes)
            userResource.save()

            if (userResource.hasErrors()) {
                throw new Exception("${userResource.errors.allErrors.first()}")
            }

            rend.success = true
            rend.resourceId = userResource.id.toStringMongod()

        } catch (Exception e) {
            rend.success = false
            rend.message = "Failed to save logo"
            log.error("${e.class}, ${e.message?:e.cause.message}")
        }

        render rend as JSON

    }
    
    def viewLogo() {
        def userResource

        if (params.resourceId) {
            userResource = UserResource.findById(new ObjectId(params.resourceId))
        }else{
            def survey = surveyService.getCurrentEditedSurvey()

            if (survey) {
                ObjectId objectId = survey[Survey.COMPONENTS.LOGO]
                userResource = UserResource.findByid(objectId)
            }
        }

        if (userResource) {
            def imageByte = Base64.decode(userResource[Survey.COMPONENTS.LOGO])
            response.outputStream << imageByte
        }
    }

}
