<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="ticbox"/>
    <title><g:message code="app.register.surveyor.label" /></title>
</head>
<body>
    <div class="module">
        <div class="module-header">
            <div class="title"><g:message code="app.register.surveyor.label" /></div>
        </div>
        <div class="module-content">
            <g:form name="registerForm" action="register">
                <g:hiddenField name="userType" value="surveyor"/>
                <fieldset>
                <div class="row-fluid">
                    <div class="span3"><label><g:message code="app.username.label"/></label></div>
                    <div class="span9"><g:textField name="username"/></div>
                </div>
                <div class="row-fluid">
                    <div class="span3"><label><g:message code="app.email.label"/></label></div>
                    <div class="span9"><g:textField name="email"/></div>
                </div>
                <div class="row-fluid">
                    <div class="span3"><label><g:message code="app.password.label"/></label></div>
                    <div class="span9"><g:passwordField name="password"/></div>
                </div>
                <div class="row-fluid">
                    <div class="span3"><label><g:message code="app.passwordconfirm.label"/></label></div>
                    <div class="span9"><g:passwordField name="passwordconfirm"/></div>
                </div>
                <div class="row-fluid">
                    <div class="span3"><label><g:message code="app.company.label"/></label></div>
                    <div class="span9"><g:textField name="company"/></div>
                </div>
                <div class="row-fluid">
                    <div class="span8"><p class="muted"><g:message code="app.register.disclaimer.message"/></p></div>
                </div>
                <div class="row-fluid">
                    <div class="span8">
                        <p>
                            <g:submitButton name="submit" value="${g.message(code:'app.register.label')}" class="btn btn-green-city-large btngreen"/>
                            <button type="reset" name="reset" class="btn btn-green-city-large btn-light-oak">${g.message(code:'app.reset.label')}</button>
                        </p>
                    </div>
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
        </div>
    </div>
<g:javascript src="jquery.validate.min.js"/>
<g:javascript src="additional-methods.min.js"/>
<script type="text/javascript">
    $(document).ready(function() {

        $('#registerForm').validate({
            rules: {
                username: {
                    required: true,
                    minlength: 5
                },
                email: {
                    email: true,
                    required: true,
                    minlength: 5
                },
                password: {
                    required: true,
                    minlength: 5
                },
                passwordconfirm: {
                    required: true,
                    minlength: 5,
                    equalTo: password
                }
            }
        });

    });
</script>
</body>
</html>