package ticbox

class RespondentProfile {
    Map<String,Object> profileItems  = [:]
    String referrer
    List<String> references = []
    long trust = 0
    long gold = 0
    static embedded = ["profileItems"]
    static constraints = {
        referrer (nullable: true)
    }
}
