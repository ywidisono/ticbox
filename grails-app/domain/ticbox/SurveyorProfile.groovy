package ticbox

class SurveyorProfile {

    User userAccount

    //TODO to be completed
    String companyName
    String address
    String phoneNumber
    String email
    String billingInfo

    static embedded = ['userAccount']

    static constraints = {
        companyName nullable: true
        address nullable: true
        phoneNumber nullable: true
        billingInfo nullable: true
    }
}
