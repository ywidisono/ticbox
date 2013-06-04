package ticbox

class RespondentProfile {
    Map<String,String> profileItems
    List<RespondentGoldHistory> goldHistory
    long trust = 0
    long gold = 0
    static embedded = ["profileItems", "goldHistory"]
    static constraints = {
        profileItems (nullable: true)
        goldHistory (nullable: true)
    }
}
