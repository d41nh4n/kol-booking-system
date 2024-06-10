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
import d41nh4n.google_image.demo.entity.Notification.Notification;
import d41nh4n.google_image.demo.entity.Notification.UserNotification;
import d41nh4n.google_image.demo.entity.Notification.UserNotificationId;
import d41nh4n.google_image.demo.repository.NotificationRepository;
import d41nh4n.google_image.demo.repository.UserRepository;
import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.Setter;

@Service
@Setter
@Getter
@RequiredArgsConstructor
public class NotificationService {

    private final SimpMessagingTemplate messagingTemplate;
    private final NotificationRepository notificationRepository;

    public void save(UserNotification notification) {
        notificationRepository.save(notification);
    }

    public UserNotification getById(UserNotificationId userNotificationId) {
        return notificationRepository.findById(userNotificationId).orElseThrow(null);
    }

    public List<UserNotification> getAll() {
        List<UserNotification> notifications = notificationRepository.findAll();
        if (notifications == null || notifications.isEmpty()) {
            return new ArrayList<>();
        }
        return notifications;
    }

    public Page<NotificationDto> getUserNotificationById(String userId) {
        Pageable sortedByCreateAtDesc = PageRequest.of(0, Integer.MAX_VALUE, Sort.by("createAt").descending());
        Page<NotificationDto> notifications = notificationRepository.getUserNotificationById(userId,
                sortedByCreateAtDesc);
        if (notifications == null || notifications.isEmpty()) {
            return Page.empty();
        }
        return notifications;
    }

    public void processNotification(String userId, NotificationDto notificationDto) {
        messagingTemplate.convertAndSendToUser(userId, "/queue/notification", notificationDto);
    }
}
