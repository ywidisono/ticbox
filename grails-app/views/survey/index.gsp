<%--
  Created by IntelliJ IDEA.
  User: arnold
  Date: 3/24/13
  Time: 10:45 PM
--%>

<%@ page import="ticbox.Survey" contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="surveyor"/>
    <title></title>

    <link rel="stylesheet" type="text/css" href="${resource(dir: 'frameworks/jqplot', file: 'jquery.jqplot.min.css')}" />

    <style type="text/css">

        .surveyItemContainer {
            margin-bottom: 10px;
            clear: right;
        }

        .surveyItemContainer .seqNumberContainer {
            width: 40px;
            vertical-align: top;
            text-align: right;
            padding-right: 5px;
        }

        .surveyItemContainer .questionNumber {
            font-size: 24px;
            font-weight: bold;
            color: #97b11a;
        }

    </style>

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
                <th></th>
            </tr>
        </thead>
        <tbody>
            <g:each in="${inProgress}" var="survey">
                <tr>
                    <td><a href="${request.contextPath}/survey/editSurvey?surveyId=${survey.surveyId}">${survey.name}</a></td>
                    <td></td>
                    <td></td>
                    <td><a class="displayResultLink" surveyid="${survey.surveyId}" href="javascript:void(0)">Display Result</a></td>
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

<div id="displaySurveyResultModal" class="modal modal80 hide fade" tabindex="-1" role="dialog" aria-labelledby="displaySurveyResultModalLabel" aria-hidden="true">
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
        <h3 id="displaySurveyResultModalLabel">Survey Result</h3>
    </div>
    <div class="modal-body" style="overflow: auto">

        <div class="questionItemsContainer">

        </div>

    </div>
    <div class="modal-footer">
        <button class="btn-ticbox" data-dismiss="modal" aria-hidden="true"><g:message code="label.button.close" default="Close"/></button>
    </div>
</div>

<div class="templates">
    <div id="questionItemTemplate" class="surveyItemContainer line rowLine10">

        <div class="line rowLine2">
            <div class="seqNumberContainer questionNumber col"> </div>
            <div class="questionTextContainer col col5" style="max-width: 93%">
                <span class="question-text"></span>
            </div>
        </div>
        <div class="chart-container line rowline2">
            <div class="chart" style="height:300px;width:500px;"></div>
        </div>

    </div>
</div>

<script type="text/javascript" src="${resource(dir: 'frameworks/jqplot', file: 'jquery.jqplot.min.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'frameworks/jqplot/plugins', file: 'jqplot.pieRenderer.min.js')}"></script>

<script type="text/javascript">

    jQuery(function(){

        jQuery('.displayResultLink').click(function(){
            var surveyId = jQuery(this).attr('surveyid');

            jQuery('#displaySurveyResultModal').modal('show').find('.questionItemsContainer').empty();

            jQuery.getJSON('${request.contextPath}/survey/getQuestionItems', {surveyId: surveyId}, function(data){
                loadResultGraph(data);
            });
        });

    });

    function constructQuestionItemCont(questionStr, idx){
        var cont = jQuery('#questionItemTemplate').clone().attr('id', 'qi_'+idx);

        jQuery('.questionNumber', cont).html((idx + 1) + '.');
        jQuery('.questionTextContainer > span.question-text', cont).html(questionStr);

        return cont;
    }

    function loadResultGraph(questionItems){

        var questionItemsContainer = jQuery('#displaySurveyResultModal').find('.questionItemsContainer');

        if (questionItems) {

            jQuery.each(questionItems, function(idx, item){

                var answerDetails = item.answerDetails;
                var container = constructQuestionItemCont(item.questionStr, idx);

                questionItemsContainer.append(container);

                switch(answerDetails.type){

                    case '${Survey.QUESTION_TYPE.CHOICE}' :



                        break;

                    case '${Survey.QUESTION_TYPE.FREE_TEXT}' :



                        break;

                    case '${Survey.QUESTION_TYPE.SCALE_RATING}' :

                        jQuery('.chart-container .chart', container).attr('id', 'mychart');

                        var data = [
                            ['Heavy Industry', 12],['Retail', 9], ['Light Industry', 14],
                            ['Out of home', 16],['Commuting', 7], ['Orientation', 9]
                        ];

                        var plot1 = jQuery.jqplot ('mychart', [data],
                                {
                                    seriesDefaults: {
                                        // Make this a pie chart.
                                        renderer: jQuery.jqplot.PieRenderer,
                                        rendererOptions: {
                                            // Put data labels on the pie slices.
                                            // By default, labels show the percentage of the slice.
                                            showDataLabels: true
                                        }
                                    },
                                    legend: { show:true, location: 'e' }
                                }
                        );

                        break;

                    case '${Survey.QUESTION_TYPE.STAR_RATING}' :



                        break;

                }

            });

        }

    }

</script>

</body>
</html>