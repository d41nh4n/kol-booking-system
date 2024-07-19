package d41nh4n.google_image.demo.validation;

import java.util.Date;

import org.springframework.stereotype.Service;

import d41nh4n.google_image.demo.security.JwtDecoder;
import d41nh4n.google_image.demo.security.JwtToPrincipalConverter;
import d41nh4n.google_image.demo.security.UserPrincipal;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ValidTokenService {
    
    private final JwtToPrincipalConverter converter;
    private final JwtDecoder decoder;

    public UserPrincipal principalFromToken(String tokenString) {
        try {
            var decodeJwt = decoder.decode(tokenString);
            return converter.convert(decodeJwt);
        } catch (Exception e) {
            System.err.println("Failed to authenticate JWT: " + e.getMessage());
            return null;
        }
    }

    public boolean isTokenExpired(String tokenString) {
        try {
            var decodeJwt = decoder.decode(tokenString);
            return decodeJwt.getExpiresAt().before(new Date());
        } catch (Exception e) {
            System.err.println("Failed to decode JWT: " + e.getMessage());
            return true;
        }
    }
}
