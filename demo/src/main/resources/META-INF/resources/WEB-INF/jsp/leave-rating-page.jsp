
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Leave Comment</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        .star-rating {
            display: flex;
            flex-direction: row-reverse;
            justify-content: center;
        }

        .star-rating input {
            display: none;
        }

        .star-rating label {
            font-size: 2em;
            color: #ddd;
            cursor: pointer;
        }

        .star-rating input:checked ~ label,
        .star-rating label:hover,
        .star-rating label:hover ~ label {
            color: #ffd700;
        }

        .comment-body {
            margin-top: 120px;
        }
    </style>
</head>
<body>
<%@ include file="navbar.jsp" %>
<div class="container comment-body">
    <div class="card">
        <div class="card-body">
            <h3 class="card-title">Leave Comment</h3>
            
            <!-- User information section -->
            <div class="user-info mb-4">
                <img src="${userBeRated.avatar}" alt="User Avatar" class="img-thumbnail" style="width: 100px; height: 100px;">
                <h4>${userBeRated.fullName}</h4>
            </div>
            
            <form id="commentForm" onsubmit="submitComment(event)">
                <input type="hidden" id="userId" name="userId" value="${userBeRated.id}">
                <div class="form-group">
                    <label for="rating">Rate the Place</label>
                    <div class="star-rating">
                        <input type="radio" id="5-stars" name="rating" value="5" />
                        <label for="5-stars" class="star">&#9733;</label>
                        <input type="radio" id="4-stars" name="rating" value="4" />
                        <label for="4-stars" class="star">&#9733;</label>
                        <input type="radio" id="3-stars" name="rating" value="3" />
                        <label for="3-stars" class="star">&#9733;</label>
                        <input type="radio" id="2-stars" name="rating" value="2" />
                        <label for="2-stars" class="star">&#9733;</label>
                        <input type="radio" id="1-stars" name="rating" value="1" />
                        <label for="1-stars" class="star">&#9733;</label>
                    </div>
                </div>
                <div class="form-group">
                    <label for="comment">Your Comment</label>
                    <textarea class="form-control" id="comment" name="comment" rows="4"></textarea>
                </div>
                <button type="submit" class="btn btn-primary">Submit Comment</button>
            </form>
        </div>
    </div>
</div>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script src="../../assert/js/leave-rating-page.js"></script>
</body>
</html>
