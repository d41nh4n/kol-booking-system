package d41nh4n.google_image.demo.service;

import java.util.Collections;
import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import d41nh4n.google_image.demo.entity.Message;
import d41nh4n.google_image.demo.entity.Conversation.Conversation;
import d41nh4n.google_image.demo.repository.ChatMessageRepository;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ChatMessageService {

    private final ChatMessageRepository chatMessageRepository;
    private final ConversationService conversationService;

    public void save(Message chatMessage) {
        chatMessageRepository.save(chatMessage);
    }

    public Page<Message> getMessagesInConversation(String conversationId, int pageNumber, int pageSize) {

        Conversation conversation = conversationService.findConversationById(conversationId);
        if (conversation != null) {
            Pageable sortedByTimeStampDesc = PageRequest.of(pageNumber, pageSize, Sort.by("timestamp").descending());
            return chatMessageRepository.findByConversation(conversation, sortedByTimeStampDesc);
        } else {
            return Page.empty();
        }
    }
}
