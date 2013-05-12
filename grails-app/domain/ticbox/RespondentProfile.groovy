package ticbox

class RespondentProfile {
    String country
    String state
    String city
    String gender
    Date dob
    Double monthlyIncome
    String lastEducation
    String job
    String maritalStatus
    Integer children
    static constraints = {
        country(nullable: false)
        state(nullable: false)
        city(nullable: false)
        gender(nullable: false)
        dob(nullable: false)
        monthlyIncome(nullable: false)
        lastEducation(nullable: false)
        job(nullable: false)
        maritalStatus(nullable: false)
        children(nullable: false)
    }
}
