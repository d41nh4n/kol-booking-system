
package d41nh4n.google_image.demo.controller;

import org.springframework.data.domain.Page;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import d41nh4n.google_image.demo.dto.ChatMessage;
import d41nh4n.google_image.demo.dto.respone.ConversationExsisted;
import d41nh4n.google_image.demo.entity.Conversation.Conversation;
import d41nh4n.google_image.demo.entity.Conversation.Message;
import d41nh4n.google_image.demo.entity.Conversation.TypeConversation;
import d41nh4n.google_image.demo.entity.Conversation.UserConversation;
import d41nh4n.google_image.demo.entity.User.User;
import d41nh4n.google_image.demo.mapper.MessageToMessageDto;
import d41nh4n.google_image.demo.security.UserPrincipal;
import d41nh4n.google_image.demo.service.ChatMessageService;
import d41nh4n.google_image.demo.service.ConversationService;
import d41nh4n.google_image.demo.service.UserConversationService;
import d41nh4n.google_image.demo.service.UserService;
import d41nh4n.google_image.demo.validation.Utils;
import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequiredArgsConstructor
public class ChatController {

    private final SimpMessagingTemplate messagingTemplate;
    private final ChatMessageService chatMessageService;
    private final ConversationService conversationService;
    private final UserService userService;
    private final UserConversationService userConversationService;
    private final Utils utils;
    @MessageMapping("/chat.sendMessage")
    public void processMessage(@Payload ChatMessage chatMessage) {
        String sender = chatMessage.getSender();
        String recipient = chatMessage.getRecipient();
        String conversationId = utils.generateChatRoomId(sender, recipient);
        System.out.println("conversation Id : "+conversationId);
        Conversation conversation = conversationService.findConversationById(conversationId);
        User userSender = userService.getUserById(sender);
        User userRecipient = userService.getUserById(recipient);
        if (conversation == null) {
            // create new conversation
            conversation = new Conversation();
            conversation.setId(conversationId);
            conversation.setCreatedAt(ZonedDateTime.now());
            conversation.setUpdatedAt(ZonedDateTime.now());
            conversation.setType(TypeConversation.PRIVATE);
            conversationService.save(conversation);

            // add user to conversation
            User userA = userService.getUserById(sender);
            User userB = userService.getUserById(recipient);

            UserConversation userConversationSender = new UserConversation();
            userConversationSender.setUser(userA);
            userConversationSender.setConversation(conversation);
            userConversationService.save(userConversationSender);

            UserConversation userConversationRecipient = new UserConversation();
            userConversationRecipient.setUser(userB);
            userConversationRecipient.setConversation(conversation);
            userConversationService.save(userConversationRecipient);
        }
        
        ZonedDateTime zonedDateTime = ZonedDateTime.parse(chatMessage.getTimeStamp(), DateTimeFormatter.ISO_DATE_TIME);
        conversation.setLastMessage(chatMessage.getContent());
        conversation.setUpdatedAt(zonedDateTime);
        conversationService.save(conversation);

        Message message = new Message(null, chatMessage.getContent(), zonedDateTime, userSender,
                userRecipient, conversation);
        chatMessageService.save(message);
        chatMessage.setTimeStamp(zonedDateTime.toString());
        messagingTemplate.convertAndSendToUser(
                chatMessage.getRecipient(), "/queue/messages",
                chatMessage);
    }

    @GetMapping("/chatbox")
    public String chatBox(@RequestParam(value = "userId", required = false) String userId, HttpServletRequest request,
            Model model) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        UserPrincipal principal = (UserPrincipal) authentication.getPrincipal();
        String userSender = principal.getUserId();

        if (userId != null && !userId.trim().isEmpty()) {
            String conversationId = utils.generateChatRoomId(userSender, userId);
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
                User userA = userService.getUserById(userId);
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
        List<ConversationExsisted> userConversations = userConversationService.findConversationByUserId(userSender);
        System.out.println(userConversations.size());
        model.addAttribute("conversations", userConversations);
        return "chatbox";
    }

    @GetMapping("/getChat")
    public ResponseEntity<Map<String, Object>> getMessages(
            @RequestParam String conversationId,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "20") int size) {
        System.out.println(conversationId);
        Map<String, Object> res = new HashMap<>();
        Page<Message> messages = chatMessageService.getMessagesInConversation(conversationId, page, size);
        Page<ChatMessage> messageDtos = messages.map(message -> {
            ChatMessage messageDto = MessageToMessageDto.chatMessage(message);
            return messageDto;
        });

        res.put("message", messageDtos.getContent());
        res.put("conversation", conversationId);

        return new ResponseEntity<>(res, HttpStatus.OK);
    }

    @GetMapping("/getUserChatted")
    public ResponseEntity<Object> getUserChatted(@RequestParam String userId) {
        List<ConversationExsisted> userConversations = userConversationService.findConversationByUserId(userId);
        return ResponseEntity.ok(userConversations);
    }
}
