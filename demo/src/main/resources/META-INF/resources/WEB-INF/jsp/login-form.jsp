<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" type="text/css" href="../../assert/css/login.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <title>Modern Login Page | AsmrProg</title>
</head>

<body>

    <div class="container" id="container">
        <div class="form-container sign-up">
            <form action="/login/register" method="post" id="registerForm">
                <h1>Create Account</h1>
                <a href="/guest/register">Register KOL</a>
                <i id="username-check" class="icon-check"></i>
                <input type="text" id="username" name="username" placeholder="Username" required>
                <input type="password" id="password" name="password" placeholder="Password" required>
                <input type="password" id="passwordConfirm" name="passwordConfirm" placeholder="Confirm password" required>
                <input type="email" id="email" name="email" placeholder="Email" required>
                <button type="button" id="getEmailVerificationCode">Get Verification Code</button>
                
                <!-- Input for verification code -->
                <input type="text" id="verificationCode" name="verificationCode" placeholder="Verification Code" style="display:none;" required>
                <button type="submit" id="signUpButton" style="display:none;">Sign Up</button>
            </form>
        </div>
        <div class="form-container sign-in">
            <form action="/login/auth" method="post">
                <h1>Sign In</h1>
                <div class="social-icons">
                    <a href="${pageContext.request.contextPath}/oauth2/authorization/google" class="icon"><i class="fa-brands fa-google-plus-g"></i></a>
                    <a href="#" class="icon"><i class="fa-brands fa-facebook-f"></i></a>
                    <a href="#" class="icon"><i class="fa-brands fa-github"></i></a>
                    <a href="#" class="icon"><i class="fa-brands fa-linkedin-in"></i></a>
                </div>
                <span>or use your username password</span>
                <c:if test="${not empty errorMessage}">
                     <p class="error-message">${errorMessage}</p>
                </c:if>
                <c:if test="${not empty success}">
                    <p class="success-message">${success}</p>
                </c:if>
                <input type="text" name="username" placeholder="Username" required>
                <input type="password" name="password" placeholder="Password" required>
                <a href="/forgotpassword">Forget Your Password?</a>
                <button type="submit">Sign In</button>
            </form>
        </div>
        <div class="toggle-container">
            <div class="toggle">
                <div class="toggle-panel toggle-left">
                    <h1>Welcome Back!</h1>
                    <p>Enter your personal details to use all of site features</p>
                    <button class="hidden" id="login">Sign In</button>
                </div>
                <div class="toggle-panel toggle-right">
                    <h1>Hello, Friend!</h1>
                    <p>Register with your personal details to use all of site features</p>
                    <button class="hidden" id="register">Sign Up</button>
                </div>
            </div>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="../../assert/js/login.js"></script>
</body>

</html>
