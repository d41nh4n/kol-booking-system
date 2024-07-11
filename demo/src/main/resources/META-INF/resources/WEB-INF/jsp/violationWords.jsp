<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Violation Words Management</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f8ff;
            color: #333;
            margin: 0;
            padding: 20px;
        }
        h1 {
            color: #0056b3;
        }
        h2 {
            color: #004080;
        }
        form {
            margin-bottom: 20px;
            background-color: #e6f2ff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 255, 0.2);
        }
        form label {
            display: block;
            margin: 10px 0 5px;
        }
        form input[type="text"],
        form input[type="number"] {
            width: 100%;
            padding: 10px;
            margin-bottom: 10px;
            border: 1px solid #0056b3;
            border-radius: 4px;
        }
        form button {
            background-color: #0056b3;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        form button:hover {
            background-color: #004080;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            background-color: #ffffff;
            box-shadow: 0 0 10px rgba(0, 0, 255, 0.1);
        }
        table, th, td {
            border: 1px solid #0056b3;
        }
        th, td {
            padding: 15px;
            text-align: left;
        }
        th {
            background-color: #007bff;
            color: white;
        }
        td a {
            color: #0056b3;
            text-decoration: none;
            margin-right: 10px;
        }
        td a:hover {
            text-decoration: underline;
        }
        td a.delete {
            color: red;
        }
        .pagination {
            display: flex;
            justify-content: center;
            margin: 20px 0;
            align-items: center;
        }
        .pagination a {
            color: #0056b3;
            padding: 10px 15px;
            text-decoration: none;
            border: 1px solid #0056b3;
            margin: 0 5px;
            border-radius: 5px;
        }
        .pagination a:hover {
            background-color: #0056b3;
            color: white;
        }
        .pagination .active {
            background-color: #007bff;
            color: white;
            border: 1px solid #007bff;
        }
        .add-button {
            display: inline-block;
            padding: 10px 20px;
            background-color: #007bff;
            color: white;
            text-decoration: none;
            border-radius: 4px;
            transition: background-color 0.3s ease;
        }
        .add-button:hover {
            background-color: #004080;
        }
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
    
    <h1>Violation Words Management</h1>
    <a href="/admin/violationWords/add" class="add-button">Add Violation Word</a> <!-- Styled Link to Add Form -->
    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Word</th>
                <th>Violation Level</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
        <c:if test="${not empty violationWords}">
    <c:forEach var="violationWord" items="${violationWords}">
        <tr>
            <td>${violationWord.wordId}</td>
            <td>${violationWord.word}</td>
            <td>${violationWord.violationLevel}</td>
            <td>
                <a href="/admin/violationWords/edit/${violationWord.wordId}">Edit</a>
                <a href="/admin/violationWords/delete/${violationWord.wordId}" class="delete" onclick="return confirm('Are you sure?')">Delete</a>
            </td>
        </tr>
    </c:forEach>
</c:if>

        </tbody>
    </table>
    <div class="pagination">
        <c:if test="${currentPage > 0}">
            <a href="/admin/violationWords?page=${currentPage - 1}">&laquo; Previous</a>
        </c:if>
        <c:forEach var="i" begin="0" end="${totalPages - 1}">
            <a href="/admin/violationWords?page=${i}" class="${currentPage == i ? 'active' : ''}">${i + 1}</a>
        </c:forEach>
        <c:if test="${currentPage < totalPages - 1}">
            <a href="/admin/violationWords?page=${currentPage + 1}">Next &raquo;</a>
        </c:if>
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
