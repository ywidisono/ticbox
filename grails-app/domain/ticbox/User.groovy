package ticbox

class User {
    String id
    String username
    String passwordHash
    String email
    RespondentProfile respondentProfile
    static hasMany = [ roles: Role, permissions: String ]
    static embedded = ["respondentProfile"]
    static constraints = {
        username(nullable: false, blank: false, unique: true)
        passwordHash(nullable: false)
        email(nullable: true, unique: true)
        respondentProfile(nullable: true)
    }
    static mapping = {
        username index: true
    }
}

