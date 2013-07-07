package ticbox

class AdminController {
    def userService

    def index() {
        def users = User.all
        def roles = Role.all*.name
        [users: users, userTypes: roles]
    }

    def createUser = {
        try {
            userService.createUser(params)
            flash.message = message(code: "general.create.success.message")
        } catch (Exception e) {
            flash.error = message(code: "general.create.failed.message") + " : " + e.message
            log.error(e.message, e)
        }
        redirect(controller: "admin", action: "index")
    }

    def deleteUsers = {
        try {
            if (params.delUserIds) {
                def delUserIds = ((String) params.delUserIds).split(",")
                userService.deleteUsers(delUserIds)
                flash.message = message(code: "general.delete.success.message")
            } else {
                throw Exception("No user was found")
            }
        } catch (Exception e) {
            flash.error = message(code: "general.delete.failed.message") + " : " + e.message
            log.error(e.message, e)
        }
        redirect(controller: "admin", action: "index")
    }

}
