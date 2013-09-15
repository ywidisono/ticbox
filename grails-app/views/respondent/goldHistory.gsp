<%@ page import="ticbox.RespondentGoldHistory" %>
<html>
<head>
    <meta name="layout" content="respondent"/>
    <title>Gold History</title>
    <style type="text/css">
    </style>
</head>
<body>
    <div id="goldHistoryHeader" class="module-header">
        <div class="title">Gold History</div>
    </div>
    <div id="goldHistory" class="module-content">
        <g:if test="${goldHistory != null && goldHistory.size() > 0}">
            <table class="table table-bordered">
               <thead>
                    <tr>
                        <th>Date</th>
                        <th>Type</th>
                        <th>Description</th>
                        <th>Amount</th>
                        <th>Status</th>
                    </tr>
               </thead>
               <tbody>
                <g:each in="${goldHistory}" var="history">
                    <tr class="<g:if test='${RespondentGoldHistory.TYPES.INCOME_SURVEY.equals(history.type) || RespondentGoldHistory.TYPES.INCOME_REFERENCE.equals(history.type)}'>info</g:if><g:else>warning</g:else>">
                        <td class="span2">${history.date}</td>
                        <td class="span2">${history.typeDisplay()}</td>
                        <td class="span5">${history.description}</td>
                        <td class="span2">${history.amount}</td>
                        <td class="span3">${history.statusDisplay()}</td>
                    </tr>
                </g:each>
               </tbody>
            </table>
        </g:if>
        <g:else>
            <div class="module-message">No history yet</div>
        </g:else>
    </div>
</body>
</html>