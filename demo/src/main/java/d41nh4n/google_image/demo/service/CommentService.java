package d41nh4n.google_image.demo.service;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import d41nh4n.google_image.demo.entity.Comment;
import d41nh4n.google_image.demo.entity.user.User;
import d41nh4n.google_image.demo.repository.CommentRepository;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class CommentService {

    private final CommentRepository commentRepository;
    private final UserService userService;

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
}
