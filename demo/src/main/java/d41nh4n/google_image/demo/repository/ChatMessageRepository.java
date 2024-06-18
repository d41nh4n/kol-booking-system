package d41nh4n.google_image.demo.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

import d41nh4n.google_image.demo.entity.conversation.Conversation;
import d41nh4n.google_image.demo.entity.conversation.Message;


public interface ChatMessageRepository extends JpaRepository<Message, Long> {
    Page<Message> findByConversation(Conversation conversation, Pageable pageable);
}
