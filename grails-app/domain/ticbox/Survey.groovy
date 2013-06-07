package ticbox

class Survey {
    static POINT_TYPE = [TRUST:"TRUST", GOLD:"GOLD"]

    static COMPONENTS = [
        SUMMARY_DETAIL : 'DETAIL_SUMMARIES',
        RESPONDENT_FILTER : 'RESPONDENT_FILTER'
    ]

    String id
    String surveyId
    String name
    
    static constraints = {

    }
}
