const button = $("#hire-button");
$(function () {
  $(".superbox-img").click(function () {
    $("#showPhoto .modal-body").html($(this).clone());
    $("#showPhoto").modal("show");
  });
});

$(document).ready(function () {
  $(".nav-tabs li").click(function (event) {
    event.preventDefault();

    $(".nav-tabs li").removeClass("active");
    $(".tab-pane").removeClass("active");

    $(this).addClass("active");
    $(".tab-pane").eq($(this).index()).addClass("active");
  });
});

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
  } else {
    const index = selectedDaysList.indexOf(dateStr);
    if (index > -1) {
      selectedDaysList.splice(index, 1);
    }
  }

  if (selectedDaysList.length > maxDays) {
    alert("The maximum number of days you can select is " + maxDays);
    event.target.checked = false;
    const lastSelectedDate = selectedDaysList.pop();
    document.querySelector(
      `input[data-date='${lastSelectedDate}']`
    ).checked = false;
  }
}

function enforceMaxDaysSelection() {
  const maxDays = parseInt(document.getElementById("max-days").value);

  while (selectedDaysList.length > maxDays) {
    const lastSelectedDate = selectedDaysList.pop();
    document.querySelector(
      `input[data-date='${lastSelectedDate}']`
    ).checked = false;
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

async function submitPostRequest() {
  console.log("Function submitPostRequest() is called");
  const recipientId = document.getElementById("user-recipient-request").value; // Lấy giá trị từ input có id là userId
  const location = document.getElementById("postLocation").value;
  const dateRequire = new Date().toISOString().split("T")[0]; // Ngày hiện tại
  const deadline = document.getElementById("postDeadline").value;
  const description = document.getElementById("postDescription").value;
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
  const recipientId = document.getElementById("user-recipient-request").value // Bạn có thể lấy giá trị này từ input nếu cần
  const location = document.getElementById("videoLocation").value;
  const dateRequire = new Date().toISOString().split("T")[0]; // Ngày hiện tại
  const deadline = document.getElementById("videoDeadline").value;
  const description = document.getElementById("videoDescription").value;

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
    const recipientId = document.getElementById("user-recipient-request").value; // Bạn có thể lấy giá trị này từ input nếu cần
    const location = document.getElementById("hireLocation").value;
    const dateRequire = selectedDaysList[0]; // Giả sử ngày yêu cầu là ngày đầu tiên được chọn
    const description = document.getElementById("hireDescription").value;

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
  const recipientId = document.getElementById("user-recipient-request").value; // Bạn có thể lấy giá trị này từ input nếu cần
  const location = document.getElementById("representativeLocation").value;
  const dateRequire = new Date().toISOString().split("T")[0]; // Ngày hiện tại
  const dateStart = document.getElementById("representativeStart").value; // Ngày bắt đầu
  const numberMonths = document.getElementById("representativeMonths").value;
  const description = document.getElementById(
    "representativeDescription"
  ).value;

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
    const response = await fetch("/request", {
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
    console.log(result.result);
    alert(result.result);
    const recipientId = document.getElementById("user-recipient-request").value;
    window.location.href = `https://localhost:443/chatbox?userId=${recipientId}`
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

document.addEventListener("DOMContentLoaded", () => {
  updateCalendar(); // Call this function to initialize the calendar for 'by_date' modal
});
