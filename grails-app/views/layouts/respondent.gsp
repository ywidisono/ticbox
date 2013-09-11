<%@ page import="org.apache.shiro.SecurityUtils" %>
<!DOCTYPE html>
<!--[if lt IE 7 ]> <html lang="en" class="no-js ie6"> <![endif]-->
<!--[if IE 7 ]>    <html lang="en" class="no-js ie7"> <![endif]-->
<!--[if IE 8 ]>    <html lang="en" class="no-js ie8"> <![endif]-->
<!--[if IE 9 ]>    <html lang="en" class="no-js ie9"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--> <html lang="en" class="no-js"><!--<![endif]-->
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title><g:layoutTitle default="TicBOX"/></title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="shortcut icon" href="${resource(dir: 'images', file: 'favicon.ico')}" type="image/x-icon">
    <link rel="apple-touch-icon" href="${resource(dir: 'images', file: 'apple-touch-icon.png')}">
    <link rel="apple-touch-icon" sizes="114x114" href="${resource(dir: 'images', file: 'apple-touch-icon-retina.png')}">

    <link rel="stylesheet" href="${resource(dir: 'frameworks/jquery-ui-1.10.2/css/smoothness', file: 'jquery-ui-1.10.2.custom.css')}" type="text/css">

    <link rel="stylesheet" href="${resource(dir: 'frameworks/bootstrap/css', file: 'bootstrap.css')}" type="text/css">

    <link rel="stylesheet" href="${resource(dir: 'css', file: 'app.css')}" type="text/css">

    <style type="text/css">

    html, body, #doc {
        /**padding-top: 65px;**/
        /**background-color: #dfdfde;**/
        /**background: url("http://dryicons.com/images/cutie_animation/header_cutie.jpg") no-repeat fixed right 0 transparent;**/
        /*background-color: #d3d3d3;*/
        background: url("../images/skin/bg-building-clean.png") no-repeat center center fixed #F6F4F0;
        -webkit-background-size: cover;
        -moz-background-size: cover;
        -o-background-size: cover;
        background-size: cover;
    }

    html, body, #doc, #page-outer {
        height: 100%;
    }

    .line {
        display: block;
    }

    @media (max-width: 980px) {
    /* Enable use of floated navbar text */
        .navbar-text.pull-right {
            float: none;
            padding-left: 5px;
            padding-right: 5px;
        }
    }

    .navbar-inverse .navbar-text {
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

    #menuNavPanel {
        /*margin-left: 0;
        position: fixed;*/
    }

    #mainContentPanel {
        /**width: 800px;
        margin-left: 10px;**/
        /**margin-left: 230px;**/
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

    .navbar-inverse .nav li.dropdown.open > .dropdown-toggle, .navbar-inverse .nav li.dropdown.active > .dropdown-toggle, .navbar-inverse .nav li.dropdown.open.active > .dropdown-toggle{
        background-color: transparent !important;
    }

    .wrapper {
        padding-bottom: 0;
        min-height: 100%;
        position: relative;
        padding: 70px 14px 15px;
        width: 1024px;
        margin: 0 auto;
        overflow: auto;
    }

    .wrapper.grey {
        background: url("../images/skin/bg-wash-grey.png") repeat scroll 0 0 transparent;
        /**background: url("https://abs.twimg.com/a/1378257772/t1/img/wash-white-30.png") repeat scroll 0 0 transparent;**/
    }

    .row {
        margin-left: -10px;
    }

    .leftPanel {
        float: left;
        width: 220px;
        position: relative;
    }

    .rightPanel {
        float: right;
        width: 792px;
        /*position: relative;*/
    }

    .module {
        border: 1px solid rgba(0, 0, 0, 0.1);
        /**text-shadow: 0 1px 0 #FFFFFF;**/
        margin-bottom: 10px;
        position: relative;
        background-color: #F9F9F9;
        border-radius: 6px 6px 6px 6px;
        box-shadow: 1px 1px 5px lightgrey;
        color: #333333;
        padding: 12px;
    }

    a {
        color: #333333;
    }

    .accountGroup {
        overflow: hidden;
        text-overflow: ellipsis;
        white-space: nowrap;
        padding-bottom: 20px;
    }

    .fullName {
        color: #333333;
        display: block;
        font-size: 16px;
        font-weight: bold;
    }

    .metadata {
        color: #999999;
        font-size: 12px;
    }

    .accountGroup .desc {
        margin-left: 62px;
        padding-top: 5px;
    }

    .line20 {
        line-height: 20px;
    }

    .accountGroup img {
        border-radius: 4px 4px 4px 4px;
        height: 50px;
        width: 50px;
        position: absolute;
        float: left;
        display: block;
    }

    .profileStats {
        border-top: 1px solid #E8E8E8;
        overflow: hidden;
        padding-bottom: 0;
    }

    .stats {
        text-transform: uppercase;
        padding: 12px;
        color: #999999;
        font-size: 11px;
    }

    .stats strong {
        color: #333333;
        display: block;
        font-size: 16px;
    }

    .leftBordered {
        border-left: 1px solid #E8E8E8;
    }

    .module-header {
        border-bottom: 1px solid #E8E8E8;
        font-size: 18px;
        font-weight: bold;
        padding-top: 5px;
        padding-bottom: 5px;
        /*border-bottom-width: 0;*/
    }

    .module-header .title {
        color: #7F9B09;
    }

    .module-message {
        color: #a67a3a;
        font-style: italic;
        font-size: 12px;
        padding-bottom: 10px;
    }

    .module-content {
        padding: 12px;
    }

    .message-box {
        background-color: gainsboro;
        border-radius: 6px 6px 6px 6px;
        width: auto;
    }

    .message-box .module-message {
        padding: 5px 10px 5px 10px;
        width: auto;
    }

    </style>

    <link rel="stylesheet" href="${resource(dir: 'frameworks/bootstrap/css', file: 'bootstrap-responsive.css')}" type="text/css">
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'app.css')}" type="text/css">

    <script type="text/javascript" src="${resource(dir: 'frameworks/jquery-ui-1.10.2/js', file: 'jquery-1.9.1.js')}"></script>
    <script type="text/javascript" src="${resource(dir: 'frameworks/jquery-ui-1.10.2/js', file: 'jquery-ui-1.10.2.custom.js')}"></script>
    <script type="text/javascript" src="${resource(dir: 'frameworks/bootstrap/js', file: 'bootstrap.js')}"></script>

    <g:layoutHead/>
    <r:layoutResources />

</head>
<body>

<div id="doc" class="route-home">

    <div class="navbar navbar-inverse navbar-fixed-top">
        <div class="navbar-inner">
            <div class="container-fluid">
                %{--
                <button type="button" class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                --}%
                <a class="brand" href="${request.contextPath}/">
                    <img src="${g.resource(dir: 'images/ticbox', file: 'TicBoxLogo.png')}" width="200" height="100">
                </a>
                <div class="nav-collapse collapse">

                    <ul class="nav">
                        <li class="index"><g:link action="index">Survey List</g:link></li>
                        <li class="profileForm"><g:link action="profileForm">Profile</g:link></li>
                        <li class="inviteFriends"><g:link action="inviteFriends">Invite Friends</g:link></li>
                        <li class="redeemGold"><g:link action="redeemGold">Redeem GOLD Points</g:link></li>
                        <li class="goldHistory"><g:link action="goldHistory">GOLD Points History</g:link></li>
                    </ul>

                    <ul class="nav nav-pills pull-right">
                        %{--TODO should be providing different state when there is notification available--}%
                        <li class="dropdown">
                            <a class="dropdown-toggle" data-toggle="dropdown" href="#">Logged in as ${SecurityUtils.getSubject().getPrincipals().oneByType(String.class)}</a>
                            <ul class="dropdown-menu" role="menu" aria-labelledby="dLabel">
                                <li role="presentation"><g:link controller="auth" action="signOut">Logout</g:link></li>
                                <li role="presentation" class="divider"></li>
                                <g:each in="${ticbox.UserNotification.findAllByUsernameAndIsNoticed(SecurityUtils.getSubject().getPrincipals().oneByType(String.class), false)}" var="notification">
                                    <li role="presentation">
                                        <g:link controller="userNotification" title="${notification.title}" params="[code: notification.code]">${notification.title}</g:link>
                                    </li>
                                </g:each>
                            </ul>
                        </li>
                    </ul>

                </div>
            </div>
        </div>
    </div>

    <div id="page-outer">
        <div id="main-container" class="wrapper grey">
        %{--<div class="row">--}%
            <div id="menuNavPanel" class="leftPanel">

                <div id="respondentProfileAccordion" class="module" >
                    <div class="profileSummary">
                            <div class="accountGroup">
                    %{--
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
                                    --}%
                                        <g:if test="${respondent.pic}">
                                            <img id="sidebarRespondentPic" class="" src="${g.createLink(action: 'viewImage', params: [respondentId: respondent.id])}"/>
                                        </g:if>
                                        <g:else>
                                            <img id="sidebarRespondentPic" class="" src="${g.resource(dir: 'images/ticbox', file: 'anonymous.png')}"/>
                                        </g:else>
                                    %{--
                                    </div>
                                </div>

                            </div>
                        </div>
                    </div>
                    --}%
                                <div class="desc line20">
                                    <b class="fullName">${respondent?.username}</b>
                                    <g:link class="metadata" action="profileForm">View profile page</g:link>
                                </div>
                            </div>
                    </div>

                    <div class="profileStats">
                        <div class="row-fluid">
                            <div class="span6 stats">
                                <div><strong>${respondent?.respondentProfile?.gold}</strong></div>
                                <div style="color: goldenrod;"><b>Gold</b></div>
                            </div>
                            <div class="span6 stats leftBordered">
                                <div><strong>${respondent?.respondentProfile?.trust}</strong></div>
                                <div style="color: #6daac9"><b>Trust</b></div>
                            </div>
                        </div>
                    </div>
                    <div class="profileStats">
                        <div class="row-fluid">
                            <div class="span12 stats">
                                <div><strong>XX</strong></div>
                                <div><b>Total Survey Joined</b></div>
                            </div>
                        </div>
                    </div>
                </div>

                <div id="respondentNavAccordion" class="accordion module" >
                        <div class="accordion-heading module-header">
                            <a style="padding: 0" class="accordion-toggle" data-toggle="collapse" data-parent="#respondentNavAccordion" href="#respondentNavContainer">
                                <div class="title">Dashboard</div>
                            </a>
                        </div>
                        <div id="respondentNavContainer" class="accordion-body collapse in">
                            <div class="accordion-inner" style="padding-left: 12px;">
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
            <div id="main" class="rightPanel mainContentPanel">
                <div class="module">
                    <g:layoutBody/>
                </div>

            </div>
        %{--</div>--}%

        %{--<footer>
            &copy; TicBOX 2013
        </footer>--}%

    </div>
    </div>
</div>

<div id="spinner" class="spinner" style="display:none;"><g:message code="spinner.alt" default="Loading&hellip;"/></div>

<r:layoutResources />

<script type="text/javascript">

    jQuery(function(){

        jQuery(".nav > li.${actionName}").addClass('active');

        jQuery('#menuNavPanel').append(jQuery('#menuNavPanelContent'));

        jQuery('.datePicker').datepicker({
            showAnim : 'slideDown',
            dateFormat : '<g:message code="app.date.format.js" default="dd/mm/yy"/>',
            changeMonth: true,
            changeYear: true,
            yearRange: 'c-60:c+10'
        });

    });

</script>

</body>
</html>
