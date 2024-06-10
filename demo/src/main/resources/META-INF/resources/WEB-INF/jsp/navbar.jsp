<%@ page language="java" contentType="text/html; charset=US-ASCII" pageEncoding="US-ASCII" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=US-ASCII" />
    <title>Navbar</title>
    <link rel="stylesheet" type="text/css" href="../../assert/css/navbar.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" />
</head>
<body>
<header>   
     <input type="text" id="userId" value="${userInfo.id}" readonly="" hidden="">
    <div class="container">
        <a href="/" class="logo">
            <img src="https://flowbite.com/docs/images/logo.svg" alt="Flowbite Logo" />
            <span>KOL</span>
        </a>

        <form autocomplete="off" class="search-form">
            <div class="suggestions">
                <input type="text" id="input" placeholder="Type a name here..." class="search-input" oninput="searchByName(this)" />
                <ul class="suggestions-list"></ul>
            </div>
            <button type="button" class="search-button">Search</button>
        </form>

        <c:if test="${not empty userInfo}">
        <a href="/chatbox" class="notification-container">
         <i class="fa-solid fa-message fa-2x"></i>
        <span id="messageNotificationDot" class="notification-dot block"></span>
        </a>
      <div class="notifi-box" id="box">
        <i class="fa-solid fa-bell fa-2x" onclick="fetchNotifications()"></i>
        <ul></ul>
        </div>

        </c:if>

        <c:choose>
            <c:when test="${not empty userInfo}">
                <div class="user-info">
                    <a href="/infor">
                        <img src="${userInfo.avatarUrl}" alt="user photo">
                    </a>
                    <div>
                     <a href="/login/logout" class="logout-link">Logout</a>
                    </div>
                </div>
            </c:when>
            <c:otherwise>
                <a href="/login/form" class="login-link">Login</a>
            </c:otherwise>
        </c:choose>
    </div>
</header>
<script src="../../assert/js/navbar.js"></script>
</body>
</html>
