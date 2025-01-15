function changePassword() {
    let oldPassword = $('#oldPassword').val();
    let newPassword = $('#newPassword').val();
    let confirmPassword = $('#confirmPassword').val();
    let messageElement = $('#message');

    if (!oldPassword) {
        messageElement.css('color', 'red');
        messageElement.text('Current password cannot be empty.');
    } else if (!newPassword) {
        messageElement.css('color', 'red');
        messageElement.text('New password cannot be empty.');
    } else if (!confirmPassword) {
        messageElement.css('color', 'red');
        messageElement.text('Confirm password cannot be empty.');
    } else if (oldPassword === newPassword) {
        messageElement.css('color', 'red');
        messageElement.text('The new password cannot be the same as the old password.');
    } else if (newPassword !== confirmPassword) {
        messageElement.css('color', 'red');
        messageElement.text('The new password and confirm password do not match.');
    } else {
        $.ajax({
            url: '/login/change-password',
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify({
                oldPassword: oldPassword,
                newPassword: newPassword
            }),
            success: function(response) {
                messageElement.css('color', 'green');
                messageElement.text(response.message);
                window.location.href = `https://localhost/login/logout`
            },
            error: function(xhr) {
                messageElement.css('color', 'red');
                if (xhr.responseJSON && xhr.responseJSON.error) {
                    messageElement.text(xhr.responseJSON.error);
                } else {
                    messageElement.text('An error occurred.');
                }
            }
        });
    }
}

function togglePassword(fieldId) {
    let field = document.getElementById(fieldId);
    if (field.type === "password") {
        field.type = "text";
    } else {
        field.type = "password";
    }
}

$(document).ready(function() {
    $('#changePasswordButton').on('click', changePassword);
});
