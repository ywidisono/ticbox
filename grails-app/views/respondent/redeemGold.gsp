<html>
<head>
    <meta name="layout" content="respondent"/>
    <title>Redeem Gold</title>
    <style type="text/css">
    </style>
</head>

<body>
<div class="container-fluid surveyList">
    <h3>Redeem Gold</h3>

    <div class="row">
        <div class="span12">
            <h4>1 Gold = ${goldRate}</h4>
        </div>
    </div>

    <div class="row">
        <div class="span12">
            <h4>Your balance is ${balance}</h4>
        </div>
    </div>

    <br/>

    <g:form name="redeemForm">
        <div class="row-fluid">
            <div class="span3">
                <label><g:message code="app.respondent.redeemAmount.label" default="Redeem Amount"/></label>
            </div>

            <div class="span8">
                <g:textField id="redemptionAmount" name="redemptionAmount"/>
            </div>
        </div>

        <div class="row-fluid">
            <div class="span3">
                <label><g:message code="app.respondent.bankName.label" default="Bank Name"/></label>
            </div>

            <div class="span8">
                <g:textField id="bankName" name="bankName"/>
            </div>
        </div>

        <div class="row-fluid">
            <div class="span3">
                <label><g:message code="app.respondent.bankBranchName.label" default="Bank Branch Name"/></label>
            </div>

            <div class="span8">
                <g:textField id="bankBranchName" name="bankBranchName"/>
            </div>
        </div>

        <div class="row-fluid">
            <div class="span3">
                <label><g:message code="app.respondent.bankAccountNumber.label" default="Bank Account Number"/></label>
            </div>

            <div class="span8">
                <g:textField id="bankAccountNumber" name="bankAccountNumber"/>
            </div>
        </div>

        <div class="row-fluid">
            <div class="span3">
                <label><g:message code="app.respondent.bankAccountName.label" default="Bank Account Name"/></label>
            </div>

            <div class="span8">
                <g:textField id="bankAccountName" name="bankAccountName"/>
            </div>
        </div>
    </g:form>

    <button id="submitRequest" class="btn btn-primary btn-large">${g.message(code: 'app.submit.label')}</button>
</div>

<g:javascript src="jquery.validate.min.js"/>
<g:javascript src="additional-methods.min.js"/>
<script type="text/javascript">

    function submitRequest(btn) {
        if($('#redeemForm').valid()) {
            jQuery(btn).attr('disabled', 'disabled');
            var url = '${g.createLink(controller: "respondent", action: "requestRedemption")}';
            var data = $('#redeemForm').find('input').serialize();
            $.post(url, data, function(response) {
                var message = (response) ? 'Success' : 'Application error';
                alert(message);
                window.location.replace('${request.contextPath}/respondent/');
            });
        }
    }

    $(document).ready(function () {

        $('#submitRequest').click(function() {
            submitRequest(this);
        });

        $('#redeemForm').validate({
            rules: {
                redemptionAmount: {
                    required: true,
                    number: true,
                    max: ${maxRedemption},
                    min: ${minRedemption}
                },
                bankName: {
                    required: true
                },
                bankBranchName: {
                    required: true
                },
                bankAccountNumber: {
                    required: true,
                    number: true
                },
                bankAccountName: {
                    required: true
                }
            }
        });
    });

</script>
</body>
</html>