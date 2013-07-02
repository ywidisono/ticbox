package ticbox

class GoldService {

    static String delimiter = ";"

    def saveRedemptionRequest(Map params) throws Exception {
        def redemptionAmount = Double.parseDouble(params.redemptionAmount)
        params.redemptionAmount = redemptionAmount
        params.status = RedemptionRequest.STATUS.New
        def history = deductGold(params)
        def newRequest = new RedemptionRequest(respondentId: params.respondentId, respondentGoldHistoryId: history.id, redemptionAmount: params.redemptionAmount, bankName: params.bankName, bankBranchName: params.bankBranchName, bankAccountNumber: params.bankAccountNumber, bankAccountName: params.bankAccountName, status: params.status).save()
    }

    def deductGold(Map params) throws Exception {
        def goldRateValue = Double.parseDouble(Parameter.findByCode("GOLD_RATE_IDR")?.value)
        def goldAmount = params.redemptionAmount / goldRateValue
        def history
        def respondent = User.findById(params.respondentId)
        if (respondent.respondentProfile.gold >= goldAmount){
            def details = params.bankAccountName + delimiter + params.bankBranchName + delimiter + params.bankAccountNumber + delimiter + params.bankAccountName;
            history = new RespondentGoldHistory(description: "Redemption", amount: goldAmount, type: RespondentGoldHistory.TYPES.EXPENSE, date: new Date(), details: details, status: RespondentGoldHistory.STATUS.IN_PROGRESS).save()
            respondent.respondentProfile.gold -= goldAmount
            respondent.respondentProfile.goldHistory.add(history)
            respondent.save()
        } else {
            throw new Exception("Invalid amount")
        }
        return history
    }

    def addGoldToReferrer(String description, User respondent, Date date) {
        if (respondent.respondentProfile?.referrer) {
            def rewardParam = Parameter.findByCode("REFERRER_REWARD");
            long reward = (rewardParam) ? Long.parseLong(rewardParam.value) : 0
            def referer = User.findByUsername(respondent.respondentProfile.referrer)
            def goldHistory = new RespondentGoldHistory(description: description, amount: reward, type: RespondentGoldHistory.TYPES.INCOME, date: date).save()
            referer.respondentProfile.goldHistory.add(goldHistory)
            referer.respondentProfile.gold += reward
            referer.save()
        }
    }

    def addGoldByTakingSurvey(Survey survey, User respondent) {
        // todo use i18n message template
        def desc = survey.title
        def refDesc = respondent.username + " " + survey.title
        def currentDate = new Date()
        def goldHistory = new RespondentGoldHistory(description: desc, amount: survey.point, type: RespondentGoldHistory.TYPES.INCOME, date: currentDate).save()
        respondent?.respondentProfile?.goldHistory?.add(goldHistory)
        respondent?.respondentProfile?.gold += survey.point
        respondent.save()
        addGoldToReferrer(refDesc, respondent, currentDate)
    }

}
