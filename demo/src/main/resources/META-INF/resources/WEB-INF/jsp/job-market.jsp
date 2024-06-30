<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <title>Search users page result - Bootdey.com</title>
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
        <link href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/3.10.2/fullcalendar.min.css" rel="stylesheet">
        <link rel="stylesheet" href="../../assert/css/job-market.css" />
    </head>
    <%@include file="navbar.jsp" %>
    <body>
        <div class="container jobs-market">
            <c:if test="${userInfor.role == 'USER'}">
                <button class="btn btn-primary add-new" onclick="$('#myModal').modal('show')"><i class="fas fa-plus"></i> Add new</button>
            </c:if>
            <div class="row">
                <div class="col-md-12">
                    <c:forEach var="request" items="${list}">
                        <section class="search-result-item">
                            <a class="image-link" href="#">
                                <img class="image" src="${request.sender.avatar}" />
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
                                            <p class="Deadline">Start Date: ${request.requestRepresentative.dateStart}</p>
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
                                        <a class="btn btn-primary btn-info btn-sm view-more" href="#" data-toggle="modal" data-target="#viewMoreModal" data-avatar="${request.sender.avatar}" 
                                        data-fullname="${request.sender.fullName}" data-location="${request.requestDto.location}" 
                                        data-description="${request.requestDto.decription}" data-deadline="${request.requestDto.deadline}" 
                                        data-daysrequired="${request.requestByDay.daysRequire}" data-daylocation="${request.requestByDay.location}" 
                                        data-daydescription="${request.requestByDay.decription}" data-replocation="${request.requestRepresentative.location}" data-repdescription="${request.requestRepresentative.decription}" data-startdate="${request.requestRepresentative.dateStart}" data-months="${request.requestRepresentative.numberMonths}" data-price="${request.price}"
                                           <c:if test="${not empty request.requestDto}">
                                                data-type="${request.requestDto.type}">
                                            </c:if>
                                            <c:if test="${not empty request.requestByDay}">
                                                data-type="${request.requestByDay.type}">
                                            </c:if>
                                            <c:if test="${not empty request.requestRepresentative}">
                                                data-type="${request.requestRepresentative.type}">
                                            </c:if>
                                            View More</a>
                                        <c:if test="${userInfor.role == 'KOL'}">
                                            <a class="btn btn-primary btn-info btn-sm" href="#" onclick="applyPublicRequest(${request.requestId})">Accept</a>
                                        </c:if>
                                    </div>
                                </div>
                            </div>
                        </section>
                    </c:forEach>
                    <div class="text-align-center">
                        <ul class="pagination pagination-sm"></ul>
                    </div>
                </div>
            </div>
        </div>

        <!-- Main Modal -->
        <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                        <h4 class="modal-title" id="myModalLabel">Hire Type</h4>
                    </div>
                    <div class="modal-body">
                        <div class="form-group">
                            <button type="button" class="btn btn-primary" onclick="showContent('post')">A Post</button>
                            <button type="button" class="btn btn-primary" onclick="showContent('video')">A Video</button>
                            <button type="button" class="btn btn-primary" onclick="showContent('by_date')">Hire By Day</button>
                            <button type="button" class="btn btn-primary" onclick="showContent('representative')">Representative</button>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    </div>
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

        <!-- Post Modal -->
        <div class="modal fade" id="postModal" tabindex="-1" role="dialog" aria-labelledby="postModalLabel">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" id="cancelPost" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                        <h4 class="modal-title" id="postModalLabel">Post Modal</h4>
                    </div>
                    <div class="modal-body">
                        <div class="form-group">
                            <label for="postDeadline">Deadline:</label>
                            <input type="date" class="form-control" id="postDeadline">
                        </div>
                        <div class="form-group">
                            <label for="postDescription">Description:</label>
                            <textarea class="form-control" id="postDescription"></textarea>
                        </div>
                        <div class="form-group">
                            <label for="postLocation">Location:</label>
                            <select class="form-control" id="postLocation">
                                <c:forEach var="province" items="${provinces}">
                                    <option value="${province}">${province}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="postLocation">Money:</label>
                            <input type="Number" class="form-control" id="money-post">
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        <button type="button" class="btn btn-primary" onclick="submitPostRequest()">Send</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Video Modal -->
        <div class="modal fade" id="videoModal" tabindex="-1" role="dialog" aria-labelledby="videoModalLabel">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title" id="videoModalLabel">Video</h4>
                    </div>
                    <div class="modal-body">
                        <div class="form-group">
                            <label for="videoDeadline">Deadline:</label>
                            <input type="date" class="form-control" id="videoDeadline">
                        </div>
                        <div class="form-group">
                            <label for="videoDescription">Description:</label>
                            <textarea class="form-control" id="videoDescription"></textarea>
                        </div>
                        <div class="form-group">
                            <label for="videoLocation">Location:</label>
                            <select class="form-control" id="videoLocation">
                                <c:forEach var="province" items="${provinces}">
                                    <option value="${province}">${province}</option>
                                </c:forEach>
                            </select>
                        </div>
                         <div class="form-group">
                            <label for="postLocation">Money:</label>
                            <input type="Number" class="form-control" id="money-video">
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        <button type="button" class="btn btn-primary" onclick="submitVideoRequest()">Send</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Date Modal -->
        <div class="modal fade" id="dateModal" tabindex="-1" role="dialog" aria-labelledby="dateModalLabel">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title" id="dateModalLabel">Hire By Day</h4>
                    </div>
                    <div class="modal-body">
                        <div class="calendar">
                            <div class="calendar-header">
                                <button onclick="prevMonth()">&#8249;</button>
                                <div class="month-name" id="month-name">January 2024</div>
                                <button onclick="nextMonth()">&#8250;</button>
                            </div>
                            <div class="weekdays">
                                <div>Sun</div>
                                <div>Mon</div>
                                <div>Tue</div>
                                <div>Wed</div>
                                <div>Thu</div>
                                <div>Fri</div>
                                <div>Sat</div>
                            </div>
                            <div class="days" id="days"></div>
                        </div>
                        <div class="form-group">
                            <label for="hireDescription">Description:</label>
                            <textarea class="form-control" id="hireDescription"></textarea>
                        </div>
                        <div class="form-group">
                            <label for="hireLocation">Location:</label>
                            <select class="form-control" id="hireLocation">
                                <c:forEach var="province" items="${provinces}">
                                    <option value="${province}">${province}</option>
                                </c:forEach>
                            </select>
                        </div>
                         <div class="form-group">
                            <label for="postLocation">Money:</label>
                            <input type="Number" class="form-control" id="money-hire">
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-primary" onclick="submitHiretRequest()">Send</button>
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Representative Modal -->
    <div class="modal fade" id="representativeModal" tabindex="-1" role="dialog" aria-labelledby="representativeModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="representativeModalLabel">Representative Modal</h4>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <label for="representativeDescription">Description:</label>
                        <textarea class="form-control" id="representativeDescription"></textarea>
                    </div>
                    <div class="form-group">
                        <label for="representativeMonths">Month Number:</label>
                        <select class="form-control" id="representativeMonths">
                            <option value="3">3 Months</option>
                            <option value="6">6 Months</option>
                            <option value="9">9 Months</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="videoDeadline">Start Day:</label>
                        <input type="date" class="form-control" id="representativeStart">
                    </div>
                    <div class="form-group">
                        <label for="representativeLocation">Location:</label>
                        <select class="form-control" id="representativeLocation">
                            <c:forEach var="province" items="${provinces}">
                                <option value="${province}">${province}</option>
                            </c:forEach>
                        </select>
                    </div>
                     <div class="form-group">
                            <label for="postLocation">Money:</label>
                            <input type="Number" class="form-control" id="money-representative">
                        </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" onclick="submitRepresentativetRequest()">Send</button>
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>
    <script src="https://code.jquery.com/jquery-1.10.2.min.js"></script>
    <script src="https://netdna.bootstrapcdn.com/bootstrap/3.1.0/js/bootstrap.min.js"></script>
    <script src="../../assert/js/job-market.js"></script>
</body>
</html>
