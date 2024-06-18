<%@ page language="java" contentType="text/html; charset=US-ASCII"
pageEncoding="US-ASCII" %> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Forgot Password</title>
<link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
<style>
    /* Thêm bất kỳ tùy chỉnh CSS nào ở đây */
</style>
</head>
<body class="bg-gray-100">
<div class="container mx-auto mt-8">
    <h2 class="text-2xl font-bold mb-4">Forgot Password</h2>
   
    <p class="mb-4">Please enter your username to reset your password:</p>
     <c:if test="${not empty emailNotVerified}">
        <p id="errorMessage" class="text-red-500">Your account has not been verified. Please check your email.</p>
    </c:if>
    
    <c:if test="${not empty invalidUser}">
        <p id="errorMessage" class="text-red-500">Invalid username. Please try again.</p>
    </c:if>

    <c:if test="${not empty confirmNotification}">
        <p id="succesMessage" >Check email to get link reset!</p>
    </c:if>
    <form id="forgotPasswordForm" action="/forgotpassword" method="post" class="mb-4">
        <input type="text" id="username" name="username" placeholder="Enter your username" required
               class="block w-full px-4 py-2 rounded-md border border-gray-300 focus:outline-none focus:border-blue-500">
        <button type="submit" class="block mt-2 px-4 py-2 bg-blue-500 text-white rounded-md transition duration-300 hover:bg-blue-600 focus:outline-none focus:bg-blue-600">
            Reset Password
        </button>
    </form>
</div>
</body>
</html>
