package d41nh4n.google_image.demo.security;

import java.time.Instant;
import java.time.temporal.ChronoUnit;

import org.springframework.stereotype.Component;

import com.auth0.jwt.JWT;
import com.auth0.jwt.algorithms.Algorithm;

import lombok.AllArgsConstructor;

@Component
@AllArgsConstructor
public class JwtIssuer {

    private final JwtProperties jwtProperties;

    public String createAccessToken(int id, String fullname, String role, boolean isLocked, String avatar) {
        return JWT.create()
                .withClaim("id", id)
                .withExpiresAt(Instant.now().plus(java.time.Duration.of(1, ChronoUnit.HOURS)))
                .withClaim("name", fullname)
                .withClaim("role", role)
                .withClaim("isLocked", isLocked)
                .withClaim("avatar", avatar)
                .sign(Algorithm.HMAC256(jwtProperties.getSecretKey()));
    }

    public String createRefreshToken(String id) {
        return JWT.create()
                .withSubject(id)
                .withExpiresAt(Instant.now().plus(java.time.Duration.of(30, ChronoUnit.DAYS)))
                .sign(Algorithm.HMAC256(jwtProperties.getSecretKey()));
    }
}
