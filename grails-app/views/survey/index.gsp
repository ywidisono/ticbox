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

        .chart-container {
            margin-left: 50px;
        }

        #displaySurveyResultModal {
            top: 5%;
        }

        #displaySurveyResultModal .modal-body {
            max-height: 450px;
        }

        #displaySurveyResultModal .modal-footer {
            padding: 5px 15px 5px;
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
        <div class="chart-container line rowline2" style="padding-top: 10px;">
            <div class="chart" style="height:300px;width:500px;"></div>
        </div>

    </div>
</div>

<script type="text/javascript" src="${resource(dir: 'frameworks/jqplot', file: 'jquery.jqplot.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'frameworks/jqplot/plugins', file: 'jqplot.pieRenderer.min.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'frameworks/jqplot/plugins', file: 'jqplot.highlighter.min.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'frameworks/jqplot/plugins', file: 'jqplot.cursor.min.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'frameworks/jqplot/plugins', file: 'jqplot.dateAxisRenderer.min.js')}"></script>

<script type="text/javascript">

    jQuery(function(){

        jQuery('.displayResultLink').click(function(){
            var that = jQuery(this);
            var surveyId = that.attr('surveyid');

            var txt = that.text();
            that.text('Loading Data..');

            jQuery.getJSON('${request.contextPath}/survey/getSurveyResult', {surveyId: surveyId}, function(result){

                jQuery('#displaySurveyResultModal').modal('show').find('.questionItemsContainer').empty();

                setTimeout(function() {
                    loadResultGraph(result);

                    that.text(txt);
                }, 500);
            });
        });

    });

    function constructQuestionItemCont(questionStr, seq){

        var cont = jQuery('#questionItemTemplate').clone().attr('id', 'qi_'+seq);

        jQuery('.questionNumber', cont).html(seq + '.');
        jQuery('.questionTextContainer > span.question-text', cont).html(questionStr);

        jQuery('.chart-container .chart', cont).attr('id', 'chart_'+seq);

        return cont;
    }

    function loadResultGraph(result){

        var questionItemsContainer = jQuery('#displaySurveyResultModal').find('.questionItemsContainer');

        if (result) {

            jQuery.each(result, function(key, item){

                var questionItem = item.questionItem;
                var summary = item.summary;

                var answerDetails = questionItem.answerDetails;
                var container = constructQuestionItemCont(questionItem.questionStr, key);

                questionItemsContainer.append(container);

                var target = jQuery('.chart-container .chart:first', container);

                switch(answerDetails.type){

                    case '${Survey.QUESTION_TYPE.CHOICE}' :

                        var data = [];

                        jQuery.each(summary, function(label, count){
                            data.push([label, count]);
                        });

                        constructPieChart(target, data, 'Answer Type - Choice');

                        break;

                    case '${Survey.QUESTION_TYPE.FREE_TEXT}' :

                        var line1= [['23-May-08', 578.55], ['20-Jun-08', 566.5], ['25-Jul-08', 480.88], ['22-Aug-08', 509.84],
                            ['26-Sep-08', 454.13], ['24-Oct-08', 379.75], ['21-Nov-08', 303], ['26-Dec-08', 308.56],
                            ['23-Jan-09', 299.14], ['20-Feb-09', 346.51], ['20-Mar-09', 325.99], ['24-Apr-09', 386.15]];

                        constructLineChart(target, line1, 'Answer Type - Free Text');

                        break;

                    case '${Survey.QUESTION_TYPE.SCALE_RATING}' :

                        jQuery.each(summary, function(rowLabel, rowSummary){

                            var data = [];

                            jQuery.each(rowSummary, function(colLabel, count){
                                data.push([colLabel, count]);
                            });

                            var targetCopy = target.clone();

                            jQuery('.chart-container', container).append(targetCopy);

                            constructPieChart(targetCopy, data, 'Scale Rating (' + rowLabel + ')');
                        });

                        target.remove();

                        break;

                    case '${Survey.QUESTION_TYPE.STAR_RATING}' :

                        var data = [];

                        jQuery.each(summary, function(label, count){
                            data.push([label, count]);
                        });

                        constructPieChart(target, data, 'Answer Type - Star Rating');

                        break;

                }

            });

        }

    }

    function constructPieChart(target, data, title){

        return jQuery.jqplot (target, [data],
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
                    legend: { show:true, location: 'e' },
                    title: {
                        text: title?title:'',
                        show: title != null
                    }
                }
        );

    }

    function constructLineChart(target, data, title){

        return jQuery.jqplot(target, [data], {
            title:'Data Point Highlighting',
            axes:{
                xaxis:{
                    renderer:jQuery.jqplot.DateAxisRenderer,
                    tickOptions:{
                        formatString:'%b&nbsp;%#d'
                    }
                },
                yaxis:{
                    tickOptions:{
                        formatString:'$%.2f'
                    }
                }
            },
            highlighter: {
                show: true,
                sizeAdjust: 7.5
            },
            cursor: {
                show: false
            },
            title: {
                text: title?title:'',
                show: title != null
            }
        });
    }

</script>

</body>
</html>