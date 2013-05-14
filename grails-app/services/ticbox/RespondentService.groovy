package ticbox

class RespondentService {
    def serviceMethod() {

    }

    def getProfileItems (){
        return ProfileItem.list()?.sort{it.seq}
    }
}
