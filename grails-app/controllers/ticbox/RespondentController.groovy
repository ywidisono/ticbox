package ticbox

import org.apache.shiro.SecurityUtils

class RespondentController {
    def respondentService

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
}
