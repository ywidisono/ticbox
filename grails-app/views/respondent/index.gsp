<html>
<head>
    <meta name="layout" content="respondent"/>
    <title>Survey List</title>
    <style type="text/css">
         .surveyList .row-fluid{
             margin: 1em 0;
             border-bottom: 1px solid #eee;
         }

        .center {
            text-align: center;
            vertical-align: middle;
        }
    </style>
</head>
<body>
    <div class="container-fluid surveyList">
        <h3>Survey List</h3>
        <g:each in="${surveyList}" var="survey">
            <div class="row-fluid">
                <div class="span3 center">
                    <div>${survey.point}</div>
                    <div>${survey.pointType}</div>
                </div>
                <div class="span7">
                    <div class="row">
                        <h4>${survey.name}</h4>
                    </div>
                    <div class="row">
                        <g:if test="${ticbox.Survey.POINT_TYPE.GOLD.equalsIgnoreCase(survey.pointType)}">
                            Need ${survey.target} Respondents | Fulfill ${survey.getPercentage()} %
                        </g:if>
                    </div>
                </div>
                <div class="span2">
                    <div class="row">
                        <g:if test="${survey.logo != null}">
                            <img class="logo" src="${g.createLink(controller: "survey", action: "viewLogo", params: [surveyId: survey.id])}"/>
                        </g:if>
                    </div>
                    <div class="row">
                        <g:link>Take Survey</g:link>
                    </div>
                </div>
            </div>
        </g:each>
    </div>
</body>
</html>