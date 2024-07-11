document.addEventListener('DOMContentLoaded', function() {
    // Lấy danh sách tất cả các nút ban/unban
    const banUnbanButtons = document.querySelectorAll('.ban-unban-btn');

    // Lặp qua từng nút và cập nhật trạng thái
    banUnbanButtons.forEach(button => {
        // Kiểm tra xem trạng thái banAction có được lưu trong localStorage không
        const userId = button.getAttribute('data-id');
        const savedAction = localStorage.getItem(`banAction_${userId}`);
        
        // Nếu có, cập nhật lại nội dung của nút với trạng thái được lưu
        if (savedAction) {
            button.textContent = savedAction.charAt(0).toUpperCase() + savedAction.slice(1);
            button.setAttribute('data-action', savedAction);
        }

        // Lưu trữ trạng thái banAction ban đầu vào localStorage khi nhấn vào nút
        button.addEventListener('click', function() {
            const action = button.getAttribute('data-action');
            const newAction = action === 'ban' ? 'unban' : 'ban';
            const endpoint = `/admin/users/${action}/${userId}`;

            fetch(endpoint, { method: 'POST' })
                .then(response => {
                    if (response.ok) {
                        button.textContent = newAction.charAt(0).toUpperCase() + newAction.slice(1); // Cập nhật lại nút với hành động mới
                        button.setAttribute('data-action', newAction);
                        localStorage.setItem(`banAction_${userId}`, newAction); // Lưu trạng thái mới vào localStorage
                    } else {
                        alert('Failed to update user status');
                    }
                })
                .catch(error => {
                    console.error('Error updating user status:', error);
                });
        });
    });

    // Kiểm tra xem trang có được tải lại từ trang "view" không
    // Nếu có, cập nhật lại trạng thái banAction và nội dung của nút
    window.addEventListener('pageshow', function(event) {
        if (event.persisted) {
            banUnbanButtons.forEach(button => {
                const userId = button.getAttribute('data-id');
                const initialAction = localStorage.getItem(`banAction_${userId}`); // Lấy lại trạng thái banAction ban đầu từ localStorage

                if (initialAction) {
                    button.textContent = initialAction.charAt(0).toUpperCase() + initialAction.slice(1); // Cập nhật lại nút với trạng thái banAction ban đầu
                    button.setAttribute('data-action', initialAction); // Cập nhật lại data attribute
                }
            });
        }
    });
});
