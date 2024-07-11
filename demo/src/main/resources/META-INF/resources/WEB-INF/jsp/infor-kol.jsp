<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <title>Profile</title>
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
        <link href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/3.10.2/fullcalendar.min.css" rel="stylesheet">
        <link rel="stylesheet" href="../../assert/css/infor-kol.css">
    </head>
    <%@include file="navbar.jsp" %>
    <body>
        <section id="content" class="container">
            <div class="page-heading">
                <div class="media">
                    <div class="media-left pr30">
                        <a href="#">
                            <img
                                class="media-object"
                                src="${userInformation.avatarUrl}"
                                alt="..."
                                />
                        </a>
                    </div>
                    <div class="media-body va-m">
                        <h2 class="media-heading">${userInformation.fullName}</h2>
                    </div>
                    <div class="media-right">
                        <div class="hire-container">

                            <c:if test="${not empty me}">
                                <a href="/update-profile-form" class="btn btn-primary btn-lg edit-profile">
                                    <i class="fa fa-pencil-square fa-lg"></i> Edit profile
                                </a>
                            </c:if>
                        </div>
                        <div class="right-container">

                            <div class="right-player-profile">
                                <p class="price-player-profile">A post: <fmt:formatNumber value="${userInformation.pricePost}" type="number" pattern="#,##0" /> VND</p>
                                <p class="price-player-profile">A Video: <fmt:formatNumber value="${userInformation.priceVideo}" type="number" pattern="#,##0" /> VND</p>
                                <p class="price-player-profile">Per Day: <fmt:formatNumber value="${userInformation.priceHireByDay}" type="number" pattern="#,##0" /> VND</p>
                                <p class="price-player-profile">Representative: <fmt:formatNumber value="${userInformation.representativePrice}" type="number" pattern="#,##0" /> VND / 3 months</p>
                                 <div class="rating-style">
        <!-- Hiển thị các sao đầy đủ -->
        <i class="fas fa-star <c:if test="${userInformation.averageRating >= 1}">star-filled</c:if>"></i>
        <i class="fas fa-star <c:if test="${userInformation.averageRating >= 2}">star-filled</c:if>"></i>
        <i class="fas fa-star <c:if test="${userInformation.averageRating >= 3}">star-filled</c:if>"></i>
        <i class="fas fa-star <c:if test="${userInformation.averageRating >= 4}">star-filled</c:if>"></i>
        <i class="fas fa-star <c:if test="${userInformation.averageRating >= 5}">star-filled</c:if>"></i>
        <!-- Hiển thị số lượng đánh giá -->
        <span><c:out value="${totalRating}"/> Evaluate</span>
    </div>
                            <c:if test="${empty me && userInfor.role == 'USER'}">
                                <button id="hire-button" type="button" class="btn btn-primary btn-sm" data-bs-toggle="modal" data-bs-target="#myModal">$ Hire</button>
                            </c:if>
                            <c:if test="${empty me && userInfor.role == 'USER'}">
                            <a id="chat" href="/chatbox?userId=${userInformation.userId}" class="btn btn-warning btn-sm " >Chat</a>
                            </c:if>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-4">
                <div class="panel">
                    <div class="panel-heading">
                        <span class="panel-icon">
                            <i class="fa fa-star"></i>
                        </span>
                        <span class="panel-title"> User Popularity</span>
                    </div>
                    <div class="panel-body pn">
                        <table class="table mbn tc-icon-1 tc-med-2 tc-bold-last">
                            <thead>
                                <tr class="hidden">
                                    <th class="mw30">#</th>
                                    <th>First Name</th>
                                    <th>Revenue</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>
                                        <span class="fa fa-desktop text-warning"></span>
                                    </td>
                                    <td>Television</td>
                                    <td>
                                        <i class="fa fa-caret-up text-info pr10"></i>$855,913
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <span class="fa fa-microphone text-primary"></span>
                                    </td>
                                    <td>Radio</td>
                                    <td>
                                        <i class="fa fa-caret-down text-danger pr10"></i>$349,712
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <span class="fa fa-newspaper-o text-info"></span>
                                    </td>
                                    <td>Newspaper</td>
                                    <td>
                                        <i class="fa fa-caret-up text-info pr10"></i>$1,259,742
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
                <div class="panel">
                    <div class="panel-heading">
                        <span class="panel-icon">
                            <i class="fa fa-trophy"></i>
                        </span>
                        <span class="panel-title"> My Field</span>
                    </div>
                    <div class="panel-body pb5">
                         <c:forEach var="category" items="${userInformation.categories}">
                            <span class="label-tags"><span class="label label-success">${category}</span></span>
                        </c:forEach>
                    </div>
                </div>
                <div class="panel">
                    <div class="panel-heading">
                        <span class="panel-icon">
                            <i class="fa fa-user"></i>
                        </span>
                        <span class="panel-title">About Me</span>
                    </div>
                    <div class="panel-body pb5">
                        <h6>Name</h6>
                        <h4>${userInformation.fullName}</h4>
                        <hr class="short br-lighter" />       
                        <h6>Day Of Birth</h6>
                        <h4>${userInformation.birthday}</h4>
                        <hr class="short br-lighter" />
                        <h5>Description</h5>
                        <p class="text-muted">
                            ${userInformation.bio}
                        </p>
                        <hr class="short br-lighter" />
                        <h5>Location</h5>
                        <h4>${userInformation.location}</h4>
                    </div>
                </div>

            </div>
            <div class="col-md-8">
                <div class="tab-block">
                    <ul class="nav nav-tabs">
                        <li class="about-me active">
                            <a href="#" data-toggle="tab">About Me</a>
                        </li>
                        <li class="evaluate">
                            <a href="#" data-toggle="tab">Evaluate</a>
                        </li >
                        <c:if test="${not empty me}">
                            <li class="schedule">
                                <a href="#" data-toggle="tab">Schedule</a>
                            </li>
                        </c:if>
                    </ul>
                    <div class="tab-content p30" style="height: 900px">
                        <div id="tab1" class="tab-pane active">
                            <div class="container-image_list">
                                <c:if test="${not empty me}">
                                    <div class="superbox">
                                        <div class="superbox-list add" onclick="document.getElementById('file-input').click();">
                                            <img
                                                src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAOEAAADhCAMAAAAJbSJIAAAAclBMVEX///8AAADc3NyWlpaamporKyvBwcE3Nzd0dHR5eXn19fXe3t68vLzr6+uenp6jo6MJCQmzs7OLi4uCgoJubm7Hx8eQkJDt7e1QUFAXFxdEREQ/Pz/R0dHm5uZbW1scHBwkJCRiYmIxMTEbGxurq6tVVVUawSspAAAE0klEQVR4nO2d61bqMBBGLTe1gAiICFLFy3n/VzwelUvJZJI2kyZz1rd/SlaSLYVOJ5NwdQUAAAAAkA3Vw80FD5PUc5KlVxgMUs9JFhjqB4b6gaF+YKgfGOoHhvqBoX5gqB8Y6geG+oGhfmCon//fcGwa3sUbrVrNBv1QiPmNH62tB0vT8IWZRMiaxm55bw7Wglez65FIx9/ctPabXEvNYRjV8Lal3/pJbg5ZGk7kZpCnYV9uAkWWhrKCGRqKXqJFhoZTudF/yM5Q8Fv0h9wMBQf/JTdDsRv9kcwMd3JjH8jM8FZu7AOZGcoE2zXyMhS/VRS5Ga7khj6Sl+Gn3NBH8jK8kxv6yL05jGBg+NDQcGB2MRn3whibw5RMa8J+yUyhCjckJhiVyJkowrAn2L0PkbOJMOwAGAYCww6AYSAw7AAYBgLDDoBhIDDsABgGAsMwev2n1/vN/mXA9anYcD48dfq8sjZTa1i917t9Ki0NtRoSqeYd3VKpIZlLp3vWaUhkCP9BXqg6DTe04RPVVqWhda1gRDRWaWgTLK6JxoRhP3wKRxoa+pU+MuswxKpDORldIrmw0Mzwtpj7dPpgN+y++reR4ePXq/bY5ASzcv4iN3VPmhh+Oi/iH0q7YLEXnLsfDQwP67hrV59cbQCxehoZf8Nj4c3GFmAeYKsfxA1ceBtWpwbEOn0N7irdyCs48DVcn7cgQ5MzmG+abQQHHk/D8qPW5I3vlLlbLKJYcHgaPjea6NxuaHmCioif4YvRiK0lsH8Qu/8Y+hlSVx0b3Cxshp/RRKz4GD6Sk2WvN4vgezwRKx6GM8t0ueDGUi7XtNpHArehvbaPC27IJ0SfmFYcpyHx9HaADW4IxTQn6bkMK/P1E+zH6vK9/+g6l/6Lw7DkS4jZ4KasbSyMuGmSx2E4NF+uwZdClp9v3602KY965A23DsGiWLoGKKup41lkvL++YDgL1TqDNXxzCkpcfQlzbX4bFbwyNxzpDOlQxiT0LpfM0L/GPTD3l8qwSXX9NGgKiQwbbYdyZm5Y0hiyoYxJ0DNDEsO1+VceV+aGI4nha1NDV+aGo3vDsZGV8cEZ3GRkWJlZGR9aBzfdG7qDUZq2wU33hq1pmSlUZNhy9ViToXtZSr1hq+BGlaFzWUq/oSu4WVeVcSUrM2SCm9Hi9/iG7aL2SKnN0BLclBdLGYvTJ1adIRncEEs1x6ogfYZmcDPeU82GlVrDy8yNNV2wUmtYD26YGrCRWsPzzA17LsVKreEpuGHWrv7R02p4zNw4Ez5TrYa/wY1j7eqL+5KomFZh+BPcuNauvnjW+h5+Bzde6QLiv6DEsLhjaqN4tBi2B4YwhGF6YAhDGKYHhjCEYXpgCEMYpgeGMIRhemAIQximB4YwhGF6YAhDGKYHhk2wbbZPi+QeUuaQjoQE79o8I8JPdgkgeQJK4z1cnRC02+8SsvQzMW3q4e1YD1pJiOxBRI7awSQIny/RZiteXKRPy4rxy2thiB/y8ie10QXyRyvmdsNotT2MR/r3gMOgjqkNRvg3nYOIdI5NPorRDurJ5UKNeFbWut0GblneInzJnLFKfevfxj9TcXfb/CwFKfbLjo4CK3fzWb9rZvOd6OMSAAAAAAAAAAAAAAAAAAAAAAAAAIA8fwFbdGGIFPgtJQAAAABJRU5ErkJggg=="
                                                alt
                                                class="superbox-img-add"
                                                />
                                            <input type="file" id="file-input" accept="image/*,video/*" onchange="handleFileSelect(event)">
                                        </div>
                                    </div> 
                                </c:if>
                                <c:forEach items="${medias}" var="media">
                                    <div class="superbox-list" data-id="${media.id}">
                                        <img src="${media.url}" alt="" class="superbox-img" />
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                        <div id="tab2" class="tab-pane ">
                            <section class="content-item" id="comments">
                                <div class="container-comment">
                                    <div class="row">
                                        <div class="col-sm-11">
                                            <div class="total-comment">
                                            </div>
                                            <div id="comments-list">
                                            </div>
                                            <nav>
                                                <ul class="pagination justify-content-center" id="pagination">
                                                </ul>
                                            </nav>
                                        </div>
                                    </div>
                                </div>
                            </section>
                        </div>
                        <div id="tab3" class="tab-pane">
                        </div>
                    </div>
            </div>
        </div>
    </div>
</div>
<div
    class="modal fade"
    id="showPhoto"
    tabindex="-1"
    role="dialog"
    aria-labelledby="myModalLabel"
    >
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button
                    type="button"
                    class="close"
                    data-dismiss="modal"
                    aria-label="Close"
                    >
                    <span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="myModalLabel">Modal title</h4>
            </div>
            <div class="modal-body"></div>
            <div class="modal-footer">
                <c:if test="${userInfor.role == 'ROLE'}">
                <button type="button" class="btn btn-danger" onclick="deleteImage()">Delete Image</button>
                </c:if>
            </div>
        </div>
    </div>
</div>

<input type="hidden" id="user-recipient-request" value="${userInformation.userId}">
<c:if test="${empty me && userInfor.role == 'USER'}">
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
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" data-dismiss="modal">Close</button>
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
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" onclick="submitHiretRequest()">Send</button>
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
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
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" onclick="submitRepresentativetRequest()">Send</button>
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>
</c:if>
</section>

<script src="https://code.jquery.com/jquery-1.10.2.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/3.10.2/fullcalendar.min.js"></script>
<script src="../../assert/js/infor-kol.js"></script>
<footer>  
</footer>
</body>
</html>
