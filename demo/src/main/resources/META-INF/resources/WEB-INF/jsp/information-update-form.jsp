<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <title>Profile Edit - Bootdey.com</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/css/bootstrap.min.css" rel="stylesheet" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/js-cookie/3.0.1/js.cookie.min.js" integrity="sha512-QMCLsqfS2hu0Lm2pRjZs7cb0mNzHRmACs2oP0nRc63F0tqlN8f7wu2h8Sf6KfWbX2hnM9F0iJ+43GxJJLHx86g==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
    <link rel="stylesheet" href="../../assert/css/information-update-form.css" />
    <style>
    .hidden {
    display: none;
}
    </style>
</head>
<body>
    <%@include file="navbar.jsp" %>
    <div class="container-xl px-4 mt-16">
        <nav class="nav nav-borders">
            <a class="nav-link ms-0" href="/infor"><i class="fa-solid fa-id-card"></i>Back To Profile</a>
        </nav>
        <hr class="mt-0 mb-4" />
        <div class="row">
            <div class="col-xl-4">
                <div class="card mb-4 mb-xl-0">
                    <div class="card-header">Profile Picture</div>
                    <div class="card-body text-center">
                        <img class="img-account-profile rounded-circle mb-2" src="<c:out value='${userInformation.avatarUrl}'/>" alt="Profile Picture" onerror="handleImageError(this)" />
                        <div class="small font-italic text-muted mb-4">JPG or PNG no larger than 5 MB</div>
                        <button class="btn btn-primary" type="button" onclick="openModal()">Upload new image</button>
                    </div>
                </div>
            </div>
            <div class="col-xl-8">
                <div class="card mb-4">
                    <div class="card-header">Account Details</div>
                    <div class="card-body">
                        <form class="p-4 border rounded-lg shadow-lg" id="userForm" onsubmit="submitForm(event)">
                            <div class="grid grid-cols-1 md:grid-cols-2 gap-4 mb-3">
                                <div>
                                    <label class="small mb-1" for="inputFullName">Full Name (how your name will appear to other users on the site)</label>
                                    <input name="fullName" class="form-control w-full p-2 border rounded" id="inputFullName" type="text" placeholder="Enter your full name" value="<c:out value='${userInformation.fullName}'/>" />
                                </div>
                                <div>
                                    <label class="small mb-1" for="inputGender">Gender</label>
                                    <select class="form-select form-select-sm" id="inputGender" name="gender">
                                        <option value="Male" <c:if test="${userInformation.gender == 'MALE'}">selected</c:if>>Male</option>
                                        <option value="Female" <c:if test="${userInformation.gender == 'FEMALE'}">selected</c:if>>Female</option>
                                        <option value="Other" <c:if test="${userInformation.gender == 'OTHER'}">selected</c:if>>Other</option>
                                    </select>
                                </div>
                            </div>
                            <div class="mb-3">
                                <label class="small mb-1" for="inputBio">Bio</label>
                                <textarea name="description" class="form-control w-full p-2 border rounded" id="inputBio" placeholder="Enter your bio"><c:out value='${userInformation.bio}'/></textarea>
                            </div>
                            <div class="grid grid-cols-1 md:grid-cols-2 gap-4 mb-3">
                                <div>
                                    <label class="small mb-1" for="inputPhone">Phone number</label>
                                    <input name="phone" class="form-control w-full p-2 border rounded" id="inputPhone" type="tel" placeholder="Enter your phone number" value="<c:out value='${userInformation.phoneNumber}'/>" />
                                </div>
                                <div>
                                    <label class="small mb-1" for="inputBirthday">Birthday</label>
                                    <input name="dob" class="form-control w-full p-2 border rounded" id="inputBirthday" type="date" value="<c:out value='${userInformation.birthday}'/>" />
                                </div>
                            </div>
                            <div class="mb-3">
                                <label class="small mb-1" for="inputAddress">Address</label>
                                <input name="address" class="form-control w-full p-2 border rounded" id="inputAddress" type="text" placeholder="Enter your address" value="<c:out value='${userInformation.address}'/>" />
                            </div>
                            <button class="btn btn-primary mb-3 w-full md:w-auto" type="submit">Save changes</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Modal for uploading new image -->
<div class="modal fade" id="uploadImageModal" tabindex="-1" aria-labelledby="uploadImageModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="uploadImageModalLabel">Upload New Image</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <!-- Your form for uploading image can go here -->
                <form id="uploadForm" onsubmit="uploadImage(); return false;">
                    <input type="file" name="imageUpload" id="imageUpload" accept=".jpg, .png" />
                    <button type="submit" class="btn btn-primary">Upload</button>
                </form>
            </div>
        </div>
    </div>
</div>
    <script src="../../assert/js/information-update-form.js"></script>
</body>
</html>
