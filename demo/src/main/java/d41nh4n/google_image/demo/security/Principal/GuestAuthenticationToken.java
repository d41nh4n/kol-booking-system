package d41nh4n.google_image.demo.security.Principal;
import org.springframework.security.authentication.AbstractAuthenticationToken;
import org.springframework.security.core.GrantedAuthority;

import java.util.Collection;

public class GuestAuthenticationToken extends AbstractAuthenticationToken {

    private final Object principal;

    public GuestAuthenticationToken() {
        super(null);
        this.principal = "GUEST";
        setAuthenticated(false);
    }

    public GuestAuthenticationToken(Collection<? extends GrantedAuthority> authorities) {
        super(authorities);
        this.principal = "GUEST";
        setAuthenticated(true);
    }

    @Override
    public Object getCredentials() {
        return null;
    }

    @Override
    public Object getPrincipal() {
        return this.principal;
    }
}
