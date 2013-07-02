package ticbox

class RespondentProfile {
    Map<String,Object> profileItems  = [:]
    List<RespondentGoldHistory> goldHistory = []
    String referrer
    List<String> references = []
    long trust = 0
    long gold = 0
    static embedded = ["profileItems", "goldHistory"]
    static constraints = {
        referrer (nullable: true)
    }
}
