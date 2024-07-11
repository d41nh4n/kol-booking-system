package com.example.demo.dto.chatdto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class ChatMessage {

    private String sender;
    private String recipient;
    private String content;
    private String type;
    private String timeStamp;
}
