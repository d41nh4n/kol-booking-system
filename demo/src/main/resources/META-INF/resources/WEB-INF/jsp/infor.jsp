
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>User Info Form</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet" />
    <style>
        .hidden { display: none; }
    </style>
</head>

<body class="bg-gray-100">
<%@include file="navbar.jsp" %>
 <div class="mx-16 my-16 ">
    <div class="card">
        <div class="card-body flex flex-col items-center">
            <!-- Profile picture image-->
            <img class="img-account-profile rounded-circle mb-2 w-24 h-24 rounded-full object-cover"
                src="${userInfo.avatarUrl}"
                alt="Avatar"
                onerror="handleImageError(this)"
            />
            <!-- Profile picture help block-->
            <div class="text-sm text-gray-500 mb-4">
                JPG or PNG no larger than 5 MB
            </div>
            <!-- Profile picture upload button-->
            <button class="bg-blue-500 text-white px-4 py-2 rounded hover:bg-blue-600 focus:outline-none focus:ring-2 focus:ring-blue-500" onclick="openModal()">
                Upload new image
            </button>
        </div>
    </div>

    <!-- Account details card-->
    <div class="card mr-16">
        <div class="card-header">Account Details</div>
        <div class="card-body">
            <!-- Form Row-->
            <div class="mb-3">
                    <c:if test="${not empty invalidEmail}">
                 <div class="text-red-500">Invalid email address. Please enter a valid email.</div>
                 </c:if>
               <c:if test="${not empty emailExist}">
                  <div class="text-red-500">Email address exist!. Please enter a other email</div>
                </c:if>
                <form id="emailForm" action="/verifyemail" method="post" onsubmit="return validateEmailForm()">
                    <label for="inputEmailAddress" class="small mb-1">Email address</label>
                    <input id="email" name="email" class="form-control w-full px-3 py-2 rounded border-gray-300 border" placeholder="Enter your email address" value="${userInfo.email}" />
                    <span id="emailMessage" class="text-red-500 hidden">Please enter a valid email address.</span>
                    <c:if test="${empty userInfo.email}">
                        <button type="submit" class="mt-2 bg-green-500 text-white px-4 py-2 rounded">Verify Email</button>
                    </c:if>
                </form>
            </div>
            <form id="userForm" onsubmit="submitForm(event)">
                <!-- Form Group (location)-->
                <div>
                    <label for="inputLocation" class="small mb-1">Address</label>
                    <input id="inputLocation" class="form-control w-full px-3 py-2 rounded border-gray-300 border" type="text" name="address" value="${userInfo.address}" />
                </div>
                <!-- Form Row-->
                <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                    <!-- Form Group (phone number)-->
                    <div>
                        <label for="inputPhone" class="small mb-1">Phone number</label>
                        <input id="inputPhone" class="form-control w-full px-3 py-2 rounded border-gray-300 border" placeholder="Enter your phone number" type="text" name="phone" value="${userInfo.phone}" />
                    </div>
                    <!-- Form Group (birthday)-->
                    <div>
                        <label for="inputBirthday" class="small mb-1">Birthday</label>
                        <input type="date" name="dob" value="${userInfo.dateOfBirth}" class="form-control w-full px-3 py-2 rounded border-gray-300 border" />
                    </div>
                </div>
                <!-- Form Group (profile description)-->
                <div class="mb-3">
                    <label for="inputProfileDesc" class="small mb-1">Profile Description</label>
                    <textarea name="description" id="description" class="form-control w-full block px-3 py-2 rounded border-gray-300 border" rows="4" placeholder="Enter your profile description">${userInfo.profileDesc}</textarea>
                </div>
                <div class="attribute mb-4">
                    <label class="block small mb-1">Gender:</label>
                    <input type="radio" name="gender" value="true" ${userInfo.gender == true ? 'checked' : ''} class="mr-2"> Male
                    <input type="radio" name="gender" value="false" ${userInfo.gender == false ? 'checked' : ''} class="mr-2"> Female
                </div>
                <!-- Save changes button-->
                <div>
                    <button type="submit" class="btn btn-primary px-4 py-2 rounded bg-blue-500 text-white hover:bg-blue-600 focus:outline-none focus:ring-2 focus:ring-blue-500">Save changes</button>
                </div>
            </form>
            <!-- Modal -->
            <div id="uploadModal" class="fixed inset-0 bg-gray-900 bg-opacity-50 flex items-center justify-center hidden">
                <div class="bg-white p-8 rounded-lg shadow-md w-96 relative">
                    <h2 class="text-xl font-bold mb-4">Upload Avatar</h2>
                    <input type="file" id="imageUpload" accept="image/*" class="w-full mb-4">
                    <div class="flex justify-between">
                        <button type="button" onclick="uploadImage()" class="bg-blue-500 text-white px-4 py-2 rounded">Upload</button>
                        <button type="button" onclick="closeModal()" class="bg-red-500 text-white px-4 py-2 rounded">Cancel</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    </div>
    <script src="../../assert/js/inforUser.js"></script>
</body>
</html>
