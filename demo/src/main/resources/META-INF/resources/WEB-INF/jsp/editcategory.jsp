<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Category</title>
    <link rel="stylesheet" href="../../assert/css/add_edit.css"> 
</head>
<body>
    <h1>Edit Category</h1>
    <form action="/admin/categories/update/${category.categoryId}" method="post">
        <label for="categoryName">Name:</label>
        <input type="text" id="categoryName" name="categoryName" value="${category.categoryName}" required>
        <label for="description">Description:</label>
        <input type="text" id="description" name="description" value="${category.description}" required>
        <button type="submit">Update</button>
    </form>
    <c:if test="${not empty duplicateMessage}">
        <p style="color: red;">${duplicateMessage}</p>
    </c:if>
</body>
</html>
