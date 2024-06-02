<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Confirmation Code</title>
<style>
    body {
        font-family: Arial, sans-serif;
    }
    .container {
        max-width: 400px;
        margin: 0 auto;
        text-align: center;
        padding: 20px;
    }
    input[type="text"] {
        width: 100%;
        padding: 10px;
        margin: 10px 0;
    }
    button {
        padding: 10px 20px;
        background-color: #007bff;
        color: #fff;
        border: none;
        cursor: pointer;
    }
    button:disabled {
        background-color: #ccc;
        cursor: not-allowed;
    }
    .error {
        color: red;
        margin-top: 10px;
    }
</style>
</head>
<body>
<div class="container">
    <h2>Enter Confirmation Code</h2>
    <p>Please enter the 6-digit confirmation code:</p>
    <p id="errorMessage" class="error"></p>
    <form id="confirmationForm">
        <input type="hidden" id="codeId" value="${idCode}">
        <input type="text" id="confirmationCode" maxlength="6" pattern="\d{6}" required>
        <button type="submit" id="submitButton" disabled>Submit</button>
    </form>
    <h3>We just send a confirm code. Check your email ${email}</h3>
</div>

<script>
document.getElementById("confirmationCode").addEventListener("input", function() {
    var codeLength = this.value.length;
    var submitButton = document.getElementById("submitButton");
    if (codeLength === 6) {
        submitButton.disabled = false;
    } else {
        submitButton.disabled = true;
    }
});

document.getElementById("confirmationForm").addEventListener("submit", function(event) {
    event.preventDefault();
    var idCode = document.getElementById("codeId").value;
    var confirmationCode = document.getElementById("confirmationCode").value;
    var errorMessage = document.getElementById("errorMessage");

    var formData = new FormData();
    formData.append('idCode', idCode);
    formData.append('verifyCode', confirmationCode);

    fetch('/verifycode', {
        method: 'POST',
        body: formData
    })
    .then(response => response.json())
    .then(data => {
        if (data.status === 500) { 
             setTimeout(() => {
                window.location.href = '/verifyFailure';
            }, 3000);
        } else if (data.status === 400) {
            errorMessage.textContent = data.message;
        } else {
            window.location.href = '/verifySuccess';
        }
    })
    .catch(error => {
        console.error('Error:', error);
    });
});

</script>
</body>
</html>