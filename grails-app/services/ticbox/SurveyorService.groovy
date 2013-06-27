package ticbox

class SurveyorService {

    def ticboxUtilsService

    SurveyorProfile getCurrentSurveyor(){
        return getSurveyor(ticboxUtilsService.getPrincipal())
    }

    SurveyorProfile getSurveyor(def username){
        def res = SurveyorProfile.createCriteria().list {
            userAccount {
                eq 'username', username
            }
        }

        return res ? res.get(0) : null
    }
}
