<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>User Profile</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<%@ include file="navbar.jsp" %>
<body class="bg-gray-100">
    <c:if test="${not empty UserNotExsist}"> 
        <h2>${UserNotExsist}</h2>
    </c:if>
    <div class="flex flex-col items-start container mx-auto mt-10 bg-white rounded-lg shadow-lg ">
        <div class="flex space-x-5 my-4 items-center w-full">
            <img class="w-24 h-24 rounded-full" src="${user.avatarUrl}" alt="User Avatar">
            <div>
                <h1 class="text-3xl font-bold text-gray-900">${user.username}</h1>
                <p class="text-gray-600">${user.role}</p>
            </div>
            <div class="ml-auto">
                <a href="/chatbox?userId=${user.id}" class="bg-blue-500 text-white px-4 py-2 rounded hover:bg-blue-600 focus:outline-none focus:ring-2 focus:ring-blue-500">Chat</a>
            </div>
        </div>
        <div class="mt-5">
            <h2 class="text-2xl font-semibold text-gray-800">Personal Information</h2>
            <ul class="mt-2 text-gray-700">
                <li><strong>Email:</strong> ${user.email}</li>
                <li><strong>Phone:</strong> ${user.phone}</li>
                <li><strong>Date of Birth:</strong> ${user.dateOfBirth}</li>
                <li><strong>Gender:</strong> 
                    <c:choose>
                        <c:when test="${user.gender == 'Male'}">Male</c:when>
                        <c:when test="${user.gender == 'Female'}">Female</c:when>
                        <c:otherwise>Unspecified</c:otherwise>
                    </c:choose>
                </li>
                <li><strong>Address:</strong> ${user.address}</li>
            </ul>
        </div>
        <div class="my-5">
            <h2 class="text-2xl font-semibold text-gray-800">Profile Description</h2>
            <p class="mt-2 text-gray-700">${user.profileDesc}</p>
        </div>
    </div>
</body>
</html>
