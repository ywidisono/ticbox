package ticbox

class TestService {

    def servletContext

    def serviceMethod() {

    }
    def emailBlasterService

    def testSendEmail(){
        String link = "${servletContext.contextPath}/survey"

        emailBlasterService.blastEmail(['arnold.palar@gmail.com'], 'takeSurvey', 'test mail', [link:link])
    }
}
