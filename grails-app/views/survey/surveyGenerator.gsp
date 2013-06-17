<%--
  Created by IntelliJ IDEA.
  User: arnold
  Date: 4/13/13
  Time: 9:56 PM
--%>

<%@ page import="ticbox.Survey" contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="survey"/>
    <title></title>

    <style type="text/css">

        .surveyItemsContainer input, .surveyItemsContainer textarea, .surveyItemsContainer select {
            margin: 0;
        }

        .surveyItemsContainer input[type=text], .surveyItemsContainer textarea {
            width: 500px;
        }

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

        .questionNumber {
            font-size: 24px;
            font-weight: bold;
            color: #97b11a;
        }

        .surveyItemContainer table {
            margin-bottom: 0;
        }

        .surveyItemContainer .table th, .surveyItemContainer .table td{
            padding: 5px 1px;
        }

        .surveyItemContainer .item-label {
            width: 485px !important;
        }

        #questionTypesMenuContainer {
            width: 300px;
            height: auto;
            background: #97b11a;
            color: #ffffff;
            padding: 10px 0 30px 0 !important;
            position: relative;
        }

        #questionTypesItemContainer{
            width: 260px;
            height:70px;
            margin: 0 auto;
            background: #ffffff;
        }

        #questionTypesItemContainer ul {
            list-style: none;
            margin: 70px 0 0 0;
            padding: 0;
            display: block;
        }

        #questionTypesItemContainer ul li {
            float:left;
            width:52px;
            height:70px;
            background:transparent url('../images/ticbox/question_BasicState.png');
            background-position: 0 0;
        }

        #questionTypesTitleContainer {
            background:transparent url('../images/ticbox/00_Question-Type.png') center no-repeat !important;
            width: 100% !important;
            height: 70px !important;
            margin: 0 !important;
            padding: 0 !important;
            position: absolute;
            top: 7px;
            left: 0;
        }

        #questionTypesItemContainer ul li:hover {
            background:transparent url('../images/ticbox/question_ActiveState.png');
        }

        #questionTypesItemContainer ul li{
            background-position: 0 0;
        }
        #questionTypesItemContainer ul li.single-choice:hover ~ #questionTypesTitleContainer {
            background:transparent url('../images/ticbox/01_SingleChoice.png') center no-repeat !important;
        }

        #questionTypesItemContainer ul li.multiple-choice{
            background-position: 208px 0;
        }
        #questionTypesItemContainer ul li.multiple-choice:hover ~ #questionTypesTitleContainer {
            background:transparent url('../images/ticbox/02_MultipleChoice.png') center no-repeat !important;
        }

        #questionTypesItemContainer ul li.single-text{
            background-position: 156px 0;
        }
        #questionTypesItemContainer ul li.single-text:hover ~ #questionTypesTitleContainer {
            background:transparent url('../images/ticbox/03_FreeText.png') center no-repeat !important;
        }

        #questionTypesItemContainer ul li.scale{
            background-position: 104px 0;
        }
        #questionTypesItemContainer ul li.scale:hover ~ #questionTypesTitleContainer {
            background:transparent url('../images/ticbox/04_ScaleRating.png') center no-repeat !important;
        }

        #questionTypesItemContainer ul li.star-rating{
            background-position: 52px 0;
        }
        #questionTypesItemContainer ul li.star-rating:hover ~ #questionTypesTitleContainer {
            background:transparent url('../images/ticbox/05_StarRating.png') center no-repeat !important;
        }

        .answerTemplate {
            margin: 0 0 0 45px;
        }

        .question-action-btn {
            width: 20px;
            height: 15px;
        }

        .upload-pic-icon {
            background: transparent url("../images/ticbox/06_Question_UploadIcon_Picture.png") no-repeat center;
        }

        .upload-vid-icon {
            background: transparent url("../images/ticbox/07_Question_UploadIcon_Video.png") no-repeat center;
        }

        .delete-question-icon {
            background: transparent url("../images/ticbox/07_Question_Delete.png") no-repeat center;
        }

        .single-choice-icon {
            background: transparent url("../images/ticbox/01b_SingleChoice.png") no-repeat center;
        }

        .multiple-choice-icon {
            background: transparent url("../images/ticbox/02b_MultipleChoice.png") no-repeat center;
        }

        .free-text-icon {
            background: transparent url("../images/ticbox/03b_FreeText.png") no-repeat center;
        }

        .scale-rating-icon {
            background: transparent url("../images/ticbox/04b_ScaleRating.png") no-repeat center;
        }
        .star-rating-icon {
            background: transparent url("../images/ticbox/05b_StarRating.png") no-repeat center;
        }

    </style>

    <script type="text/javascript">

        var ttlQuestions = 0;

        jQuery(function() {

            jQuery('#surveyLogo').click(function(){
                jQuery('.qq-upload-button > input').trigger('click');
            });

            jQuery('.enableTooltip').tooltip({
                selector: "button[data-toggle=tooltip]"
            });

            jQuery('.surveyItemTypeAdd').click(function(){
                var type = jQuery(this).attr('type');
                var subtype = jQuery(this).attr('subtype');

                constructQuestionItem(type, subtype);

            });

            jQuery('#submitSurveyBtn').click(function(){

                var questionItems = buildQuestionItemsMap();
                submitSurvey(questionItems);

            });

            jQuery('#surveyTitle').val('${survey.title}');

            jQuery.getJSON('${request.contextPath}/survey/getQuestionItems', {}, function(questionItems){

                loadSurvey(questionItems);

            });

            jQuery('#surveyPreviewModal').on('shown', function(){

                var questionItems = buildQuestionItemsMap();
                constructPreview(questionItems);

            });

        });

        function constructQuestionItem(type, subtype){
            var answerComp = null;

            var changeTypeIconClass = '';

            switch(type){

                case '${Survey.QUESTION_TYPE.CHOICE}' :

                    answerComp = jQuery('#answerTemplate-choice').clone().removeAttr('id');

                    if (subtype == 'single') {
                        jQuery('.choice-type', answerComp).val('single');

                        changeTypeIconClass = 'single-choice-icon';
                    }else if (subtype == 'multiple') {
                        jQuery('.choice-type', answerComp).val('multiple');

                        changeTypeIconClass = 'multiple-choice-icon';
                    }

                    jQuery('.add-item', answerComp).click(function(){
                        var newItem = jQuery('.choice-item:first', '#answerTemplate-choice').clone();
                        jQuery('.item-label', newItem).val('');
                        jQuery('.item-check', newItem).click(function(){
                            newItem.remove();
                        });

                        newItem.appendTo(jQuery('.choice-items', answerComp));
                    });

                    jQuery('.item-check', answerComp).click(function(){
                        jQuery('.choice-item:first', answerComp).remove();
                    });

                    break;

                case '${Survey.QUESTION_TYPE.FREE_TEXT}' :

                    answerComp = jQuery('#answerTemplate-singleText').clone().removeAttr('id');
                    changeTypeIconClass = 'free-text-icon';

                    break;

                case '${Survey.QUESTION_TYPE.SCALE_RATING}' :

                    answerComp = jQuery('#answerTemplate-scale').clone().removeAttr('id');

                    jQuery('.add-row', answerComp).click(function(){
                        var row = jQuery('.scale-row:first', answerComp).clone();
                        jQuery('table', answerComp).append(row);
                        jQuery('.rating-weight > input', row).attr('name', 'rd-'+jQuery('.scale-row',answerComp).size());
                    });

                    jQuery('.add-rating', answerComp).click(function(){
                        var ratingLabel = jQuery('.rating-label', '#answerTemplate-scale').clone();
                        jQuery(this).parent().before(ratingLabel);

                        jQuery('.scale-row', answerComp).each(function(idx){
                            var ratingWeight = jQuery('.rating-weight', '#answerTemplate-scale').clone();
                            jQuery('.rating-weight:last', jQuery(this)).after(ratingWeight);
                            jQuery('input', ratingWeight).attr('name', jQuery('.rating-weight > input:first',ratingWeight.parent()).attr('name'));
                        });
                    });

                    changeTypeIconClass = 'scale-rating-icon';

                    break;

                case '${Survey.QUESTION_TYPE.STAR_RATING}' :



                    break;

            }

            var questionComp = jQuery('#questionTemplate').clone().removeAttr('id').append(answerComp).appendTo('.surveyItemsContainer');

            jQuery('.change-question-type-btn', questionComp).addClass(changeTypeIconClass);

            jQuery('.surveyItemsContainer > .surveyItemContainer').each(function(idx){
                jQuery('.questionNumber', jQuery(this)).html(idx + 1 + '.');
            });

            jQuery('.surveyItemActions .remove', questionComp).click(function(){
                jQuery(this).parents('.surveyItemContainer').remove();
                jQuery('.surveyItemsContainer > .surveyItemContainer').each(function(idx){
                    jQuery('.questionNumber', jQuery(this)).html(idx + 1 + '.');
                });
            });

            return questionComp;
        }

        function buildQuestionItemsMap(){
            var questionItems = [];

            jQuery('.surveyItemsContainer > .surveyItemContainer').each(function(){

                var container = jQuery(this);
                var type = jQuery('.answerTemplate', container).attr('type');

                var questionStr = jQuery('.questionTextContainer > textarea', container).val();
                var answerDetails = {};
                answerDetails['type'] = type;

                switch(type){

                    case '${Survey.QUESTION_TYPE.CHOICE}' :

                        answerDetails['choiceItems'] = [];
                        jQuery('.choice-items > .choice-item', container).each(function(){

                            var item = jQuery(this);
                            answerDetails['choiceItems'].push(jQuery('input.item-label', item).val());
                        });

                        answerDetails['choiceType'] = jQuery('select.choice-type', container).val();

                        break;

                    case '${Survey.QUESTION_TYPE.FREE_TEXT}' :

                        answerDetails['questionPlaceholder'] = jQuery('textarea.place-holder-text', container).val();

                        break;

                    case '${Survey.QUESTION_TYPE.SCALE_RATING}' :

                        answerDetails['ratingLabels'] = [];
                        jQuery('table.scale-table > thead .rating-label input', container).each(function(){

                            answerDetails['ratingLabels'].push(jQuery(this).val());

                        });

                        answerDetails['rowLabels'] = [];
                        jQuery('table.scale-table > tbody input.row-label', container).each(function(){

                            answerDetails['rowLabels'].push(jQuery(this).val());

                        });

                        break;

                    case '${Survey.QUESTION_TYPE.STAR_RATING}' :



                        break;

                }

                questionItems.push({
                    questionStr : questionStr,
                    answerDetails : answerDetails
                });

            });

            return questionItems
        }

        function submitSurvey(questionItems){

            jQuery.post('${request.contextPath}/survey/submitQuestionItems', {questionItems: JSON.stringify(questionItems), surveyTitle: jQuery('#surveyTitle').val()}, function(data){

                if('SUCCESS' == data){
                    alert('Submission success..');
                }else{
                    alert('Submission failure');
                }

            });
        }

        function loadSurvey(questionItems){

            if (questionItems) {

                jQuery.each(questionItems, function(idx, item){

                    var answerDetails = item.answerDetails;
                    var container = null;

                    switch(answerDetails.type){

                        case '${Survey.QUESTION_TYPE.CHOICE}' :

                            var choiceItems = answerDetails.choiceItems;
                            var choiceType = answerDetails.choiceType;

                            container = constructQuestionItem(answerDetails.type, choiceType);

                            jQuery.each(choiceItems, function(idx, choiceItem){
                                var choiceItemCont = jQuery('.choice-items > .choice-item:first', container).clone();
                                jQuery('.choice-items', container).append(choiceItemCont
                                );
                                jQuery('.item-label', choiceItemCont).val(choiceItem);
                            });
                            jQuery('.choice-items > .choice-item:first', container).remove();

                            jQuery('select.choice-type', container).val(choiceType);

                            break;

                        case '${Survey.QUESTION_TYPE.FREE_TEXT}' :

                            var questionPlaceHolder = answerDetails.questionPlaceholder;

                            container = constructQuestionItem(answerDetails.type);

                            jQuery('textarea.place-holder-text', container).val(questionPlaceHolder);

                            break;

                        case '${Survey.QUESTION_TYPE.SCALE_RATING}' :

                            var ratingLabels = answerDetails.ratingLabels;
                            var rowLabels = answerDetails.rowLabels;

                            container = constructQuestionItem(answerDetails.type);

                            jQuery.each(ratingLabels, function(idx, ratingLabel){
                                var ratingLabelCont = jQuery('table.scale-table > thead th.rating-label:first', container).clone();
                                jQuery('table.scale-table > thead th.rating-label:first', container).after(ratingLabelCont);
                                jQuery('input', ratingLabelCont).val(ratingLabel);
                            });
                            jQuery('table.scale-table > thead th.rating-label:first', container).remove();

                            jQuery.each(rowLabels, function(idx, rowLabel){
                                var rowLabelCont = jQuery('table.scale-table > tbody > tr.scale-row:first', container).clone();
                                jQuery('table.scale-table > tbody > tr.scale-row:first', container).after(rowLabelCont);
                                jQuery('input.row-label', rowLabelCont).val(rowLabel);
                                for(var i = 1; i < ratingLabels.length; i++){
                                    jQuery('td.rating-weight:first', rowLabelCont).after(jQuery('td.rating-weight:first', rowLabelCont).clone());
                                }
                            });
                            jQuery('table.scale-table > tbody > tr.scale-row:first', container).remove();

                            break;

                        case '${Survey.QUESTION_TYPE.STAR_RATING}' :



                            break;

                    }

                    jQuery('.questionTextContainer textarea', container).val(item.questionStr);

                });

            }

        }

        function constructPreview(questionItems){

            jQuery.each(questionItems, function(idx, item){

                var questionStr = item.questionStr;
                var answerDetails = item.answerDetails;

                switch(answerDetails.type){

                    case '${Survey.QUESTION_TYPE.CHOICE}' :

                        var choiceItems = answerDetails.choiceItems;
                        var choiceType = answerDetails.choiceType;

                        jQuery.each(choiceItems, function(idx, choiceItem){

                        });

                        break;

                    case '${Survey.QUESTION_TYPE.FREE_TEXT}' :

                        var questionPlaceHolder = answerDetails.questionPlaceholder;

                        break;

                    case '${Survey.QUESTION_TYPE.SCALE_RATING}' :

                        var ratingLabels = answerDetails.ratingLabels;
                        var rowLabels = answerDetails.rowLabels;

                        jQuery.each(ratingLabels, function(idx, ratingLabel){

                        });

                        jQuery.each(rowLabels, function(idx, rowLabel){

                        });

                        break;

                    case '${Survey.QUESTION_TYPE.STAR_RATING}' :



                        break;

                }

            });
        }

    </script>

    <r:require module="fileuploader" />

</head>
<body>

<div class="line rowLine10">
    <div class="col col10">
        <div id="surveyLogo" class="clickable" style="width: 250px; height: 150px; background: #f5f5f5 url('../images/ticbox/Logo_Placeholder.png') no-repeat center">
            <img src="${request.contextPath}/survey/viewLogo" style="width: 250px; height: 150px">
        </div>
    </div>
    <div class="col" style="width: 400px; height: auto; vertical-align: bottom; display: inline-block; color: #97b11a; padding-top: 80px;">
        <g:message code="label.survey.survey-generator.survey-title" default="Your survey title here"/>
        <textarea id="surveyTitle" style="width: 350px; display: inline-block; resize: none;"></textarea>
    </div>
</div>

<div class="line" style="display: none">
    <uploader:uploader id="imageUploader" url="${[controller:'survey', action:'uploadLogo']}" params="${[:]}">
        <uploader:onComplete>
            jQuery('#surveyLogo > img').attr('src', '${request.contextPath}/survey/viewLogo');
        </uploader:onComplete>
    </uploader:uploader>
</div>

<div class="surveyItemsContainer enableTooltip line10">

</div>

<div class="line" style="text-align: center">
    <button id="submitSurveyBtn" class="btn-ticbox"><g:message code="label.button.submit" default="SUBMIT"/></button>
</div>

<div id="menuNavPanelContent" class="line">

    <div id="questionTypesMenuContainer" class="side-panel">
        <div id="questionTypesItemContainer">
            <ul>
                <li class="surveyItemTypeAdd single-choice clickable" type="${Survey.QUESTION_TYPE.CHOICE}" subtype="single"></li>
                <li class="surveyItemTypeAdd multiple-choice clickable" type="${Survey.QUESTION_TYPE.CHOICE}" subtype="multiple"></li>
                <li class="surveyItemTypeAdd single-text clickable" type="${Survey.QUESTION_TYPE.FREE_TEXT}"></li>
                <li class="surveyItemTypeAdd scale clickable" type="${Survey.QUESTION_TYPE.SCALE_RATING}"></li>
                <li class="surveyItemTypeAdd star-rating clickable" type="${Survey.QUESTION_TYPE.STAR_RATING}"></li>

                <li id="questionTypesTitleContainer"></li>

            </ul>
        </div>
    </div>

    <div class="line" style="text-align: center">
        <button class="btn-ticbox" href="#surveyPreviewModal" role="button" data-toggle="modal"><g:message code="label.button.preview" default="PREVIEW" /> </button>
    </div>

</div>

<div class="templates" style="display: none;">

    <div id="questionTemplate" class="surveyItemContainer line rowLine10">

        <div class="line rowLine2">
            <div class="seqNumberContainer questionNumber col"> </div>
            <div class="questionTextContainer col col5">
                <textarea rows="3" placeholder="${message([code: 'message.type-to-set-question', default: 'Type your question here..'])}"></textarea>
            </div>
            <div class="col surveyItemActions">
                <div class="line rowLine2">
                    <div class="col col5">
                        %{--<button class="btn picture" data-toggle="tooltip" data-placement="top" title="Upload picture"><i class="icon-camera"></i></button>--}%
                        <div class="question-action-btn upload-pic-icon clickable"></div>
                    </div>
                    <div class="col">
                        %{--<button class="btn video" data-toggle="tooltip" data-placement="top" title="Upload video"><i class="icon-play"></i></button>--}%
                        <div class="question-action-btn change-question-type-btn clickable"></div>
                    </div>
                </div>
                <div class="line">
                    <div class="col col5">
                        %{--<button class="btn remove" data-toggle="tooltip" data-placement="top" title="Remove"><i class="icon-remove"></i></button>--}%
                        <div class="question-action-btn upload-vid-icon clickable"></div>
                    </div>
                    <div class="col">
                        %{--<button class="btn remove" data-toggle="tooltip" data-placement="top" title="Remove"><i class="icon-remove"></i></button>--}%
                        <div class="remove question-action-btn delete-question-icon clickable"></div>
                    </div>
                </div>
            </div>
        </div>

    </div>

    <div id="answerTemplate-singleText" class="answerTemplate line rowLine2" type="${Survey.QUESTION_TYPE.FREE_TEXT}">
        <div class="col">
            <textarea class="place-holder-text" rows="3" placeholder="${message([code: 'message.type-to-replace-place-holder', default: 'Type here to change this placeholder..'])}"></textarea>
        </div>
    </div>

    <div id="answerTemplate-choice" class="answerTemplate line rowLine2" type="${Survey.QUESTION_TYPE.CHOICE}">
        <div class="choice-items line">
            <div class="choice-item line rowLine2">
                <div class="col col5">
                    <input class="item-check" type="checkbox" checked>
                </div>
                <div class="col col5 ">
                    <input class="item-label" type="text" placeholder="${message([code: 'message.type-to-set-label', default: 'Type here to set label..'])}">
                </div>
                <div class="col" style="height: 30px">
                    %{--<button class="btn" data-toggle="tooltip" data-placement="right" title="Upload picture"><i class="icon-camera"></i></button>--}%
                    <div style="width: 20px; height: 100%; cursor: pointer; background: transparent url('../images/ticbox/06_Question_UploadIcon_Picture.png') no-repeat center"></div>
                </div>
            </div>
        </div>
        <div class="line rowLine2">
            <div class="col col2">
                <select class="choice-type">
                    <option value="single">Single Choice</option>
                    <option value="multiple">Multiple Choice</option>
                </select>
            </div>
            <div class="col">
                <button class="btn add-item"><i class="icon-plus"></i></button>
            </div>
        </div>
    </div>

    <div id="answerTemplate-scale" class="answerTemplate line rowLine2" type="${Survey.QUESTION_TYPE.SCALE_RATING}">
        <div class="col" style="height:auto; overflow-x: auto; max-width: 720px;">
            <table class="table scale-table">
                <thead>
                    <tr class="scale-head">
                        <th style="text-align: center; width: 100px;">
                            <button class="btn btn-small add-row">
                                <i class="icon-plus"></i>
                            </button>
                        </th>
                        <th class="rating-label" style="text-align: center">
                            <input type="text" class="input-small" placeholder="Rating label.." style="width: 100px; padding: 1px;">
                        </th>
                        <th>
                            <button class="btn btn-small add-rating">
                                <i class="icon-plus"></i>
                            </button>
                        </th>
                    </tr>
                </thead>
                <tbody>
                    <tr class="scale-row">
                        <td style="max-width: 100px;">
                            <input type="text" class="row-label input-small" placeholder="Row label.." style="width: 100px; padding: 1px;">
                        </td>
                        <td class="rating-weight" style="text-align: center">
                            <input type="radio" name="rd-1">
                        </td>
                        <td></td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>


</div>

<!-- Preview Modal -->
<div id="surveyPreviewModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="surveyPreviewModalLabel" aria-hidden="true">
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
        <h3 id="surveyPreviewModalLabel">Survey Preview</h3>
    </div>
    <div class="modal-body">

    </div>
    <div class="modal-footer">
        <button class="btn-ticbox" data-dismiss="modal" aria-hidden="true">Close</button>
    </div>
</div>

</body>
</html>