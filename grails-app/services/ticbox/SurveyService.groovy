package ticbox

class SurveyService {
    def serviceMethod() {

    }

    def getProfileItemsForRespondentFilter(){
        return ProfileItem.list()?.sort{it.seq}
    }
}
