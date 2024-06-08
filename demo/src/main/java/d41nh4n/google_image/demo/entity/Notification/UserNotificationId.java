package d41nh4n.google_image.demo.entity.Notification;

import java.io.Serializable;
import java.util.Objects;

import d41nh4n.google_image.demo.entity.User.User;
import jakarta.persistence.Column;
import jakarta.persistence.Embeddable;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Setter
@Getter
@AllArgsConstructor
@NoArgsConstructor
@Embeddable
public class UserNotificationId implements Serializable {

    @Column(name = "userId")
    private String userId;

    @ManyToOne
    @JoinColumn(name = "userId", referencedColumnName = "user_id", insertable=false, updatable=false)
    private User user;

    @Column(name = "notificationId")
    private Long notificationId;

    @ManyToOne
    @JoinColumn(name = "notificationId", referencedColumnName = "notification_id", insertable=false, updatable=false)
    private Notification notification;

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        UserNotificationId that = (UserNotificationId) o;
        return Objects.equals(userId, that.userId) &&
                Objects.equals(notificationId, that.notificationId);
    }

    @Override
    public int hashCode() {
        return Objects.hash(userId, notificationId);
    }
}
