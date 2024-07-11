<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <title>User profile with friends and chat - Bootdey.com</title>
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <link rel="stylesheet" href="../../assert/css/infor-user.css" />
    </head>
    <%@include file="navbar.jsp" %>
    <body>
        <div class="container bootstrap snippets bootdeys">
            <div class="row" id="user-profile">
                <div class="col-lg-3 col-md-4 col-sm-4">
                    <div class="main-box clearfix">
                        <h2>${userInformation.fullName}</h2>
                        <div class="profile-status">
                            <i class="fa fa-check-circle"></i> Online
                        </div>
                        <img
                            src="${userInformation.avatarUrl}"
                            alt
                            class="profile-img img-responsive center-block"
                            />
                        <div class="profile-label">
                            <span class="label label-danger">${userInformation.role}</span>
                        </div>
                        <div class="profile-stars">
                            <i class="fa fa-star"></i>
                            <i class="fa fa-star"></i>
                            <i class="fa fa-star"></i>
                            <i class="fa fa-star"></i>
                            <i class="fa fa-star-o"></i>
                            <span>Super User</span>
                        </div>
                        <div class="profile-since">Member since: ${userInformation.createAt}</div>
                        <br/>
                        <c:if test="${empty me}">
                            <div class="profile-message-btn center-block text-center">
                                <a href="/profile?userId=${userInformation.userId}" class="btn btn-success">
                                    <i class="fa fa-envelope"></i> Send message
                                </a>
                            </div>
                        </c:if>
                    </div>
                </div>
                <div class="col-lg-9 col-md-8 col-sm-8">
                    <div class="main-box clearfix">
                        <div class="profile-header">
                            <h3><span>User info</span></h3>
                            <c:if test="${not empty me}">
                                <a href="/update-profile-form" class="btn btn-primary btn-lg edit-profile">
                                    <i class="fa fa-pencil-square fa-lg"></i> Edit profile
                                </a>
                            </c:if>
                        </div>
                        <div class="row profile-user-info">
    <div class="col-sm-8">
        <div class="profile-user-details clearfix">
            <div class="profile-user-details-label">First Name</div>
            <c:if test="${not empty userInformation.fullName}">
             <div class="profile-user-details-value">${userInformation.fullName}</div>
            </c:if>
            <c:if test="${empty userInformation.fullName}">
            <div class="profile-user-details-value">&nbsp</div>
            </c:if>
        </div>
        <div class="profile-user-details clearfix">
            <div class="profile-user-details-label">Location</div>
            <c:if test="${not empty userInformation.location}">
             <div class="profile-user-details-value">${userInformation.location}</div>
            </c:if>
            <c:if test="${empty userInformation.location}">
            <div class="profile-user-details-value">&nbsp</div>
            </c:if>
        </div>
        <div class="profile-user-details clearfix">
            <div class="profile-user-details-label">Description</div>
            <c:if test="${not empty userInformation.bio}">
             <div class="profile-user-details-value">${userInformation.bio}</div>
            </c:if>
            <c:if test="${empty userInformation.bio}">
            <div class="profile-user-details-value">&nbsp</div>
            </c:if> 
        </div>
    </div>
</div>

                        <div class="col-sm-4 profile-social">
                            <ul class="fa-ul">
                            </ul>

                        </div>
                    </div>
                    <div class="tabs-wrapper profile-tabs">
                        <ul class="nav nav-tabs">
                            <li class="active">
                                <a href="#tab-activity" data-toggle="tab">Activity</a>
                            </li>

                        </ul>
                        <div class="tab-content">
                            <div class="tab-pane fade in active" id="tab-activity">
                                <div class="table-responsive">
                                    <table class="table">
                                        <tbody>
                                            <tr>
                                                <td class="text-center">
                                                    <i class="fa fa-comment"></i>
                                                </td>
                                                <td>
                                                    John Doe posted a comment in
                                                    <a href="#">Avengers Initiative</a> project.
                                                </td>
                                                <td>2014/08/08 12:08</td>
                                            </tr>
                                            <tr>
                                                <td class="text-center">
                                                    <i class="fa fa-truck"></i>
                                                </td>
                                                <td>
                                                    John Doe changed order status from
                                                    <span class="label label-primary">Pending</span> to
                                                    <span class="label label-success">Completed</span>
                                                </td>
                                                <td>2014/08/08 12:08</td>
                                            </tr>
                                            <tr>
                                                <td class="text-center">
                                                    <i class="fa fa-check"></i>
                                                </td>
                                                <td>
                                                    John Doe posted a comment in
                                                    <a href="#">Lost in Translation opening scene</a>
                                                    discussion.
                                                </td>
                                                <td>2014/08/08 12:08</td>
                                            </tr>
                                            <tr>
                                                <td class="text-center">
                                                    <i class="fa fa-users"></i>
                                                </td>
                                                <td>
                                                    John Doe posted a comment in
                                                    <a href="#">Avengers Initiative</a> project.
                                                </td>
                                                <td>2014/08/08 12:08</td>
                                            </tr>
                                            <tr>
                                                <td class="text-center">
                                                    <i class="fa fa-heart"></i>
                                                </td>
                                                <td>
                                                    John Doe changed order status from
                                                    <span class="label label-warning">On Hold</span> to
                                                    <span class="label label-danger">Disabled</span>
                                                </td>
                                                <td>2014/08/08 12:08</td>
                                            </tr>
                                            <tr>
                                                <td class="text-center">
                                                    <i class="fa fa-check"></i>
                                                </td>
                                                <td>
                                                    John Doe posted a comment in
                                                    <a href="#">Lost in Translation opening scene</a>
                                                    discussion.
                                                </td>
                                                <td>2014/08/08 12:08</td>
                                            </tr>
                                            <tr>
                                                <td class="text-center">
                                                    <i class="fa fa-truck"></i>
                                                </td>
                                                <td>
                                                    John Doe changed order status from
                                                    <span class="label label-primary">Pending</span> to
                                                    <span class="label label-success">Completed</span>
                                                </td>
                                                <td>2014/08/08 12:08</td>
                                            </tr>
                                            <tr>
                                                <td class="text-center">
                                                    <i class="fa fa-users"></i>
                                                </td>
                                                <td>
                                                    John Doe posted a comment in
                                                    <a href="#">Avengers Initiative</a> project.
                                                </td>
                                                <td>2014/08/08 12:08</td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script
        data-cfasync="false"
        src="/cdn-cgi/scripts/5c5dd728/cloudflare-static/email-decode.min.js"
    ></script>
    <script type="text/javascript"></script>
</body>
</html>
