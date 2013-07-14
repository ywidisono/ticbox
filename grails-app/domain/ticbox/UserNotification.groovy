package ticbox

class UserNotification {

    String id
    String code
    String username
    String actionLink
    boolean isNoticed = false

    static constraints = {
    }

    static mapping = {
        username index: true
    }
}
