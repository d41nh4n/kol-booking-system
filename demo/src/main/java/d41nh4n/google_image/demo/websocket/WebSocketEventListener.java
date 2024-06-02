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
    private static ConcurrentHashMap<String, String> userSessionMap = new ConcurrentHashMap<>();

    @EventListener
    public void handleWebSocketConnectListener(SessionConnectEvent event) {
        StompHeaderAccessor accessor = StompHeaderAccessor.wrap(event.getMessage());    
        String token = accessor.getFirstNativeHeader("token");
        String userId = validTokenService.principalFromToken(token).getUserId();
        System.out.println("HandleConnect: " + userId);
        String sessionId = accessor.getSessionId();
        System.out.println(sessionId);
        if (userId != null) {
            userSessionMap.put(userId, sessionId);
        }
    }

    @EventListener
    public void handleWebSocketDisconnectListener(SessionDisconnectEvent event) {
        String sessionId = event.getSessionId();
        userSessionMap.entrySet().removeIf(entry -> sessionId.equals(entry.getValue()));
    }

    public static String getSessionIdByUserId(String userId) {
        return userSessionMap.get(userId);
    }
}
