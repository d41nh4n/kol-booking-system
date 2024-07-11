package com.example.demo.dto;

import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;

import com.example.demo.entity.notification.Notification;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@NoArgsConstructor
@ToString
public class NotificationDto {
    private Long id;
    private String referenceId;
    private String content;
    private String createAt;
    private String type;
    private String urlAvatar;

    public NotificationDto(Notification notification) {
        this.id = notification.getNotificationId();
        this.referenceId = notification.getReferenceId();
        this.content = notification.getContent();
        this.createAt = notification.getCreateAt().toString();
        this.type = notification.getType().toString();
    }
}
