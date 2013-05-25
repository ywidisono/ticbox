package ticbox

class RespondentProfile {
    Map<String,String> profileItems
    long trust = 0
    long gold = 0
    static embedded = ["profileItems"]
    static constraints = {
    }
}
