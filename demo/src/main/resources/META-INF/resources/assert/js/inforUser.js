function handleImageError(image) {
  image.onerror = null;
  image.src =
    "https://png.pngtree.com/element_our/20200610/ourlarge/pngtree-default-avatar-image_2237213.jpg";
}

function openModal() {
  document.getElementById("uploadModal").classList.remove("hidden");
}

function closeModal() {
  document.getElementById("uploadModal").classList.add("hidden");
}

async function uploadImage() {
  const fileInput = document.getElementById("imageUpload");
  if (fileInput.files.length === 0) {
    alert("Please select a file.");
    return;
  }

  const file = fileInput.files[0];

  // Check file type
  const allowedTypes = ["image/jpeg", "image/png", "image/gif"];
  if (!allowedTypes.includes(file.type)) {
    alert("Only JPEG, PNG, and GIF files are allowed.");
    return;
  }

  // Check file size (5MB limit)
  const maxSizeInBytes = 5 * 1024 * 1024;
  if (file.size > maxSizeInBytes) {
    alert("File size must be less than 5MB.");
    return;
  }

  const formData = new FormData();
  formData.append("image", file);

  try {
    const response = await fetch("/cloudinary/upload", {
      method: "POST",
      body: formData,
    });
    const result = await response.json();

    if (response.ok) {
      alert("Image uploaded successfully!");
      window.location.reload();
    } else {
      alert("Image upload failed: " + result.message);
    }
  } catch (error) {
    console.error("Error uploading image:", error);
    alert("Error uploading image");
  }
}

function submitForm(event) {
  event.preventDefault();
  const form = document.getElementById("userForm");
  const formData = new FormData(form);
  const data = {};
  formData.forEach((value, key) => {
    data[key] = value;
  });

  fetch("/update", {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
    },
    body: JSON.stringify(data),
  })
    .then((response) => {
      if (response.ok) {
        alert("User updated successfully");
      } else {
        return response.json().then((error) => {
          throw new Error(error.message);
        });
      }
    })
    .catch((error) => {
      console.error("Error updating user:", error);
      alert("Failed to update user: " + error.message);
    });
}

function validateEmail(email) {
  var regex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
  return regex.test(email);
}

function validateEmailForm() {
  var emailInput = document.getElementById("email");
  var email = emailInput.value.trim();
  var messageElement = document.getElementById("emailMessage");

  if (validateEmail(email)) {
      messageElement.classList.add("hidden");
      return true;  // Allow form submission
  } else {
      messageElement.classList.remove("hidden");
      return false; // Prevent form submission
  }
}
