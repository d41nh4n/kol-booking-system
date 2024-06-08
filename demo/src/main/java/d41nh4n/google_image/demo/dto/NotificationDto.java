package d41nh4n.google_image.demo.dto;

import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;
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
    private boolean isRead;

    public NotificationDto(Long id, String referenceId, String content, ZonedDateTime createAt, boolean isRead) {
        this.id = id;
        this.referenceId = referenceId;
        this.content = content;
        this.createAt = createAt.toString();
        this.isRead = isRead;
    }

}

