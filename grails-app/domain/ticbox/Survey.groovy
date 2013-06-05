package ticbox

class Survey {
    static POINT_TYPE = [TRUST:"TRUST", GOLD:"GOLD"]

    static COMPONENTS = [
        RESPONDENT_FILTER : 'RESPONDENT_FILTER'
    ]

    String id
    String surveyId
    String name
    String pointType
    long point = 0
    long target = 0
    long current = 0
    String logo
    
    static constraints = {
        logo (nullable: true)
    }

    long getPercentage() {
        long result = (target > 0) ? current / target * 100 : 0;
        return result
    }
}
