<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <title>Search users page result - Bootdey.com</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/css/bootstrap.min.css">
    <style type="text/css">
        body {
            background: #dcdcdc;
            margin-top: 20px;
        }
        .widget {
            background: #fff;
            margin-bottom: .75rem;
            display: block;
            position: relative;
            margin-top: 40px;
        }
        .widget-user-list > li {
            display: inline-block;
        }
        .widget-user-list {
            padding: 0;
            list-style-type: none;
        }
        .widget-user-list {
            margin: 0;
            white-space: nowrap;
            overflow: hidden;
        }
        .widget-user-list > li + li {
            margin-left: -1.125rem;
        }
        .widget-user-list > li a {
            display: block;
            border: 0.125rem solid #fff;
            overflow: hidden;
            width: 2.25rem;
            height: 2.25rem;
            margin-bottom: -0.3125rem;
            line-height: 2rem;
            text-align: center;
            text-decoration: none;
            -webkit-border-radius: 2.25rem;
            -moz-border-radius: 2.25rem;
            border-radius: 2.25rem;
        }
        .widget-user-list > li a img {
            display: block;
            max-width: 100%;
        }
        .widget-user-list > li.number a {
            background: #c7c7cc;
            color: #fff;
        }
        .widget-content, .widget-footer {
            padding: .625rem;
            background: #fff;
            position: relative;
        }
        .search-result-item {
            margin-bottom: 1rem;
            padding: 1rem;
            border: 1px solid #eee;
            background-color: #fff;
        }
        .search-result-item .image-link {
            display: block;
            float: left;
            margin-right: 1rem;
        }
        .search-result-item .image-link img {
            width: 64px;
            height: 64px;
            border-radius: 50%;
        }
        .search-result-item .search-result-item-body {
            overflow: hidden;
        }
        .search-result-item .search-result-item-heading {
            margin: 0;
        }
        .search-result-item .info {
            font-size: 0.875rem;
            color: #555;
        }
        .search-result-item .description {
            font-size: 0.875rem;
            margin-top: 0.5rem;
            color: #777;
        }
        .search-result-item .day {
            font-size: 0.875rem;
            margin-top: 0.5rem;
            color: #999;
        }
        .search-result-item .text-align-center {
            text-align: center;
        }
        .search-result-item .btn {
            margin-top: 0.5rem;
        }
        .search-result-item .status {
            display: inline-block;
            padding: 0.25rem 0.5rem;
            font-size: 0.75rem;
            color: #fff;
            border-radius: 0.25rem;
        }
        .search-result-item .bg-gray {
            background-color: #b0b0b0;
        }
        .search-result-item .bg-green {
            background-color: #5cb85c;
        }
        .search-result-item .bg-blue {
            background-color: #5bc0de;
        }
        .search-result-item .bg-red {
            background-color: #d9534f;
        }
        .request-list{
            margin-top: 70px
        }
    </style>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>

<body>
<%@ include file="navbar.jsp" %>
<div class="container request-list">
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
                                <c:if test="${userInfor.role == 'KOL'}">
                                    <a class="btn btn-primary btn-info btn-sm" href="/request/accept?request=${request.requestId}">Accept</a>
                                    <a class="btn btn-primary btn-info btn-sm" href="/request/deny?request=${request.requestId}">Deny</a>
                                </c:if>
                                <c:if test="${userInfor.role == 'USER' && request.status == 'PENDING'}">
                                    <a class="btn btn-primary btn-danger btn-sm" href="#" onclick="cancelRequest(${request.requestId})">Cancel</a>
                                </c:if>
                                <c:choose>
                                    <c:when test="${request.status == 'PENDING'}">
                                        <div class="status bg-gray">Pending</div>
                                    </c:when>
                                    <c:when test="${request.status == 'IN_PROGRESS'}">
                                        <div class="status bg-green">In Progress</div>
                                    </c:when>
                                    <c:when test="${request.status == 'FINISHED'}">
                                        <div class="status bg-blue">Finished</div>
                                    </c:when>
                                    <c:when test="${request.status == 'CANCLE'}">
                                        <div class="status bg-red">Cancelled</div>
                                    </c:when>
                                </c:choose>
                                <a class="btn btn-primary btn-info btn-sm view-more" href="#" data-toggle="modal" data-target="#viewMoreModal"
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
                                    data-price="${request.price}">
                                    View More
                                </a>
                            </div>
                        </div>
                        <div class="widget-content">
                            <ul class="widget-user-list">
                                <li><a href="#"><img src="https://bootdey.com/img/Content/avatar/avatar7.png" alt="User"></a></li>
                                <li><a href="#"><img src="https://bootdey.com/img/Content/avatar/avatar6.png" alt="User"></a></li>
                                <li><a href="#"><img src="https://bootdey.com/img/Content/avatar/avatar1.png" alt="User"></a></li>
                                <li><a href="#"><img src="https://bootdey.com/img/Content/avatar/avatar2.png" alt="User"></a></li>
                                <li><a href="#"><img src="https://bootdey.com/img/Content/avatar/avatar3.png" alt="User"></a></li>
                                <li><a href="#"><img src="https://bootdey.com/img/Content/avatar/avatar4.png" alt="User"></a></li>
                                <li><a href="#"><img src="https://bootdey.com/img/Content/avatar/avatar5.png" alt="User"></a></li>
                                <li class="number"><a href="#">+26</a></li>
                            </ul>
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

<script src="../../assert/js/request-list.js"></script>
</body>
</html>
