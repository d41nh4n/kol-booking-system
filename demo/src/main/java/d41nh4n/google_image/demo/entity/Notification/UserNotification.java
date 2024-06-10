package d41nh4n.google_image.demo.entity.Notification;

import jakarta.persistence.Column;
import jakarta.persistence.EmbeddedId;
import jakarta.persistence.Entity;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Setter
@Getter
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "user_notifications")
public class UserNotification {

    @EmbeddedId
    private UserNotificationId id;

    @Column(name = "is_read", nullable = false)
    private boolean isRead = false;
}
