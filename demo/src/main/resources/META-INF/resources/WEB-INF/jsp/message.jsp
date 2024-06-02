<%@ page language="java" contentType="text/html; charset=US-ASCII"
pageEncoding="US-ASCII" %> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Message</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>
<body class="bg-gray-100 flex items-center justify-center h-screen">
    <div class="container mx-auto p-4 bg-white shadow-md rounded-lg text-center">
        <h2 class="text-2xl font-bold mb-4 text-red-500">${message == 'Invalid Token' ? 'Verification Failed' : 'Password Changed Successfully'}</h2>
        <p class="mb-4">${message}</p>
        <a href="/login/form" class="text-blue-500 hover:underline">Go back to Login</a>
    </div>
</body>
</html>
