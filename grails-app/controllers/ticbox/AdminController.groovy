package ticbox

class AdminController {

    def index() {
        def users = User.all
        [users: users]
    }
}
