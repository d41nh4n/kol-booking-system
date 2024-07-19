package d41nh4n.google_image.demo.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import d41nh4n.google_image.demo.entity.Comment;
import d41nh4n.google_image.demo.entity.user.User;

public interface CommentRepository extends JpaRepository<Comment, Integer> {

    Page<Comment> findByReceiver(User receiver, Pageable pageable);

    @Query("SELECT AVG(c.ratingValue) FROM Comment c WHERE c.receiver.id = :receiverId")
    Double findAverageRatingByReceiverId(@Param("receiverId") Integer receiverId);

    @Query("SELECT COUNT(c.ratingValue) FROM Comment c WHERE c.receiver.id = :receiverId")
    Integer findTotalRatingByReceiverId(@Param("receiverId") Integer receiverId);

}
