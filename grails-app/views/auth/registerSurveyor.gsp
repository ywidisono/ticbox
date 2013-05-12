<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main"/>
    <title><g:message code="app.register.surveyor.label" /></title>
</head>
<body>
    <g:form action="register">
        <g:hiddenField name="userType" value="surveyor"/>
        <fieldset>
        <legend><g:message code="app.register.surveyor.label" /></legend>
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
        <div class="row-fluid">
            <div class="span3"><label><g:message code="app.company.label"/></label></div>
            <div class="span3"><g:textField name="company"/></div>
        </div>
        <div class="row-fluid">
            <div class="span8"><p class="muted"><g:message code="app.register.disclaimer.message"/></p></div>
        </div>
        <div class="row-fluid">
            <div class="span8"><p><g:submitButton name="submit" value="${g.message(code:'app.register.label')}" class="btn btn-primary btn-large"/></p></div>
        </div>
        <div class="row-fluid">
            <div class="span8"><h3><g:message code="app.register.sso.message"/></h3></div>
        </div>
        <div class="row-fluid">
            <div class="span8">
                <oauth:connect provider="facebook"><g:img file="ticbox/facebook-signup-button.png"/></oauth:connect>
                <oauth:connect provider="twitter"><g:img file="ticbox/twitter-signup-button.png"/></oauth:connect>
                <oauth:connect provider="google"><g:img file="ticbox/google-signup-button.png"/></oauth:connect>
            </div>
        </div>
        </fieldset>
    </g:form>
</body>
</html>