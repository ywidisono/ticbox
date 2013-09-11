<html>
<head>
    <meta name="layout" content="respondent"/>
    <title>Survey List</title>
    <style type="text/css">
        .survey {
            background-color: #efefef;
            margin: 1em 0em;
        }

    </style>
</head>
<body>
        <div id="surveyHeader" class="module-header">
            <div class="title">Survey List</div>
        </div>
        <div id="surveyList" class="module-content">
            <g:if test="${surveyList}">
                <g:each in="${surveyList}" var="survey">
                    <div class="row-fluid survey">
                        <div class="span2 center" style="background-color: #dddddd">
                            <div><h2>${survey.point}</h2></div>
                            <div><h3>${survey.pointType}</h3></div>
                        </div>
                        <div class="span8">
                            <div>
                                <h4>${survey.name}</h4>
                            </div>
                            <div>
                                <g:if test="${ticbox.Survey.POINT_TYPE.GOLD.equalsIgnoreCase(survey.pointType)}">
                                    Need 0 Respondents | Fulfill 100%
                                </g:if>
                            </div>
                        </div>
                        <div class="span2 center">
                            <div style="background-color: #dddddd; padding:0.5em">
                                <h3><g:link action="takeSurvey" params="[surveyId:survey.surveyId]">Take Survey</g:link></h3>
                            </div>
                        </div>
                    </div>
                </g:each>
            </g:if>
            <g:else>
                <div class="module-message">There is no survey at the moment..</div>
            </g:else>
        </div>
</body>
</html>