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
}
