<html>
<head>
    <meta name="layout" content="respondent"/>
    <title>Gold History</title>
    <style type="text/css">
    </style>
</head>
<body>
    <div class="container-fluid surveyList">
        <h3>Gold History</h3>
        <g:if test="${goldHistory != null && goldHistory.size() > 0}">
            <table class="table">
               <thead>
                    <tr>
                        <th>Date</th>
                        <th>Type</th>
                        <th>Description</th>
                        <th>Amount</th>
                    </tr>
               </thead>
               <tbody>
                <g:each in="${goldHistory}" var="history">
                    <tr class="<g:if test='${ticbox.RespondentGoldHistory.TYPES.INCOME.equals(history.type)}'>info</g:if><g:else>warning</g:else>">
                        <td class="span2">${history.date}</td>
                        <td class="span2"><g:if test='${ticbox.RespondentGoldHistory.TYPES.INCOME.equals(history.type)}'>Income</g:if><g:else>Expense</g:else></td>
                        <td class="span5">${history.description}</td>
                        <td class="span5">${history.amount}</td>
                    </tr>
                </g:each>
               </tbody>
            </table>
        </g:if>
        <g:else>
            <h3>No history yet</h3>
        </g:else>
    </div>
</body>
</html>