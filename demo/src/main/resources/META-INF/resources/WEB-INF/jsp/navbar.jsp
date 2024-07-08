<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="vi">
<head>
<title>Google plus navbar style - Bootdey.com</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://netdna.bootstrapcdn.com/bootstrap/3.1.0/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" />
<style type="text/css">
    body{
        background:#eee;
    }                       
    .header {
        background-color: #FFFFFF;
        border-width: 0;
    }
    .input-group{
        display:block;
    }
    #subnav {
        position: fixed;
        width: 100%;
    }
    .navbar-default {
        background-color: #F4F4F4;
        border-width: 0;
        margin-top: 50px;
        z-index: 5;
    }
    .btn-primary, .label-primary, .list-group-item.active, .list-group-item.active:hover, .list-group-item.active:focus {
        background-color: #4285F4;
    }
    .btn-primary {
        border-color: rgba(0, 0, 0, 0);
    }
    .btn, .form-control, .panel, .list-group, .well {
        border-radius: 1px;
        box-shadow: 0 0 0;
    }
    .navbar-default .navbar-nav > .active > a, .navbar-default .navbar-nav > li:hover > a {
        -moz-border-bottom-colors: none;
        -moz-border-left-colors: none;
        -moz-border-right-colors: none;
        -moz-border-top-colors: none;
        background-color: rgba(0, 0, 0, 0);
        border-color: #4285F4;
        border-image: none;
        border-style: solid;
        border-width: 0 0 2px;
        font-weight: 800;
    }    
    .dropdown-menu {
        max-width: 400px;
        min-width: 400px;
        max-height: 300px; 
        overflow-y: auto; 
    }
    .dropdown-menu.user {
        min-width: 300px;
    }
    .navbar-nav .dropdown-menu{
        position:absolute;
    }
    .navbar-nav{
        display: flex;
        flex-direction: row;
    }           
    .navbar-nav > li > a > i {
        font-size: 1.5em; /* Tăng kích thước icon */
    }  
    .dropdown-menu>li>a {
        height: 40px;
    }     
</style>
</head>
<body>
<c:if test="${not empty userInfor}">
    <input type="text" id="userId" value="${userInfor.id}" readonly="" hidden="">
</c:if>
<div class="navbar navbar-fixed-top header">
    <div class="col-md-12">
        <div class="navbar-header">
            <a class="navbar-brand" href="/">KOL</a>
            <button data-target="#navbar-collapse1" data-toggle="collapse" class="navbar-toggle" type="button">
                <i class="glyphicon glyphicon-search"></i>
            </button>
        </div>
        <div id="navbar-collapse1" class="collapse navbar-collapse">
            <%-- <form class="navbar-form pull-left">
                <div style="max-width:600px;" class="input-group">
                    <input type="text" id="srch-term" name="srch-term" placeholder="Search" class="form-control" onchange="searchByName(this)">
                    <div class="input-group-btn">
                        <button type="submit" class="btn btn-default btn-primary"><i class="glyphicon glyphicon-search"></i></button>
                    </div>
                </div>
            </form> --%>
            <ul class="nav navbar-nav navbar-right">
                <c:if test="${not empty userInfor}">
                    <li>
                        <a href="/request/job-market"><i class="fa-solid fa-shop"></i></a>
                    </li>
                </c:if>
                <c:if test="${not empty userInfor}">
                    <li>
                        <a data-toggle="dropdown" class="dropdown-toggle" href="#"><i class="glyphicon glyphicon-bell"></i></a>
                        <ul class="dropdown-menu" id="notificationDropdown">
                            <li><a href="#">Not have notification yet</a></li>
                        </ul>
                    </li>
                </c:if>
                <c:if test="${not empty userInfor}">
                    <li><a id="btnToggle" href="/chatbox"><i class="fa-solid fa-message"></i></a></li>
                </c:if>
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                        <i class="glyphicon glyphicon-user"></i>
                        <c:if test="${not empty userInfor}">
                            <span>(<fmt:formatNumber value="${balance}" type="number" pattern="###0" /> VND)</span>
                        </c:if>
                    </a>
                    <ul class="dropdown-menu user">
                        <c:choose>
                            <c:when test="${not empty userInfor}">
                                <li><a href="#" data-toggle="modal" data-target="#balanceModal">Balance: <fmt:formatNumber value="${balance}" type="number" pattern="###0" /> VND</a></li>      
                                <li class="divider"></li>           
                                <li><a href="/request/pending">Jobs</a></li>
                                <li><a href="/infor">Profile</a></li>
                                <li><a href="/login/change-password">Change password</a></li>
                                <li class="divider"></li>
                                <li><a href="/login/logout">Logout</a></li>
                            </c:when>
                            <c:otherwise>
                                <li><a href="/login/form">Login</a></li>
                            </c:otherwise>
                        </c:choose>
                    </ul>
                </li>
            </ul>
        </div>
    </div>
</div>

<!-- Modal -->
<div class="modal fade" id="balanceModal" tabindex="-1" role="dialog" aria-labelledby="balanceModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="balanceModalLabel">Information Balance</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <p>Balance: <fmt:formatNumber value="${balance}" type="number" pattern="###0" /> VND</p>
                <a href="/payment/recharge" class="btn btn-primary">Pay In</a>
            </div>
        </div>
    </div>
</div>

<script src="https://code.jquery.com/jquery-1.10.2.min.js"></script>
<script src="https://netdna.bootstrapcdn.com/bootstrap/3.1.0/js/bootstrap.min.js"></script>
<script src="../../assert/js/navbar.js"></script>
</body>
</html>
