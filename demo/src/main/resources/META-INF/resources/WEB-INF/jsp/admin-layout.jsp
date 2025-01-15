
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Layout</title>
    <link rel="stylesheet" type="text/css" href="../../assert/css/sidebar.css">
    <link rel="stylesheet" type="text/css" href="../../assert/css/main.css">
</head>
<body>
    <div>
        <jsp:include page="sidebar.jsp"></jsp:include>
    </div>
    <div class="main-content">
        <jsp:include page="${viewName}.jsp"></jsp:include>
    </div>
</body>
</html>
