document.addEventListener("DOMContentLoaded", function() {
    const modal = document.getElementById("myModal");
    const btn = document.getElementById("openModal");
    const span = document.getElementsByClassName("close")[0];
    const form = document.getElementById("notificationForm");
    const notificationsDiv = document.getElementById("notifications");

    btn.onclick = function() {
        modal.style.display = "block";
    };

    span.onclick = function() {
        modal.style.display = "none";
    };

    window.onclick = function(event) {
        if (event.target === modal) {
            modal.style.display = "none";
        }
    };

    form.onsubmit = function(event) {
        event.preventDefault();
        const message = document.getElementById("message").value;
        const userId = document.getElementById("userId").value;

        fetch('/api/notifications', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({ message: message, notificationDate: new Date() })
        }).then(response => {
            if (response.ok) {
                return response.json();
            }
            throw new Error('Network response was not ok.');
        }).then(notification => {
            return fetch('/api/user-notifications', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({ notificationId: notification.notificationId, userId: userId })
            });
        }).then(response => {
            if (response.ok) {
                const li = document.createElement("li");
                li.textContent = message;
                notificationsDiv.querySelector("ul").appendChild(li);
                modal.style.display = "none";
                form.reset();
            } else {
                throw new Error('Network response was not ok.');
            }
        }).catch(error => {
            console.error('There was a problem with the fetch operation:', error);
        });
    };

    // Fetch notifications when the page is loaded
    fetch('/api/notifications')
        .then(response => response.json())
        .then(data => {
            const ul = notificationsDiv.querySelector("ul");
            ul.innerHTML = ''; // Clear the list to avoid duplicates
            data.forEach(notification => {
                const li = document.createElement("li");
                li.textContent = notification.message;
                ul.appendChild(li);
            });
        })
        .catch(error => console.error('Error fetching notifications:', error));
});
