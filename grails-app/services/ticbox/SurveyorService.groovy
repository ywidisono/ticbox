package ticbox

class SurveyorService {

    def ticboxUtilsService

    SurveyorProfile getCurrentSurveyor(){
        return getSurveyor(ticboxUtilsService.getPrincipal())
    }

    SurveyorProfile getSurveyor(def username){
        SurveyorProfile surveyor = SurveyorProfile.createCriteria().list {
            userAccount {
                eq 'username', username
            }
        }?.get(0)

        return surveyor
    }
}
