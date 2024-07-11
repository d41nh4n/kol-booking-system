<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" />
    <title>Payment</title>
    <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700&display=swap" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.7.2/css/all.css" rel="stylesheet">
  </head>
  <body>

    <div class="container p-0">
      <div class="card px-4">
        <p class="h8 py-3">Payment Details</p>
        <div class="row gx-3">
          <c:forEach var="request" items="${requests}">
            <div class="col-12">
              <div class="d-flex flex-column">
                <p class="text mb-1">Request ID</p>
                <input class="form-control mb-3" type="text" value="${request.requestId}" placeholder="Request ID" readonly>
              </div>
            </div>
            <div class="col-12">
              <div class="d-flex flex-column">
                <p class="text mb-1">Requester ID</p>
                <input class="form-control mb-3" type="text" value="${request.requesterId.userId}" placeholder="Requester ID" readonly>
              </div>
            </div>
            <div class="col-12">
              <div class="d-flex flex-column">
                <p class="text mb-1">Responder ID</p>
                <input class="form-control mb-3" type="text" value="${request.responderId.userId}" placeholder="Responder ID" readonly>
              </div>
            </div>
            <div class="col-12">
              <div class="d-flex flex-column">
                <p class="text mb-1">Description</p>
                <input class="form-control mb-3" type="text" value="${request.requestDescription}" placeholder="Description" readonly>
              </div>
            </div>
            <div class="col-12">
              <div class="d-flex flex-column">
                <p class="text mb-1">Location</p>
                <input class="form-control mb-3" type="text" value="${request.requestLocation}" placeholder="Location" readonly>
              </div>
            </div>
            <div class="col-12">
              <div class="d-flex flex-column">
                <p class="text mb-1">Payment</p>
                <input class="form-control mb-3" type="text" value="${request.payment}" placeholder="Payment" readonly>
              </div>
            </div>
            <div class="col-12">
              <div class="d-flex flex-column">
                <p class="text mb-1">Request Date</p>
                <input class="form-control mb-3" type="text" value="${request.requestDate}" placeholder="Request Date" readonly>
              </div>
            </div>
            <div class="col-12">
              <div class="d-flex flex-column">
                <p class="text mb-1">Request Date End</p>
                <input class="form-control mb-3" type="text" value="${request.requestDateEnd}" placeholder="Request Date End" readonly>
              </div>
            </div>
            <div class="col-12">
              <div class="d-flex flex-column">
                <p class="text mb-1">Status</p>
                <input class="form-control mb-3" type="text" value="${request.requestStatus ? 'Active' : 'Inactive'}" placeholder="Status" readonly>
              </div>
            </div>
            <c:if test="${!request.requestStatus}">
              <div class="col-12">
                <a class="btn btn-primary mb-3" href="<c:url value='/payment/order-save'/>?amount=${request.payment}&info=${request.requestDescription}&requesterId=${request.requesterId}&responderId=${request.responderId}&requestId=${request.requestId}&requestStatus=${request.requestStatus}">
                  <span>Payment with VNPAY</span>
                </a>
              </div>
            </c:if>
          </c:forEach>
        </div>
      </div>
    </div>
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
  </body>
</html>
