package com.example.demo.repository;

import com.example.demo.dto.respone.ConversationExsisted;
import com.example.demo.entity.conversation.UserConversation;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface UserConversationRepository extends JpaRepository<UserConversation, Long> {

    @Query("SELECT NEW com.example.demo.dto.respone.ConversationExsisted(" +
            "c.id AS conversationId, " +
            "uc2.user.id AS recipientId, " +
            "p.fullName AS fullName, " +
            "p.avatarUrl AS avatarUrl, " +
            "c.lastMessage AS lastMessage) " +
            "FROM UserConversation uc1 " +
            "JOIN uc1.conversation c " +
            "JOIN UserConversation uc2 ON c.id = uc2.conversation.id " +
            "JOIN User u ON uc2.user.id = u.id " +
            "JOIN u.profile p " +
            "WHERE uc1.user.id = :userId " +
            "AND uc2.user.id <> :userId " +
            "ORDER BY c.updatedAt DESC")
    List<ConversationExsisted> findConversationsByUserId(@Param("userId") int userId);
}
