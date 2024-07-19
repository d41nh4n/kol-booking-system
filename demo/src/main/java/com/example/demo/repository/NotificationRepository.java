package d41nh4n.google_image.demo.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import d41nh4n.google_image.demo.entity.notification.Notification;
import d41nh4n.google_image.demo.entity.user.User;

public interface NotificationRepository extends JpaRepository<Notification, Long> {
    Page<Notification> findByUser(User user, Pageable pageable);
}
