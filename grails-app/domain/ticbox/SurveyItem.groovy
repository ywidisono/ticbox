package ticbox

class SurveyItem {

    def ANSWER_TYPES = [
        FREE_TEXT : 'FREE_TEXT',    // will have maxLength(int)
        CHOICE : 'CHOICE',          // will have choices([String])
        CHECK_LIST : 'CHECK_LIST',  // will have checkItems([value(String):, picture(String):])
        SCALE : 'SCALE'             // will have from(double), to(double)
    ]

    String id
    String pageId
    String text
    String answerType
    String labelPicture
    String labelVideo

    static constraints = {
    }
}
