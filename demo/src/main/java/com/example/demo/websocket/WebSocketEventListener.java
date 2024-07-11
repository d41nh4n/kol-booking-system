package com.example.demo.websocket;

import org.springframework.context.event.EventListener;
import org.springframework.messaging.simp.stomp.StompHeaderAccessor;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.messaging.SessionConnectEvent;
import org.springframework.web.socket.messaging.SessionDisconnectEvent;
import com.example.demo.validation.ValidTokenService;
import lombok.RequiredArgsConstructor;

import java.util.concurrent.ConcurrentHashMap;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Component
@RequiredArgsConstructor
public class WebSocketEventListener {
    private static final Logger logger = LoggerFactory.getLogger(WebSocketEventListener.class);
    private final ValidTokenService validTokenService;
    private static ConcurrentHashMap<Integer, String> userSessionMap = new ConcurrentHashMap<>();

    @EventListener
    public void handleWebSocketConnectListener(SessionConnectEvent event) {
        StompHeaderAccessor accessor = StompHeaderAccessor.wrap(event.getMessage());
        String token = accessor.getFirstNativeHeader("token");
        if (token != null) {
            try {
                Integer userId = validTokenService.principalFromToken(token).getUserId();
                if (userId != null) {
                    String sessionId = accessor.getSessionId();
                    userSessionMap.put(userId, sessionId);
                    logger.info("User connected: userId={}, sessionId={}", userId, sessionId);
                } else {
                    logger.warn("Invalid userId from token.");
                }
            } catch (Exception e) {
                logger.error("Error while processing token: {}", e.getMessage());
            }
        } else {
            logger.warn("Token is missing.");
        }
    }

    @EventListener
    public void handleWebSocketDisconnectListener(SessionDisconnectEvent event) {
        String sessionId = event.getSessionId();
        userSessionMap.entrySet().removeIf(entry -> sessionId.equals(entry.getValue()));
        logger.info("User disconnected: sessionId={}", sessionId);
    }

    public static String getSessionIdByUserId(Integer userId) {
        return userSessionMap.get(userId);
    }
}
