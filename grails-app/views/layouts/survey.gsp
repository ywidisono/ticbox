<%@ page import="org.apache.shiro.SecurityUtils; ticbox.ProfileItem; ticbox.Survey" %>
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

    <link rel="stylesheet" href="${resource(dir: 'css', file: 'app.css')}" type="text/css">

    <style type="text/css">

        body {
            padding-top: 65px;
            font-family: helveticaneue-light,tahoma,sans-serif;
            letter-spacing: 0.1em;
            color: #5a5a5a;

        }

        textarea, input[type=text] {
            background-color: #f5f5f5;
        }

        textarea:focus, input[type=text]:focus {
            background-color: #ffffff;
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
            min-width: 1060px !important;
            margin: 0 20px !important;
            padding: 0 10px !important;
        }

        #menuNavPanel {
            width: 300px;
            margin-left: 0;
            border-right: 1px solid #7F9B09;
        }

        #menuNavPanel .side-panel {
            width: 300px;
            margin: 10px 0;
        }

        #menuNavPanel .side-panel .line {
            padding-left: 5px;
        }

        #menuNavPanel .side-panel .summary-header {
            color: #bad33c;
            font-size: x-large;
        }

        #menuNavPanel hr{
            height: 5px;
            border: 0;
            margin: 5px 0;
            -webkit-box-shadow: inset 0 6px 5px -5px #a0a0a0;
            -moz-box-shadow: inset 0 6px 5px -5px #a0a0a0;
            box-shadow: inset 0 6px 5px -5px #a0a0a0;
        }

        #mainContentPanel {
            width: 890px;
            margin: 10px 0 0 10px;
        }

        .control-label {
            /*text-align: left !important;*/
        }

        .summary-header {
            /*background-color: #565655;*/
            margin-bottom: 10px;
        }

        .summary-body {
            /*background-color: #a0a0a0;*/
        }

        .preview-item-even {
            background-color: #ececec;
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
                    <li class="index"><a href="${request.contextPath}/survey/index">Survey Type</a></li>
                    <li class="respondentFilter"><a href="${request.contextPath}/survey/respondentFilter">Respondent Filter</a></li>
                    <li class="surveyGenerator"><a href="${request.contextPath}/survey/surveyGenerator">Create Survey</a></li>
                </ul>
            </div>
        </div>
    </div>
</div>

<div id="main-container" class="shadowed-container">
    <div class="line">
        <div id="menuNavPanel" class="col">
            %{--menu navigation panel--}%


        </div>
        <div id="mainContentPanel" class="col">
            <g:layoutBody/>
        </div>
    </div>

    %{--<footer>
        &copy; TicBOX 2013
    </footer>--}%

</div>

<r:layoutResources />

<script type="text/javascript">

    var surveySummary;

    jQuery(function(){

        jQuery(".nav > li.${actionName}").addClass('active');

        //jQuery('#menuNavPanel .survey-summary').before(jQuery('#menuNavPanelContent'));
        jQuery('#menuNavPanel').append(jQuery('#menuNavPanelContent').contents());

        jQuery('.datePicker').datepicker({
            showAnim : 'slideDown',
            format : '<g:message code="app.date.format.js" default="dd/mm/yy"/>'
        });

        jQuery.getJSON('${request.contextPath}/survey/getSurveySummary', {}, function(data){
            if(data){
                surveySummary = data;

                jQuery('.total-charge').html(parseFloat(surveySummary.chargePerRespondent) * parseFloat(surveySummary.totalRespondent));
                jQuery('.charge-per-respondent').html(surveySummary.chargePerRespondent);
                jQuery('.total-respondents').html(surveySummary.totalRespondent);
            }
        });

        jQuery('.enableTooltip').tooltip({
            selector: "button[data-toggle=tooltip]"
        });

    });



</script>

</body>
</html>
