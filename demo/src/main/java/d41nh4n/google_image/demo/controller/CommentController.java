package d41nh4n.google_image.demo.controller;

import java.util.List;
import java.util.stream.Collectors;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import d41nh4n.google_image.demo.dto.CommentDto;
import d41nh4n.google_image.demo.entity.Comment;
import d41nh4n.google_image.demo.service.CommentService;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("/comment")
public class CommentController {
        private final CommentService commentService;

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
}
