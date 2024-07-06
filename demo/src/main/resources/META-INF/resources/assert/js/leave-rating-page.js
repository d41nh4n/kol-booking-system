async function submitComment(event) {
    event.preventDefault();
    
    const form = document.getElementById('commentForm');
    const formData = new FormData(form);
    
    const data = {
        userId: parseInt(formData.get('userId')), // Chuyển đổi thành số nguyên
        rating: parseInt(formData.get('rating')), // Chuyển đổi thành số nguyên
        comment: formData.get('comment')
    };
    console.log(data);
    try {
        const response = await fetch('/comment/comment-rating', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(data)
        });
        
        if (!response.ok) {
            throw new Error('Network response was not ok ' + response.statusText);
        }
        
        const result = await response.json();
        alert(result.message);
        
        // Redirect to the request/finish page
        window.location.href = '/request/finish';
    } catch (error) {
        alert('An error occurred: ' + error.message);
    }
}
