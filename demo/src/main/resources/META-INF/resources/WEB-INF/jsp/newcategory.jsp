
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>New Category</title>
    <link rel="stylesheet" type="text/css" href="../../assert/css/add_edit.css">
    <link rel="stylesheet" type="text/css" href="../../assert/css/header.css">
</head>
<body>
    
    <h1>New Category</h1>
    <form action="/admin/categories" method="post">
        <label for="categoryName">Name:</label>
        <input type="text" id="categoryName" name="categoryName" value="${category.categoryName}" required>
        <label for="description">Description:</label>
        <input type="text" id="description" name="description" value="${category.description}" required>
        <button type="submit">Save</button>
    </form>
    <c:if test="${duplicateMessage != null}">
        <p style="color: red;">${duplicateMessage}</p>
    </c:if>
</body>
</html>
