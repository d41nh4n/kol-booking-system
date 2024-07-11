document.addEventListener('DOMContentLoaded', function() {
    const banUnbanButtons = document.querySelectorAll('.ban-unban-btn');

    banUnbanButtons.forEach(button => {
        button.addEventListener('click', function() {
            const userId = button.getAttribute('data-id');
            const action = button.getAttribute('data-action');
            const newAction = action === 'ban' ? 'unban' : 'ban';
            const endpoint = `/admin/users/${action}/${userId}`;

            fetch(endpoint, { method: 'POST' })
                .then(response => {
                    if (response.ok) {
                        button.textContent = newAction.charAt(0).toUpperCase() + newAction.slice(1);
                        button.setAttribute('data-action', newAction);
                        localStorage.setItem(`banAction_${userId}`, newAction);
                    } else {
                        alert('Failed to update user status');
                    }
                })
                .catch(error => {
                    console.error('Error updating user status:', error);
                });
        });

        window.addEventListener('pageshow', function(event) {
            if (event.persisted) {
                const userId = button.getAttribute('data-id');
                const initialAction = localStorage.getItem(`banAction_${userId}`);

                if (initialAction) {
                    button.textContent = initialAction.charAt(0).toUpperCase() + initialAction.slice(1);
                    button.setAttribute('data-action', initialAction);
                }
            }
        });
    });
});
