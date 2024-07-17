const button = $("#hire-button");
let imageId = null;
let userId = null;
$(function () {
  $(".superbox-img").click(showImgage);
});
function showImgage() {
  const clickedImage = $(this);

  const dataId = clickedImage.closest(".superbox-list").data("id");
  imageId = dataId;

  $("#showPhoto .modal-body").html(clickedImage.clone());

  $("#showPhoto .modal-title").text(clickedImage.attr("alt") || "Image");

  $("#showPhoto").modal("show");
}

function deleteImage() {
  if (confirm("Are you sure you want to delete this image?")) {
    fetch(`https://localhost:443/profile-media-delete?id=${imageId}`, {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
    })
      .then((response) => response.json())
      .then((data) => {
        if (data.status === 200) {
          $("#showPhoto").modal("hide");

          const imageToDelete = $(".superbox-list[data-id='" + imageId + "']");
          if (imageToDelete.length) {
            imageToDelete.remove();
          } else {
            console.error(
              "Image element not found in the DOM (might be a loading issue or already removed)"
            );
          }
        } else {
          console.error(
            "Error deleting image:",
            data.message || "Server error"
          );
        }
      })
      .catch((error) => {
        console.error("Error:", error);
      });
  }
}

$("#deleteButton").click(deleteImage);

// ================================================
$(document).ready(function () {
  $(".nav-tabs li").click(function (event) {
    event.preventDefault();

    $(".nav-tabs li").removeClass("active");
    $(".tab-pane").removeClass("active");

    $(this).addClass("active");
    $(".tab-pane").eq($(this).index()).addClass("active");
  });
  getComment(0);
});

// ================================================
function openModal() {
  $("#myModal").modal("show");
}

button.on("click", openModal);

const monthNames = [
  "January",
  "February",
  "March",
  "April",
  "May",
  "June",
  "July",
  "August",
  "September",
  "October",
  "November",
  "December",
];
const currentDate = new Date();
let currentMonth = currentDate.getMonth();
let currentYear = currentDate.getFullYear();

const selectedDaysList = [];

function updateCalendar() {
  const daysContainer = document.getElementById("days");
  daysContainer.innerHTML = "";
  const monthNameDiv = document.getElementById("month-name");
  monthNameDiv.innerText = `${monthNames[currentMonth]} ${currentYear}`;

  const firstDay = new Date(currentYear, currentMonth, 1).getDay();
  const monthDays = new Date(currentYear, currentMonth + 1, 0).getDate();

  for (let i = 0; i < firstDay; i++) {
    const emptyDiv = document.createElement("div");
    daysContainer.appendChild(emptyDiv);
  }

  for (let day = 1; day <= monthDays; day++) {
    const dayDiv = document.createElement("div");
    dayDiv.className = "day";

    const checkbox = document.createElement("input");
    checkbox.type = "checkbox";
    checkbox.id = `day${day}`;
    checkbox.dataset.date = `${currentYear}-${currentMonth + 1}-${day}`;

    const label = document.createElement("label");
    label.setAttribute("for", checkbox.id);
    label.innerText = day;

    if (selectedDaysList.includes(checkbox.dataset.date)) {
      checkbox.checked = true;
      label.style.backgroundColor = "#007bff";
      label.style.color = "white";
    }

    checkbox.addEventListener("change", handleCheckboxChange);

    dayDiv.appendChild(checkbox);
    dayDiv.appendChild(label);
    daysContainer.appendChild(dayDiv);
  }

  enforceMaxDaysSelection();
}

function handleCheckboxChange(event) {
  var maxDays = 15;

  const day = parseInt(event.target.id.replace("day", ""));
  const selectedDate = new Date(currentYear, currentMonth, day);

  if (selectedDate < currentDate) {
    alert("You cannot select a date earlier than today.");
    event.target.checked = false;
    return;
  }

  const dateStr = event.target.dataset.date;
  if (event.target.checked) {
    selectedDaysList.push(dateStr);
    event.target.nextElementSibling.style.backgroundColor = "#007bff";
    event.target.nextElementSibling.style.color = "white";
  } else {
    const index = selectedDaysList.indexOf(dateStr);
    if (index > -1) {
      selectedDaysList.splice(index, 1);
      event.target.nextElementSibling.style.backgroundColor = "";
      event.target.nextElementSibling.style.color = "";
    }
  }

  if (selectedDaysList.length > maxDays) {
    alert("The maximum number of days you can select is " + maxDays);
    event.target.checked = false;
    const lastSelectedDate = selectedDaysList.pop();
    document.querySelector(
      `input[data-date='${lastSelectedDate}']`
    ).checked = false;
    document.querySelector(
      `input[data-date='${lastSelectedDate}']`
    ).nextElementSibling.style.backgroundColor = "";
    document.querySelector(
      `input[data-date='${lastSelectedDate}']`
    ).nextElementSibling.style.color = "";
  }
}

function enforceMaxDaysSelection() {
  const maxDays = 15;
  while (selectedDaysList.length > maxDays) {
    const lastSelectedDate = selectedDaysList.pop();
    document.querySelector(
      `input[data-date='${lastSelectedDate}']`
    ).checked = false;
    document.querySelector(
      `input[data-date='${lastSelectedDate}']`
    ).nextElementSibling.style.backgroundColor = "";
    document.querySelector(
      `input[data-date='${lastSelectedDate}']`
    ).nextElementSibling.style.color = "";
  }
}

function prevMonth() {
  if (currentMonth === 0) {
    currentMonth = 11;
    currentYear--;
  } else {
    currentMonth--;
  }
  updateCalendar();
}

function nextMonth() {
  if (currentMonth === 11) {
    currentMonth = 0;
    currentYear++;
  } else {
    currentMonth++;
  }
  updateCalendar();
}

document.addEventListener("DOMContentLoaded", updateCalendar);

function replaceNewLinesWithBr(text) {
  return text.replace(/\n/g, "<br>");
}

async function submitPostRequest() {
  const recipientId = document.getElementById("user-recipient-request").value;
  const location = document.getElementById("postLocation").value;
  const dateRequire = new Date().toISOString().split("T")[0]; // Ngày hiện tại
  const deadline = document.getElementById("postDeadline").value;
  const description = replaceNewLinesWithBr(
    document.getElementById("postDescription").value
  );
  if (!checkCurrentDate(deadline)) {
    alert("The deadline must be greater than the current date.");
    return;
  }
  const requestData = {
    typeRequest: "POST",
    request: {
      recipientId: recipientId,
      location: location,
      type: "POST",
      dateRequire: dateRequire,
      deadline: deadline,
      decription: description,
    },
  };

  await sendRequest(requestData);
}

async function submitVideoRequest() {
  const recipientId = document.getElementById("user-recipient-request").value;
  const location = document.getElementById("videoLocation").value;
  const dateRequire = new Date().toISOString().split("T")[0]; // Ngày hiện tại
  const deadline = document.getElementById("videoDeadline").value;
  const description = replaceNewLinesWithBr(
    document.getElementById("videoDescription").value
  );
  if (!checkCurrentDate(deadline)) {
    alert("The deadline must be greater than the current date.");
    return;
  }
  const requestData = {
    typeRequest: "VIDEO",
    request: {
      recipientId: recipientId,
      location: location,
      type: "VIDEO",
      dateRequire: dateRequire,
      deadline: deadline,
      decription: description,
    },
  };

  await sendRequest(requestData);
}

async function submitHiretRequest() {
  if (selectedDaysList.length > 0) {
    const recipientId = document.getElementById("user-recipient-request").value;
    const location = document.getElementById("hireLocation").value;
    const dateRequire = new Date().toISOString().split("T")[0]; // Ngày hiện tại
    const description = replaceNewLinesWithBr(
      document.getElementById("hireDescription").value
    );

    const requestData = {
      typeRequest: "HIREBYDAY",
      request: {
        recipientId: recipientId,
        location: location,
        type: "HIREBYDAY",
        dateRequire: dateRequire,
        daysRequire: selectedDaysList,
        decription: description,
      },
    };

    await sendRequest(requestData);
  } else {
    alert("No days selected");
  }
}

async function submitRepresentativetRequest() {
  const recipientId = document.getElementById("user-recipient-request").value;
  const location = document.getElementById("representativeLocation").value;
  const dateRequire = new Date().toISOString().split("T")[0]; // Ngày hiện tại
  const dateStart = document.getElementById("representativeStart").value; // Ngày bắt đầu
  const numberMonths = document.getElementById("representativeMonths").value;
  const description = replaceNewLinesWithBr(
    document.getElementById("representativeDescription").value
  );
  if (!checkCurrentDate(dateStart)) {
    alert("The Date Start must be greater than the current date.");
    return;
  }
  const requestData = {
    typeRequest: "REPRESENTATIVE",
    request: {
      recipientId: recipientId,
      location: location,
      type: "REPRESENTATIVE",
      dateRequire: dateRequire,
      dateStart: dateStart,
      numberMonths: numberMonths,
      decription: description,
    },
  };

  await sendRequest(requestData);
}

async function sendRequest(data) {
  try {
    const response = await fetch("/request/private", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify(data),
    });
    console.log(data);
    if (!response.ok) {
      throw new Error(`HTTP error! status: ${response.status}`);
    }

    const result = await response.json();
    console.log(result);
    if (result.type === "ERROR_MONEY") {
      alert("Insufficient funds. Redirecting to recharge page...");
      window.location.href = "https://localhost/payment/recharge";
    } else {
      console.log(result.result);
      alert(result.result);
      window.location.href = "https://localhost/request/pending";
    }
  } catch (error) {
    alert("An error occurred: " + error.message);
  }
}

document.addEventListener("DOMContentLoaded", updateCalendar);

function showContent(type) {
  // Add modal body content based on type
  let modalContent;
  $("#myModal").modal("hide");
  switch (type) {
    case "post":
      $("#postModal").modal("show");
      break;
    case "video":
      $("#videoModal").modal("show");
      break;
    case "by_date":
      $("#dateModal").modal("show");
      break;
    case "representative":
      $("#representativeModal").modal("show");
      break;
    default:
  }
}

// ================================================
document.getElementById("add-button").addEventListener("click", function () {
  document.getElementById("file-input").click();
});

document
  .getElementById("file-input")
  .addEventListener("change", handleFileSelect);

  function handleFileSelect(event) {
    const file = event.target.files[0];
    if (file) {
      console.log("Send");
      const reader = new FileReader();
      reader.onload = function (e) {
        const uploadData = {
          content: e.target.result,
          createAt: new Date().toISOString(),
        };
  
        fetch("https://localhost:443/profile-media-add", {
          method: "POST",
          headers: {
            "Content-Type": "application/json",
          },
          body: JSON.stringify(uploadData),
        })
          .then((response) => {
            if (!response.ok) {
              return response.json().then((data) => {
                throw new Error(data.result || "Unknown error occurred");
              });
            }
            return response.json();
          })
          .then((data) => {
            alert("Add Image Success");
  
            const mediaElement = document.createElement(
              file.type.startsWith("image/") ? "img" : "video"
            );
            mediaElement.src = e.target.result;
            mediaElement.className = "superbox-img";
            if (file.type.startsWith("video/")) {
              mediaElement.controls = true;
            }
  
            const newSuperboxList = document.createElement("div");
            newSuperboxList.className = "superbox-list";
            newSuperboxList.appendChild(mediaElement);
  
            const superbox = document.querySelector(".superbox");
            const secondChild = superbox.children[1]; // Get the second child
            if (secondChild) {
              superbox.insertBefore(newSuperboxList, secondChild);
            } else {
              superbox.appendChild(newSuperboxList); // If no second child, append to end
            }
            $(".superbox-img").click(showImgage);
          })
          .catch((error) => {
            alert("Add Image Fail: " + error.message);
          });
  
        event.target.value = "";
      };
  
      reader.readAsDataURL(file);
    }
  }
  
// ================================================
function getTotalComment(totalNumber) {
  const totalComment = $(".total-comment");
  totalComment.empty();
  var totalCommentHtml = `<h3>Total Comments: ${totalNumber}</h3>`;
  totalComment.append(totalCommentHtml);
}
function getComment(numberPage) {
  userId = document.getElementById("user-recipient-request").value;
  $("#comments-list").empty();
  var apiUrlGetComments = `https://localhost/comment?userId=${userId}&&page=${numberPage}`;
  console.log(apiUrlGetComments);
  fetch(apiUrlGetComments)
    .then((response) => {
      if (!response.ok) {
        throw new Error("Network response was not ok");
      }
      return response.json();
    })
    .then((data) => {
      getTotalComment(data.totalElements);
      if (data.content && data.content.length > 0) {
        data.content.forEach(function (comment) {
          // Generate star rating HTML
          var starRatingHtml = generateStarRating(comment.rating);

          // Create HTML structure for comment
          var commentHtml = `
            <div class="media">
              <a class="pull-left" href="#">
                <img class="media-object" src="${comment.urlAvatarSender}" alt="Avatar">
              </a>
              <div class="media-body">
                <h4 class="media-heading">${comment.nameSender}</h4>
                <div class="star-rating">
                  ${starRatingHtml}
                </div>
                <p>${comment.content}</p>
                <ul class="list-unstyled list-inline media-detail pull-left">
                  <li><i class="fa fa-calendar"></i>${new Date(comment.createAt).toLocaleDateString()}</li>
                </ul>
                <div class="report-comment">
                   <button class="report-btn" onclick="openReportModal(${comment.commentId}, ${comment.idSender})">Report</button>
                </div>
              </div>
            </div>
          `;
          // Append comment to container
          $("#comments-list").append(commentHtml);
          console.log(comment.commentId, comment.idSender);
        });
        createPagination(data.totalPages, data.number);
      } else {
        $("#comments-list").append("<p>No comments available.</p>");
      }
    })
    .catch((error) => {
      console.error("Failed to load comments:", error);
      $("#comments-list").append("<p>Failed to load comments.</p>");
    });
}

function openReportModal(commentId, reportedUserId) {
  document.getElementById('reportedComment').value = commentId;
  document.getElementById('reportedUser').value = reportedUserId;
  $("#reportModal").modal("show");
}

$(document).on('click', '.close', function () {
  $(this).closest('.modal').modal('hide');
});



function createPagination(totalPages, currentPage) {
  const pagination = $("#pagination");
  pagination.empty();
  console.log(totalPages, currentPage);
  var prevButton = `<li class="page-item ${
    currentPage === 0 ? "disabled" : ""
  }">
  ${
    currentPage === 0
      ? '<span class="">Previous</span>'
      : '<a class="page-link" href="#" data-page="' +
        (currentPage - 1) +
        '">Previous</a>'
  }
  </li>`;
  pagination.append(prevButton);

  for (var i = 0; i <= totalPages - 1; i++) {
    var pageButton = `<li class="page-item ${
      i === currentPage ? "active" : ""
    }">
                        <a class="page-link" href="#" data-page="${i}">${
      i + 1
    }</a>
                      </li>`;
    pagination.append(pageButton);
  }

  var nextButton = `<li class="page-item ${
    currentPage + 1 === totalPages ? "disabled" : ""
  }">
  ${
    currentPage + 1 === totalPages
      ? '<span class="">Next</span>'
      : '<a class="page-link" href="#" data-page="' +
        (currentPage + 1) +
        ' ">Next</a>'
  }                
                    </li>`;
  pagination.append(nextButton);

  pagination.find(".page-link").click(function (event) {
    event.preventDefault();
    var page = parseInt($(this).attr("data-page"));
    getComment(page);
  });
}

function generateStarRating(rating) {
  let starHtml = "";
  for (let i = 1; i <= 5; i++) {
    if (i <= rating) {
      starHtml += '<i class="fa fa-star"></i>';
    } else {
      starHtml += '<i class="fa fa-star-o"></i>';
    }
  }
  return starHtml;
}

function checkCurrentDate(dateEnd) {
  var currentDate = new Date().toISOString().split("T")[0]; // Chỉ lấy ngày
  if (dateEnd <= currentDate) {
    return false;
  }
  return true;
}
