package com.example.demo.dto.respone;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Setter
@Getter
@AllArgsConstructor
@NoArgsConstructor
public class ConversationExsisted {
    private String conversationId;
    private int recipientId;
    private String recipientName;
    private String avatarUrl;
    private String lastMessage;
}
