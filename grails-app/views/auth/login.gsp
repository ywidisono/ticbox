<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="ticbox"/>
        <title>Login</title>
    </head>

    <body>
        <div class="module container-fluid">
            <div class="module-header">
                <div class="title">Login</div>
            </div>

            <div class="module-content">

                <div style="font-weight: bold; margin-top: 10px;">Already one of us? Please sign in</div>

                <g:if test="${flash.message}">
                    <div class="alert alert-success" style="display: block">${flash.message}</div>
                %{--
                <div class="row-fluid">
                    <div class="span12 message">${flash.message}</div>
                </div>
                --}%
                </g:if>
                <g:form name="signIn" action="signIn" style="margin: 20px 0 0 0;">
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
                            <button id="submit" class="btn btn-green-city-large btngreen"><i class="icon-off icon-white"></i> Sign In </button>
                        </div>
                    </div>
                </g:form>

            </div>

            <div class="module-header"></div>
            <div class="module-content">
                <div style="font-weight: bold; margin-top: 10px;">Haven't had an account? Don't be shy, don't be an outsider, join now!</div>
                <div style="margin: 10px 0;">
                    <a class="btn btn-green-city-large btn-light-oak" href="${g.createLink(controller: 'auth', action: 'registerRespondent')}"><i class="icon-user icon-white"></i> Register as Respondent</a>
                    <a class="btn btn-green-city-large btn-blue-trust" href="${g.createLink(controller: 'auth', action: 'registerSurveyor')}"><i class="icon-user icon-white"></i> Register as Surveyor</a>
                </div>
            </div>
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
