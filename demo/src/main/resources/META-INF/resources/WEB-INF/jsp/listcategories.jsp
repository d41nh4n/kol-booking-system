<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Category List</title>
    <link rel="stylesheet" href="../../assert/css/list_categories.css">
    <style>
        .notification {
            display: none;
            background-color: #4CAF50; /* Green */
            color: white;
            padding: 15px;
            position: fixed;
            top: 10px;
            right: 10px;
            z-index: 1000;
            border-radius: 5px;
        }
    </style>
</head>
<body>
    <div id="notification" class="notification">${notification}</div>
    
    <h1>All Categories</h1>
    <a href="/admin/categories/new" class="btn btn-info btn-mad">
        <span class="glyphicon glyphicon-plus"></span> Add New Category
    </a>
    <form action="/admin/categories" method="get">
        <div class="search-container">
            <input type="text" id="search" name="keyword" placeholder="Search..." value="${keyword}">
            <button type="submit">Search</button>
        </div>
    </form>
    <div class="table-container">
        <table id="categoryTable">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Description</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="category" items="${categoryPage}">
                    <tr>
                        <td>${category.categoryId}</td>
                        <td>${category.categoryName}</td>
                        <td>${category.description}</td>
                        <td>
                            <a href="/admin/categories/edit/${category.categoryId}" class="btn btn-info btn-sm">
                                <span class="glyphicon glyphicon-edit"></span> Edit
                            </a>
                            |
                            <a href="/admin/categories/delete/${category.categoryId}" 
                               class="btn btn-info btn-sm"
                               onclick="return confirm('Are you sure you want to delete this category?')">
                                <span class="glyphicon glyphicon-trash"></span> Delete
                            </a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
    <div class="pagination">
        <ul>
            <c:if test="${currentPage > 1}">
                <li>
                    <a href="/admin/categories?keyword=${keyword != null ? keyword : ''}&amp;page=${currentPage - 1}">&laquo; Previous</a>
                </li>
            </c:if>
            <c:forEach var="i" begin="1" end="${totalPages}">
                <li>
                    <a href="/admin/categories?keyword=${keyword != null ? keyword : ''}&amp;page=${i}" class="${currentPage == i ? 'active' : ''}">${i}</a>
                </li>
            </c:forEach>
            <c:if test="${currentPage < totalPages}">
                <li>
                    <a href="/admin/categories?keyword=${keyword != null ? keyword : ''}&amp;page=${currentPage + 1}">Next &raquo;</a>
                </li>
            </c:if>
        </ul>
    </div>

    <script>
        document.addEventListener("DOMContentLoaded", function() {
            var notification = document.getElementById("notification");
            if (notification.textContent.trim().length > 0) {
                notification.style.display = "block";
                setTimeout(function() {
                    notification.style.display = "none";
                }, 5000);
            }
        });
    </script>
</body>
</html>
