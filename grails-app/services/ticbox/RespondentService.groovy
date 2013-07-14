package ticbox

import org.springframework.context.i18n.LocaleContextHolder

class RespondentService {

    def helperService
    def goldService

    def getProfileItems () {
        return ProfileItem.list()?.sort{it.seq}
    }

    def getRespondentProfileFromParams(Map<String, String> params) {
        def profile = null
        def profileItems = [:]
        def items = ProfileItem.all
        for (Map.Entry<String, String> entry : params.entrySet()) {
            for (ProfileItem item : items) {
                if (entry.value && entry.key.equalsIgnoreCase(item.code)) {

                    switch(item.type){
                        case ProfileItem.TYPES.CHOICE :

                            //TODO all the items must be appended in 1 string
                            profileItems.put(entry.key, entry.value)

                            break

                        case ProfileItem.TYPES.DATE :

                            profileItems.put(entry.key, Date.parse(helperService.getProperty('app.date.format.input', 'dd/MM/yyyy'), entry.value).getTime())

                            break

                        case ProfileItem.TYPES.LOOKUP :

                            //TODO all the items must be appended in 1 string
                            profileItems.put(entry.key, entry.value)

                            break

                        case ProfileItem.TYPES.NUMBER :

                            profileItems.put(entry.key, Double.valueOf(entry.value))

                            break

                        case ProfileItem.TYPES.STRING :

                            profileItems.put(entry.key, entry.value)

                            break

                        default :

                            break

                    }

                    break
                }
            }
        }
        if (profileItems.size() > 0) {
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

    def processReference(String referrer, RespondentProfile referenceProfile) {
        if (referrer && referenceProfile?.userAccount) {

            RespondentProfile referrerProfile = getRespondentByUsername(referrer)

            if (referrerProfile) {

                referrerProfile?.references?.add(referenceProfile?.userAccount?.username)
                referrerProfile.save()

                referenceProfile?.referrer = referrer
                referenceProfile.save()
            }
        }
    }

    def getRespondentByUsername(String username){
        def res = RespondentProfile.createCriteria().list {
            userAccount {
                eq 'username', username
            }
        }

        return res && res.size() > 0 ? res.get(0) : null
    }

}
