<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta charset="UTF-8">
    <title>Report List</title>
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
        }
        .form-group {
            margin-bottom: 15px;
        }
        .form-control {
            padding: 10px;
            width: 100%;
            box-sizing: border-box;
        }
        .btn {
            padding: 10px 20px;
            color: white;
            border: none;
            cursor: pointer;
        }
        .btn-primary {
            background-color: #007bff;
        }
        .btn-danger {
            background-color: #dc3545;
        }
        .btn-success {
            background-color: #28a745;
        }
        .table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        .table th, .table td {
            border: 1px solid #dee2e6;
            padding: 8px;
        }
        .table th {
            background-color: #007bff;
        }
        .table thead {
            color: white;
        }
        .mt-2 {
            margin-top: 10px;
        }
        .mt-3 {
            margin-top: 20px;
        }
        .pagination {
            display: flex;
            list-style: none;
            padding: 0;
        }
        .page-item {
            margin: 0 5px;
        }
        .page-link {
            display: block;
            padding: 10px 15px;
            color: #007bff;
            text-decoration: none;
        }
        .page-item.disabled .page-link {
            color: #6c757d;
            pointer-events: none;
        }
        .page-item.active .page-link {
            background-color: #007bff;
            color: white;
        }
        .notification {
            display: none;
            background-color: #4CAF50; /* Green */
            color: white;
            padding: 15px;
            position: fixed;
            top: 10px;
            right: 10px;
            z-index: 1000;
            border-radius: 5px;
        }
    </style>
</head>
<body>
    <div id="notification" class="notification">${notification}</div>
    <h2>Report List</h2>
    <form action="/admin/reports" method="get">
        <div class="form-group">
            <input type="text" name="keyword" class="form-control" placeholder="Search..." value="${keyword}">
        </div>
        <button type="submit" class="btn btn-primary">Search</button>
    </form>
    <table class="table table-striped mt-3">
        <thead>
            <tr>
                <th>ID</th>
                <th>Description</th>
                <th>Reason</th>
                <th>Create Date</th>
                <th>Report User</th>
                <th>Reported User</th>
                <th>Comment</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="report" items="${reportPage.content}">
                <tr>
                    <td>${report.reportId}</td>
                    <td>${report.description}</td>
                    <td>${report.reason}</td>
                    <td>${report.createDate}</td>
                    <td>${report.reportUser.username}</td>
                    <td>${report.reportedUser.username}</td>
                    <td><c:out value="${report.reportedComment != null ? report.reportedComment.commentContent : ''}" /></td>
                    <td>
                        <form action="/admin/reports/sendNotification" method="post" class="d-inline">
                            <input type="hidden" name="userId" value="${report.reportedUser.userId}" />
                            <div class="input-group">
                                <textarea name="message" class="form-control" placeholder="Enter notification message" required></textarea>
                                <div class="input-group-append">
                                    <button type="submit" class="btn btn-primary">Send Notification</button>
                                </div>
                            </div>
                        </form>
                        <div class="mt-2">
                            <c:if test="${!report.reportedUser.locked}">
                                <button data-id="${report.reportedUser.userId}" class="btn btn-danger btn-ban">Ban</button>
                            </c:if>
                            <c:if test="${report.reportedUser.locked}">
                                <button data-id="${report.reportedUser.userId}" class="btn btn-success btn-unban">Unban</button>
                            </c:if>
                        </div>
                        <!-- Delete Report Button -->
                        <form action="/admin/reports/delete/${report.reportId}" method="post" class="d-inline" onclick="return confirm('Are you sure you want to delete this report?')">
                            <button type="submit" class="btn btn-danger">Delete Report</button>
                        </form>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
    <div>
        <nav>
            <ul class="pagination">
                <c:if test="${reportPage.totalPages > 1}">
                    <li class="page-item ${reportPage.number == 0 ? 'disabled' : ''}">
                        <a class="page-link" href="/admin/reports?page=${reportPage.number - 1}&size=${reportPage.size}&keyword=${keyword}">Previous</a>
                    </li>
                    <c:forEach var="i" begin="1" end="${reportPage.totalPages}">
                        <li class="page-item ${reportPage.number + 1 == i ? 'active' : ''}">
                            <a class="page-link" href="/admin/reports?page=${i - 1}&size=${reportPage.size}&keyword=${keyword}">${i}</a>
                        </li>
                    </c:forEach>
                    <li class="page-item ${reportPage.number + 1 == reportPage.totalPages ? 'disabled' : ''}">
                        <a class="page-link" href="/admin/reports?page=${reportPage.number + 1}&size=${reportPage.size}&keyword=${keyword}">Next</a>
                    </li>
                </c:if>
            </ul>
        </nav>
    </div>

    <script>
        $(document).ready(function() {
            $(".btn-ban").click(function() {
                var userId = $(this).data("id");
                $.post("/admin/users/ban/" + userId, function(response) {
                    location.reload();
                }).fail(function(xhr) {
                    alert(xhr.responseText);
                });
            });

            $(".btn-unban").click(function() {
                var userId = $(this).data("id");
                $.post("/admin/users/unban/" + userId, function(response) {
                    location.reload();
                }).fail(function(xhr) {
                    alert(xhr.responseText);
                });
            });

            document.addEventListener("DOMContentLoaded", function() {
                var notification = document.getElementById("notification");
                if (notification.textContent.trim().length > 0) {
                    notification.style.display = "block";
                    setTimeout(function() {
                        notification.style.display = "none";
                    }, 5000);
                }
            });
        });
    </script>
</body>
</html>
