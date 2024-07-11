package d41nh4n.google_image.demo.service;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import d41nh4n.google_image.demo.entity.Comment;
import d41nh4n.google_image.demo.entity.user.User;
import d41nh4n.google_image.demo.exeption.InvalidNumber;
import d41nh4n.google_image.demo.exeption.InvalidRoleUser;
import d41nh4n.google_image.demo.exeption.RatingNotFoundException;
import d41nh4n.google_image.demo.repository.CommentRepository;
import d41nh4n.google_image.demo.validation.Utils;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class CommentService {

    private final CommentRepository commentRepository;
    private final UserService userService;
    private final Utils utils;

    public Page<Comment> getAllCommentByUserId(int userId, int pageNumber, int pageSize) {
        User user = userService.getUserById(userId);

        if (user == null) {
            return Page.empty();
        }
        Pageable pageable = PageRequest.of(pageNumber, pageSize, Sort.by("createdAt").descending());
        return commentRepository.findByReceiver(user, pageable);
    }

    public Comment save(Comment comment) {
        return commentRepository.save(comment);
    }

    public void delete(Comment comment) {
        commentRepository.delete(comment);
    }

    public double getAverageRating(int userId) {
        try {
            Double averageRating = commentRepository.findAverageRatingByReceiverId(userId);

            if (averageRating == null) {
                throw new RatingNotFoundException("Không tìm thấy bình luận cho người dùng với ID: " + userId);
            }
            return averageRating;
        } catch (Exception e) {
            throw new RuntimeException("Lỗi khi tính giá trị trung bình của rating", e);
        }
    }

    public int totalRatingByUserId(int userId) {
        User user = userService.getUserById(userId);
        if (user == null) {
            throw new InvalidNumber("User not found", null);
        }
        if (user.getRole().equalsIgnoreCase("USER")) {
            throw new InvalidRoleUser("Invalid user role!");
        }
        return commentRepository.findTotalRatingByReceiverId(userId);
    }
}