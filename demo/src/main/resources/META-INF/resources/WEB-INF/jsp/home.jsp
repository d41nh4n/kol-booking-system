<!DOCTYPE html>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=US-ASCII" />
  <title>Page Home</title>
  <%-- <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet" /> --%>
</head>
<style>
.container-homepage{
  margin-top:80px;
}
</style>
<body class="bg-gray-100">
  <%@include file="navbar.jsp" %>
  <div class="container-homepage">
    <c:choose>
      <c:when test="${empty userInfo}">
        <h2 class="text-xl font-semibold">Guest Page</h2>
      </c:when>
      <c:when test="${not empty userInfo && userInfo.role == 'USER'}">
        <h2 class="text-xl font-semibold">User Page</h2>
      </c:when>
      <c:when test="${not empty userInfo && userInfo.role == 'ADMIN'}">
        <h2 class="text-xl font-semibold">ADMIN Page</h2>
      </c:when>
    </c:choose>
  </div>
  <script>

    function closeModal() {
      document.getElementById('emailModal').classList.add('hidden');
    }

    function openModal() {
      document.getElementById('emailModal').classList.remove('hidden');
    }

    function checkAccount() {
      fetch('/checkAccount', {
        method: 'GET',
      })
      .then(response => response.json())
      .then(data => {
        console.log(data)
        if (data.status === false) {
          openModal();
        } else {
          // nothing happen
        }
      })
      .catch(error => {
        console.error('Error:', error);
      });
    }

    // Call checkAccount on page load
    window.onload = function() {
      checkAccount();
    }
  </script>
</body>
</html>
