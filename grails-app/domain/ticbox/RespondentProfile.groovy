package ticbox

class RespondentProfile {
    User userAccount
    Map<String,Object> profileItems  = [:]
    String referrer
    List<String> references = []
    long trust = 0
    long gold = 0
    static embedded = ["profileItems", "userAccount"]
    static constraints = {
        referrer (nullable: true)
    }
}
