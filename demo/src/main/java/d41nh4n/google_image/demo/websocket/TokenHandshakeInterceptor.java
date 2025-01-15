package d41nh4n.google_image.demo.websocket;

import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.http.server.ServerHttpRequest;
import org.springframework.http.server.ServerHttpResponse;
import org.springframework.web.socket.WebSocketHandler;
import org.springframework.web.socket.server.HandshakeInterceptor;

import d41nh4n.google_image.demo.validation.ValidTokenService;

public class TokenHandshakeInterceptor implements HandshakeInterceptor {

    private final ValidTokenService validTokenService;

    public TokenHandshakeInterceptor(ValidTokenService validTokenService) {
        this.validTokenService = validTokenService;
    }

    @Override
    public boolean beforeHandshake(ServerHttpRequest request, ServerHttpResponse response, WebSocketHandler wsHandler,
            Map<String, Object> attributes) throws Exception {
        String token = request.getHeaders().getFirst("token");
        if (token == null || (!validTokenService.isTokenExpired(token) && validTokenService.principalFromToken(token) == null)) {
            response.setStatusCode(HttpStatus.UNAUTHORIZED);
            return false;
        }
        return true;
    }

    @Override
    public void afterHandshake(ServerHttpRequest request, ServerHttpResponse response, WebSocketHandler wsHandler,
            Exception exception) {
        // Không cần thực hiện gì sau khi bắt tay hoàn tất
    }
}
