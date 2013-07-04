package ticbox

class RespondentGoldHistory {
    static TYPES = [INCOME_SURVEY:0, INCOME_REFERENCE:1, EXPENSE_REDEMPTION:2]
    static STATUS = [NONE:0,IN_PROGRESS:2,SUCCESS:1]

    String id
    String description
    long amount = 0
    int type
    Date date
    String details
    int status = 0
    static constraints = {
        description (blank: false)
        details (nullable: true)
    }
}
