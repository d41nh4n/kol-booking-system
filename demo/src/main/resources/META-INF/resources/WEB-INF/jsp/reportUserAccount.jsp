<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Submit Report</title>
</head>
<body>
    <h1>Submit Report</h1>
    <form action="${pageContext.request.contextPath}/admin/reports/submit1" method="post">
        <label for="description">Description:</label>
        <input type="text" id="description" name="description" required><br><br>

        <label for="reason">Reason:</label>
        <select id="reason" name="reason" required>
            <option value="Spam">Spam</option>
            <option value="Inappropriate behavior">Inappropriate behavior</option>
            <option value="Fake profile">Fake profile</option>
            <option value="Harassment">Harassment</option>
            <option value="Scam or fraud">Scam or fraud</option>
            <option value="Impersonation">Impersonation</option>
            <option value="Posting offensive content">Posting offensive content</option>
        </select><br><br>

        <label for="reportUser">Report User ID:</label>
        <input type="number" id="reportUser" name="reportUser" required><br><br>

        <label for="reportedUser">Reported User ID:</label>
        <input type="number" id="reportedUser" name="reportedUser" required><br><br>

        <button type="submit">Submit Report</button>
    </form>
</body>
</html>
