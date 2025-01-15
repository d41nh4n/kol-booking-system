package d41nh4n.google_image.demo.security;

import java.io.IOException;
import java.util.Date;
import java.util.Optional;

import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

import d41nh4n.google_image.demo.security.Principal.UserPrincipalAuthenticationToken;
import d41nh4n.google_image.demo.validation.Utils;
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
    private final Utils utils;

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain)
            throws ServletException, IOException {
        String accessToken = utils.getTokenFromCookies(request);

        if (accessToken != null && !accessToken.isEmpty()) {
            try {
                var decodedJwt = decoder.decode(accessToken);

                if (decodedJwt.getExpiresAt().before(new Date())) {
                    utils.removeTokenCookie(response);
                } else {
                    var principalFromDecodedJwt = converter.convert(decodedJwt);
                    if (!principalFromDecodedJwt.isLocked()) {
                        var userPrincipalAuthenticationToken = new UserPrincipalAuthenticationToken(
                                principalFromDecodedJwt);
                        SecurityContextHolder.getContext().setAuthentication(userPrincipalAuthenticationToken);
                    }
                }
            } catch (Exception e) {
                System.err.println("Failed to authenticate JWT: " + e.getMessage());
                utils.removeTokenCookie(response);
            }
        }

        filterChain.doFilter(request, response);
    }
}
