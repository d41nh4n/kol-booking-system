package d41nh4n.google_image.demo.repository;

import d41nh4n.google_image.demo.dto.respone.ConversationExsisted;
import d41nh4n.google_image.demo.entity.UserConversation;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface UserConversationRepository extends JpaRepository<UserConversation, Long> {

    @Query("SELECT new d41nh4n.google_image.demo.dto.respone.ConversationExsisted( uc1.conversation.id, uc2.user.userId, u.username, u.avatarUrl, c.lastMessage) " +
           "FROM UserConversation uc1 " +
           "JOIN uc1.conversation c " +
           "JOIN UserConversation uc2 ON c.id = uc2.conversation.id " +
           "JOIN User u ON uc2.user.userId = u.userId " +
           "WHERE uc1.user.userId = :userId " +
           "AND uc2.user.userId <> :userId " +
           "ORDER BY c.updatedAt DESC")
    List<ConversationExsisted> findConversationsByUserId(@Param("userId") String userId);
}
