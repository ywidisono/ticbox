package ticbox

class RespondentGoldHistory {
    static TYPES = [INCOME_SURVEY:0, INCOME_REFERENCE:1, EXPENSE_REDEMPTION:2]
    static STATUS = [NONE:0, SUCCESS:1, IN_PROGRESS:2, FAILED: 3]

    String id
    long respondentId
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

    String typeDisplay() {
        String res = ""
        switch (type) {
            case TYPES.EXPENSE_REDEMPTION :
                res = "Expense"
                break
            case TYPES.INCOME_REFERENCE :
                res = "Income"
                break
            case TYPES.INCOME_SURVEY :
                res = "Income"
                break
        }
        return res
    }

    String statusDisplay() {
        String res = ""
        switch (status) {
            case STATUS.SUCCESS :
                res = "Success"
                break
            case STATUS.FAILED :
                res = "Failed"
                break
            case STATUS.IN_PROGRESS :
                res = "In Progess"
                break
            case STATUS.NONE :
                res = "None"
                break
        }
        return res
    }
}
