package d41nh4n.google_image.demo.controller;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

import d41nh4n.google_image.demo.dto.respone.UserInfoRespone;
import d41nh4n.google_image.demo.entity.User.User;
import d41nh4n.google_image.demo.mapper.UserToUserDto;
import d41nh4n.google_image.demo.security.UserPrincipal;
import d41nh4n.google_image.demo.service.UserService;
import lombok.RequiredArgsConstructor;

@Component
@ControllerAdvice
@RequiredArgsConstructor
public class GlobalControllerAdvice {

    private final UserService userService;

    @ModelAttribute
    public void addUserAttributes(Model model) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication != null && authentication.isAuthenticated()
                && !"anonymousUser".equals(authentication.getPrincipal())) {
            Object principal = authentication.getPrincipal();
            if (principal instanceof UserPrincipal) {
                UserPrincipal userDetails = (UserPrincipal) principal;
                User user = userService.getUserById(userDetails.getUserId());
                UserInfoRespone userInfo = UserToUserDto.mapToUserInfoResponse(user);
                model.addAttribute("userInfo", userInfo);
            }

        }
    }
}