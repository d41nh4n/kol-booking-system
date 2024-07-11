package com.example.demo.service;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import com.example.demo.entity.Comment;
import com.example.demo.entity.user.User;
import com.example.demo.exeption.InvalidNumber;
import com.example.demo.exeption.InvalidRoleUser;
import com.example.demo.exeption.RatingNotFoundException;
import com.example.demo.repository.CommentRepository;
import com.example.demo.validation.Utils;
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