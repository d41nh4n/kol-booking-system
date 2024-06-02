<%@ page language="java" contentType="text/html; charset=US-ASCII"
pageEncoding="US-ASCII" %> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Reset Password</title>
<link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>
<body class="bg-gray-100 flex items-center justify-center h-screen">
<div class="container mx-auto p-4">
    <h2 class="text-2xl font-bold text-center mb-6">Reset Your Password</h2>
    <form action="/reset_password" method="post" class="max-w-sm mx-auto bg-white p-6 rounded-lg shadow-md">
        <input type="hidden" name="token" value="${token}" />
        <div class="mb-4">
            <input type="password" name="password" id="password" class="form-input mt-1 block w-full border border-gray-300 rounded-md py-2 px-3 text-gray-900 focus:outline-none focus:ring-2 focus:ring-blue-500" placeholder="Enter your new password" required autofocus />
        </div>         
        <div class="mb-4">
            <input type="password" class="form-input mt-1 block w-full border border-gray-300 rounded-md py-2 px-3 text-gray-900 focus:outline-none focus:ring-2 focus:ring-blue-500" placeholder="Confirm your new password" required oninput="checkPasswordMatch(this);" />
        </div>         
        <div class="text-center">
            <input type="submit" value="Change Password" class="bg-blue-500 hover:bg-blue-600 text-white font-bold py-2 px-4 rounded-full transition duration-300 ease-in-out" />
        </div>
    </form>
</div>
<script>
function checkPasswordMatch(fieldConfirmPassword) {
    const passwordField = document.getElementById("password");
    if (fieldConfirmPassword.value != passwordField.value) {
        fieldConfirmPassword.setCustomValidity("Passwords do not match!");
    } else {
        fieldConfirmPassword.setCustomValidity("");
    }
}
</script>

</body>
</html>
