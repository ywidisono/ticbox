package ticbox

class User {
    String username
    String passwordHash
    String email
    String pic
    RespondentProfile respondentProfile
    static embedded = ["respondentProfile"]
    static hasMany = [ roles: Role ]
    static constraints = {
        username(nullable: false, blank: false, unique: true)
        passwordHash(nullable: false)
        email(nullable: true, unique: true)
        pic(nullable: true)
        respondentProfile(nullable: true)
    }
    static mapping = {
        username index: true
    }
}

