<%--
  Created by IntelliJ IDEA.
  User: arnold
  Date: 3/24/13
  Time: 11:48 PM
  To change this template use File | Settings | File Templates.
--%>

<%@ page import="ticbox.LookupMaster" contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="survey"/>
    <title></title>

    <style type="text/css">

        .control-label {
            text-align: left !important;
        }

        .summary-header {
            background-color: #565655;
        }

        .summary-body {
            background-color: #a0a0a0;
        }

        .preview-item-even {
            background-color: #ececec;
        }

    </style>

    <script type="text/javascript">

        jQuery(function(){

            jQuery('#addFilterBtn').click(function(){

                var filterComponentCode = jQuery('#respondentFilterComponents').val();
                var template = jQuery('#filterTemplates').find('.control-group[code="'+ filterComponentCode +'"]');

                if (template.length > 0) {
                    jQuery('#filterForm').append(template);

                    var label = jQuery('.control-label', template).html();
                    jQuery('.filter-details-container').append(jQuery('<div class="line"></div>').append(label));
                }

            });

        });

    </script>

</head>
<body>

<div id="menuNavPanelContent" style="min-height: 150px">

    <div class="filter-details-container line side-panel">
        <div class="line">
            <strong>Filter Details : </strong>
        </div>
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
        </div>
    </div>
</form>

<form id="filterTemplates" class="form-horizontal" style="display: none">
    <g:each in="${profileItems}" var="profileItem">
        <div class="control-group" code="${profileItem.code}">
            <label class="control-label" for="${profileItem.code}">${profileItem.label}</label>
            <div class="controls">
                <g:if test="${profileItem.type == ticbox.ProfileItem.TYPES.STRING}">
                    <g:if test="${profileItem.row > 1}">
                        <g:textArea id="${profileItem.code}" name="${profileItem.code}" rows="${profileItem.row}" cols="30" maxlength="${profileItem.max}" placeholder="${profileItem.placeHolder}"></g:textArea>
                    </g:if>
                    <g:else>
                        <input id="${profileItem.code}" name="${profileItem.code}" type="text" class="" max="${profileItem.max}" placeholder="${profileItem.placeHolder}"/>
                    </g:else>
                </g:if>
                <g:elseif test="${profileItem.type == ticbox.ProfileItem.TYPES.DATE}">
                    <input id="${profileItem.code}" name="${profileItem.code}" type="text" class="datePicker" placeholder="from"> - <input type="text" class="datePicker" placeholder="to">
                </g:elseif>
                <g:elseif test="${profileItem.type == ticbox.ProfileItem.TYPES.NUMBER}">
                    <input id="${profileItem.code}" name="${profileItem.code}" type="text" placeholder="from"> - <input type="text" placeholder="to"> ${profileItem.unit}
                </g:elseif>
                <g:elseif test="${profileItem.type == ticbox.ProfileItem.TYPES.LOOKUP}">
                    <g:each in="${LookupMaster.findByCode(profileItem.lookupFrom)?.values}" var="item">
                        <label class="checkbox">
                            <input id="${profileItem.code}_${item.key}" type="checkbox" name="${profileItem.code}" value="${item.key}"> ${"$item.value"}
                        </label>
                    </g:each>
                </g:elseif>
                <g:elseif test="${profileItem.type == ticbox.ProfileItem.TYPES.CHOICE}">

                    <g:if test="${profileItem.items}">
                        <g:each in="${profileItem.items}" var="item">
                            <label class="checkbox">
                                <input id="${profileItem.code}_${item}" type="checkbox" name="${profileItem.code}" value="${item}"> ${"$item"}
                            </label>
                        </g:each>
                    </g:if>
                    <g:elseif test="${profileItem.lookupFrom}">
                        <g:each in="${LookupMaster.findByCode(profileItem.lookupFrom)?.values}" var="item">
                            <label class="checkbox">
                                <input id="${profileItem.code}_${item.key}" type="checkbox" name="${profileItem.code}" value="${item.key}"> ${"$item.value"}
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
