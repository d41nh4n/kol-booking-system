package d41nh4n.google_image.demo.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Service;

import d41nh4n.google_image.demo.dto.NotificationDto;
import d41nh4n.google_image.demo.entity.notification.Notification;
import d41nh4n.google_image.demo.entity.user.User;
import d41nh4n.google_image.demo.repository.NotificationRepository;
import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.Setter;

@Service
@Setter
@Getter
@RequiredArgsConstructor
public class NotificationService {

    private final NotificationRepository notificationRepository;

    public Page<Notification> findNotificationByUser(User user, int pageNumber, int pageSize) {
        Pageable pageable = PageRequest.of(pageNumber, pageSize, Sort.by("createAt").descending());
        return notificationRepository.findByUser(user, pageable);
    }

    public Notification save(Notification notification) {
        return notificationRepository.save(notification);
    }

    public Notification createNotification(Notification notification) {
        return notificationRepository.save(notification);
    }
}
