<html>
<head>
    <meta name="layout" content="respondent"/>
    <title>Invite Friends</title>
    <style type="text/css">
    </style>
</head>

<body>
<div class="container-fluid surveyList">
    <h3>Invite Friends</h3>

    <div class="row-fluid">
        <div class="span2"># Reference</div><div class="span1">0</div>
        <div class="span2">Gold</div><div class="span1">0</div>
    </div>

    <br/>

    <h4>Reference Link</h4>
    <div class="row-fluid">
        <div class="span10">
            <div class="input-append">
                <input id="refLink" class="input-xxlarge" type="text" value="${g.createLink(controller: 'auth', action: 'registerRespondent', absolute: true)}?ref=${respondent.username}" disabled="disabled"/>
                <button id="copyRefLink" class="btn"><i class="icon-book"></i> Copy</button>
            </div>
        </div>
    </div>

    <h4>Invite friends by email</h4>
    <g:form name="inviteForm">
        <textarea id="friendEmails" name="friendEmails" rows="4" class="input-xxlarge"></textarea>
        <label style="color:#a0a0a0">Separate valid emails by comma ","</label>
    </g:form>

    <button id="submitRequest" class="btn btn-primary btn-large">${g.message(code: 'app.submit.label')}</button>
</div>

<g:javascript src="jquery.validate.min.js"/>
<g:javascript src="additional-methods.min.js"/>
<g:javascript src="jquery.zclip.min.js"/>
<script type="text/javascript">

    function submitRequest(btn) {
        var form = $('#inviteForm');
        if(form.valid()) {
            jQuery(btn).attr('disabled', 'disabled');
            var url = '${g.createLink(controller: "respondent", action: "inviteByEmail")}';
            var data = form.serialize();
            $.post(url, data, function(response) {
                var message = (response == 'SUCCESS') ? 'Invitations sent' : 'Failed to send email';
                alert(message);
                jQuery(btn).removeAttr('disabled');
            });
        }
    }

    $(document).ready(function () {

        $('#copyRefLink').zclip({
            path: '${g.resource(dir: "js", file: "ZeroClipboard.swf")}',
            copy: $('#refLink').val()
        });

        $('#submitRequest').click(function() {
            submitRequest(this);
        });

        $('#inviteForm').validate({
            rules: {
                friendEmails: {
                    required: true,
                    minlength: 7
                }
            }
        });
    });

</script>
</body>
</html>