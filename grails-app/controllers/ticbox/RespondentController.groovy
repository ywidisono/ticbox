package ticbox

class RespondentController {
    def respondentService

    def index() {
        render ""
    }

    def profileForm(){
        def profileItems = respondentService.getProfileItems()

        [profileItems : profileItems]
    }


}
