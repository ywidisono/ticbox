<%--
  Created by IntelliJ IDEA.
  User: arnold
  Date: 3/24/13
  Time: 11:48 PM
  To change this template use File | Settings | File Templates.
--%>

<%@ page import="ticbox.Survey; ticbox.ProfileItem; ticbox.LookupMaster" contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="surveyor"/>
    <title></title>

    <style type="text/css">

        #filterForm .well {
            background-color: #ffffff;
            border-color: #7F9B09;
        }

        #filterForm .control-group {
            margin-bottom: 10px;
        }

        #filterForm .profile-item-container {
            -webkit-box-shadow: 0 6px 5px -5px #a0a0a0/*#7F9B09*/;
            -moz-box-shadow: 0 6px 5px -5px#a0a0a0/*#7F9B09*/;
            box-shadow: 0 6px 5px -5px #a0a0a0/*#7F9B09*/;
            margin-bottom: 10px;
            padding: 10px 0 10px 0;
        }

        #filterForm.form-horizontal .controls {
            margin-right: 25px;
        }

    </style>

    <script type="text/javascript">

        jQuery(function(){

            jQuery('input.surveyType[value="${survey.type}"]').prop('checked', true);

            jQuery('#addFilterBtn').click(function(){

                var filterComponentCode = jQuery('#respondentFilterComponents').val();

                populateFilterComponent(filterComponentCode);

            });

            jQuery('#submitFilterBtn').click(function(){

                var filterItems = [];

                jQuery('#filterForm').find('.profile-item-container').each(function(){

                    var filterItem = {};

                    filterItem['code'] = jQuery(this).attr('code');
                    filterItem['type'] = jQuery(this).attr('type');
                    filterItem['label'] = jQuery(this).attr('label');

                    switch(filterItem['type']){

                        case '${ProfileItem.TYPES.STRING}' :

                            filterItem['val'] = jQuery('.filter-value', this).val();

                            break;

                        case '${ProfileItem.TYPES.NUMBER}' :

                            filterItem['valFrom'] = jQuery('.filter-value-from', this).val();
                            filterItem['valTo'] = jQuery('.filter-value-to', this).val();

                            break;

                        case '${ProfileItem.TYPES.CHOICE}' :
                            filterItem['checkItems'] = [];
                            jQuery('input.check-item:checked', this).each(function(){
                                if (jQuery(this).attr('label')) {
                                    filterItem['checkItems'].push({key:jQuery(this).val(), value:jQuery(this).attr('label')});
                                } else {
                                    filterItem['checkItems'].push(jQuery(this).val());
                                }
                            });

                            break;

                        case '${ProfileItem.TYPES.LOOKUP}' :
                            filterItem['checkItems'] = [];
                            jQuery('input.check-item:checked', this).each(function(){
                                filterItem['checkItems'].push({key:jQuery(this).val(), value:jQuery(this).attr('label')});
                            });

                            break;

                        case '${ProfileItem.TYPES.DATE}' :

                            filterItem['valFrom'] = jQuery('.filter-value-from', this).val();
                            filterItem['valTo'] = jQuery('.filter-value-to', this).val();

                            break;

                        default :

                            break;

                    }

                    filterItems.push(filterItem);

                });

                var filterItemsJSON = JSON.stringify(filterItems);

                jQuery.getJSON('${request.contextPath}/survey/submitRespondentFilter', {filterItemsJSON : filterItemsJSON, surveyType:jQuery('input.surveyType:checked').val()}, function(data){

                    alert('Submitted');

                    loadRespondentFilter(data);
                });

            });

            jQuery.getJSON('${request.contextPath}/survey/getRespondentFilter', {}, function(respondentFilter){

                jQuery.each(respondentFilter, function(idx, filter){
                    populateFilterComponent(filter.code, filter)
                });

                loadRespondentFilter(respondentFilter);

            });

        });

        function populateFilterComponent(filterComponentCode, filter){
            var template = jQuery('#filterTemplates').find('.control-group[code="'+ filterComponentCode +'"]');

            if (template.length > 0) {
                jQuery('#filterForm').append(template);

                jQuery('.remove-filter', template).click(function(){
                    jQuery(this).parent().appendTo(jQuery('#filterTemplates'));
                });

                if(filter){
                    switch(filter.type){

                        case '${ProfileItem.TYPES.STRING}' :

                            jQuery('.filter-value', template).val(filter.val);

                            break;

                        case '${ProfileItem.TYPES.NUMBER}' :

                            jQuery('.filter-value-from', template).val(filter.valFrom);
                            jQuery('.filter-value-to', template).val(filter.valTo);

                            break;

                        case '${ProfileItem.TYPES.CHOICE}' :
                            var filter_ = filter;
                            jQuery('input.check-item', template).each(function(){
                                var chkBox = this;
                                jQuery.each(filter_.checkItems, function(idx, item){
                                    if(item instanceof Object){
                                        if(jQuery(chkBox).val() == item.key){
                                            //jQuery(chkBox).prop('checked', true);
                                            jQuery(chkBox).parent().find('a').trigger('click');
                                        }
                                    }else{
                                        if(jQuery(chkBox).val() == item){
                                            //jQuery(chkBox).prop('checked',true);
                                            jQuery(chkBox).parent().find('a').trigger('click');
                                        }
                                    }
                                });
                            })/*.prettyCheckable()*/;

                            break;

                        case '${ProfileItem.TYPES.LOOKUP}' :
                            var filter_ = filter;
                            jQuery('input.check-item', template).each(function(){
                                var chkBox = this;
                                jQuery.each(filter_.checkItems, function(idx, item){
                                    if(item instanceof Object){
                                        if(jQuery(chkBox).val() == item.key){
                                            //jQuery(chkBox).prop('checked', true);
                                            jQuery(chkBox).parent().find('a').trigger('click');
                                        }
                                    }else{
                                        if(jQuery(chkBox).val() == item){
                                            //jQuery(chkBox).prop('checked', true);
                                            jQuery(chkBox).parent().find('a').trigger('click');
                                        }
                                    }
                                });
                            })/*.prettyCheckable()*/;

                            break;

                        case '${ProfileItem.TYPES.DATE}' :

                            jQuery('.filter-value-from', template).val(filter.valFrom);
                            jQuery('.filter-value-to', template).val(filter.valTo);

                            break;

                        default :

                            break;

                    }
                }
            }
        }

        function loadRespondentFilter(respondentFilter){

            if(respondentFilter){
                jQuery('.filter-details-container').empty();

                jQuery.each(respondentFilter, function(idx, filter){

                    var filterContent = null;

                    switch(filter.type){

                        case '${ProfileItem.TYPES.STRING}' :

                            filterContent = jQuery('<div style="margin-left: 15px"></div>').append(filter.val);

                            break;

                        case '${ProfileItem.TYPES.NUMBER}' :

                            filterContent = jQuery('<div style="margin-left: 15px"></div>').append(filter.valFrom + ' - ' + filter.valTo);

                            break;

                        case '${ProfileItem.TYPES.CHOICE}' :

                            filterContent = jQuery('<div style="margin-left: 15px"></div>');
                            var ul = jQuery('<ul></ul>');

                            jQuery.each(filter.checkItems, function(idx, item){
                                if (item instanceof Object) {
                                    ul.append(jQuery('<li></li>').append(item.value));
                                }else{
                                    ul.append(jQuery('<li></li>').append(item));
                                }
                            });

                            filterContent.append(ul);

                            break;

                        case '${ProfileItem.TYPES.LOOKUP}' :

                            filterContent = jQuery('<div style="margin-left: 15px"></div>');
                            var ul = jQuery('<ul></ul>');

                            jQuery.each(filter.checkItems, function(idx, item){
                                ul.append(jQuery('<li></li>').append(item.value));
                            });

                            filterContent.append(ul);

                            break;

                        case '${ProfileItem.TYPES.DATE}' :

                            filterContent = jQuery('<div style="margin-left: 15px"></div>').append(filter.valFrom + ' - ' + filter.valTo);

                            break;

                        default :

                            break;

                    }

                    jQuery('.filter-details-container').append(jQuery('<div class="line"><div>')
                            .append(jQuery('<label></label>').append(jQuery('<strong></strong>').append(filter.label + ' : ')))
                            .append(filterContent)
                    );

                });

            }else{
                //TODO no survey fetched
            }
        }

    </script>

</head>
<body>

<div id="menuNavPanelContent">

    <div class="line side-panel">
        <div class="line header">
            Survey
        </div>
        <div class="line">
            Name : ${survey.name}
        </div>
        <hr/>
    </div>

    <div class="line side-panel">
        <div class="line header">
            Charge Summary
        </div>
        <div class="line">
            Total : $<span class="total-charge"></span>
        </div>
        <div class="line">
            $<span class="charge-per-respondent"></span> x <span class="total-respondents"></span> Respondents
        </div>
        <hr>
    </div>

    <div class="line side-panel">
        <div class="line header">
            Filter Details
        </div>
        <div class="filter-details-container line">

        </div>
        <hr>
    </div>

</div>

<div class="line line-centered">
    <h3>Choose Your Survey Type</h3>
</div>
<div class="line line-centered">
    <div class="col col-centered enableTooltip">
        <input name="surveyType" data-toggle="tooltip" data-placement="bottom" type="radio" class="surveyType prettyChk" id="freeSurveyChk" data-label="<g:message code="survey.type.free.label"/>" value="${Survey.SURVEY_TYPE.FREE}">
        <input name="surveyType" data-toggle="tooltip" data-placement="bottom" type="radio" class="surveyType prettyChk" id="easySurveyChk" data-label="<g:message code="survey.type.easy.label"/>" value="${Survey.SURVEY_TYPE.EASY}">
    </div>
</div>

<form id="filterForm" class="form-horizontal">

</form>

<form class="form-horizontal">
    <div class="control-group">
        <label class="control-label" for="respondentFilterComponents">Add Filter</label>
        <div class="controls">
            <select id="respondentFilterComponents">
                <g:each in="${profileItems}" var="profileItem">
                    <option value="${profileItem.code}">${profileItem.label}</option>
                </g:each>
            </select>

            <button id="addFilterBtn" class="btn" type="button">
                <i class="icon-plus"></i>
            </button>

            <button id="submitFilterBtn" class="btn-ticbox" type="button">
                <g:message code="label.button.save" default="Save"/>
            </button>
        </div>
    </div>
</form>

<div class="line line-centered rowLine10">

    <button class="btn-ticbox link" href="${request.contextPath}/survey/" type="button">
        <g:message code="label.button.back" default="Back"/>
    </button>

    <button class="btn-ticbox link" href="${request.contextPath}/survey/surveyGenerator" type="button">
        <g:message code="label.button.next" default="Next"/>
    </button>

</div>

<form id="filterTemplates" class="form-horizontal" style="display: none">
    <g:each in="${profileItems}" var="profileItem">
        <div class="profile-item-container control-group" code="${profileItem.code}" type="${profileItem.type}" label="${profileItem.label}" style="position: relative">
            <i class="remove-filter icon-remove clickable" style="position: absolute; top: 5px; right: 7px;"></i>
            <label class="control-label" for="${profileItem.code}">${profileItem.label}</label>
            <div class="controls">
                <g:if test="${profileItem.type == ticbox.ProfileItem.TYPES.STRING}">
                    <g:if test="${profileItem.row > 1}">
                        <textArea class="filter-value" id="${profileItem.code}" name="${profileItem.code}" rows="${profileItem.row}" cols="30" maxlength="${profileItem.max}" placeholder="${profileItem.placeHolder}" style="width: 85%; resize: none"></textArea>
                    </g:if>
                    <g:else>
                        <input class="filter-value" id="${profileItem.code}" name="${profileItem.code}" type="text" class="" max="${profileItem.max}" placeholder="${profileItem.placeHolder}"/>
                    </g:else>
                </g:if>
                <g:elseif test="${profileItem.type == ticbox.ProfileItem.TYPES.DATE}">
                    <input id="${profileItem.code}" name="${profileItem.code}" type="text" class="filter-value-from datePicker" placeholder="from"> - <input type="text" class="filter-value-to datePicker" placeholder="to">
                </g:elseif>
                <g:elseif test="${profileItem.type == ticbox.ProfileItem.TYPES.NUMBER}">
                    <input class="filter-value-from" id="${profileItem.code}" name="${profileItem.code}" type="text" placeholder="from"> - <input class="filter-value-to" type="text" placeholder="to"> ${profileItem.unit}
                </g:elseif>
                <g:elseif test="${profileItem.type == ticbox.ProfileItem.TYPES.LOOKUP}">
                    <g:each in="${LookupMaster.findByCode(profileItem.lookupFrom)?.values}" var="item">
                        %{--<label class="checkbox">
                            <input id="${profileItem.code}_${item.key}" class="check-item" type="checkbox" name="${profileItem.code}" value="${item.key}" label="${item.value}"> ${item.value}
                        </label>--}%
                        <input id="${profileItem.code}_${item.key}" class="check-item prettyChk" type="checkbox" data-label="${item.value}" name="${profileItem.code}" value="${item.key}" label="${item.value}">
                    </g:each>
                </g:elseif>
                <g:elseif test="${profileItem.type == ticbox.ProfileItem.TYPES.CHOICE}">

                    <g:if test="${profileItem.items}">
                        <g:each in="${profileItem.items}" var="item">
                            %{--<label class="checkbox">
                                <input id="${profileItem.code}_${item}" class="check-item" type="checkbox" name="${profileItem.code}" value="${item}"> ${item}
                            </label>--}%
                            <input id="${profileItem.code}_${item}" class="check-item prettyChk" type="checkbox" data-label="${item}" name="${profileItem.code}" value="${item}">
                        </g:each>
                    </g:if>
                    <g:elseif test="${profileItem.lookupFrom}">
                        <g:each in="${LookupMaster.findByCode(profileItem.lookupFrom)?.values}" var="item">
                            %{--<label class="checkbox">
                                <input id="${profileItem.code}_${item.key}" class="check-item" type="checkbox" name="${profileItem.code}" value="${item.key}" label="${item.value}"> ${item.value}
                            </label>--}%
                            <input id="${profileItem.code}_${item.key}" class="check-item prettyChk" type="checkbox" data-label="${item.value}" name="${profileItem.code}" value="${item.key}" label="${item.value}">
                        </g:each>
                    </g:elseif>

                </g:elseif>
            </div>
        </div>
    </g:each>
</form>

<script type="text/javascript">

    jQuery(function(){

        jQuery.getJSON('${request.contextPath}/survey/getSurveySummary', {}, function(data){
            if(data){
                surveySummary = data;

                jQuery('.total-charge').html(parseFloat(surveySummary.chargePerRespondent) * parseFloat(surveySummary.totalRespondent));
                jQuery('.charge-per-respondent').html(surveySummary.chargePerRespondent);
                jQuery('.total-respondents').html(surveySummary.totalRespondent);
            }
        });

    });

</script>

</body>
</html>