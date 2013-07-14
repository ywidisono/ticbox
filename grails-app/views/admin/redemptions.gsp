<%@ page import="ticbox.User; org.apache.shiro.SecurityUtils" %>
<html>
<head>
    <meta name="layout" content="admin"/>
    <title>Administrator Page : Redemptions</title>
    <style type="text/css">

    </style>
</head>
<body>
    <h3>Redemptions</h3>

    <div class="row-fluid">
        <div class="span2">
            <g:select class="input-medium" name="newStatusSelect" from="${redemptionStatuses.entrySet()}" optionKey="key" optionValue="value"/>
        </div>
        <div class="span2">
            <a id="changeStatus" role="button" class="btn" data-loading-text="Processing.."><i class="icon-tag"></i> Change Status</a>
        </div>
    </div>

    <br />

    <table id="redemptionTable" class="table table-bordered table-striped">
        <thead>
            <tr>
                <th></th>
                <th>Date Created</th>
                <th>Respondent ID</th>
                <th>Name</th>
                <th>Amount</th>
                <th>Bank Name</th>
                <th>Account No</th>
                <th>Account Name</th>
                <th>Status</th>
            </tr>
        </thead>
        <tbody>
            <g:each in="${redemptionRequestList}" var="redemption" status="status">
                <tr>
                    <td><input type="checkbox" name="redemptionIds" value="${redemption.id}" /></td>
                    <td>${redemption.dateCreated}</td>
                    <td>${redemption.respondentId}</td>
                    <td>${redemption.respondentUsername}</td>
                    <td>${g.formatNumber(number: redemption.redemptionAmount, formatName: 'app.currency.format')}</td>
                    <td>${redemption.bankName}</td>
                    <td>${redemption.bankAccountNumber}</td>
                    <td>${redemption.bankAccountName}</td>
                    <td>${redemption.status}</td>
                </tr>
            </g:each>
        </tbody>
    </table>

<g:form name="changeRedemptionStatusForm" action="changeRedemptionStatus">
    <g:hiddenField name="redemptionIds"></g:hiddenField>
    <g:hiddenField name="newStatus"></g:hiddenField>
</g:form>

<script type="text/javascript">
    $(document).ready(function() {

        $('#changeStatus').click(function() {
            if (confirm('Change all statuses?')) {
                $('#changeStatus').button('loading');
                var selected = [];
                var form = $('#changeRedemptionStatusForm');
                $('input[name=redemptionIds]:checked').each(function(id, elmt) {
                    selected.push(elmt.value);
                });
                $('#redemptionIds', form).val(selected);
                $('#newStatus', form).val($('#newStatusSelect').val());
                form.submit();
            }
        });

    });
</script>
</body>
</html>