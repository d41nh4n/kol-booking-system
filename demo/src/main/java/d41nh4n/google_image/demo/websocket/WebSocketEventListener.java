package d41nh4n.google_image.demo.websocket;

import org.springframework.context.event.EventListener;
import org.springframework.messaging.simp.stomp.StompHeaderAccessor;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.messaging.SessionConnectEvent;
import org.springframework.web.socket.messaging.SessionDisconnectEvent;
import d41nh4n.google_image.demo.validation.ValidTokenService;
import lombok.RequiredArgsConstructor;

import java.util.concurrent.ConcurrentHashMap;

@Component
@RequiredArgsConstructor
public class WebSocketEventListener {
    private final ValidTokenService validTokenService;

    private static ConcurrentHashMap<Integer, String> userSessionMap = new ConcurrentHashMap<>();

    @EventListener
    public void handleWebSocketConnectListener(SessionConnectEvent event) {
        StompHeaderAccessor accessor = StompHeaderAccessor.wrap(event.getMessage());
        String token = accessor.getFirstNativeHeader("token");
        if (token != null) {
            Integer userId = validTokenService.principalFromToken(token).getUserId();
            if (userId != null) {
                String sessionId = accessor.getSessionId();
                userSessionMap.put(userId, sessionId);
                System.out.println("User connected: userId=" + userId + ", sessionId=" + sessionId);
            }
        }
    }

    @EventListener
    public void handleWebSocketDisconnectListener(SessionDisconnectEvent event) {
        String sessionId = event.getSessionId();
        userSessionMap.entrySet().removeIf(entry -> sessionId.equals(entry.getValue()));
        System.out.println("User disconnected: sessionId=" + sessionId);
    }

    public static String getSessionIdByUserId(Integer userId) {
        return userSessionMap.get(userId);
    }
}
