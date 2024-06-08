package d41nh4n.google_image.demo.controller;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import d41nh4n.google_image.demo.dto.NotificationDto;
import d41nh4n.google_image.demo.service.NotificationService;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class NotificationController {

    private final NotificationService notificationService;

    @GetMapping("/notifications")
    public ResponseEntity<Object> getAllNotifications(@RequestParam(value = "userId", required = false) String userId) {
        System.out.println("notifications!");
        if (userId.trim() == "" || userId == null || userId.isEmpty()) {
            return new ResponseEntity<>("Invalid userId", HttpStatus.BAD_REQUEST);
        }
        Page<NotificationDto> notification = notificationService.getUserNotificationById(userId);
     System.out.println(notification);
        return ResponseEntity.ok(notification);
    }

    public ResponseEntity<Object> readNotification(@RequestParam String userId) {
        
        return ResponseEntity.ok("success!");
    }
}
