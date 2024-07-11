package com.example.demo.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.demo.dto.CommentDto;
import com.example.demo.dto.CommentRatingDto;
import com.example.demo.dto.userdto.UserInfo;
import com.example.demo.entity.Comment;
import com.example.demo.entity.request.Request;
import com.example.demo.entity.user.User;
import com.example.demo.service.CommentService;
import com.example.demo.service.RequestService;
import com.example.demo.service.UserService;
import com.example.demo.validation.Utils;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("/comment")
public class CommentController {
        private final RequestService requestService;
        private final CommentService commentService;
        private final UserService userService;
        private final SimpMessagingTemplate messagingTemplate;
        private final Utils utils;

        @GetMapping
        public ResponseEntity<?> getAllComment(@RequestParam(name = "userId") int userId,
                        @RequestParam(defaultValue = "0") int page,
                        @RequestParam(defaultValue = "5") int size) {
                Page<Comment> comments = commentService.getAllCommentByUserId(userId, page, size);
                List<CommentDto> commentDtoList = comments.getContent().stream()
                                .map(comment -> new CommentDto(comment))
                                .collect(Collectors.toList());
                Page<CommentDto> commentDtoPage = new PageImpl<>(commentDtoList, comments.getPageable(),
                                comments.getTotalElements());
                return ResponseEntity.ok(commentDtoPage);
        }

        @PostMapping("/comment-rating")
        public ResponseEntity<Map<String, String>> submitComment(@RequestBody CommentRatingDto requestBody) {
                Map<String, String> response = new HashMap<>();

                User commenter = userService.getUserById(utils.getPrincipal().getUserId());
                User receiver = userService.getUserById(requestBody.getUserId());

                if (commenter == null || receiver == null) {
                        response.put("message", "Invalid user information");
                        return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(response);
                }

                // tạo 1 comment mới
                Comment comment = new Comment();
                comment.setCommentContent(requestBody.getComment());
                comment.setRatingValue(requestBody.getRating());
                comment.setCommenter(commenter);
                comment.setReceiver(receiver);
                commentService.save(comment);

                // gửi 1 thông báo cho người đc commnet
                messagingTemplate.convertAndSendToUser(String.valueOf(receiver.getUserId()),
                                "/queue/notification",
                                "You have new notification");
                response.put("message", "Comment submitted successfully");

                // tính lại tổng rating của người đc rating
                double averageRating = commentService.getAverageRating(receiver.getUserId());
                receiver.getProfile().setAverageRating(averageRating);
                userService.save(receiver);

                return ResponseEntity.ok(response);
        }

        @GetMapping("/rating-page")
        public String rating(@RequestParam(name = "requestId") int requestId, Model model) {
                Request request = requestService.findRequestById(requestId);
                if (request == null) {
                        return "redirect:/request/finish";
                }

                UserInfo userDto = new UserInfo(request.getResponder());
                model.addAttribute("userBeRated", userDto);
                return "leave-rating-page";
        }

}
