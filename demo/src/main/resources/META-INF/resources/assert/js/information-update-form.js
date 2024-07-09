async function submitForm(event) {
  event.preventDefault();

  const form = document.getElementById("userForm");
  const formData = new FormData(form);

  let description = formData.get("description");
  description = description.replace(/\n/g, "<br>");
  formData.set("description", description);

  const userProfileUpdate = {
    fullName: formData.get("fullName"),
    gender: formData.get("gender"),
    description: formData.get("description"),
    dob: formData.get("dob"),
    location: formData.get("location"),
    priceAPost: formData.get("priceAPost"),
    priceAVideo: formData.get("priceAVideo"),
    priceAToHireADay: formData.get("priceAToHireADay"),
    representativePrice: formData.get("representativePrice"),
  };

  try {
    const response = await fetch("/update", {
      method: "POST",
      headers: {
        "Content-Type": "application/json; charset=UTF-8", // Đảm bảo sử dụng UTF-8
        Accept: "application/json",
      },
      body: JSON.stringify(userProfileUpdate),
    });

    const contentType = response.headers.get("content-type");
    let result;

    if (contentType && contentType.indexOf("application/json") !== -1) {
      result = await response.json();
    } else {
      result = await response.text();
    }

    if (response.ok) {
      alert(result.message || "User updated successfully");
      console.log(result);
    } else {
      alert("Error: " + (result.message || result));
    }
  } catch (error) {
    console.error("Error:", error);
    alert("An error occurred. Please try again later.");
  }
}

function handleImageError(image) {
  image.onerror = null;
  image.src =
    "https://png.pngtree.com/element_our/20200610/ourlarge/pngtree-default-avatar-image_2237213.jpg";
}

function openModal() {
  $("#uploadImageModal").modal("show");
}

function closeModal() {
  $("#uploadImageModal").modal("hide");
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
