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
            <a href="/chatbox">
                <i class="fa-solid fa-message fa-2x"></i>
            </a>
        </c:if>
        <c:choose>
            <c:when test="${not empty userInfo}">
                <div class="user-info">
                    <a href="/infor">
                        <img src="${userInfo.avatarUrl}" alt="user photo">
                    </a>
                    <div>
                     <a href="/login/logout" class="logout-link">
                        Logout
                    </a>
                    </div>
                </div>
            </c:when>
           
            <c:otherwise>
                <a href="/login/form" class="login-link">Login</a>
            </c:otherwise>
        </c:choose>
    </div>
</header>
<script>
  function searchByName(param) {
      var search = param.value.trim(); 
      if (search === "") {
          removeElements();
          return; 
      } else {
          $.ajax({
              url: "/findUser",
              type: "get",
              data: {
                  username: search
              },
              success: function (data) {
                  displaySuggestions(data.list);
              },
              error: function (xhr) {
                  // Handle error
              }
          });
      }
  }

  function displaySuggestions(users) {
      removeElements();
      users.forEach(user => {
          let listItem = document.createElement("li");
          listItem.classList.add("suggestions-item");
          listItem.textContent = user.username; 
          listItem.setAttribute("data-id", user.id);
          listItem.addEventListener("click", () => {
              window.location.href = "/profile?userId=" + user.id;
          });
          document.querySelector(".suggestions-list").appendChild(listItem);
      });
  }

  function removeElements() {
      let items = document.querySelectorAll(".suggestions-item");
      items.forEach((item) => {
          item.remove();
      });
  }
</script>
</body>
</html>
