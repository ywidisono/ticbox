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
</head>
<body>

<form class="form-horizontal">
    <g:each in="${profileItems}" var="profileItem">
        <div class="control-group">
            <label class="control-label">${profileItem.label}</label>
            <div class="controls">
                <g:if test="${profileItem.type == ticbox.ProfileItem.TYPES.STRING}">
                    <g:if test="${profileItem.row > 1}">
                        <g:textArea name="${profileItem.code}" rows="${profileItem.row}" cols="30" maxlength="${profileItem.max}" placeholder="${profileItem.placeHolder}"></g:textArea>
                    </g:if>
                    <g:else>
                        <input name="${profileItem.code}" type="text" class="" max="${profileItem.max}" placeholder="${profileItem.placeHolder}"/>
                    </g:else>
                </g:if>
                <g:elseif test="${profileItem.type == ticbox.ProfileItem.TYPES.DATE}">
                    <input name="${profileItem.code}" type="text" class="datePicker" placeholder="from"> - <input type="text" class="datePicker" placeholder="to">
                </g:elseif>
                <g:elseif test="${profileItem.type == ticbox.ProfileItem.TYPES.NUMBER}">
                    <input name="${profileItem.code}" type="text" placeholder="from"> - <input type="text" placeholder="to"> ${profileItem.unit}
                </g:elseif>
                <g:elseif test="${profileItem.type == ticbox.ProfileItem.TYPES.LOOKUP}">
                    <g:each in="${LookupMaster.findByCode(profileItem.lookupFrom)?.values}" var="item">
                        <label class="checkbox">
                            <input type="checkbox" name="${profileItem.code}" value="${item.key}"> ${"$item.value"}
                        </label>
                    </g:each>
                </g:elseif>
                <g:elseif test="${profileItem.type == ticbox.ProfileItem.TYPES.CHOICE}">

                    <g:if test="${profileItem.items}">
                        <g:each in="${profileItem.items}" var="item">
                            <label class="checkbox">
                                <input type="checkbox" name="${profileItem.code}" value="${item}"> ${"$item"}
                            </label>
                        </g:each>
                    </g:if>
                    <g:elseif test="${profileItem.lookupFrom}">
                        <g:each in="${LookupMaster.findByCode(profileItem.lookupFrom)?.values}" var="item">
                            <label class="checkbox">
                                <input type="checkbox" name="${profileItem.code}" value="${item.key}"> ${"$item.value"}
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