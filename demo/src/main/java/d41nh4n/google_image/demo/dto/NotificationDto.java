package d41nh4n.google_image.demo.dto;

import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;

import d41nh4n.google_image.demo.entity.notification.Notification;
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

    public NotificationDto(Notification notification) {
        this.id = notification.getNotificationId();
        this.referenceId = notification.getReferenceId();
        this.content = notification.getContent();
        this.createAt = notification.getCreateAt().toString();
        this.type = notification.getType().toString();
    }
}
