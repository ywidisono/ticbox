package ticbox

import com.sun.xml.internal.messaging.saaj.util.ByteOutputStream
import grails.converters.JSON
import org.apache.shiro.SecurityUtils
import org.springframework.web.multipart.MultipartFile
import org.springframework.web.multipart.MultipartHttpServletRequest
import uk.co.desirableobjects.ajaxuploader.exception.FileUploadException

class RespondentController {
    def respondentService
    def grailsApplication

    def index() {
        render ""
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
        try {
            def inputStream
            def fileExt = params.qqfile.split("\\.").last()
            if (request instanceof MultipartHttpServletRequest) {
                MultipartFile multipartFile = ((MultipartHttpServletRequest) request).getFile("qqfile")
                inputStream = multipartFile.inputStream
            } else {
                inputStream = request.inputStream
            }
            def filePath = grailsApplication.config.ticbox.imageUpload.respondentImageDir + params.respondentId + "." + fileExt
            def uploaded = new File(filePath)
            if(uploaded.exists()) uploaded.delete()
            uploaded.createNewFile()
            writeToFile(inputStream, uploaded)

            // update user
            def user = User.findById(params.respondentId)
            user.pic = uploaded.getName()
            user.save()

            return render(text: [success:true, fileName: uploaded.getName()] as JSON, contentType:'text/json')
        } catch (FileUploadException e) {
            log.error("Failed to upload file.", e)
            return render(text: [success:false] as JSON, contentType:'text/json')
        }

    }

    def viewImage = {
        def user = User.findById(params.respondentId)
        def image = (user?.pic) ? new File(grailsApplication.config.ticbox.imageUpload.respondentImageDir + user.pic) : null
        def imageByte
        if (image) {
            def is = new FileInputStream(image)
            imageByte = is.bytes
        }
        response.outputStream << imageByte
    }

    private void writeToFile(InputStream inputStream, File file) {

        try {
            file << inputStream
        } catch (Exception e) {
            throw new FileUploadException(e)
        }

    }
}
