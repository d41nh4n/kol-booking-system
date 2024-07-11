
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>User Profile</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        /* CSS để thiết lập vị trí và kiểu dáng cho nút Back */
        .container {
            max-width: 600px;
            margin: 0 auto;
            padding-top: 50px;
        }
        .back-button {
            background-color: #007bff;
            color: #ffffff;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            text-decoration: none;
        }
        .back-button:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>User Profile</h1>
        <c:if test="${profile == null}">
            <p>User profile not found.</p>
        </c:if>
        <c:if test="${profile != null}">
            <p>ID: <span>${profile.id}</span></p>
            <p>Name: <span>${profile.name}</span></p>
            <p>Full Name: <span>${profile.fullName}</span></p>
            <p>Email: <span>${profile.email}</span></p>
            <p>Role: <span>${profile.role}</span></p>
            <p>Created At: <span>${profile.createdAt}</span></p>
            <p>Ban: <span>${profile.banAction == 'Ban' ? 'False' : 'True'}</span></p>
            <p>Bio: <span>${profile.bio}</span></p>
            <p>Phone Number: <span>${profile.phoneNumber}</span></p>
            <p>Address: <span>${profile.address}</span></p>
            <p>Birthday: <span>${profile.birthday}</span></p>
            
            <!-- Add display for avatar if needed -->

            <!-- Nút trở về -->
            <a href="/admin/list_users?page=${currentPage}" class="back-button">Back</a>
        </c:if>
    </div>
</body>
</html>
