package d41nh4n.google_image.demo.service;

import java.time.ZonedDateTime;
import java.util.Collections;
import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import d41nh4n.google_image.demo.entity.conversation.Conversation;
import d41nh4n.google_image.demo.entity.conversation.Message;
import d41nh4n.google_image.demo.entity.conversation.TypeConversation;
import d41nh4n.google_image.demo.entity.conversation.UserConversation;
import d41nh4n.google_image.demo.entity.user.User;
import d41nh4n.google_image.demo.repository.ChatMessageRepository;
import d41nh4n.google_image.demo.validation.Utils;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ChatMessageService {

    private final ChatMessageRepository chatMessageRepository;
    private final ConversationService conversationService;
    private final UserConversationService userConversationService;
    private final UserService userService;
    private final Utils utils;
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

    public void createAConversation(int userSender, int userRecipient) {
        String conversationId = utils.generateChatRoomId(String.valueOf(userSender), String.valueOf(userRecipient));
        Conversation conversation = conversationService.findConversationById(conversationId);
        if (conversation == null) {
            // create new conversation
            Conversation newConversation = new Conversation();
            newConversation.setId(conversationId);
            newConversation.setCreatedAt(ZonedDateTime.now());
            newConversation.setUpdatedAt(ZonedDateTime.now());
            newConversation.setType(TypeConversation.PRIVATE);
            conversationService.save(newConversation);

            // add user to conversation
            User userA = userService.getUserById((userRecipient));
            User userB = userService.getUserById(userSender);

            UserConversation userConversationSender = new UserConversation();
            userConversationSender.setUser(userA);
            userConversationSender.setConversation(newConversation);
            userConversationService.save(userConversationSender);

            UserConversation userConversationRecipient = new UserConversation();
            userConversationRecipient.setUser(userB);
            userConversationRecipient.setConversation(newConversation);
            userConversationService.save(userConversationRecipient);
        }
    }
}
