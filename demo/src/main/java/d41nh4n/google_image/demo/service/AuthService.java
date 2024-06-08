package d41nh4n.google_image.demo.service;

import java.util.Date;

import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import com.auth0.jwt.exceptions.JWTVerificationException;

import d41nh4n.google_image.demo.entity.User.User;
import d41nh4n.google_image.demo.security.JwtDecoder;
import d41nh4n.google_image.demo.security.JwtIssuer;
import d41nh4n.google_image.demo.security.JwtToPrincipalConverter;
import d41nh4n.google_image.demo.security.UserPrincipal;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class AuthService {

    private final JwtToPrincipalConverter converter;
    private final JwtDecoder decoder;
    private final JwtIssuer issuer;
    private final AuthenticationManager authenticationManager;
    private final UserService userService;

    public String login(String username, String password) {
        try {
            var authentication = authenticationManager.authenticate(
                    new UsernamePasswordAuthenticationToken(username, password));
                   
            SecurityContextHolder.getContext().setAuthentication(authentication);
            var principal = (UserPrincipal) authentication.getPrincipal();

            String role = principal.getAuthorities()
                    .stream().map(grantedAuthority -> grantedAuthority.getAuthority())
                    .findFirst()
                    .orElseThrow(() -> new RuntimeException("User has no roles assigned"));

            var isLocked = principal.isLocked();

            var token = issuer.createAccessToken(principal.getUserId(), principal.getUsername(), role, isLocked);
            return token;
        } catch (AuthenticationException e) {
            System.out.println("Authentication failed: " + e.getMessage());
            throw new BadCredentialsException("Invalid username or password", e);
        }
    }

    public String generateAccessTokenFromRefreshToken(String refreshToken) throws JWTVerificationException {

        var principal = principalFromToken(refreshToken);
        if (principal == null) {
            return null;
        }
        String id = principal.getUserId();
        User user = userService.getUserById(id);
        return issuer.createAccessToken(id, user.getUsername(), user.getRole(),
                !user.isLocked());
    }

    public UserPrincipal principalFromToken(String tokenString) {
        try {
            // Valid token
            var decodeJwt = decoder.decode(tokenString);

            if (decodeJwt.getExpiresAt().before(new Date())) {

                System.err.println("JWT has expired.");

                return null;
            }
            var principalFromDecodeJwt = converter.convert(decodeJwt);

            return principalFromDecodeJwt;

        } catch (Exception e) {

            System.err.println("Failed to authenticate JWT: " + e.getMessage());

            return null;
        }
    }
}
