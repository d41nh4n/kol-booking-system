<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Change Password</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link rel="stylesheet" href="../../assert/css/change-password.css">
</head>
<%@ include file="navbar.jsp" %>
<body>
    <div class="password-container">
        <h2>Change Password</h2>
        <div class="password-field">
            <i class="fa-solid fa-lock"></i>
            <input type="password" id="oldPassword" name="oldPassword" placeholder="Current Password" required>
        </div>
        <div class="password-field">
            <i class="fa-solid fa-key"></i>
            <input type="password" id="newPassword" name="newPassword" placeholder="New Password" required>
        </div>
        <div class="password-field">
            <i class="fa-solid fa-check"></i>
            <input type="password" id="confirmPassword" name="confirmPassword" placeholder="Confirm Password" required>
        </div>
        <button type="button" id="changePasswordButton" class="submit-button">Change Password</button>
        <div class="message" id="message"></div>
    </div>
    <script src="../../assert/js/change-pasword.js"></script>
</body>
</html>
