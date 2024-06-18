// package d41nh4n.google_image.demo.repository;

// import org.springframework.data.domain.Page;
// import org.springframework.data.domain.Pageable;
// import org.springframework.data.jpa.repository.JpaRepository;
// import org.springframework.data.repository.query.Param;
// import org.springframework.data.jpa.repository.Query;

// import d41nh4n.google_image.demo.dto.NotificationDto;
// import d41nh4n.google_image.demo.entity.notification.UserNotification;

// public interface NotificationRepository extends
// JpaRepository<UserNotification> {
// @Query("SELECT new
// d41nh4n.google_image.demo.dto.NotificationDto(n1.notificationId,
// n1.referenceId, n1.content, n1.createAt, n2.isRead) "+
// "FROM Notification n1 INNER JOIN UserNotification n2 ON n1.notificationId =
// n2.id.notificationId "+
// "WHERE n2.id.userId = :userId"
// )
// Page<NotificationDto> getUserNotificationById(@Param("userId") String userId,
// Pageable pageable);
// }
