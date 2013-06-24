package ticbox

class Survey {
    static POINT_TYPE = [TRUST:"TRUST", GOLD:"GOLD"]

    static QUESTION_TYPE = [
        CHOICE : 'CHOICE',
        FREE_TEXT : 'FREE_TEXT',
        SCALE_RATING : 'SCALE_RATING',
        STAR_RATING : 'STAR_RATING'
    ]

    static COMPONENTS = [
        SUMMARY_DETAIL : 'SUMMARY_DETAIL',
        RESPONDENT_FILTER : 'RESPONDENT_FILTER',
        QUESTION_ITEMS : 'QUESTION_ITEMS',
        LOGO : 'LOGO'
    ]

    String id
    String surveyId
    String name
    String title
    
    static constraints = {
        title maxSize: 1000, nullable: true
    }
}
