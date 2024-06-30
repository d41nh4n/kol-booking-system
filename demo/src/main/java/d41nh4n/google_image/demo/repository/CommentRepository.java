package d41nh4n.google_image.demo.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

import d41nh4n.google_image.demo.entity.Comment;
import d41nh4n.google_image.demo.entity.user.User;

public interface CommentRepository extends JpaRepository<Comment, Integer> {

    Page<Comment> findByReceiver(User receiver, Pageable pageable);
}
