
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>User List</title>
    <link rel="stylesheet" type="text/css" href="/css/search_result.css">
    <link rel="stylesheet" type="text/css" href="/css/header.css">
</head>
<body>
    <jsp:include page="admin/admin-template/header.jsp" />

    <h1>All Users</h1>
    
    <!-- Search Form -->
    <form action="/admin/search-result" method="get">
        <div class="search-container">
            <input type="text" id="search" name="keyword" placeholder="Search..." value="${keyword}">
            <button type="submit">Search</button>
        </div>
    </form>
    
    <!-- Display Search Result -->
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
                        </c:if>
                        
                        <!-- Button to view -->
                        <form action="/admin/users/view/${user.id}" method="GET">
                            <button type="submit">View</button>
                        </form>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
    
    <!-- Pagination Controls -->
    <div class="pagination">
        <ul>
            <c:if test="${userPage.number > 0}">
                <li>
                    <a href="/admin/search-result?keyword=${keyword}&page=${currentPage - 1}">&laquo; Previous</a>
                </li>
            </c:if>
            <c:forEach var="i" begin="1" end="${userPage.totalPages}">
                <li>
                    <a href="/admin/search-result?keyword=${keyword}&page=${i}" text="${i}"></a>
                </li>
            </c:forEach>
            <c:if test="${userPage.hasNext()}">
                <li>
                    <a href="/admin/search-result?keyword=${keyword}&page=${currentPage + 1}">Next &raquo;</a>
                </li>
            </c:if>
        </ul>
    </div> 
    <script src="/js/search_result.js"></script>
</body>
</html>
