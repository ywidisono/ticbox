<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="ticbox"/>
    <title>Login</title>
</head>

<body>
<div class="container-fluid">
    <g:if test="${flash.message}">
        <div class="row-fluid">
            <div class="span12 message">${flash.message}</div>
        </div>
    </g:if>
    <g:form name="signIn" action="signIn">
        <input type="hidden" name="targetUri" value="${targetUri}"/>

        <div class="row-fluid">
            <div class="span1">Username</div>
            <div class="span9"><input type="text" name="username" value="${username}"/></div>
        </div>

        <div class="row-fluid">
            <div class="span1">Password</div>
            <div class="span9"><input type="password" name="password" value=""/></div>
        </div>

        <div class="row-fluid">
            <div class="offset1 span11">
                <g:checkBox name="rememberMe" value="${rememberMe}"/> &nbsp;
                ${g.message(code: "app.rememberMe.label")}
            </div>
        </div>

        <div class="row-fluid">
            <div class="offset1 span11">
                <button id="submit" class="btn btn-primary btn-large"><i class="icon-off icon-white"></i> Sign In </button> &nbsp; OR &nbsp;
                <a class="btn btn-large btn-success" href="${g.createLink(controller: 'auth', action: 'registerRespondent')}"><i class="icon-user icon-white"></i> Register as Respondent</a>
                <a class="btn btn-large btn-warning" href="${g.createLink(controller: 'auth', action: 'registerSurveyor')}"><i class="icon-user icon-white"></i> Register as Surveyor</a>
            </div>
        </div>

    </g:form>
</div>
<g:javascript src="jquery.validate.min.js"/>
<g:javascript src="additional-methods.min.js"/>
<script type="text/javascript">
    $(document).ready(function() {

        $('input[name="username"]').focus();

        $('#submit').click(function() {
            $('#signIn').submit();
        });

        $('#signIn').validate({
            rules: {
                username: {
                    required: true,
                    minlength: 5
                },
                password: {
                    required: true,
                    minlength: 5
                }
            }
        });
    });
</script>
</body>
</html>
