<!DOCTYPE html>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=US-ASCII" />
  <title>Page Home</title>
  <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet" />
</head>
<body class="bg-gray-100">
  <%@include file="navbar.jsp" %>
  <div class="container mx-auto mt-8">
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

  <!-- The Modal -->
  <div id="emailModal" class="fixed z-10 inset-0 overflow-y-auto hidden " aria-labelledby="modal-title" role="dialog" aria-modal="true">
    <div class="flex items-end justify-center min-h-screen pt-4 px-4 pb-20 text-center sm:block sm:p-0">
      <div class="fixed inset-0 bg-gray-500 bg-opacity-75 transition-opacity" aria-hidden="true"></div>

      <!-- This element is to trick the browser into centering the modal contents. -->
      <span class="hidden sm:inline-block sm:align-middle sm:h-screen" aria-hidden="true">&#8203;</span>

      <div class="inline-block align-bottom bg-white rounded-lg text-left overflow-hidden shadow-xl transform transition-all sm:my-8 sm:align-middle sm:max-w-lg sm:w-full">
        <div class="bg-white px-4 pt-5 pb-4 sm:p-6 sm:pb-4">
          <div class="sm:flex sm:items-start">
            <div class="mt-3 text-center sm:mt-0 sm:text-left">
              <h3 class="text-lg leading-6 font-medium text-gray-900" id="modal-title">Update Email</h3>
              <div class="mt-2">
                <p class="text-sm text-gray-500">Please update your email address for security reasons.</p>
              </div>
            </div>
          </div>
        </div>
        <div class="bg-gray-50 px-4 py-3 sm:px-6 sm:flex sm:flex-row-reverse">
          <a href="/infor" class="w-full inline-flex justify-center rounded-md border border-transparent shadow-sm px-4 py-2 bg-blue-600 text-base font-medium text-white hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500 sm:ml-3 sm:w-auto sm:text-sm">
            Update Email
          </a>
          <button type="button" class="mt-3 w-full inline-flex justify-center rounded-md border border-gray-300 shadow-sm px-4 py-2 bg-white text-base font-medium text-gray-700 hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500 sm:mt-0 sm:ml-3 sm:w-auto sm:text-sm" onclick="closeModal()">
            Cancel
          </button>
        </div>
      </div>
    </div>
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
        }else{
          //nothing happen
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
