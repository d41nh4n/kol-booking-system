package com.example.demo.security.Principal;

import org.springframework.security.authentication.AbstractAuthenticationToken;

import com.example.demo.security.UserPrincipal;

public class UserPrincipalAuthenticationToken extends AbstractAuthenticationToken {

    private final UserPrincipal principal;

    public UserPrincipalAuthenticationToken(UserPrincipal principal) {
        super(principal.getAuthorities());
        this.principal = principal;
        setAuthenticated(true);
    }

    @Override
    public Object getCredentials() {
        throw new UnsupportedOperationException("Unimplemented method 'getCredentials'");
    }

    @Override
    public UserPrincipal getPrincipal() {
        return principal;
    }

}
