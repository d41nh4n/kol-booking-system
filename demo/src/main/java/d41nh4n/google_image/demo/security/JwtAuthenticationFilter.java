package d41nh4n.google_image.demo.security;

import java.io.IOException;
import java.util.Date;
import java.util.Optional;

import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

import d41nh4n.google_image.demo.security.Principal.UserPrincipalAuthenticationToken;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.AllArgsConstructor;

@Component
@AllArgsConstructor
public class JwtAuthenticationFilter extends OncePerRequestFilter {
    private final JwtDecoder decoder;
    private final JwtToPrincipalConverter converter;
    private static final String TOKEN_COOKIE_NAME = "accessToken";

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain)
            throws ServletException, IOException {
        Optional<String> accessToken = getTokenFromCookies(request);

        if (accessToken.isPresent()) {
            try {
                var decodedJwt = decoder.decode(accessToken.get());

                if (decodedJwt.getExpiresAt().before(new Date())) {
                    removeTokenCookie(response);
                    System.err.println("JWT has expired.");
                } else {
                    var principalFromDecodedJwt = converter.convert(decodedJwt);
                    var userPrincipalAuthenticationToken = new UserPrincipalAuthenticationToken(principalFromDecodedJwt);
                    SecurityContextHolder.getContext().setAuthentication(userPrincipalAuthenticationToken);
                }
            } catch (Exception e) {
                System.err.println("Failed to authenticate JWT: " + e.getMessage());
                removeTokenCookie(response);
            }
        }

        filterChain.doFilter(request, response);
    }

    private Optional<String> getTokenFromCookies(HttpServletRequest request) {
        Cookie[] cookies = request.getCookies();

        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (TOKEN_COOKIE_NAME.equals(cookie.getName())) {
                    return Optional.of(cookie.getValue());
                }
            }
        }

        return Optional.empty();
    }

    private void removeTokenCookie(HttpServletResponse response) {
        Cookie cookie = new Cookie(TOKEN_COOKIE_NAME, "");
        cookie.setHttpOnly(true);
        cookie.setPath("/");
        cookie.setMaxAge(0);
        response.addCookie(cookie);
    }
}
