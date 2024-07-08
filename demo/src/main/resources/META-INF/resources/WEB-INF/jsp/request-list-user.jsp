<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <title>Search users page result - Bootdey.com</title>
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/css/bootstrap.min.css">
        <link rel="stylesheet" type="text/css" href="../../assert/css/request-list.css">
    </head>
    <style type="text/css">
       .widget {
    background: #fff;
    margin-bottom: .75rem;
    display: block;
    position: relative;
    margin-top: 40px;
}

.widget-user-list {
    padding: 0;
    list-style-type: none;
    margin: 0;
    white-space: nowrap;
    overflow: hidden;
    display: flex; /* Sử dụng flexbox để căn chỉnh các phần tử */
}

.widget-user-list > li {
    display: inline-block;
}

.widget-user-list > li + li {
    margin-left: -1.125rem; /* Khoảng cách giữa các hình ảnh */
}

.widget-user-list > li img {
    display: block;
    border: 0.125rem solid #fff;
    overflow: hidden;
    width: 3.25rem;
    height: 3.25rem;
    margin-bottom: -0.3125rem;
    line-height: 2rem;
    text-align: center;
    border-radius: 50%; /* Tạo hình tròn cho hình ảnh */
}

.widget-content, .widget-footer {
    background: #fff;
    position: relative;
}

.wait-list {
    display: flex;
}

.wait-list .day {
    margin-right: 10px; /* Khoảng cách giữa chữ "Wait List:" và danh sách người dùng */
}

.wait-list .widget-content {
    display: flex;
}

    </style>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>

<body>
    <%@ include file="navbar.jsp" %>
    <div class="container request-list">
         <nav class="nav nav-borders">
            <a class="nav-link" href="/request/pending"><i class="fa-solid fa-clock"></i> Pending Requests</a>
            <a class="nav-link" href="/request/in-process"><i class="fa-solid fa-spinner"></i> In Progress Requests</a>
            <a class="nav-link" href="/request/finish"><i class="fa-solid fa-check"></i> Finished Requests</a>
            <a class="nav-link" href="/request/cancel"><i class="fa-solid fa-times"></i> Cancelled Requests</a>
        </nav>
        <div class="row ng-scope">
            <div class="col-lg-12">
                <c:forEach items="${list}" var="request">
                    <section class="search-result-item">
                        <a class="image-link" href="/profile?userId=${request.sender.id}">
                            <img class="image" src="${request.sender.avatar}" alt="avatar">
                        </a>
                        <div class="search-result-item-body">
                            <div class="row">
                                <div class="col-sm-9">
                                    <h4 class="search-result-item-heading">
                                        <a href="#">${request.sender.fullName}</a>
                                    </h4>
                                    <c:if test="${not empty request.requestDto}">
                                        <p class="info">${request.requestDto.location}</p>
                                        <p class="description">${request.requestDto.decription}</p>
                                        <p class="day">Deadline: ${request.requestDto.deadline}</p>
                                        <p class="day">Day Required: ${request.requestDto.dateRequire}</p>
                                    </c:if>
                                    <c:if test="${not empty request.requestByDay}">
                                        <p class="info">${request.requestByDay.location}</p>
                                        <p class="description">${request.requestByDay.decription}</p>
                                        <p class="day">Hire Days Required: ${request.requestByDay.daysRequire}</p>
                                        <p class="day">Day Required: ${request.requestByDay.dateRequire}</p>
                                    </c:if>
                                    <c:if test="${not empty request.requestRepresentative}">
                                        <p class="info">${request.requestRepresentative.location}</p>
                                        <p class="description">${request.requestRepresentative.decription}</p>
                                        <p class="day">Start Date: ${request.requestRepresentative.dateStart}</p>
                                        <p class="day">Months: ${request.requestRepresentative.numberMonths}</p>
                                        <p class="day">Day Required: ${request.requestRepresentative.dateRequire}</p>
                                    </c:if>
                                </div>
                                <div class="col-sm-3 text-align-center">
                                    <p class="value3 mt-sm"><fmt:formatNumber value="${request.price}" type="number" pattern="###0" /> VND</p>
                                    <c:if test="${not empty request.requestDto}">
                                        <p class="fs-mini text-muted">
                                            ${request.requestDto.type} |
                                        <c:choose>
                                            <c:when test="${request.isPublic}">
                                                PUBLIC
                                            </c:when>
                                            <c:otherwise>
                                                PRIVATE
                                            </c:otherwise>
                                        </c:choose>
                                        </p>
                                    </c:if>

                                    <c:if test="${not empty request.requestByDay}">
                                        <p class="fs-mini text-muted">
                                            ${request.requestByDay.type} |
                                        <c:choose>
                                            <c:when test="${request.isPublic}">
                                                PUBLIC
                                            </c:when>
                                            <c:otherwise>
                                                PRIVATE
                                            </c:otherwise>
                                        </c:choose>
                                        </p>
                                    </c:if>

                                    <c:if test="${not empty request.requestRepresentative}">
                                        <p class="fs-mini text-muted">
                                            ${request.requestRepresentative.type} |
                                        <c:choose>
                                            <c:when test="${request.isPublic}">
                                                PUBLIC
                                            </c:when>
                                            <c:otherwise>
                                                PRIVATE
                                            </c:otherwise>
                                        </c:choose>
                                        </p>
                                    </c:if> 

                                   
                                    <c:if test="${userInfor.role == 'USER' && request.status == 'PENDING'}">
                                        <a class="btn btn-primary btn-danger btn-sm" href="#" onclick="cancelRequest(${request.requestId})">Cancel</a>
                                    </c:if>
                                    <c:choose>
                                        <c:when test="${request.status == 'PENDING'}">
                                            <div class="status bg-gray rounded">Pending</div>
                                        </c:when>
                                        <c:when test="${request.status == 'IN_PROGRESS'}">
                                            <div class="status bg-green rounded">In Progress</div>
                                        </c:when>
                                        <c:when test="${request.status == 'FINISHED'}">
                                            <div class="status bg-blue rounded">Finished</div>
                                        </c:when>
                                        <c:when test="${request.status == 'CANCEL'}">
                                            <div class="status bg-red rounded">Cancelled</div>
                                        </c:when>
                                    </c:choose>
                                    <a class="btn btn-primary btn-info btn-sm view-more my-2 rounded " href="#" data-toggle="modal" data-target="#viewMoreModal"
                                       data-avatar="${request.sender.avatar}" 
                                       data-fullname="${request.sender.fullName}" 
                                       data-location="${request.requestDto.location}" 
                                       data-description="${request.requestDto.decription}" 
                                       data-deadline="${request.requestDto.deadline}" 
                                       data-daysrequired="${request.requestByDay.daysRequire}" 
                                       data-daylocation="${request.requestByDay.location}" 
                                       data-daydescription="${request.requestByDay.decription}" 
                                       data-replocation="${request.requestRepresentative.location}" 
                                       data-repdescription="${request.requestRepresentative.decription}" 
                                       data-startdate="${request.requestRepresentative.dateStart}" 
                                       data-months="${request.requestRepresentative.numberMonths}" 
                                       data-price="${request.price}"
                                       data-type="${request.requestDto.type}">
                                        View More
                                    </a>
                                     <c:if test="${not empty request.urlResult}">
                                        <a class="btn btn-primary btn-info btn-sm view-url my-2 rounded" href="#" data-toggle="modal" data-target="#viewUrlModal"
                                           data-urlresult="${request.urlResult}" data-requestid="${request.requestId}">
                                            View URL
                                        </a>
                                    </c:if>
                                    <c:if test="${ request.status == 'FINISHED'}">
                                        <a class="btn btn-primary btn-info btn-sm my-2 rounded" href="/comment/rating-page?requestId=${request.requestId}" >
                                            Comment
                                        </a>
                                    </c:if>
                                </div>
                            </div>
                            <c:if test="${userInfor.role == 'USER' && request.isPublic && request.status == 'PENDING'}">
                             <div class="wait-list">
                                <p class="day">Wait List:</p>
                                <div class="widget-content">
                                    <a href="/request/candidate-list?requestId=${request.requestId}">
                                        <ul class="widget-user-list">
                                             <c:forEach items="${request.listWaitList}" var="userWaitting">
                                            <li><img src="${userWaitting.avatar}" alt="User"></li>
                                             </c:forEach>
                                        </ul>
                                    </a>
                                </div>
                             </div>
                            </c:if>
                           <div class="wait-list">
    <p class="day">User Work:</p>
    <c:choose>
        <c:when test="${not empty request.responder}">
            <div class="widget-content">
                <a href="/profile?userId=${request.responder.id}">
                    <ul class="widget-user-list">
                        <li><img src="${request.responder.avatar}" alt="User"></li> 
                    </ul>
                </a>  
            </div>
        </c:when>
        <c:otherwise>
            Not yet
        </c:otherwise>
    </c:choose>
</div>

                        </div>
                    </section>
                </c:forEach>
                <c:if test="${empty list}">
                    <h2 style="text-align: center;">Not Yet</h2>
                </c:if>
            </div>
        </div>
    </div>

    <!-- View More Modal -->
    <div class="modal fade" id="viewMoreModal" tabindex="-1" role="dialog" aria-labelledby="viewMoreModalLabel">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="viewMoreModalLabel">Request Details</h4>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-md-4 text-center">
                            <img id="modal-avatar" src="" alt="Avatar" class="img-circle img-responsive" style="margin: 0 auto;">
                        </div>
                        <div class="col-md-8">
                            <h4 id="modal-fullname"></h4>
                            <p id="modal-location"></p>
                            <p id="modal-description"></p>
                            <p id="modal-deadline"></p>
                            <p id="modal-daylocation"></p>
                            <p id="modal-daydescription"></p>
                            <p id="modal-daysrequired"></p>
                            <p id="modal-replocation"></p>
                            <p id="modal-repdescription"></p>
                            <p id="modal-startdate"></p>
                            <p id="modal-months"></p>
                            <p id="modal-price"></p>
                            <p id="modal-type"></p>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>

     <div class="modal fade" id="viewUrlModal" tabindex="-1" role="dialog" aria-labelledby="viewUrlModalLabel">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                <h4 class="modal-title" id="viewUrlModalLabel">View URL</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    
                </div>
                <div class="modal-body">
                     <a id="modal-urlResult" href="#" target="_blank"></a>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    <button type="button" class="btn btn-primary" onclick="finishRequest()">Finish</button>
                </div>
            </div>
        </div>
    </div>
    <c:if test="${not empty list}">
    <div class="text-align-center pagination-box">
        <ul class="pagination pagination-sm">
            <li class="${currentPage == 0 ? 'disabled' : ''}">
                <a <c:if test="${currentPage > 0}">href="${baseUrl}?page=${currentPage - 1}"</c:if>>Prev</a>
            </li>
            <c:if test="${totalPages > 0}">
                <c:forEach begin="0" end="${totalPages - 1}" var="i">
                    <li class="${i == currentPage ? 'active' : ''}">
                        <a <c:if test="${i != currentPage}">href="${baseUrl}?page=${i}"</c:if>>${i + 1}</a>
                    </li>
                </c:forEach>
            </c:if>
            <li class="${currentPage == totalPages - 1 ? 'disabled' : ''}">
                <a <c:if test="${currentPage < totalPages - 1}">href="${baseUrl}?page=${currentPage + 1}"</c:if>>Next</a>
            </li>
        </ul>
    </div>
</c:if>


    <script src="../../assert/js/request-list.js"></script>
</body>
</html>
