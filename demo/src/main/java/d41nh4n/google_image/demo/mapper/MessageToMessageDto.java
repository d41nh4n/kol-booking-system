package d41nh4n.google_image.demo.mapper;

import d41nh4n.google_image.demo.dto.ChatMessage;
import d41nh4n.google_image.demo.entity.Message;

public final class MessageToMessageDto {

    public static ChatMessage chatMessage(Message message) {
        ChatMessage chatMessageDto = new ChatMessage();
        chatMessageDto.setContent(message.getContent());
        chatMessageDto.setSender(message.getSender().getUserId());
        chatMessageDto.setRecipient(message.getRecipient().getUserId());
        chatMessageDto.setTimeStamp(message.getTimestamp().toString());
        return chatMessageDto;
    }
}
