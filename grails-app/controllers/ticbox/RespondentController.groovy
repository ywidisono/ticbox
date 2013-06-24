package ticbox

import com.sun.org.apache.xerces.internal.impl.dv.util.Base64
import grails.converters.JSON
import org.apache.shiro.SecurityUtils
import org.springframework.web.multipart.MultipartFile
import org.springframework.web.multipart.MultipartHttpServletRequest
import uk.co.desirableobjects.ajaxuploader.exception.FileUploadException

class RespondentController {
    def respondentService
    def surveyService

    def index() {
        def surveyList = Survey.all
        def principal = SecurityUtils.subject.principal
        def respondent = User.findByUsername(principal.toString())
        [surveyList:surveyList, respondent: respondent]
    }

    def profileForm() {
        def profileItems = respondentService.getProfileItems()
        def principal = SecurityUtils.subject.principal
        def respondent = User.findByUsername(principal.toString())
        [profileItems: profileItems, respondent: respondent]
    }

    def modify = {
        def respondent
        try {
            respondent = User.findById(params.id)
            def respondentProfile = respondentService.getRespondentProfileFromParams(params)
            respondent.respondentProfile = respondentProfile
            respondent.save()
            flash.message = message(code: "general.create.success.message")
        } catch (Exception e) {
            flash.message = message(code: "general.create.failed.message")
            log.error(e.message)
        }
        forward(action: "profileForm")
    }

    def uploadImage = {
        def message
        try {
            def inputStream
            if (request instanceof MultipartHttpServletRequest) {
                MultipartFile multipartFile = ((MultipartHttpServletRequest) request).getFile("qqfile")
                inputStream = multipartFile.inputStream
            } else {
                inputStream = request.inputStream
            }

            // update user
            def user = User.findById(params.respondentId)
            user.pic = Base64.encode(inputStream.bytes)
            user.save()

            if (user.hasErrors()) {
                throw new Exception(user.errors.allErrors.first())
            }

            return render(text: [success:true] as JSON, contentType:'text/json')
        } catch (FileUploadException e) {
            message = "Failed to upload file."
            log.error(message, e)
        } catch (Exception e) {
            message = "Failed to save respondent"
            log.error(message, e)
        }
        return render(text: [success:false, message: message] as JSON, contentType:'text/json')
    }

    def viewImage = {
        def user = User.findById(params.respondentId)
        def imageByte
        if (user?.pic) {
            imageByte = Base64.decode(user?.pic)
        }
        response.outputStream << imageByte
    }

    def takeSurvey = {
        def survey = surveyService.getSurveyForRespondent(params.surveyId)
        def principal = SecurityUtils.subject.principal
        def respondent = User.findByUsername(principal.toString())
        [survey: survey, respondent: respondent]
    }

    def getSurvey = {
        def survey = surveyService.getSurveyForRespondent(params.surveyId)
        def questions = com.mongodb.util.JSON.serialize(survey[Survey.COMPONENTS.QUESTION_ITEMS])
        render questions
    }

    def viewSurveyLogo() {
        def survey = surveyService.getSurveyForRespondent(params.surveyId)

        if (survey[Survey.COMPONENTS.LOGO]) {
            def imageByte
            imageByte = Base64.decode(survey[Survey.COMPONENTS.LOGO])
            response.outputStream << imageByte
        }
    }

    def saveResponse(){
        try {
            def surveyResponse = params.surveyResponse
            surveyService.saveResponse(surveyResponse, params.surveyId, params.respondentId)
            respondentService.saveReward(params.respondentId, params.surveyId)
            render 'SUCCESS'
        } catch (Exception e) {
            log.error(e.getMessage(), e)
            render 'FAILED'
        }
    }

    def goldHistory = {
        def principal = SecurityUtils.subject.principal
        def respondent = User.findByUsername(principal.toString())
        def goldHistory = respondent.respondentProfile?.goldHistory
        [goldHistory:goldHistory, respondent: respondent]
    }
}
