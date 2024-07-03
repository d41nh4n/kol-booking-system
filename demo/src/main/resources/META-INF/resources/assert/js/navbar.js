function searchByName(param) {
  var search = param.value.trim();
  if (search === "") {
    removeElements();
    return;
  } else {
    $.ajax({
      url: "/findUser",
      type: "get",
      data: {
        name: search,
      },
      success: function (data) {
        displaySuggestions(data.list);
      },
      error: function (xhr) {
        // Handle error
      },
    });
  }
}

function displaySuggestions(users) {
  removeElements();
  users.forEach((user) => {
    let listItem = document.createElement("li");
    listItem.classList.add("suggestions-item");

    let userSpan = document.createElement("span");
    userSpan.textContent = user.fullname;

    listItem.setAttribute("data-id", user.id);
    listItem.addEventListener("click", () => {
      window.location.href = "/profile?userId=" + user.id;
    });
    listItem.appendChild(userSpan);

    // Append listItem to suggestions list
    document.querySelector(".suggestions-list").appendChild(listItem);
  });
}

function removeElements() {
  let items = document.querySelectorAll(".suggestions-item");
  items.forEach((item) => {
    item.remove();
  });
}

let currentPage = 0;
let totalPages = 0;
let isLoading = false;

document
  .querySelector(".dropdown-toggle")
  .addEventListener("click", function (event) {
    event.preventDefault();
    loadNotifications();
  });

  function loadNotifications() {
    if (isLoading || (currentPage >= totalPages && totalPages !== 0)) return;
    isLoading = true;
  
    fetch(`https://localhost/notifications?page=${currentPage}`)
      .then((response) => response.json())
      .then((data) => {
        let dropdownMenu = document.getElementById("notificationDropdown");
        
        if (data.content.length === 0) {
          isLoading = false;
          return;
        }
        
        if (currentPage === 0) {
          dropdownMenu.innerHTML = "";
        }
  
        // Kiểm tra nếu data.content là mảng rỗng
        
        
        data.content.forEach((notification) => {
          let listItem = document.createElement("li");
          let link = document.createElement("a");
          if (notification.type === "REQUEST") {
            link.href = "/request/pending";
          } else if (notification.type === "MONEY") {
            link.href = "#";
          } else if (notification.type === "JOIN_REQUEST") {
            link.href = `/request/candidate-list?requestId=${notification.referenceId}`;
          } else if (notification.type === "ACCOUNT") {
            link.href = "#";
          }
  
          link.textContent = notification.content;
          listItem.appendChild(link);
          dropdownMenu.appendChild(listItem);
        });
  
        currentPage++;
        totalPages = data.totalPages;
        isLoading = false;
      })
      .catch((error) => {
        console.error("Error fetching notifications:", error);
        isLoading = false;
      });
  }
  
document
  .getElementById("notificationDropdown")
  .addEventListener("scroll", function () {
    let dropdownMenu = document.getElementById("notificationDropdown");
    if (
      dropdownMenu.scrollTop + dropdownMenu.clientHeight >=
      dropdownMenu.scrollHeight
    ) {
      loadNotifications();
    }
  });
