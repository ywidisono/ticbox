package ticbox

class UserNotificationController {

    def ticboxUtilsService

    def index() {
        def userNotification = UserNotification.findByCodeAndUsername(params.code, ticboxUtilsService.getPrincipal())

        if(userNotification) {
            userNotification.isNoticed = true
            userNotification.save()

            redirect uri : userNotification.actionLink
        }else {
            redirect uri: '/'
        }

    }
}
