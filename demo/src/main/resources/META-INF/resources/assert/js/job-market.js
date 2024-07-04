$(document).ready(function () {
  $(".view-more").on("click", function () {
      // Lấy dữ liệu từ thuộc tính data-*
      var avatar = $(this).data("avatar");
      var fullname = $(this).data("fullname");
      var location = $(this).data("location");
      var description = String($(this).data("description")); // Chuyển đổi description thành chuỗi
      var deadline = $(this).data("deadline");
      var dayLocation = $(this).data("daylocation");
      var dayDescription = $(this).data("daydescription");
      var daysRequired = $(this).data("daysrequired");
      var repLocation = $(this).data("replocation");
      var repDescription = $(this).data("repdescription");
      var startDate = $(this).data("startdate");
      var months = $(this).data("months");
      var price = $(this).data("price");
      var type = $(this).data("type");

      // Cập nhật nội dung modal dựa trên dữ liệu của item được click
      $("#modal-avatar").attr("src", avatar);
      $("#modal-fullname").text(fullname);
      $("#modal-location").text(location);
      $("#modal-description").html(description.replace(/\n/g, "<br>"));  // Chuyển đổi thành chuỗi
      $("#modal-deadline").text("Deadline: " + (deadline || ""));
      $("#modal-daylocation").text(dayLocation || "");
      $("#modal-daydescription").text(dayDescription || "");
      $("#modal-daysrequired").text("Days Required: " + (daysRequired || ""));
      $("#modal-replocation").text(repLocation || "");
      $("#modal-repdescription").text(repDescription || "");
      $("#modal-startdate").text("Start Date: " + (startDate || ""));
      $("#modal-months").text("Months: " + (months || ""));
      $("#modal-price").text(price || "");
      $("#modal-type").text(type || "");

      // Hiển thị/ẩn nội dung modal dựa trên loại yêu cầu
      if (type === "POST" || type === "VIDEO") {
          $("#modal-daysrequired").hide();
          $("#modal-startdate").hide();
          $("#modal-months").hide();
      } else if (type === "HIREBYDAY") {
          $("#modal-daysrequired").show();
          $("#modal-startdate").hide();
          $("#modal-months").hide();
          $("#modal-deadline").hide();
      } else if (type === "REPRESENTATIVE") {
          $("#modal-daysrequired").hide();
          $("#modal-startdate").show();
          $("#modal-months").show();
          $("#modal-deadline").hide();
      }

      // Cập nhật hiển thị loại yêu cầu
      $("#modal-type").text(type || "");
  });

  // Reset nội dung modal khi modal bị ẩn
  $("#viewMoreModal").on("hidden.bs.modal", function () {
      $("#modal-avatar").attr("src", "");
      $("#modal-fullname").text("");
      $("#modal-location").text("");
      $("#modal-description").text("");
      $("#modal-deadline").text("");
      $("#modal-daylocation").text("");
      $("#modal-daydescription").text("");
      $("#modal-daysrequired").text("");
      $("#modal-replocation").text("");
      $("#modal-repdescription").text("");
      $("#modal-startdate").text("");
      $("#modal-months").text("");
      $("#modal-price").text("");
      $("#modal-type").text("");
  });
});


// ================================================
function openModal() {
  $("#myModal").modal("show");
}

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
  console.log(selectedDate);
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

function replaceNewLinesWithBr(text) {
  return text.replace(/\n/g, '<br>');
}


document.addEventListener("DOMContentLoaded", updateCalendar);

async function submitPostRequest() {
  const location = document.getElementById("postLocation").value;
  const dateRequire = new Date().toISOString().split("T")[0];
  const deadline = document.getElementById("postDeadline").value;
  const description = replaceNewLinesWithBr(document.getElementById("postDescription").value);
  const money = document.getElementById("money-post").value;
  const requestData = {
    typeRequest: "POST",
    request: {
      recipientId: null,
      location: location,
      type: "POST",
      dateRequire: dateRequire,
      deadline: deadline,
      decription: description,
    },
    money: money,
  };

  await sendRequest(requestData);
}

async function submitVideoRequest() {
  const location = document.getElementById("videoLocation").value;
  const dateRequire = new Date().toISOString().split("T")[0];
  const deadline = document.getElementById("videoDeadline").value;
  const description = replaceNewLinesWithBr(document.getElementById("videoDescription").value);
  const money = document.getElementById("money-video").value;
  const requestData = {
    typeRequest: "VIDEO",
    request: {
      recipientId: null,
      location: location,
      type: "VIDEO",
      dateRequire: dateRequire,
      deadline: deadline,
      decription: description,
    },
    money: money,
  };

  await sendRequest(requestData);
}

async function submitHiretRequest() {
  const selectedDays = [];
  const checkboxes = document.querySelectorAll(".day input:checked");
  checkboxes.forEach((checkbox) => {
    const day = checkbox.nextElementSibling.innerText;
    const date = `${currentYear}-${currentMonth + 1}-${day}`;
    selectedDays.push(date);
  });

  if (selectedDays.length > 0) {
    const location = document.getElementById("hireLocation").value;
    const dateRequire = new Date().toISOString().split("T")[0];
    const description = replaceNewLinesWithBr(document.getElementById("hireDescription").value);
    const money = document.getElementById("money-hire").value;
    const requestData = {
      typeRequest: "HIREBYDAY",
      request: {
        recipientId: null,
        location: location,
        type: "HIREBYDAY",
        dateRequire: dateRequire,
        daysRequire: selectedDays,
        decription: description,
      },
      money: money,
    };

    await sendRequest(requestData);
  } else {
    alert("No days selected");
  }
}

async function submitRepresentativetRequest() {
  const location = document.getElementById("representativeLocation").value;
  const dateRequire = new Date().toISOString().split("T")[0];
  const dateStart = document.getElementById("representativeStart").value;
  const numberMonths = document.getElementById("representativeMonths").value;
  const description = replaceNewLinesWithBr(document.getElementById("representativeDescription").value);
  const money = document.getElementById("money-representative").value;
  const requestData = {
    typeRequest: "REPRESENTATIVE",
    request: {
      recipientId: null,
      location: location,
      type: "REPRESENTATIVE",
      dateRequire: dateRequire,
      dateStart: dateStart,
      numberMonths: numberMonths,
      decription: description,
    },
    money: money,
  };

  await sendRequest(requestData);
}


async function sendRequest(data) {
  try {
    console.log(data);
    const response = await fetch("/request/public", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify(data),
    });
    
    if (!response.ok) {
      throw new Error(`HTTP error! status: ${response.status}`);
    }

    const result = await response.json();
    alert(result.result);
    location.reload();
  } catch (error) {
    alert("An error occurred: " + error.message);
  }
}

async function applyPublicRequest(id) {
  if (confirm("Are you sure to apply for this job?")) {
    try {
      const response = await fetch(`/request/apply?requestId=${id}`, {
        method: "POST",
      });

      if (!response.ok) {
        const errorResult = await response.json();
        throw new Error(errorResult.error || `HTTP error! status: ${response.status}`);
      }

      const result = await response.json();
      alert(result.message);
    } catch (error) {
      alert("An error occurred: " + error.message);
    }
  }
}



document.addEventListener("DOMContentLoaded", updateCalendar);

function showContent(type) {
  // Add modal body content based on type
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

document.addEventListener("DOMContentLoaded", updateCalendar);
