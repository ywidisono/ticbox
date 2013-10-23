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

        .line {
            display: block;
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

        .center {
            text-align: center;
            vertical-align: middle;
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

<div id="doc" class="">

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
                                    <div class="artwork">
                                        <g:if test="${respondent.pic}">
                                            <img id="sidebarRespondentPic" class="" src="${g.createLink(action: 'viewImage', params: [respondentId: respondent.id])}"/>
                                        </g:if>
                                        <g:else>
                                            <img id="sidebarRespondentPic" class="" src="${g.resource(dir: 'images/ticbox', file: 'anonymous.png')}"/>
                                        </g:else>
                                    </div>
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
                                <div class="gold"><b>Gold</b></div>
                            </div>
                            <div class="span6 stats leftBordered">
                                <div><strong>${respondent?.respondentProfile?.trust}</strong></div>
                                <div class="trust"><b>Trust</b></div>
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
