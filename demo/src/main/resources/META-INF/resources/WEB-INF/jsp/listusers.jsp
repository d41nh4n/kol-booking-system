
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>User List</title>
        <link rel="stylesheet" type="text/css" href="/css/search_result.css">
    </head>
    <body>

        <h1>All Users</h1>

        <!-- Search Form -->
        <form action="/admin/list_users" method="get">
            <div class="search-container">
                <input type="text" id="search" name="keyword" placeholder="Search..." value="${keyword}">
                <button type="submit">Search</button>
            </div>
        </form>

        <!-- Display Search Result -->
        <div class="table-container">
            <table id="searchResultTable">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Email</th>
                        <th>Gender</th>
                        <th>Role</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="user" items="${userPage.content}">
                        <tr>
                            <td>${user.id}</td>
                            <td>${user.name}</td>
                            <td>${user.email}</td>
                            <td>${user.gender}</td>
                            <td>${user.role}</td>
                            <td>
                                <!-- Only show ban/unban buttons for non-admin users -->
                                <c:if test="${user.role != 'Admin'}">
                                    <button class="ban-unban-btn" 
                                            data-id="${user.id}" 
                                            data-action="${user.banAction == 'Ban' ? 'ban' : 'unban'}" 
                                            text="${user.banAction}">
                                    </button>                          
                                    <!-- Button to view -->
                                    <form action="/admin/users/view/${user.id}" method="GET">
                                        <button type="submit">View</button>
                                    </form>
                                </c:if>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>

        <!-- Pagination Controls -->
        <div class="pagination">
            <ul>
                <!-- Previous Page Link -->
                <c:if test="${currentPage > 1}">
                    <li>
                        <a href="/admin/list_users?page=${currentPage - 1}&keyword=${keyword}">&laquo; Previous</a>
                    </li>
                </c:if>
                <!-- Page Number Links -->
                <c:forEach var="i" begin="1" end="${totalPages}">
                    <li>
                        <a href="/admin/list_users?page=${i}&keyword=${keyword}">${i}</a>
                    </li>
                </c:forEach>
                <!-- Next Page Link -->
                <c:if test="${currentPage < totalPages}">
                    <li>
                        <a href="/admin/list_users?page=${currentPage + 1}&keyword=${keyword}">Next &raquo;</a>
                    </li>
                </c:if>
            </ul>
        </div>
        <script src="/js/search_result.js"></script>
    </body>
</html>
