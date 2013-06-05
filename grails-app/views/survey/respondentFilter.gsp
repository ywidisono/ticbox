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
    <meta name="layout" content="survey"/>
    <title></title>

    <style type="text/css">

        #filterForm .well {
            background-color: #ffffff;
            border-color: #7F9B09;
        }

        #filterForm .control-group {
            margin-bottom: 10px;
        }

    </style>

    <script type="text/javascript">

        jQuery(function(){

            jQuery('#addFilterBtn').click(function(){

                var filterComponentCode = jQuery('#respondentFilterComponents').val();
                var template = jQuery('#filterTemplates').find('.control-group[code="'+ filterComponentCode +'"]');

                if (template.length > 0) {
                    jQuery('#filterForm').append(template);

                    jQuery('.remove-filter', template).click(function(){
                        jQuery(this).parent().appendTo(jQuery('#filterTemplates'));
                    });
                }

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
                                filterItem['checkItems'].push(jQuery(this).val())
                            });

                            break;

                        case '${ProfileItem.TYPES.LOOKUP}' :
                            filterItem['checkItems'] = [];
                            jQuery('input.check-item:checked', this).each(function(){
                                filterItem['checkItems'].push(jQuery(this).val())
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

                jQuery.post('${request.contextPath}/survey/submitRespondentFilter', {filterItemsJSON : filterItemsJSON}, function(data){
                    alert('Submitted');
                    loadRespondentFilter();
                });

            });

        });

    </script>

</head>
<body>

<div id="menuNavPanelContent" style="min-height: 150px">



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
            <button id="submitFilterBtn" class="btn" type="button">
                Submit
            </button>
        </div>
    </div>
</form>

<form id="filterTemplates" class="form-horizontal" style="display: none">
    <g:each in="${profileItems}" var="profileItem">
        <div class="profile-item-container control-group well" code="${profileItem.code}" type="${profileItem.type}" label="${profileItem.label}" style="position: relative">
            <i class="remove-filter icon-remove clickable" style="position: absolute; top: 5px; right: 7px;"></i>
            <label class="control-label" for="${profileItem.code}">${profileItem.label}</label>
            <div class="controls">
                <g:if test="${profileItem.type == ticbox.ProfileItem.TYPES.STRING}">
                    <g:if test="${profileItem.row > 1}">
                        <g:textArea class="filter-value" id="${profileItem.code}" name="${profileItem.code}" rows="${profileItem.row}" cols="30" maxlength="${profileItem.max}" placeholder="${profileItem.placeHolder}" style="width: 85%; resize: none"></g:textArea>
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
                        <label class="checkbox">
                            <input id="${profileItem.code}_${item.key}" class="check-item" type="checkbox" name="${profileItem.code}" value="${item.key}"> ${"$item.value"}
                        </label>
                    </g:each>
                </g:elseif>
                <g:elseif test="${profileItem.type == ticbox.ProfileItem.TYPES.CHOICE}">

                    <g:if test="${profileItem.items}">
                        <g:each in="${profileItem.items}" var="item">
                            <label class="checkbox">
                                <input id="${profileItem.code}_${item}" class="check-item" type="checkbox" name="${profileItem.code}" value="${item}"> ${"$item"}
                            </label>
                        </g:each>
                    </g:if>
                    <g:elseif test="${profileItem.lookupFrom}">
                        <g:each in="${LookupMaster.findByCode(profileItem.lookupFrom)?.values}" var="item">
                            <label class="checkbox">
                                <input id="${profileItem.code}_${item.key}" class="check-item" type="checkbox" name="${profileItem.code}" value="${item.key}"> ${"$item.value"}
                            </label>
                        </g:each>
                    </g:elseif>

                </g:elseif>
            </div>
        </div>
    </g:each>
</form>

</body>
</html>