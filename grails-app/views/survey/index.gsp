<%--
  Created by IntelliJ IDEA.
  User: arnold
  Date: 3/24/13
  Time: 10:45 PM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="surveyor"/>
    <title></title>
</head>
<body>

<div id="menuNavPanelContent">

    <div class="line side-panel">
        <div class="line header">
            Panel 1
        </div>
        <div class="line">

        </div>

        <hr>
    </div>

    <div class="line side-panel">
        <div class="line header">
            Panel 2
        </div>
        <div class="line">

        </div>

        <hr>
    </div>

    <div class="line side-panel">

        <div class="line line-centered">

            <button id="createSurveyModalBtn" href="#createSurveyModal" role="button" data-toggle="modal" class="btn-ticbox" type="button"><g:message code="label.button.create" default="Create"/> Survey</button>

        </div>

        <hr>
    </div>

</div>

<div class="line">

    <h3>Your Survey List</h3>

    <table class="table table-striped table-bordered table-hover">
        <thead>
            <tr>
                <th colspan="3">IN PROGRESS</th>
            </tr>
            <tr>
                <th>Name</th>
                <th>Running Time</th>
                <th>Status</th>
            </tr>
        </thead>
        <tbody>
            <g:each in="${inProgress}" var="survey">
                <tr>
                    <td><a href="${request.contextPath}/survey/editSurvey?surveyId=${survey.surveyId}">${survey.name}</a></td>
                    <td></td>
                    <td></td>
                </tr>
            </g:each>
            <tr>
                <td colspan="3"></td>
            </tr>
        </tbody>
    </table>

    <table class="table table-striped table-bordered table-hover">
        <thead>
            <tr>
                <th colspan="3">DRAFTS</th>
            </tr>
            <tr>
                <th>Name</th>
                <th>Total Charge</th>
                <th>Modified</th>
                <th></th>
            </tr>
        </thead>
        <tbody>
            <g:each in="${drafts}" var="survey">
                <tr>
                    <td><a href="${request.contextPath}/survey/editSurvey?surveyId=${survey.surveyId}">${survey.name}</a></td>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>
            </g:each>
            <tr>
                <td colspan="4"></td>
            </tr>
        </tbody>
    </table>

    <table class="table table-striped table-bordered table-hover">
        <thead>
        <tr>
            <th colspan="3">COMPLETED</th>
        </tr>
        <tr>
            <th>Name</th>
            <th>Total Respondents</th>
            <th>Stats</th>
            <th></th>
        </tr>
        </thead>
        <tbody>
        <g:each in="${completes}" var="survey">
            <tr>
                <td><a href="${request.contextPath}/survey/editSurvey?surveyId=${survey.surveyId}">${survey.name}</a></td>
                <td></td>
                <td></td>
                <td></td>
            </tr>
        </g:each>
        <tr>
            <td colspan="4"></td>
        </tr>
        </tbody>
    </table>

</div>

<div id="createSurveyModal" class="modal modal60 hide fade" tabindex="-1" role="dialog" aria-labelledby="createSurveyModalLabel" aria-hidden="true">
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
        <h3 id="createSurveyModalLabel">Create Survey</h3>
    </div>
    <div class="modal-body" style="overflow: auto">

        <label for="surveyName">Please name your survey</label>
        <input type="text" id="surveyName" name="surveyName" param-of="createSurveyBtn">

    </div>
    <div class="modal-footer">
        <button class="btn-ticbox" data-dismiss="modal" aria-hidden="true"><g:message code="label.button.close" default="Close"/></button>
        <button href="${request.contextPath}/survey/createSurvey" id="createSurveyBtn" class="btn-ticbox submit-redirect"><g:message code="label.button.create" default="Create"/></button>
    </div>
</div>

<script type="text/javascript">

    jQuery(function(){



    });

</script>

</body>
</html>