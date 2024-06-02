package d41nh4n.google_image.demo.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import d41nh4n.google_image.demo.entity.Conversation;

public interface ConversationRepository extends JpaRepository<Conversation, String> {

    
}
