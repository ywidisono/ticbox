<%@ page import="org.apache.shiro.SecurityUtils" %>
<!DOCTYPE html>
<!--[if lt IE 7 ]> <html lang="en" class="no-js ie6"> <![endif]-->
<!--[if IE 7 ]>    <html lang="en" class="no-js ie7"> <![endif]-->
<!--[if IE 8 ]>    <html lang="en" class="no-js ie8"> <![endif]-->
<!--[if IE 9 ]>    <html lang="en" class="no-js ie9"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--> <html lang="en" class="no-js"><!--<![endif]-->
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title><g:layoutTitle default="TicBOX"/></title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="shortcut icon" href="${resource(dir: 'images', file: 'favicon.ico')}" type="image/x-icon">
    <link rel="apple-touch-icon" href="${resource(dir: 'images', file: 'apple-touch-icon.png')}">
    <link rel="apple-touch-icon" sizes="114x114" href="${resource(dir: 'images', file: 'apple-touch-icon-retina.png')}">

    <link rel="stylesheet" href="${resource(dir: 'frameworks/jquery-ui-1.10.2/css/smoothness', file: 'jquery-ui-1.10.2.custom.css')}" type="text/css">

    <link rel="stylesheet" href="${resource(dir: 'frameworks/bootstrap/css', file: 'bootstrap.css')}" type="text/css">

    <style type="text/css">

    body {
        padding-top: 65px;
    }

    .line {
        display: block;
    }

    .col {
        display: inline-block;
        min-height: 1px;
    }

    @media (max-width: 980px) {
        /* Enable use of floated navbar text */
        .navbar-text.pull-right {
            float: none;
            padding-left: 5px;
            padding-right: 5px;
        }
    }

    .navbar-inverse .navbar-text, .navbar-inverse .navbar-link {
        color: #ffffff;
        padding-top: 10px;
    }

    .navbar-inverse .navbar-inner {
        background-color: #BAD33C;
        background-image: -moz-linear-gradient(top, #BAD33C, #7F9B09);
        background-image: -webkit-gradient(linear, 0 0, 0 100%, from(#BAD33C), to(#7F9B09));
        background-image: -webkit-linear-gradient(top, #BAD33C, #7F9B09);
        background-image: -o-linear-gradient(top, #BAD33C, #7F9B09);
        background-image: linear-gradient(to bottom, #BAD33C, #7F9B09);
        border: 0;
        -webkit-box-shadow: 0px 0px 10px #000000;
        box-shadow: 0px 0px 10px #000000;
        -moz-box-shadow: 0px 0px 10px #000000;
        color: #ffffff;
    }

    .navbar-inverse .nav > li > a  {
        color: #ffffff;
        height: 30px;
        padding-top: 20px;
        padding-bottom: 0;
    }

    .navbar .nav > .active > a,
    .navbar .nav > .active > a:hover,
    .navbar .nav > .active > a:focus,
    .navbar .nav > li > a:hover {
        background: transparent;
        -webkit-box-shadow: inset 0 3px 8px rgba(0, 0, 0, 0.125);
        -moz-box-shadow: inset 0 3px 8px rgba(0, 0, 0, 0.125);
        box-shadow: inset 0 3px 8px rgba(0, 0, 0, 0.125);
    }

    #main-container {
        width: 1024px;
        margin: 0 auto;
    }

    #menuNavPanel {
        width: 220px;
        margin-left: 0;
    }

    #mainContentPanel {
        width: 800px;
        margin-left: 10px;
    }

    [class*="span"] {
        float: left;
    }

    .error {
        color: tomato;
    }

    .center {
        text-align: center;
        vertical-align: middle;
    }

    .icon-fb, .icon-tw, .icon-li, .icon-gg {
        display:inline-block;
        *display:inline; /*IE7*/
        *zoom:1; /*IE7*/
        background: transparent url("../images/ticbox/FB_TW_LI_Gl_logo.png") no-repeat;
        width: 23px;
        height: 25px;
        padding: 0;
        margin: 0;
    }

    .icon-fb{
        background-position: 0 0;
    }

    .icon-tw{
        background-position: -24px 0;
    }

    .icon-li{
        background-position: -48px 0;
    }

    .icon-gg{
        background-position: -72px 0;
    }


    </style>

    <link rel="stylesheet" href="${resource(dir: 'frameworks/bootstrap/css', file: 'bootstrap-responsive.css')}" type="text/css">

    <script type="text/javascript" src="${resource(dir: 'frameworks/jquery-ui-1.10.2/js', file: 'jquery-1.9.1.js')}"></script>
    <script type="text/javascript" src="${resource(dir: 'frameworks/jquery-ui-1.10.2/js', file: 'jquery-ui-1.10.2.custom.js')}"></script>
    <script type="text/javascript" src="${resource(dir: 'frameworks/bootstrap/js', file: 'bootstrap.js')}"></script>

    <g:layoutHead/>
    <r:layoutResources />

</head>
<body>

<div class="navbar navbar-inverse navbar-fixed-top">
    <div class="navbar-inner">
        <div class="container-fluid">
            <button type="button" class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="brand" href="${request.contextPath}/">
                <img src="../images/ticbox/TicBoxLogo.png" width="200" height="100">
            </a>
            <div class="nav-collapse collapse">
                <p class="navbar-text pull-right">
                    Logged in as ${SecurityUtils.getSubject().getPrincipals().oneByType(String.class)} &nbsp; <g:link controller="auth" action="signOut">Logout</g:link>
                </p>
                <ul class="nav">
                    <li class="index"><g:link action="index">Survey List</g:link></li>
                    <li class="profileForm"><g:link action="profileForm">Profile</g:link></li>
                    <li class="inviteFriends"><g:link action="inviteFriends">Invite Friends</g:link></li>
                    <li class="redeemGold"><g:link action="redeemGold">Redeem GOLD Points</g:link></li>
                    <li class="goldHistory"><g:link action="goldHistory">GOLD Points History</g:link></li>
                </ul>
            </div>
        </div>
    </div>
</div>

<div id="main-container">
    <div class="row" style="margin-left: -10px;">
        <div id="menuNavPanel" class="span" style="position: fixed;">

            <div id="respondentProfileAccordion" class="accordion" style="width: 220px;">
                <div class="accordion-group">
                    <div class="accordion-heading">
                        <a class="accordion-toggle" data-toggle="collapse" data-parent="#respondentProfileAccordion" href="#respondentProfileContainer">
                            Hello, ${respondent?.username}
                        </a>
                    </div>
                    <div id="respondentProfileContainer" class="accordion-body collapse in">
                        <div class="accordion-inner" style="padding: 5px 5px;">
                            <div class="row-fluid">
                                <div class="span12 center">
                                    <img id="pic" src="${g.createLink(action: "viewImage", params: [respondentId: respondent.id])}"/>
                                </div>
                            </div>
                            <br />
                            <div class="row-fluid">
                                <div class="span6 center">
                                    <div>Trust</div>
                                    <div>${respondent?.respondentProfile?.trust}</div>
                                </div>
                                <div class="span6 center">
                                    <div>Gold</div>
                                    <div>${respondent?.respondentProfile?.gold}</div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div id="respondentNavAccordion" class="accordion" style="width: 220px;">
                <div class="accordion-group">
                    <div class="accordion-heading">
                        <a class="accordion-toggle" data-toggle="collapse" data-parent="#respondentNavAccordion" href="#respondentNavContainer">
                            DASHBOARD
                        </a>
                    </div>
                    <div id="respondentNavContainer" class="accordion-body collapse in">
                        <div class="accordion-inner" style="padding: 5px 5px;">
                            <div class="line">
                                <g:link action="index">Survey List</g:link>
                            </div>
                            <div class="line">
                                <g:link action="profileForm">Profile</g:link>
                            </div>
                            <div class="line">
                                <g:link action="inviteFriends">Invite Friends</g:link>
                            </div>
                            <div class="line">
                                <g:link action="redeemGold">Redeem GOLD Points</g:link>
                            </div>
                            <div class="line">
                                <g:link action="goldHistory">GOLD Points History</g:link>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

        </div>
        <div id="mainContentPanel" class="span" style="margin-left: 230px;">
            <g:layoutBody/>
        </div>
    </div>

    %{--<footer>
        &copy; TicBOX 2013
    </footer>--}%

</div>

<div id="spinner" class="spinner" style="display:none;"><g:message code="spinner.alt" default="Loading&hellip;"/></div>

<r:layoutResources />

<script type="text/javascript">

    jQuery(function(){

        jQuery(".nav > li.${actionName}").addClass('active');

        jQuery('#menuNavPanel').append(jQuery('#menuNavPanelContent'));

        jQuery('.datePicker').datepicker({
            showAnim : 'slideDown',
            format : '<g:message code="app.date.format.js" default="dd/mm/yy"/>'
        });

    });

</script>

</body>
</html>
