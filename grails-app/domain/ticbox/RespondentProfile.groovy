package ticbox

class RespondentProfile {
    Map<String,String> profileItems  = new HashMap<String,String>()
    List<RespondentGoldHistory> goldHistory = new ArrayList<RespondentGoldHistory>()
    long trust = 0
    long gold = 0
    static embedded = ["profileItems", "goldHistory"]
    static constraints = {

    }
}
