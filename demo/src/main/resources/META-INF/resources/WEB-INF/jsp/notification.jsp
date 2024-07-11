
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Notifications</title>
    <link rel="stylesheet" type="text/css" href="/css/notification.css">
</head>
<body>
    <h1>Notifications</h1>
    <button id="openModal">Create Notification</button>
    <div id="notifications">
        <ul>
            <c:forEach var="notification" items="${notifications}">
                <li>${notification.content}</li>
            </c:forEach>
        </ul>
    </div>

    <div id="myModal" class="modal">
        <div class="modal-content">
            <span class="close">&times;</span>
            <h2>Create Notification</h2>
            <form id="notificationForm">
                <label for="content">Content:</label>
                <textarea id="content" name="content" required></textarea>
                <label for="userId">User ID:</label>
                <input type="number" id="userId" name="userId" required>
                <button type="submit">Create</button>
            </form>
        </div>
    </div>

    <script src="/js/notification.js"></script>
</body>
</html>
