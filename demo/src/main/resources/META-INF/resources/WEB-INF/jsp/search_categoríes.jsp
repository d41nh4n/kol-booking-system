
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Category Search Results</title>
    <link rel="stylesheet" type="text/css" href="/css/list_categories.css">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!--    bootstrap icon-->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<body>
    <h1>All Categories</h1>
    <a href="/admin/categories/new" class="btn btn-info btn-mad">
        <span class="glyphicon glyphicon-plus"></span> Add New Category 
    </a>
    <form action="/admin/categories/search" method="get">
        <div class="search-container">
            <input type="text" id="search" name="keyword" placeholder="Search..." value="${keyword}">
            <button type="submit">Search</button>
        </div>
    </form>
    
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
            <c:forEach var="category" items="${categoryPage.content}">
                <tr>
                    <td>${category.categoryId}</td>
                    <td>${category.categoryName}</td>
                    <td>${category.description}</td>
                    <td>
                        <a href="/admin/categories/edit/${category.categoryId}" class="btn btn-info btn-sm">
                            <span class="glyphicon glyphicon-edit"></span> Edit
                        </a>
                        |
                        <a href="/admin/categories/delete/${category.categoryId}" class="btn btn-info btn-sm">
                            <span class="glyphicon glyphicon-trash"></span> Delete 
                        </a>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>

    <!-- Pagination Controls -->
    <div class="pagination">
        <ul>
            <c:if test="${currentPage > 1}">
                <li>
                    <a href="/admin/categories/search?keyword=${keyword}&amp;page=${currentPage - 1}">&laquo; Previous</a>
                </li>
            </c:if>
            <c:forEach var="i" begin="1" end="${totalPages}">
                <li>
                    <a href="/admin/categories/search?keyword=${keyword}&amp;page=${i}" class="${currentPage == i ? 'active' : ''}">${i}</a>
                </li>
            </c:forEach>
            <c:if test="${currentPage < totalPages}">
                <li>
                    <a href="/admin/categories/search?keyword=${keyword}&amp;page=${currentPage + 1}">Next &raquo;</a>
                </li>
            </c:if>
        </ul>
    </div>
</body>
</html>
