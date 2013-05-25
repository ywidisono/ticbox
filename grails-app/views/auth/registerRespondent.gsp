<%@ page import="ticbox.LookupMaster; ticbox.ProfileItem" contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main"/>
    <title><g:message code="app.register.respondent.label" /></title>
</head>
<body>
<g:form action="register">
    <g:hiddenField name="userType" value="respondent"/>
    <fieldset>
        <legend><g:message code="app.register.respondent.label" /></legend>
        <div class="row-fluid">
            <div class="span3"><label><g:message code="app.username.label"/></label></div>
            <div class="span3"><g:textField name="username"/></div>
        </div>
        <div class="row-fluid">
            <div class="span3"><label><g:message code="app.email.label"/></label></div>
            <div class="span3"><g:textField name="email"/></div>
        </div>
        <div class="row-fluid">
            <div class="span3"><label><g:message code="app.password.label"/></label></div>
            <div class="span3"><g:passwordField name="password"/></div>
        </div>
        <div class="row-fluid">
            <div class="span3"><label><g:message code="app.passwordconfirm.label"/></label></div>
            <div class="span3"><g:passwordField name="passwordconfirm"/></div>
        </div>
        <g:each in="${profileItemList}" var="profileItem">
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
                        <input name="${profileItem.code}" type="text" class="datePicker" placeholder="${message([code: 'app.date.format.input', default: 'dd/MM/yyyy'])}">
                    </g:elseif>
                    <g:elseif test="${profileItem.type == ticbox.ProfileItem.TYPES.NUMBER}">
                        <input name="${profileItem.code}" type="text" placeholder="${profileItem.min && profileItem.max ? "${profileItem.min} - ${profileItem.max}" : ''}">
                    </g:elseif>
                    <g:elseif test="${profileItem.type == ticbox.ProfileItem.TYPES.LOOKUP}">
                        <g:select name="${profileItem.code}" from="${LookupMaster.findByCode(profileItem.lookupFrom)?.values}" optionKey="key" optionValue="value"/>
                    </g:elseif>
                    <g:elseif test="${profileItem.type == ticbox.ProfileItem.TYPES.CHOICE}">

                        <g:if test="${profileItem.componentType == ticbox.ProfileItem.COMPONENT_TYPES.CHK_BOX}">
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
                        </g:if>

                        <g:elseif test="${profileItem.componentType == ticbox.ProfileItem.COMPONENT_TYPES.SELECT}">
                            <g:if test="${profileItem.items}">
                                <g:if test="${profileItem.multiple}">
                                    <g:select name="${profileItem.code}" from="${profileItem.items}"  multiple="true"/>
                                </g:if>
                                <g:else> %{--this is stupid!!!!--}%
                                    <g:select name="${profileItem.code}" from="${profileItem.items}"/>
                                </g:else>
                            </g:if>
                            <g:elseif test="${profileItem.lookupFrom}">
                                <g:if test="${profileItem.multiple}">
                                    <g:select name="${profileItem.code}" from="${LookupMaster.findByCode(profileItem.lookupFrom)?.values}" optionKey="key" optionValue="value" multiple="true"/>
                                </g:if>
                                <g:else> %{--this is stupid!!!!--}%
                                    <g:select name="${profileItem.code}" from="${LookupMaster.findByCode(profileItem.lookupFrom)?.values}" optionKey="key" optionValue="value"/>
                                </g:else>
                            </g:elseif>
                        </g:elseif>

                        <g:elseif test="${profileItem.componentType == ticbox.ProfileItem.COMPONENT_TYPES.RADIO}">
                            <g:if test="${profileItem.items}">
                                <g:each in="${profileItem.items}" var="item">
                                    <label class="radio">
                                        <input type="radio" name="${profileItem.code}" value="${item}"> ${"$item"}
                                    </label>
                                </g:each>
                            </g:if>
                            <g:elseif test="${profileItem.lookupFrom}">
                                <g:each in="${LookupMaster.findByCode(profileItem.lookupFrom)?.values}" var="item">
                                    <label class="radio">
                                        <input type="radio" name="${profileItem.code}" value="${item.key}"> ${"$item.value"}
                                    </label>
                                </g:each>
                            </g:elseif>
                        </g:elseif>
                    </g:elseif>
                </div>
            </div>
        </g:each>
        <br/>
        
        <div class="row-fluid">
            <div class="span12"><p class="muted"><g:message code="app.register.disclaimer.message"/></p></div>
        </div>        
        <div class="row-fluid">
            <div class="span12"><p><g:submitButton name="submit" value="${g.message(code:'app.register.label')}" class="btn btn-primary btn-large"/></p></div>
        </div>
    </fieldset>
</g:form>
</body>
</html>