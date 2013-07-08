<%@ page import="org.apache.shiro.SecurityUtils" %>
<html>
<head>
    <meta name="layout" content="admin"/>
    <title>Administrator Page</title>
    <style type="text/css">

    </style>
</head>
<body>
    <h3>Manage Users</h3>

    <div>
        <a id="addNewUser" href="#add-new-user-modal" role="button" class="btn btn-success" data-toggle="modal"><i class="icon-plus icon-white"></i> New User</a>
        <a id="delUsers" href="#delete-users-modal" role="button" class="btn btn-danger" data-toggle="modal"><i class="icon-remove icon-white"></i> Delete</a>
    </div>

    <br />

    <table id="userTable" class="table table-bordered table-striped">
        <thead>
            <tr>
                <th></th>
                <th>Username</th>
                <th>Email</th>
                <th>Role(s)</th>
            </tr>
        </thead>
        <tbody>
            <g:each in="${users}" var="user" status="status">
                <tr>
                    <td><input type="checkbox" name="userIds" value="${user.id}" ${SecurityUtils.getSubject().getPrincipals().oneByType(String.class)?.equals(user.username) ? 'disabled="disabled"' : ''} /></td>
                    <td>${user.username}</td>
                    <td>${user.email}</td>
                    <td>${user.roles*.name}</td>
                </tr>
            </g:each>
        </tbody>
    </table>

<!-- Add new user modal -->
<div id="add-new-user-modal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="addNewUserLabel" aria-hidden="true">
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
        <h3 id="addNewUserLabel">Add New User</h3>
    </div>
    <div class="modal-body container-fluid">
        <g:form name="addNewUserForm" controller="admin" action="createUser">
            <div class="row-fluid">
                <div class="span3"><label><g:message code="app.userType.label"/></label></div>
                <div class="span9"><g:select name="userType" from="${userTypes}"/></div>
            </div>
            <div class="row-fluid">
                <div class="span3"><label><g:message code="app.username.label"/></label></div>
                <div class="span9"><g:textField name="username"/></div>
            </div>
            <div class="row-fluid">
                <div class="span3"><label><g:message code="app.email.label"/></label></div>
                <div class="span9"><g:textField name="email"/></div>
            </div>
            <div class="row-fluid">
                <div class="span3"><label><g:message code="app.password.label"/></label></div>
                <div class="span9"><g:passwordField name="password"/></div>
            </div>
            <div class="row-fluid">
                <div class="span3"><label><g:message code="app.passwordconfirm.label"/></label></div>
                <div class="span9"><g:passwordField name="passwordconfirm"/></div>
            </div>
            <div class="row-fluid">
                <div class="span3"><label><g:message code="app.company.label"/></label></div>
                <div class="span9"><g:textField name="company"/></div>
            </div>
        </g:form>
    </div>
    <div class="modal-footer">
        <button class="btn" data-dismiss="modal" aria-hidden="true">Cancel</button>
        <button id="createNewUser" class="btn btn-primary" data-loading-text="Processing..">Create New User</button>
    </div>
</div>

<!-- Delete users modal -->
<div id="delete-users-modal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="deleteUsersLabel" aria-hidden="true">
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
        <h3 id="deleteUsersLabel">Delete Users</h3>
    </div>
    <div class="modal-body">
        <g:form name="deleteUsersForm" controller="admin" action="deleteUsers">
            <input type="hidden" id="delUserIds" name="delUserIds" value=""/>
            <p>Are you sure to delete these users?</p>
        </g:form>
    </div>
    <div class="modal-footer">
        <button class="btn" data-dismiss="modal" aria-hidden="true">Cancel</button>
        <button id="deleteUsers" class="btn btn-danger" data-loading-text="Processing..">Delete</button>
    </div>
</div>


<g:javascript src="jquery.validate.min.js"/>
<g:javascript src="additional-methods.min.js"/>
<script type="text/javascript">
    $(document).ready(function() {

        /* Add new user submit button */
        $('#createNewUser').click(function() {
            $(this).button('loading');
            var form = $('#addNewUserForm');
            if (form.valid()) {
                form.submit();
            } else {
                $(this).button('reset');
            }
        });

        /* Delete users */
        $('#deleteUsers').click(function() {
            $(this).button('loading');
            var selected = [];
            var form = $('#deleteUsersForm');
            $('input[name=userIds]:checked').each(function(id, elmt) {
                selected.push(elmt.value);
            });
            $('#delUserIds', form).val(selected);
            form.submit();
        });

        // Validations
        $('#addNewUserForm').validate({
            rules: {
                userType: {
                    required: true
                },
                username: {
                    required: true,
                    minlength: 5
                },
                email: {
                    email: true,
                    required: true,
                    minlength: 5
                },
                password: {
                    required: true,
                    minlength: 5
                },
                passwordconfirm: {
                    required: true,
                    minlength: 5,
                    equalTo: password
                }
            }
        });


    });
</script>
</body>
</html>