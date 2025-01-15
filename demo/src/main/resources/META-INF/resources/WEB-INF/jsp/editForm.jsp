 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Violation Word</title>
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
    </style>
</head>
<body>
    <h1>Edit Violation Word</h1>
    <form action="/admin/violationWords/save" method="post">
        <input type="hidden" name="wordId" value="${violationWord.wordId}">
        <label for="word">Word:</label>
        <input type="text" id="word" name="word" value="${violationWord.word}" required><br>
        <label for="violationLevel">Violation Level:</label>
        <input type="number" id="violationLevel" name="violationLevel" value="${violationWord.violationLevel}" required min="1" max="2"><br>
        <button type="submit">Save</button>
    </form>
    <c:if test="${duplicateMessage != null}">
        <p style="color: red;">${duplicateMessage}</p>
    </c:if>
</body>
</html>
