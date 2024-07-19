package d41nh4n.google_image.demo.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.oauth2.client.userinfo.DefaultOAuth2UserService;
import org.springframework.security.oauth2.client.userinfo.OAuth2UserRequest;
import org.springframework.security.oauth2.core.OAuth2AuthenticationException;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.stereotype.Service;

import d41nh4n.google_image.demo.entity.user.User;
import d41nh4n.google_image.demo.oauth2.CustomOAuth2User;
import d41nh4n.google_image.demo.validation.Utils;

@Service
public class CustomOAuth2UserService extends DefaultOAuth2UserService {
    @Autowired
    private UserService userService;

    @Autowired
    private Utils utils;

    @Autowired
    private MailService mailService;

    @Override
    public OAuth2User loadUser(OAuth2UserRequest userRequest) throws OAuth2AuthenticationException {
        OAuth2User user = super.loadUser(userRequest);
        return new CustomOAuth2User(user);
    }

    public void processOAuthPostLogin(CustomOAuth2User customOAuth2User) {
        String gmail = customOAuth2User.getGmail();
        User user = userService.getUserByEmail(gmail);
        if (user == null) {
            String password = utils.renderCode(10);
            User userCreated = userService.createAAccount(gmail, gmail, password);
            String fullName = userCreated.getEmail().substring(0, userCreated.getEmail().indexOf("@"));
            userCreated.getProfile().setFullName(fullName);
            userService.save(userCreated);
            mailService.sendRegistrationEmail(user);
        }
    }
}
