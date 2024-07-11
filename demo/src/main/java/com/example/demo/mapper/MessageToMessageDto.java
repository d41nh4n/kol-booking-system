package com.example.demo.mapper;

import com.example.demo.dto.chatdto.ChatMessage;
import com.example.demo.entity.conversation.Message;

public final class MessageToMessageDto {

    public static ChatMessage chatMessage(Message message) {
        ChatMessage chatMessageDto = new ChatMessage();
        chatMessageDto.setContent(message.getContent());
        chatMessageDto.setType(message.getType());
        chatMessageDto.setSender(String.valueOf(message.getSender().getUserId()));
        chatMessageDto.setRecipient(String.valueOf(message.getRecipient().getUserId()));
        chatMessageDto.setTimeStamp(message.getTimestamp().toString());
        return chatMessageDto;
    }
}
