<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.7.2/css/all.css" rel="stylesheet">
    <title>Recharge</title>
    <style>
        body {
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            background-color: #f5f5f5;
            font-family: 'Montserrat', sans-serif;
        }
        .card {
            max-width: 500px;
            width: 100%;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        }
        .btn-primary {
            background-color: #4285F4;
            border: none;
            transition: 0.3s;
        }
        .btn-primary:hover {
            background-color: #357ae8;
        }
    </style>
</head>
<body>
 <%@ include file="navbar.jsp" %>
    <div class="card">
        <h3 class="text-center">Add Money to Your Account</h3>
        <c:if test="${not empty invalidNumber}">
            <div class="alert alert-danger" role="alert">
                Invalid amount. Please enter a valid number.
            </div>
        </c:if>
        <form action="/payment/order" method="post">
            <div class="form-group">
                <label for="amount">Amount:</label>
                <input type="number" class="form-control" id="amount" name="amount" min="0" required>
            </div>
            <button type="submit" class="btn btn-primary btn-block">Recharge</button>
        </form>
    </div>

    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
</body>
</html>
