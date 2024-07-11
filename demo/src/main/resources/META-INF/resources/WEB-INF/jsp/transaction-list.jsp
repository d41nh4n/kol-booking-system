<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8" />

    <title>latest transactions - Bootdey.com</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/css/bootstrap.min.css"
      rel="stylesheet"
    />
    <style type="text/css">
      body {
        margin-top: 20px;
        background: #fff5ee;
      }

      .card {
        box-shadow: 0 20px 27px 0 rgb(0 0 0 / 5%);
      }

      .avatar.sm {
        width: 2.25rem;
        height: 2.25rem;
        font-size: 0.818125rem;
      }

      .table-nowrap .table td,
      .table-nowrap .table th {
        white-space: nowrap;
      }

      .table > :not(caption) > * > * {
        padding: 0.75rem 1.25rem;
        border-bottom-width: 1px;
      }

      table th {
        font-weight: 600;
        background-color: #eeecfd !important;
      }

      .fa-arrow-up {
        color: #00ced1;
      }

      .fa-arrow-down {
        color: #ff00ff;
      }
      .transaction-list{
        margin-top: 70px;
      }
    </style>
  </head>
  <body>
    <link
      href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css"
      rel="stylesheet"
    />
    <%@ include file="navbar.jsp" %>
    <div class="container transaction-list">
      <div class="row">
        <div class="col-12 mb-3 mb-lg-5">
          <div class="position-relative card table-nowrap table-card">
            <div class="table-responsive">
              <table class="table mb-0">
                <thead class="small text-uppercase bg-body text-muted">
                  <tr>
                    <th>Transaction ID</th>
                    <th>Request ID</th>
                    <th>Date</th>
                    <th>Type</th>
                    <th>Amount</th>
                    <c:if test="${userInfor.role == 'USER'}">
                    <th>Refund</th>
                    </c:if>
                    <th>Status</th>
                  </tr>
                </thead>
                
                <tbody>
                 <c:forEach  items="${transactions}" var="transaction">
                 <c:if test="${userInfor.role == 'USER' || (transaction.transStatus == true && userInfor.role == 'KOL' && transaction.typeRequest == 'FINISHED')}">
                  <tr class="align-middle">
                    <td>${transaction.transId}</td>
                    <c:choose>
                                        <c:when test="${transaction.typeRequest == 'PENDING'}">
                                            <td><a href="/request/pending">${transaction.requestId}</a></td>
                                        </c:when>
                                        <c:when test="${transaction.typeRequest == 'IN_PROGRESS'}">
                                            <td><a href="/request/in-progress">${transaction.requestId}</a></td>
                                        </c:when>
                                        <c:when test="${transaction.typeRequest == 'FINISHED'}">
                                            <td><a href="/request/finish">${transaction.requestId}</a></td>
                                        </c:when>
                                              <c:when test="${transaction.typeRequest == 'CANCEL'}">
                                            <td><a href="/request/cancel">${transaction.requestId}</a></td>
                                        </c:when>
                    </c:choose>
                    <td>${transaction.transDate}</td>
                    <td>${transaction.type}</td>
                    <td>

                      <div class="d-flex align-items-center">
                         <c:if test="${transaction.transStatus == true && userInfor.role == 'KOL'}">
                        <span><i class="fa-solid fa-plus text-success"></i></span>
                         </c:if>
                         <c:if test="${userInfor.role == 'USER'}">
                        <span><i class="fa-solid fa-minus text-danger"></i></span>
                         </c:if>
                        <span><fmt:formatNumber value="${transaction.transPayment}" type="number" pattern="#,##0" /></span>
                      </div>

                    </td>
                    <c:if test="${userInfor.role == 'USER'}">
                    <td>
                       <div class="d-flex align-items-center">
                        <span><i class="fa-solid fa-plus text-info"></i></span>
                        <span><fmt:formatNumber value="${transaction.refund}" type="number" pattern="#,##0" /></span>
                      </div>
                    </td>
                    </c:if>
                    <td>
                     <c:choose>
                                        <c:when test="${transaction.typeRequest == 'PENDING'}">
                                            <span class=" text">${transaction.typeRequest}</span>
                                        </c:when>
                                        <c:when test="${transaction.typeRequest == 'IN_PROGRESS'}">
                                            <span class="text-success">${transaction.typeRequest}</span>
                                        </c:when>
                                        <c:when test="${transaction.typeRequest == 'FINISHED'}">
                                            <span class="  text-info">${transaction.typeRequest}</span>
                                        </c:when>
                                              <c:when test="${transaction.typeRequest == 'CANCEL'}">
                                            <span class=" text-danger">${transaction.typeRequest}</span>
                                        </c:when>
                    </c:choose>
                  </tr>
                  </c:if>
                  </c:forEach> 
                </tbody>
              </table>
            </div>
          </div>
        </div>
      </div>
    </div>
    <script src="https://code.jquery.com/jquery-1.10.2.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/js/bootstrap.bundle.min.js"></script>
    <script type="text/javascript"></script>
  </body>
</html>
