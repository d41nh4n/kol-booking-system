    

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
                username: search
            },
            success: function (data) {
                displaySuggestions(data.list);
            },
            error: function (xhr) {
                // Handle error
            }
        });
    }
}

function displaySuggestions(users) {
    removeElements();
    users.forEach(user => {
        let listItem = document.createElement("li");
        listItem.classList.add("suggestions-item");
        listItem.textContent = user.username; 
        listItem.setAttribute("data-id", user.id);
        listItem.addEventListener("click", () => {
            window.location.href = "/profile?userId=" + user.id;
        });
        document.querySelector(".suggestions-list").appendChild(listItem);
    });
}

function removeElements() {
    let items = document.querySelectorAll(".suggestions-item");
    items.forEach((item) => {
        item.remove();
    });
}

function fetchNotifications() {
    
    

    $.ajax({
        url: "/notifications",
        type: "get",
        success: function (data) {
            displayNotifications(data.notifications);
        },
        error: function (xhr) {
            // Handle error
        }
    });
}

function displayNotifications(notifications) {
    removeNotificationElements();
    notifications.forEach(notification => {
        let listItem = document.createElement("li");
        listItem.classList.add("notifications-item");
        listItem.textContent = notification.message;
        listItem.setAttribute("data-id", notification.id);
        document.querySelector(".notifications").appendChild(listItem);
    });
    document.querySelector(".notifications").style.display = "block";
}

function removeNotificationElements() {
    let items = document.querySelectorAll(".notifications-item");
    items.forEach((item) => {
        item.remove();
    });
}

$(document).ready(function(){
    $(document).click(function(event) { 
        if(!$(event.target).closest('.notification-container').length) {
            if($('.notifications').is(":visible")) {
                $('.notifications').hide();
            }
        }        
    });
});