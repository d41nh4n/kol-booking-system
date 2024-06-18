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

function submitSelection() {
  if (selectedDaysList.length > 0) {
    alert("Selected days: " + selectedDaysList.join(", "));
  } else {
    alert("No days selected");
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
