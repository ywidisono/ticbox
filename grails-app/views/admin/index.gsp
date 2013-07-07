<html>
<head>
    <meta name="layout" content="admin"/>
    <title>Administrator Page</title>
    <style type="text/css">

    </style>
</head>
<body>
    <h3>Manage Users</h3>
    <table class="table table-bordered table-striped">
        <thead>
            <tr>
                <th>Username</th>
                <th>Email</th>
                <th>Role(s)</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <g:each in="${users}" var="user" status="status">
                <tr>
                    <td>${user.username}</td>
                    <td>${user.email}</td>
                    <td>${user.roles*.name}</td>
                    <td>
                        <span class="btn btn-info"><i class="icon-edit icon-white"></i> Edit</span>
                        <span class="btn btn-danger"><i class="icon-remove icon-white"></i> Delete</span>
                    </td>
                </tr>
            </g:each>
        </tbody>
    </table>
</body>
</html>