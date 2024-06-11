<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
    <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700&display=swap" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.7.2/css/all.css" rel="stylesheet">
    <title>Success payment</title>
</head>

<body>
  <%@include file="navbar.jsp" %>
<div class="container p-0">
    <div class="card px-4">
        <p class="h8 py-3 text-success text-center">Success payment</p>
        <div class="row gx-3">
            <div class="col-12">
                <h2 class="my-2">Detail</h2>
            </div>
            <div class="col-12">
                <div class="d-flex flex-column">
                    <p class="text mb-1">Information:</p>
                    <input class="form-control mb-3" type="text" value="${orderId}" placeholder="[order ID]" readonly>
                </div>
            </div>
            <div class="col-12">
                <div class="d-flex flex-column">
                    <p class="text mb-1">Total:</p>
                    <input class="form-control mb-3" type="text" value="${totalPrice}" placeholder="[total price]" readonly>
                </div>
            </div>
            <div class="col-12">
                <div class="d-flex flex-column">
                    <p class="text mb-1">Payment Time:p>
                    <input class="form-control mb-3" type="text" value="${paymentTime}" placeholder="[payment time]" readonly>
                </div>
            </div>
            <div class="col-12">
                <div class="d-flex flex-column">
                    <p class="text mb-1">Transaction Code::</p>
                    <input class="form-control mb-3" type="text" value="${transactionId}" placeholder="[transaction ID]" readonly>
                </div>
            </div>
            <div class="col-12">
                <a href="/" class="btn btn-primary mb-3">
                    <span>Back to home</span>
                </a>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
        crossorigin="anonymous"></script>
</body>
</html>
