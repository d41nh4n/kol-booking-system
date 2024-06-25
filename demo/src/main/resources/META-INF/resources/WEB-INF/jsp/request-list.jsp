<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <title>Search users page result - Bootdey.com</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link rel="stylesheet" type="text/css" href="../../assert/css/request-list.css" />
</head>

<%@include file="navbar.jsp" %>
<body>
    <div class="container">
        <div class="row ng-scope">
            <div class="col-lg-12">
                <c:forEach items="${list}" var="request">
                    <section class="search-result-item">
                        <a class="image-link" href="/profile?userId=${request.sender.id}"><img class="image" src="${request.sender.avatar}" /></a>
                        <div class="search-result-item-body">
                            <div class="row">
                                <div class="col-sm-9">
                                    <h4 class="search-result-item-heading"><a href="#">${request.sender.fullName}</a></h4>
                                    <c:if test="${not empty request.requestDto}">
                                        <p class="info">${request.requestDto.location}</p>
                                        <p class="description">${request.requestDto.decription}</p>
                                        <p class="description">Dealine: ${request.requestDto.deadline}</p>
                                    </c:if>
                                    <c:if test="${not empty request.requestByDay}">
                                        <p class="info">${request.requestByDay.location}</p>
                                        <p class="description">${request.requestByDay.decription}</p>
                                        <p class="description">Days Required: ${request.requestByDay.daysRequire}</p>
                                    </c:if>
                                    <c:if test="${not empty request.requestRepresentative}">
                                        <p class="info">${request.requestRepresentative.location}</p>
                                        <p class="description">${request.requestRepresentative.decription}</p>
                                        <p class="description">Start Date: ${request.requestRepresentative.dateStart}</p>
                                        <p class="description">Months: ${request.requestRepresentative.numberMonths}</p>
                                    </c:if>
                                </div>
                                <div class="col-sm-3 text-align-center">
                                    <p class="value3 mt-sm">${request.price}</p>
                                    <c:if test="${not empty request.requestDto}">
                                        <p class="fs-mini text-muted">${request.requestDto.type}</p>
                                    </c:if>
                                    <c:if test="${not empty request.requestByDay}">
                                        <p class="fs-mini text-muted">${request.requestByDay.type}</p>
                                    </c:if>
                                    <c:if test="${not empty request.requestRepresentative}">
                                        <p class="fs-mini text-muted">${request.requestRepresentative.type}</p>
                                    </c:if>
                                    <a class="btn btn-primary btn-info btn-sm" href="/request/accept?request=${request.requestId}">Accept</a>
                                    <a class="btn btn-primary btn-info btn-sm" href="/request/deny?request=${request.requestId}">Deny</a>
                                </div>
                            </div>
                        </div>
                    </section>
                </c:forEach>
                <c:if test="${not empty list}">
                <div class="text-align-center">
                        <ul class="pagination pagination-sm">
                            <li class="${currentPage == 0 ? 'disabled' : ''}">
                                <a href="/request/pending?page=${currentPage - 1}">Prev</a>
                            </li>
                            <c:if test="${totalPages > 0}">
                                <c:forEach begin="0" end="${totalPages - 1}" var="i">
                                    <li class="${i == currentPage ? 'active' : ''}">
                                        <a href="/request/pending?page=${i}">${i + 1}</a>
                                    </li>
                                </c:forEach>
                            </c:if>
                                <li class="${currentPage == totalPages - 1 ? 'disabled' : ''}">
                                    <a href="/request/pending?page=${currentPage + 1}">Next</a>
                                </li>
                        </ul>
                </div>
                </c:if>
<c:if test="${empty list}">
    <h2 style="text-align: center;">Not Yet</h2>
</c:if>

            </div>
        </div>
    </div>
</body>
</html>
