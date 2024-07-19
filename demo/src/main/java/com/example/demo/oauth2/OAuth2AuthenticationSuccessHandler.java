package d41nh4n.google_image.demo.oauth2;

import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.stereotype.Component;
import com.google.common.base.Optional;

import d41nh4n.google_image.demo.dto.userdto.UserInfo;
import d41nh4n.google_image.demo.entity.user.User;
import d41nh4n.google_image.demo.security.UserPrincipal;
import d41nh4n.google_image.demo.service.AuthService;
import d41nh4n.google_image.demo.service.CustomOAuth2UserService;
import d41nh4n.google_image.demo.service.UserService;
import org.springframework.security.core.Authentication;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Component
public class OAuth2AuthenticationSuccessHandler implements AuthenticationSuccessHandler {

    @Autowired
    private CustomOAuth2UserService customOAuth2UserService;

    @Autowired
    private UserService userService;

    // @Autowired
    // private AuthService authService;

    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
            Authentication authentication) throws IOException, ServletException {
        CustomOAuth2User oAuth2User = (CustomOAuth2User) authentication.getPrincipal();
        String accountGmail = oAuth2User.getGmail();
        // Kiểm tra xem người dùng có trong cơ sở dữ liệu không
        User user = userService.getUserByEmail(accountGmail);
        if (user != null) {
            if (user.getRole().equals("ADMIN")) {
                // genarateAndSetCookies(oAuth2User, response);
                response.sendRedirect("/admin/home");
            } else if (user.getRole().equals("USER") || (user.getRole().equals("KOL"))) {
                // genarateAndSetCookies(oAuth2User, response);
                response.sendRedirect("/");
            }
        } else {
            // Người dùng không tồn tại trong cơ sở dữ liệu, tạo tài khoản mới
            customOAuth2UserService.processOAuthPostLogin(oAuth2User);
            // genarateAndSetCookies(oAuth2User, response);
            response.sendRedirect("/");
        }
    }

    // private void genarateAndSetCookies(CustomOAuth2User oAuth2User,
    // HttpServletResponse response) {
    // User user = userService.getUserByEmail(oAuth2User.getGmail());
    // String accessToken = authService.login(null, null);
    // if (user != null) {
    // String accessToken = authService.loginByEmail(user);
    // Cookie cookie = new Cookie("accessToken", accessToken);
    // cookie.setPath("/");
    // cookie.setMaxAge(24 * 60 * 60);
    // response.addCookie(cookie);
    // }
    // }
}
