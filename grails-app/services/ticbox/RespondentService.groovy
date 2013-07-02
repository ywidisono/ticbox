package ticbox

class RespondentService {

    def goldService

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

    def saveSurveyReward(String respondentId, String surveyId) throws Exception {
        def respondent = User.findById(respondentId)
        def survey = Survey.findBySurveyId(surveyId)
        if (Survey.POINT_TYPE.GOLD.equalsIgnoreCase(survey.pointType)) {
            goldService.addGoldByTakingSurvey(survey, respondent)
        } else if (Survey.POINT_TYPE.TRUST.equalsIgnoreCase(survey.pointType)) {
            respondent?.respondentProfile?.trust += survey.point
            respondent.save()
        }
    }

    def processReference(String referrer, User reference) {
        if (referrer && reference) {
            User user = User.findByUsername(referrer)
            if (user) {
                user.respondentProfile?.references?.add(reference.username)
                user.save()
                reference.respondentProfile?.referrer = referrer
                reference.save()
            }
        }
    }

}
