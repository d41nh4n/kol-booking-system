package com.example.demo.security;

import java.util.Collections;
import java.util.List;

import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.stereotype.Component;
import com.auth0.jwt.interfaces.DecodedJWT;

@Component
public class JwtToPrincipalConverter {

    public UserPrincipal convert(DecodedJWT jwt) {
        List<SimpleGrantedAuthority> authorityList = getAuthorities(jwt);

        return UserPrincipal.builder()
                .userId(jwt.getClaim("id").asInt())
                .fullName(jwt.getClaim("name").asString())
                .authorities(authorityList)
                .isLocked(jwt.getClaim("isLocked").asBoolean())
                .avatar(jwt.getClaim("avatar").asString())
                .build();
    }

    private List<SimpleGrantedAuthority> getAuthorities(DecodedJWT jwt) {
        String role = jwt.getClaim("role").asString();
        return Collections.singletonList(new SimpleGrantedAuthority(role));
    }
}
