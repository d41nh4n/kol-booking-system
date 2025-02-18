<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Sidebar</title>
        <link rel="stylesheet" type="text/css" href="../../assert/css/sidebar.css">
</head>
<body>
    <div class="sidebar">
        <div class="logo">
            <a href="/admin/home" class="simple-text logo-normal">
                KOLs
            </a>
        </div>
        <ul class="nav">
            <li class="nav-item">
                <a class="nav-link" href="/admin/home">
                    <p>Home</p>
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="/admin/categories">
                    <p>Categories</p>
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="/admin/list_users">
                    <p>Account</p>
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="/admin/reports">
                    <p>Report</p>
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="/admin/violationWords">
                    <p>Violation Words</p>
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="/admin/kolList">
                    <p>KOLs </p>
                </a>
            </li>
            <li class="nav-item logout">
                <a class="nav-link" href="/login/logout">
                    <p>Logout</p>
                </a>
            </li>
        </ul>
    </div>
</body>
</html>
