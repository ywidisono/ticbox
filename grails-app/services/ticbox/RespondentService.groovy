package ticbox

class RespondentService {

    def getProfileItems () {
        return ProfileItem.list()?.sort{it.seq}
    }

    def getRespondentProfileFromParams(Map<String, String> params) {
        def profile
        def profileItems = [:]
        def items = ProfileItem.all
        for (Map.Entry<String, String> entry : params.entrySet()) {
            for (ProfileItem item : items) {
                if (entry.value && entry.key.equalsIgnoreCase(item.code)) {
                    profileItems.put(entry.key, entry.value)
                    break
                }
            }
        }
        if (items.size() > 0) {
            profile = new RespondentProfile(profileItems: profileItems)
        }
        return profile
    }

    def saveReward(String respondentId, String surveyId) throws Exception {
        def respondent = User.findById(respondentId)
        def survey = Survey.findBySurveyId(surveyId)
        if (Survey.POINT_TYPE.GOLD.equalsIgnoreCase(survey.pointType)) {
            def goldHistory = new RespondentGoldHistory(description: survey.title, amount: survey.point, type: RespondentGoldHistory.TYPES.INCOME, date: new Date()).save()
            respondent?.respondentProfile?.goldHistory?.add(goldHistory)
            respondent?.respondentProfile?.gold += survey.point
        } else if (Survey.POINT_TYPE.TRUST.equalsIgnoreCase(survey.pointType)) {
            respondent?.respondentProfile?.trust += survey.point
        }
        respondent.save()
    }
}
