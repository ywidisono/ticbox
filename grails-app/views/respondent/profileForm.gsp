<%--
  Created by IntelliJ IDEA.
  User: arnold
  Date: 4/13/13
  Time: 8:53 PM
--%>

<%@ page import="ticbox.LookupMaster" contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="respondent"/>
    <title>Respondent Profile Form</title>
</head>
<body>

<g:form class="form-horizontal" action="modify">
    <!-- hiddens -->
    <g:hiddenField name="id" value="${respondent.id}"/>

    <!-- static fields -->
    <div class="control-group">
        <label class="control-label">E-Mail</label>
        <div class="controls">
            <g:textField name="email" value="${respondent.email}"/>
        </div>
    </div>

    <!-- dynamic fields -->
    <g:each in="${profileItems}" var="profileItem">
        <div class="control-group">
            <label class="control-label">${profileItem.label}</label>
            <div class="controls">
                <g:if test="${profileItem.type == ticbox.ProfileItem.TYPES.STRING}">
                    <g:if test="${profileItem.row > 1}">
                        <g:textArea name="${profileItem.code}" rows="${profileItem.row}" cols="30" maxlength="${profileItem.max}" placeholder="${profileItem.placeHolder}">${respondent?.respondentProfile?.profileItems[profileItem.code]}</g:textArea>
                    </g:if>
                    <g:else>
                        <input name="${profileItem.code}" type="text" class="" max="${profileItem.max}" placeholder="${profileItem.placeHolder}" value="${respondent?.respondentProfile?.profileItems[profileItem.code]}"/>
                    </g:else>
                </g:if>
                <g:elseif test="${profileItem.type == ticbox.ProfileItem.TYPES.DATE}">
                    <input name="${profileItem.code}" type="text" class="datePicker" placeholder="${message([code: 'app.date.format.input', default: 'dd/MM/yyyy'])}" value="${respondent?.respondentProfile?.profileItems[profileItem.code]}" />
                </g:elseif>
                <g:elseif test="${profileItem.type == ticbox.ProfileItem.TYPES.NUMBER}">
                    <input name="${profileItem.code}" type="text" placeholder="${profileItem.min && profileItem.max ? "${profileItem.min} - ${profileItem.max}" : ''}" value="${respondent?.respondentProfile?.profileItems[profileItem.code]}">
                </g:elseif>
                <g:elseif test="${profileItem.type == ticbox.ProfileItem.TYPES.LOOKUP}">
                    <g:select name="${profileItem.code}" from="${LookupMaster.findByCode(profileItem.lookupFrom)?.values}" optionKey="key" optionValue="value" value="${respondent?.respondentProfile?.profileItems[profileItem.code]}"/>
                </g:elseif>
                <g:elseif test="${profileItem.type == ticbox.ProfileItem.TYPES.CHOICE}">

                    <g:if test="${profileItem.componentType == ticbox.ProfileItem.COMPONENT_TYPES.CHK_BOX}">
                        <g:if test="${profileItem.items}">
                            <g:each in="${profileItem.items}" var="item">
                                <label class="checkbox">
                                    <input type="checkbox" name="${profileItem.code}" value="${item}" <g:if test="${respondent?.respondentProfile?.profileItems[profileItem.code]?.split(",")?.contains(item)}">checked</g:if> /> ${"$item"}
                                </label>
                            </g:each>
                        </g:if>
                        <g:elseif test="${profileItem.lookupFrom}">
                            <g:each in="${LookupMaster.findByCode(profileItem.lookupFrom)?.values}" var="item">
                                <label class="checkbox">
                                    <input type="checkbox" name="${profileItem.code}" value="${item.key}" <g:if test="${respondent?.respondentProfile?.profileItems[profileItem.code]?.split(",")?.contains(item.key)}">checked</g:if> /> ${"$item.value"}
                                </label>
                            </g:each>
                        </g:elseif>
                    </g:if>

                    <g:elseif test="${profileItem.componentType == ticbox.ProfileItem.COMPONENT_TYPES.SELECT}">
                        <g:if test="${profileItem.items}">
                            <g:if test="${profileItem.multiple}">
                                <g:select name="${profileItem.code}" from="${profileItem.items}"  multiple="true"  value="${respondent?.respondentProfile?.profileItems[profileItem.code]?.split(",")?.toList()}" />
                            </g:if>
                            <g:else> %{--this is stupid!!!!--}%
                                <g:select name="${profileItem.code}" from="${profileItem.items}" value="${respondent?.respondentProfile?.profileItems[profileItem.code]}" />
                            </g:else>
                        </g:if>
                        <g:elseif test="${profileItem.lookupFrom}">
                            <g:if test="${profileItem.multiple}">
                                <g:select name="${profileItem.code}" from="${LookupMaster.findByCode(profileItem.lookupFrom)?.values}" optionKey="key" optionValue="value" multiple="true" value="${respondent?.respondentProfile?.profileItems[profileItem.code]?.split(",")?.toList()}"/>
                            </g:if>
                            <g:else> %{--this is stupid!!!!--}%
                                <g:select name="${profileItem.code}" from="${LookupMaster.findByCode(profileItem.lookupFrom)?.values}" optionKey="key" optionValue="value" value="${respondent?.respondentProfile?.profileItems[profileItem.code]}"/>
                            </g:else>
                        </g:elseif>
                    </g:elseif>

                    <g:elseif test="${profileItem.componentType == ticbox.ProfileItem.COMPONENT_TYPES.RADIO}">
                        <g:if test="${profileItem.items}">
                            <g:each in="${profileItem.items}" var="item">
                                <label class="radio">
                                    <input type="radio" name="${profileItem.code}" value="${item}" <g:if test="${item.equals(respondent?.respondentProfile?.profileItems[profileItem.code])}">checked</g:if> /> ${"$item"}
                                </label>
                            </g:each>
                        </g:if>
                        <g:elseif test="${profileItem.lookupFrom}">
                            <g:each in="${LookupMaster.findByCode(profileItem.lookupFrom)?.values}" var="item">
                                <label class="radio">
                                    <input type="radio" name="${profileItem.code}" value="${item.key}" <g:if test="${item.key.equals(respondent?.respondentProfile?.profileItems[profileItem.code])}">checked</g:if> /> ${"$item.value"}
                                </label>
                            </g:each>
                        </g:elseif>
                    </g:elseif>

                </g:elseif>
            </div>
        </div>
    </g:each>

    <!-- action buttons -->
    <div class="control-group">
        <div class="controls">
            <g:submitButton name="submit" value="${g.message(code:'app.submit.label')}" class="btn btn-primary btn-large"/>
        </div>
    </div>

</g:form>

</body>
</html>