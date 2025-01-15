<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>KOL List</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
</head>
<style>
        /* CSS tùy chỉnh cho ảnh trong modal */
        #imageModal .modal-dialog {
            max-width: 50%; /* Chiều rộng tối đa là 80% chiều rộng viewport */
        }
        #imageModal .modal-body img {
            max-width: 100%;
            min-height: 300px; 
        }
    </style>
<body>
    <div class="container">
        <h1 class="my-4">KOL List</h1>
        <form:form action="${pageContext.request.contextPath}/admin/createAccounts" method="post">
            <table class="table table-striped">
                <thead>
                    <tr>
                        <th scope="col">Select</th>
                        <th scope="col">Name</th>
                        <th scope="col">Email</th>
                        <th scope="col">Categories</th>
                        <th scope="col">Description</th>
                        <th scope="col">Pictures</th>
                        <th scope="col">Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="kol" items="${kolRegistrations}">
                        <tr>
                            <td><input type="checkbox" name="kolIds" value="${kol.id}" /></td>
                            <td>${kol.name}</td>
                            <td>${kol.email}</td>
                            <td>${kol.categories}</td>
                            <td>${kol.description}</td>
                            <td>
                                <c:forEach var="imageUrl" items="${kol.imageUrlsList}">
                                    <img src="${imageUrl.trim()}" alt="Image" style="max-width: 100px; max-height: 100px; margin-right: 5px; cursor: pointer;" onclick="showImageModal('${imageUrl.trim()}')" />
                                </c:forEach>
                            </td>
                            <td>
                                <button type="button" class="btn btn-danger btn-sm" onclick="deleteKol(${kol.id})">Delete</button>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
            <button type="submit" class="btn btn-primary">Create Accounts</button>
        </form:form>
        <c:if test="${not empty message}">
            <div class="alert alert-success mt-4">${message}</div>
        </c:if>
        <c:if test="${not empty messageError}">
            <div class="alert alert-danger mt-4">${messageError}</div>
        </c:if>
    </div>

    <form id="deleteKolForm" action="${pageContext.request.contextPath}/admin/deleteKol" method="post" style="display: none;">
        <input type="hidden" name="kolId" id="kolId" />
    </form>

    <!-- Image Modal -->
<div class="modal fade" id="imageModal" tabindex="-1" role="dialog" aria-labelledby="imageModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="imageModalLabel">Image Preview</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body text-center">
                <img id="modalImage" src="" alt="Image" class="img-fluid" />
            </div>
        </div>
    </div>
</div>


    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
    <script>
        function showImageModal(imageUrl) {
        document.getElementById('modalImage').src = imageUrl;
        $('#imageModal').modal('show');
    }

    function deleteKol(kolId) {
        if (confirm('Are you sure you want to delete this KOL?')) {
            document.getElementById('kolId').value = kolId;
            document.getElementById('deleteKolForm').submit();
        }
    }
    </script>
</body>
</html>
