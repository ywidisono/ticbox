package ticbox

class RedemptionRequest {
    static STATUS = [New:"New", Success:"Success", Failed:"Failed"]

    String id
    String respondentId
    String respondentGoldHistoryId
    double redemptionAmount
    String bankName
    String bankBranchName
    String bankAccountNumber
    String bankAccountName
    String remarks
    String status
    Date dateCreated
    Date lastUpdated
    static constraints = {
        respondentId (blank: false)
        respondentGoldHistoryId (blank: false)
        redemptionAmount (blank: false)
        bankName (blank: false)
        bankBranchName (nullable: true)
        bankAccountNumber (blank: false)
        bankAccountName (blank: false)
        status (blank: false)
        remarks (nullable: true)
    }
}
