package d41nh4n.google_image.demo.service;

import org.springframework.stereotype.Service;

import d41nh4n.google_image.demo.entity.Conversation;
import d41nh4n.google_image.demo.repository.ConversationRepository;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ConversationService {

    private final ConversationRepository conversationRepository;

    public Conversation findConversationById(String id) {
        return conversationRepository.findById(id).orElse(null);
    }

    public void save(Conversation conversation) {
        conversationRepository.save(conversation);
    }
    
    
}
