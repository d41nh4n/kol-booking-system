package com.example.demo.controller;

import java.util.List;
import java.util.stream.Collector;
import java.util.stream.Collectors;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.demo.dto.NotificationDto;
import com.example.demo.entity.notification.Notification;
import com.example.demo.entity.user.User;
import com.example.demo.service.NotificationService;
import com.example.demo.service.UserService;
import com.example.demo.validation.Utils;
import lombok.RequiredArgsConstructor;

@CrossOrigin(origins = "https://f4d3-2405-4802-7074-a350-69bf-92f1-f99c-73fa.ngrok-free.app")
@Controller
@RequiredArgsConstructor
public class NotificationController {

    private final NotificationService notificationService;
    private final UserService userService;
    private final Utils utils;

    @GetMapping("/notifications")
    public ResponseEntity<Object> getAllNotifications(@RequestParam(name = "page", required = false) String page) {
        int pageNumber = 0;
        if (page != null && !page.isEmpty()) {
            pageNumber = Integer.parseInt(page);
        }
        int pageSize = 20;
        int userId = utils.getPrincipal().getUserId();
        User user = userService.getUserById(userId);
        if (user != null) {
            Pageable pageable = PageRequest.of(pageNumber, pageSize);
            Page<Notification> notificationsPage = notificationService.findNotificationByUser(user, pageNumber,
                    pageSize);

            List<NotificationDto> notificationDtos = notificationsPage.getContent().stream()
                    .map(NotificationDto::new)
                    .collect(Collectors.toList());

            Page<NotificationDto> notificationPage = new PageImpl<>(notificationDtos, pageable,
                    notificationsPage.getTotalElements());

            return ResponseEntity.ok(notificationPage);
        }
        return ResponseEntity.ok(null);
    }

    public ResponseEntity<Object> readNotification(@RequestParam String userId) {

        return ResponseEntity.ok("success!");
    }
}
