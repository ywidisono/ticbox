<%--
  Created by IntelliJ IDEA.
  User: arnold
  Date: 3/24/13
  Time: 10:45 PM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="surveyor"/>
    <title></title>
</head>
<body>

<div id="menuNavPanelContent">

    <div class="line side-panel">
        <div class="line header">
            Panel 1
        </div>
        <div class="line">

        </div>

        <hr>
    </div>

    <div class="line side-panel">
        <div class="line header">
            Panel 2
        </div>
        <div class="line">

        </div>

        <hr>
    </div>

    <div class="line side-panel">

        <div class="line line-centered">

            <button href="${request.contextPath}/survey/createSurvey" id="createSurveyBtn" class="btn-ticbox link">Create Survey</button>

        </div>

        <hr>
    </div>

</div>

<div class="line">

    <h3>Your Survey List</h3>

    <table class="table table-striped table-bordered table-hover">
        <thead>
            <tr>
                <th colspan="3">IN PROGRESS</th>
            </tr>
            <tr>
                <th>Name</th>
                <th>Running Time</th>
                <th>Status</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td></td>
                <td></td>
                <td></td>
            </tr>
        </tbody>
    </table>

    <table class="table table-striped table-bordered table-hover">
        <thead>
            <tr>
                <th colspan="3">DRAFTS</th>
            </tr>
            <tr>
                <th>Name</th>
                <th>Total Charge</th>
                <th>Modified</th>
                <th></th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
            </tr>
        </tbody>
    </table>

    <table class="table table-striped table-bordered table-hover">
        <thead>
        <tr>
            <th colspan="3">COMPLETED</th>
        </tr>
        <tr>
            <th>Name</th>
            <th>Total Respondents</th>
            <th>Stats</th>
            <th></th>
        </tr>
        </thead>
        <tbody>
        <tr>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
        </tr>
        </tbody>
    </table>

</div>

<script type="text/javascript">

    jQuery(function(){



    });

</script>

</body>
</html>