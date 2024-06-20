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
                name: search
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