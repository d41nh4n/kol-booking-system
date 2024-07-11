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
        <input type="text" id="description" name="description" value="${report.description}" required><br><br>

        <label for="reason">Reason:</label>
        <select id="reason" name="reason" required>
            <option value="Offensive comments" ${report.reason == 'Offensive comments' ? 'selected' : ''}>Offensive comments</option>
            <option value="Comments inciting violence" ${report.reason == 'Comments inciting violence' ? 'selected' : ''}>Comments inciting violence</option>
            <option value="Comments against the government" ${report.reason == 'Comments against the government' ? 'selected' : ''}>Comments against the government</option>
            <option value="Spam or misleading information" ${report.reason == 'Spam or misleading information' ? 'selected' : ''}>Spam or misleading information</option>
            <option value="Hate speech" ${report.reason == 'Hate speech' ? 'selected' : ''}>Hate speech</option>
            <option value="Harassment or bullying" ${report.reason == 'Harassment or bullying' ? 'selected' : ''}>Harassment or bullying</option>
            <option value="Promoting illegal activities" ${report.reason == 'Promoting illegal activities' ? 'selected' : ''}>Promoting illegal activities</option>
            <option value="Misinformation or fake news" ${report.reason == 'Misinformation or fake news' ? 'selected' : ''}>Misinformation or fake news</option>
            <option value="Graphic or violent content" ${report.reason == 'Graphic or violent content' ? 'selected' : ''}>Graphic or violent content</option>
        </select><br><br>

        <label for="reportUser">Report User ID:</label>
        <input type="number" id="reportUser" name="reportUser" value="${report.reportUser.userId}" required><br><br>

        <label for="reportedUser">Reported User ID:</label>
        <input type="number" id="reportedUser" name="reportedUser" value="${report.reportedUser.userId}" required><br><br>

        <label for="reportedComment">Reported Comment ID (optional):</label>
        <input type="number" id="reportedComment" name="reportedComment" value="${report.reportedComment.commentId}"><br><br>

        <button type="submit">Submit Report</button>
    </form>
</body>
</html>
