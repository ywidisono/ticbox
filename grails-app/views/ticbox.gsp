<html>
<head>

    <meta name="layout" content="ticbox"/>
    <title>Welcome</title>
    <style>

    .landing-container {
        width: 934px;
        height: 425px;
        background: transparent;
        margin-left: auto;
        margin-right: auto;
        margin-top: 0;
        margin-bottom: 20px;
    }

    .landing-main {
        width: 734px;
        height: 425px;
        background: transparent url("images/ticbox/LandingPage_Visual01.png") no-repeat center;
    }

    .landing-bar {
        width: 196px;
        height: 391px;
        margin-top: 34px;
        margin-left: 2px;
    }

    .landing-bar div {
        float: right;
        clear: right;
        width: inherit;
        height:129px;
        background: #bad33c;
        text-align: center;
        color: #ffffff;
    }

    .landing-bar div.center {
        margin: 2px 0;
    }

    .landing-bar div table {
        height: 100%;
        width: 100%;
    }

    .landing-bar div table tr td {
        margin-top: auto;
        margin-bottom: auto;
        text-align: center;
    }

    .landing-menu {
        top : 390px;
        position: relative;
        display: table;
        margin: 0 auto;
    }

    .landing-menu .nav {
        margin: 0 20px;
    }

    .landing-menu .nav li {
        margin: 0 25px;
        color : #bad33c;
    }

    .landing-menu .nav li:hover {
        cursor: pointer;
        color: #ffffff;
    }

    .landing-menu-btn-left {
        width: 21px;
        height: 15px;
        background: transparent url("images/ticbox/GreenArrow-left.png") no-repeat;
    }

    .landing-menu-btn-right {
        width: 21px;
        height: 15px;
        background: transparent url("images/ticbox/GreenArrow-right.png") no-repeat;
    }

    .foot-landing h4, .foot-landing h5 {
        color: #bad33c;
    }

    </style>

</head>
<body>

<g:if test="${flash.message}">
    <div class="row-fluid">
        <div class="span12"><p class="text-error center">${flash.message}</p></div>
    </div>
</g:if>

<div class="landing-container line">

    <div class="landing-main col">

        <div class="landing-menu navbar">
            <div class="landing-menu-btn-left col pull-left"></div>
            <ul class="nav">
                <li class="link" href="${request.contextPath}/survey/">Create Survey</li>
                <li class="link" href="${request.contextPath}/respondent/">Join Respondent</li>
                <li>Solutions</li>
                <li>Watch Demo</li>
            </ul>
            <div class="landing-menu-btn-right col pull-right"></div>
        </div>

    </div>
    <div class="landing-bar col">
        <div>
            <h1>It's Free</h1>
            <span>Sign me up</span>
            <ul class="sign-up-icons">
                <oauth:connect provider="facebook"><li class="fb"></li></oauth:connect>
                <oauth:connect provider="twitter"><li class="tw"> </li></oauth:connect>
                <oauth:connect provider="google"><li class="gg"> </li></oauth:connect>
            </ul>
        </div>
        <div class="center">
            <a href="${request.contextPath}/auth/registerSurveyor" style="color: #ffffff;">
                <h1>Go Pro!</h1>
                <span>More perks</span><br>
                <span>Unlimited Surveys</span>
            </a>
        </div>
        <div>
            <table>
                <tr>
                    <td>
                        <a href="${request.contextPath}/auth/registerRespondent" style="color: #ffffff;">
                            Be a respondent<br>
                            Be rewarded
                        </a>
                    </td>
                </tr>
            </table>
        </div>
    </div>

</div>

<div class="row foot-landing" style="margin: 0 20px;">
    <div class="span7">
        <div class="row">
            <div class="span4">
                <h4>
                    About Us
                </h4>
                <p>
                    Donec id elit non mi porta gravida at eget metus. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus. Etiam porta sem malesuada magna mollis euismod. Donec sed odio dui.
                </p>
                <p>
                    <a class="btn" href="#">View details »</a>
                </p>
            </div>
            <div class="span3">
                <h4>
                    How It Works
                </h4>
                <p>
                    Donec id elit non mi porta gravida at eget metus. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus. Etiam porta sem malesuada magna mollis euismod. Donec sed odio dui.
                </p>
                <p>
                    <a class="btn" href="#">View details »</a>
                </p>
            </div>
        </div>
        <div class="row">
            <div class="span4">
                <h4>
                    Resources
                </h4>
                <p>
                    Donec id elit non mi porta gravida at eget metus. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus. Etiam porta sem malesuada magna mollis euismod. Donec sed odio dui.
                </p>
                <p>
                    <a class="btn" href="#">View details »</a>
                </p>
            </div>
            <div class="span3">
                <h4>
                    Blog
                </h4>
                <p>
                    Donec id elit non mi porta gravida at eget metus. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus. Etiam porta sem malesuada magna mollis euismod. Donec sed odio dui.
                </p>
                <p>
                    <a class="btn" href="#">View details »</a>
                </p>
            </div>
        </div>
    </div>
    <div class="span4">
        <h4>
            Latest News
        </h4>
        <h5>11.05.13</h5>
        <p>
            Donec id elit non mi porta gravida at eget metus. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus. Etiam porta sem malesuada magna mollis euismod. Donec sed odio dui.
        </p>
        <p>
            <a class="btn" href="#">View details »</a>
        </p>
        <h5>10.05.13</h5>
        <p>
            Donec id elit non mi porta gravida at eget metus. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus. Etiam porta sem malesuada magna mollis euismod. Donec sed odio dui.
        </p>
        <p>
            <a class="btn" href="#">View details »</a>
        </p>
    </div>
</div>

</body>
</html>
