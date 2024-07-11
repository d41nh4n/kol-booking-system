package com.example.demo.service;

import java.util.Date;

import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import com.auth0.jwt.exceptions.JWTVerificationException;

import com.example.demo.dto.userdto.UserDto;
import com.example.demo.security.JwtDecoder;
import com.example.demo.security.JwtIssuer;
import com.example.demo.security.JwtToPrincipalConverter;
import com.example.demo.security.UserPrincipal;
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
            var token = issuer.createAccessToken(principal.getUserId(), principal.getFullName(), principal.getRoles(),
                    principal.isLocked(), principal.getAvatar());
            return token;
        } catch (AuthenticationException e) {
            System.out.println("Authentication failed: " + e.getMessage());
            throw new BadCredentialsException("Invalid username or password", e);
        }
    }

    // public String generateAccessTokenFromRefreshToken(String refreshToken) throws
    // JWTVerificationException {

    // var principal = principalFromToken(refreshToken);
    // if (principal == null) {
    // return null;
    // }
    // String id = principal.getUserId();
    // User user = userService.getUserById(id);
    // return issuer.createAccessToken(id, user.getUsername(), user.getRole(),
    // !user.isLocked());
    // }

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
