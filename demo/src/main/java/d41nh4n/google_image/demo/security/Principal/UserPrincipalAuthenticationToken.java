package d41nh4n.google_image.demo.security.Principal;

import org.springframework.security.authentication.AbstractAuthenticationToken;

import d41nh4n.google_image.demo.security.UserPrincipal;



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
