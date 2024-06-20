<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
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
    .dropdown-menu{
        min-width: 250px;

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
            <form class="navbar-form pull-left">
                <div style="max-width:600px;" class="input-group">
                    <input type="text" id="srch-term" name="srch-term" placeholder="Search" class="form-control" onchange="searchByName(this)">
                    <div class="input-group-btn">
                        <button type="submit" class="btn btn-default btn-primary"><i class="glyphicon glyphicon-search"></i></button>
                    </div>
                </div>
            </form>
            <ul class="nav navbar-nav navbar-right">
                <c:if test="${not empty userInfor}">
                    <li>
                        <a data-toggle="dropdown" class="dropdown-toggle" href="#"><i class="glyphicon glyphicon-bell"></i></a>
                        <ul class="dropdown-menu">
                            <li><a href="#"><span class="badge pull-right">40</span>Link</a></li>
                            <li><a href="#"><span class="badge pull-right">2</span>Link</a></li>
                            <li><a href="#"><span class="badge pull-right">0</span>Link</a></li>
                            <li><a href="#"><span class="label label-info pull-right">1</span>Link</a></li>
                            <li><a href="#"><span class="badge pull-right">13</span>Link</a></li>
                        </ul>
                    </li>
                </c:if>
                <li><a id="btnToggle" href="/chatbox"><i class="fa-solid fa-message"></i></a></li>
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown"><i class="glyphicon glyphicon-user"></i></a>
                    <ul class="dropdown-menu">
                        <c:choose>
                            <c:when test="${not empty userInfor}">
                                <li><a href="/infor">Profile</a></li>
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

<script src="https://code.jquery.com/jquery-1.10.2.min.js"></script>
<script src="https://netdna.bootstrapcdn.com/bootstrap/3.1.0/js/bootstrap.min.js"></script>
<script src="../../assert/js/navbar.js"></script>
</script>
</body>
</html>
