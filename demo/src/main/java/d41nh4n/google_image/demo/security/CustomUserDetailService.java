package d41nh4n.google_image.demo.security;

import java.util.List;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Component;
import d41nh4n.google_image.demo.service.UserService;
import lombok.RequiredArgsConstructor;

@Component
@RequiredArgsConstructor
public class CustomUserDetailService implements UserDetailsService {

    private final UserService service;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        var user = service.getUserByUsername(username);
        return UserPrincipal.builder()
                .userId(user.getUserId())
                .userName(user.getUsername())
                .fullName(user.getProfile().getFullName())
                .password(user.getPasswordHash())
                .authorities(List.of(new SimpleGrantedAuthority(user.getRole())))
                .avatar(user.getProfile().getAvatarUrl())
                .isLocked(user.isLocked())
                .build();
    }
}
