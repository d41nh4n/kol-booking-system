<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Register KOL</title>
    <link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f0f0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        .container {
            background-color: #fff;
            padding: 20px 40px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            max-width: 500px;
            width: 100%;
        }
        h1 {
            text-align: center;
            color: #333;
        }
        label {
            display: block;
            margin: 15px 0 5px;
            color: #555;
        }
        input[type="text"],
        input[type="email"],
        textarea,
        select,
        input[type="file"] {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }
        input[type="file"] {
            padding: 5px;
        }
        .select2-container--default .select2-selection--multiple {
            border: 1px solid #ccc;
            border-radius: 4px;
            padding: 5px;
        }
        button {
            width: 100%;
            padding: 10px;
            background-color: #007BFF;
            color: #fff;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            margin-top: 20px;
        }
        button:hover {
            background-color: #0056b3;
        }
        .message {
            text-align: center;
            color: green;
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Register KOL</h1>
        <form action="/guest/register" method="post" enctype="multipart/form-data">
            <label for="name">Name:</label>
            <input type="text" id="name" name="name" value="${kolRegistration.name}" required>
            <label for="email">Email:</label>
            <input type="email" id="email" name="email" value="${kolRegistration.email}" required>
            <label for="description">Description:</label>
            <textarea id="description" name="description" required>${kolRegistration.description}</textarea>
            <label for="categories">Categories:</label>
            <select id="categories" name="categories" multiple="multiple" required>
                <c:forEach var="category" items="${categories}">
                    <option value="${category.categoryName}">${category.categoryName}</option>
                </c:forEach>
            </select>
            <label for="images">Images:</label>
            <input type="file" id="images" name="images" multiple="multiple" required>
            <button type="submit">Register</button>
        </form>
        <div class="message">
            <c:if test="${not empty message}">
                <p>${message}</p>
            </c:if>
        </div>
        <a href="/login/form">back to login</a>
    </div>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>
    <script>
        $(document).ready(function() {
            $('#categories').select2({
                placeholder: "Select categories",
                allowClear: true
            });
        });
    </script>
</body>
</html>
