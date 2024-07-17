const container = document.getElementById("container");
const registerBtn = document.getElementById("register");
const loginBtn = document.getElementById("login");
let codeId = -1;
registerBtn.addEventListener("click", () => {
  container.classList.add("active");
});

loginBtn.addEventListener("click", () => {
  container.classList.remove("active");
});

$(document).ready(function () {
  $("#username").on("input", function () {
    var username = $(this).val();
    var iconCheck = $("#username-check");

    if (username.length > 0) {
      $.ajax({
        url: "/userexist",
        type: "GET",
        data: { username: username },
        success: function (data) {
          if (data.userExist) {
            iconCheck.addClass("visible error").removeClass("success");
            iconCheck.html('<i class="fa fa-times"></i>');
          } else {
            iconCheck.addClass("visible success").removeClass("error");
            iconCheck.html('<i class="fa fa-check"></i>');
          }
        },
      });
    } else {
      iconCheck.removeClass("visible success error");
    }
  });

  $("#getEmailVerificationCode").on("click", function () {
    var username = $("#username").val();
    var password = $("#password").val();
    var email = $("#email").val();

    $.ajax({
      url: "/login/api/register-get-code",
      type: "POST",
      data: {
        userName: username,
        password: password,
        email: email,
      },
      success: function (response) {
        if (response.status === 202) {
          codeId = response.message;
          $("#verificationCode").show();
          $("#signUpButton").show();
          alert(
            "Verification code sent to your email. Please enter the code to complete registration."
          );
          $("#getEmailVerificationCode").hide();
        } else {
          alert(response.message);
        }
      },
    });
  });

  $("#registerForm").on("submit", function (event) {
    var password = $("#password").val();
    var passwordConfirm = $("#passwordConfirm").val();

    if (password !== passwordConfirm) {
      event.preventDefault();
      alert("Passwords do not match!");
    } else {
      // Assuming the registration code API was updated to include codeId
      var code = $("#verificationCode").val();
      var username = $("#username").val();
      var email = $("#email").val();

      $.ajax({
        url: "/login/api/register",
        type: "POST",
        data: {
          userName: username,
          password: password,
          email: email,
          codeId: codeId,
          code: code,
        },
        success: function (response) {
          if (response.status === 201) {
            alert(response.message);
            window.location.href('/login/form?success=true')
          } else if (response.status === 423) {
            alert(response.message);
            location.reload();
          } else {
            alert(response.message);
          }
        },
      });

      event.preventDefault();
    }
  });
});
