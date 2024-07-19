
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
import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.databind.ObjectMapper;

import d41nh4n.google_image.demo.dto.chatdto.ChatMessage;
import d41nh4n.google_image.demo.dto.chatdto.FileMessage;
import d41nh4n.google_image.demo.dto.respone.ConversationExsisted;
import d41nh4n.google_image.demo.dto.respone.ResponeUpload;
import d41nh4n.google_image.demo.entity.conversation.Conversation;
import d41nh4n.google_image.demo.entity.conversation.TypeConversation;
import d41nh4n.google_image.demo.entity.conversation.UserConversation;
import d41nh4n.google_image.demo.entity.user.User;
import d41nh4n.google_image.demo.mapper.MessageToMessageDto;
import d41nh4n.google_image.demo.model.UploadRespone;
import d41nh4n.google_image.demo.security.UserPrincipal;
import d41nh4n.google_image.demo.service.ChatMessageService;
import d41nh4n.google_image.demo.service.CloudinaryService;
import d41nh4n.google_image.demo.service.ConversationService;
import d41nh4n.google_image.demo.service.UserConversationService;
import d41nh4n.google_image.demo.service.UserService;
import d41nh4n.google_image.demo.validation.Utils;
import d41nh4n.google_image.demo.entity.conversation.Message;
import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;

import java.io.IOException;
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
    private final CloudinaryService cloudinaryService;

    @MessageMapping("/chat.sendMessage")
    public void processMessage(@Payload Map<String, Object> payload) throws IOException {
        String typeMessage = (String) payload.get("typeMessage");

        ObjectMapper mapper = new ObjectMapper();

        if (typeMessage.equals("TEXT")) {
            ChatMessage chatMessage = mapper.convertValue(payload.get("chatMessage"), ChatMessage.class);
            if (chatMessage != null && !chatMessage.getContent().isEmpty()) {
                handleChatMessage(chatMessage);
            }
        }

        if (typeMessage.equals("FILE")) {
            FileMessage fileMessage = mapper.convertValue(payload.get("fileMessage"), FileMessage.class);
            if (fileMessage != null && fileMessage.getContent() != null && !fileMessage.getContent().isEmpty()) {
                handleFileMessage(fileMessage);
            }
        }
    }

    @GetMapping("/chatbox")
    public String chatBox(@RequestParam(value = "userId", required = false) String userId, HttpServletRequest request,
            Model model) {
        try {

            Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
            UserPrincipal principal = (UserPrincipal) authentication.getPrincipal();
            int userSender = principal.getUserId();
            if (userId != null) {
                int userRecepientId = utils.stringToInt(userId);
                User userRecepient = userService.getUserById(userRecepientId);
                if (userRecepient.getRole().equalsIgnoreCase("USER")) {
                    chatMessageService.createAConversation(userSender, userRecepientId);
                }
            }
            List<ConversationExsisted> userConversations = userConversationService.findConversationByUserId(userSender);
            model.addAttribute("conversations", userConversations);
            return "chatbox";
        } catch (Exception e) {
            return "chatbox";
        }
    }

    @GetMapping("/getChat")
    public ResponseEntity<Map<String, Object>> getMessages(
            @RequestParam String conversationId,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "50") int size) {
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
    public ResponseEntity<Object> getUserChatted(@RequestParam int userId) {
        List<ConversationExsisted> userConversations = userConversationService.findConversationByUserId(userId);
        return ResponseEntity.ok(userConversations);
    }

    private void handleChatMessage(ChatMessage chatMessage) {
        String sender = chatMessage.getSender();
        String recipient = chatMessage.getRecipient();
        String conversationId = utils.generateChatRoomId(sender, recipient);
        Conversation conversation = conversationService.findConversationById(conversationId);
        User userSender = userService.getUserById(Integer.parseInt(sender));
        User userRecipient = userService.getUserById(Integer.parseInt(recipient));

        if (conversation == null) {
            createNewConversation(Integer.parseInt(sender), Integer.parseInt(recipient), conversationId);
        }

        ZonedDateTime zonedDateTime = ZonedDateTime.parse(chatMessage.getTimeStamp(), DateTimeFormatter.ISO_DATE_TIME);
        conversation.setLastMessage(chatMessage.getContent());
        conversation.setUpdatedAt(zonedDateTime);
        conversationService.save(conversation);

        Message message = new Message(null, chatMessage.getContent(), chatMessage.getType(), zonedDateTime, userSender,
                userRecipient, conversation);
        chatMessageService.save(message);
        chatMessage.setTimeStamp(zonedDateTime.toString());
        messagingTemplate.convertAndSendToUser(String.valueOf(chatMessage.getRecipient()), "/queue/messages",
                chatMessage);
    }

    private void handleFileMessage(FileMessage fileMessage) throws IOException {
        int sender = Integer.parseInt(fileMessage.getSender());
        int recipient = Integer.parseInt(fileMessage.getRecipient());
        String conversationId = utils.generateChatRoomId(String.valueOf(sender), String.valueOf(recipient));
        Conversation conversation = conversationService.findConversationById(conversationId);
        User userSender = userService.getUserById(sender);
        User userRecipient = userService.getUserById(recipient);

        if (conversation == null) {
            createNewConversation(sender, recipient, conversationId);
        }

        ZonedDateTime zonedDateTime = ZonedDateTime.parse(fileMessage.getTimeStamp(), DateTimeFormatter.ISO_DATE_TIME);
        String fileType = fileMessage.getType();

        if ("IMAGE".equals(fileType)) {
            conversation.setLastMessage("A IMG");
        } else if ("VIDEO".equals(fileType)) {
            conversation.setLastMessage("A VIDEO");
        } else if ("AUDIO".equals(fileType)) {
            conversation.setLastMessage("A AUDIO");
        } else if ("FILE".equals(fileType)) {
            conversation.setLastMessage("A FILE");
        }

        conversation.setUpdatedAt(zonedDateTime);
        conversationService.save(conversation);
        UploadRespone urlFile = cloudinaryService.handleFileMessage(fileMessage.getContent());
        Message message = new Message(null, urlFile.getUrl(), fileMessage.getType(), zonedDateTime, userSender,
                userRecipient, conversation);
        chatMessageService.save(message);
        fileMessage.setTimeStamp(zonedDateTime.toString());
        fileMessage.setContent(urlFile.getUrl());
        messagingTemplate.convertAndSendToUser(String.valueOf(fileMessage.getRecipient()), "/queue/messages",
                fileMessage);
    }

    private void createNewConversation(int sender, int recipient, String conversationId) {
        Conversation conversation = new Conversation();
        conversation.setId(conversationId);
        conversation.setCreatedAt(ZonedDateTime.now());
        conversation.setUpdatedAt(ZonedDateTime.now());
        conversation.setType(TypeConversation.PRIVATE);
        conversationService.save(conversation);

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
}