<%--
  Created by IntelliJ IDEA.
  User: arnold
  Date: 4/13/13
  Time: 9:56 PM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="survey"/>
    <title></title>

    <style type="text/css">

        .surveyItemsContainer input, .surveyItemsContainer textarea, .surveyItemsContainer select {
            margin: 2px 0;
        }

        .surveyItemsContainer input[type=text], .surveyItemsContainer textarea {
            width: 500px;
        }

        .surveyItemContainer {
            margin-bottom: 10px;
            clear: right;
        }

        .surveyItemContainer .seqNumberContainer {
            width: 25px;
            vertical-align: top;
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

        #questionTypesContainer .row {
            margin: 2px 0;
        }

    </style>

    <script type="text/javascript">

        var ttlQuestions = 0;

        jQuery(function(){
            jQuery('.enableTooltip').tooltip({
                selector: "button[data-toggle=tooltip]"
            });

            jQuery('.surveyItemType').click(function(){



            });

            jQuery('.surveyItemTypeAdd').click(function(){
                var type = jQuery(this).attr('type');

                var answerComp = null;

                if(type.indexOf('singleText') >= 0){
                    answerComp = jQuery('#answerTemplate-singleText').clone().removeAttr('id');
                }else if(type.indexOf('choice') >= 0){
                    answerComp = jQuery('#answerTemplate-choice').clone().removeAttr('id');

                    if (type.indexOf('single') >= 0) {
                        jQuery('.choice-type', answerComp).val('single');
                    }else if (type.indexOf('multiple') >= 0) {
                        jQuery('.choice-type', answerComp).val('multiple');
                    }

                    jQuery('.add-item', answerComp).click(function(){
                        var newItem = jQuery('.choice-item:first', '#answerTemplate-choice').clone();
                        jQuery('.item-label', newItem).val('');
                        jQuery('.item-check', newItem).click(function(){
                            newItem.remove();
                        });
                        answerComp.append(newItem);
                    });

                    jQuery('.item-check', answerComp).click(function(){
                        jQuery('.choice-item:first', answerComp).remove();
                    });
                }else if(type.indexOf('scale') >= 0){
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
                }

                var questionComp = jQuery('#questionTemplate').clone().removeAttr('id').append(answerComp).appendTo('.surveyItemsContainer');

                jQuery('.surveyItemsContainer > .surveyItemContainer').each(function(idx){
                    jQuery('.questionNumber', jQuery(this)).html(idx + 1 + '.');
                });

                jQuery('.surveyItemActions > .remove', questionComp).click(function(){
                    jQuery(this).parents('.surveyItemContainer').remove();
                    jQuery('.surveyItemsContainer > .surveyItemContainer').each(function(idx){
                        jQuery('.questionNumber', jQuery(this)).html(idx + 1 + '.');
                    });
                });

            });

        });

    </script>

</head>
<body>

<div class="surveyItemsContainer enableTooltip">

</div>

<div id="menuNavPanelContent" style="min-height: 150px">

    <div class="accordion" id="menuNavPanelAccordion" style="width: 220px;">
        <div class="accordion-group">
            <div class="accordion-heading">
                <a class="accordion-toggle" data-toggle="collapse" data-parent="#menuNavPanelAccordion" href="#questionTypesContainer">
                    <g:message code="nav.header.survey-item-types" default="Question Types"/>
                </a>
            </div>
            <div id="questionTypesContainer" class="accordion-body collapse in">
                <div class="accordion-inner" style="padding: 5px 5px;">
                    <div class="row">
                        <a class="btn surveyItemType" href="javascript:void(0)" ><i class="icon-play"></i> <g:message code="survey-item-types.single-text" default="Single Text"/></a>
                        <a class="btn surveyItemTypeAdd" href="javascript:void(0)" type="typedAnswer singleText"><i class="icon-plus"></i></a>
                    </div>
                    <div class="row">
                        <a class="btn surveyItemType" href="javascript:void(0)" ><i class="icon-play"></i> <g:message code="survey-item-types.choice" default="Choice"/></a>
                        <a class="btn surveyItemTypeAdd" href="javascript:void(0)" type="single choice"><i class="icon-plus"></i></a>
                    </div>
                    <div class="row">
                        <a class="btn surveyItemType" href="javascript:void(0)" ><i class="icon-play"></i> <g:message code="survey-item-types.scale" default="Scale"/></a>
                        <a class="btn surveyItemTypeAdd" href="javascript:void(0)" type="scale"><i class="icon-plus"></i></a>
                    </div>
                </div>
            </div>
        </div>
    </div>

</div>

<div class="templates" style="display: none;">

    <div id="questionTemplate" class="surveyItemContainer">

        <div class="line">
            <div class="col seqNumberContainer"> <span class="questionNumber"></span> </div>
            <div class="col questionTextContainer">
                <textarea rows="3" placeholder="${message([code: 'message.type-to-set-question', default: 'Type your question here..'])}"></textarea>
            </div>
            <div class="col surveyItemActions">
                <button class="btn picture" data-toggle="tooltip" data-placement="top" title="Upload picture"><i class="icon-camera"></i></button>
                <button class="btn video" data-toggle="tooltip" data-placement="top" title="Upload video"><i class="icon-play"></i></button>
                <button class="btn remove" data-toggle="tooltip" data-placement="top" title="Remove"><i class="icon-remove"></i></button>
            </div>
        </div>

    </div>

    <div id="answerTemplate-singleText" class="line answerTemplate">
        <div class="col seqNumberContainer"></div>
        <div class="col">
            <textarea rows="3" placeholder="${message([code: 'message.type-to-replace-place-holder', default: 'Type here to change this placeholder..'])}"></textarea>
        </div>
    </div>

    <div id="answerTemplate-choice" class="line answerTemplate">
        <div class="line">
            <div class="col seqNumberContainer"></div>
            <div class="col">
                <select class="choice-type" style="margin-left: 17px;">
                    <option value="single">Single Choice</option>
                    <option value="multiple">Multiple Choice</option>
                </select>
            </div>
            <div class="col">
                <button class="btn add-item"><i class="icon-plus"></i></button>
            </div>
        </div>
        <div class="line choice-item">
            <div class="col seqNumberContainer"></div>
            <div class="col">
                <input class="item-check" type="checkbox" checked>
            </div>
            <div class="col">
                <input class="item-label" type="text" placeholder="${message([code: 'message.type-to-set-label', default: 'Type here to set label..'])}">
            </div>
            <div class="col">
                <a class="btn" href="javascript:void(0)" data-toggle="tooltip" data-placement="right" title="Upload picture"><i class="icon-camera"></i></a>
            </div>
        </div>
    </div>

    <div id="answerTemplate-scale" class="line answerTemplate">
        <div class="col seqNumberContainer"></div>
        <div class="col" style="height:auto; overflow-x: auto; max-width: 770px;">
            <table class="table">
                <thead>
                    <tr class="scale-head">
                        <th style="text-align: center; width: 100px;">
                            <button class="btn add-row">
                                <i class="icon-plus"></i>
                            </button>
                        </th>
                        <th class="rating-label" style="text-align: center">
                            <input type="text" class="input-small" placeholder="Rating label.." style="width: 100px; padding: 1px;">
                        </th>
                        <th>
                            <button class="btn add-rating">
                                <i class="icon-plus"></i>
                            </button>
                        </th>
                    </tr>
                </thead>
                <tbody>
                    <tr class="scale-row">
                        <td style="max-width: 100px;">
                            <input type="text" class="input-small" placeholder="Row label.." style="width: 100px; padding: 1px;">
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

</body>
</html>