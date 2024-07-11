package com.example.demo.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.demo.dto.request.LoginDto;
import com.example.demo.dto.userdto.UserInfo;
import com.example.demo.entity.user.Profile;
import com.example.demo.entity.user.User;
import com.example.demo.security.UserPrincipal;
import com.example.demo.service.AuthService;
import com.example.demo.service.UserService;
import com.example.demo.validation.Utils;
import com.example.demo.validation.ValidTokenService;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("/login")
public class AuthController {

    private final AuthService authService;
    private final ValidTokenService validTokenService;
    private final UserService userService;
    private final PasswordEncoder passwordEncoder;
    private final Utils utils;

    @PostMapping("/auth")
    public String login(@ModelAttribute LoginDto loginDto, Model model, HttpServletResponse response) {
        try {
            String accessToken = authService.login(loginDto.getUsername(), loginDto.getPassword());
            UserPrincipal userPrincipal = validTokenService.principalFromToken(accessToken);
            if (userPrincipal != null) {
                UserInfo userInfo = new UserInfo(userPrincipal.getUserId(), userPrincipal.getFullName(),
                        userPrincipal.getRoles(),
                        userPrincipal.getAvatar());
                model.addAttribute("userInfor", userInfo);
                Cookie cookie = new Cookie("accessToken", accessToken);
                cookie.setPath("/");
                cookie.setMaxAge(24 * 60 * 60);
                response.addCookie(cookie);
            }
            return "redirect:/";
        } catch (AuthenticationException e) {
            return "redirect:/login/form?error=true";
        }
    }

    @GetMapping("/form")
    public String loginForm(HttpServletRequest request, Model model,
            @RequestParam(value = "error", required = false) Boolean error,
            @RequestParam(value = "success", required = false) Boolean success,
            @RequestParam(value = "userExist", required = false) Boolean userExist) {
        String accessToken = utils.getTokenFromCookies(request);

        if (accessToken != null && !accessToken.isEmpty() && !validTokenService.isTokenExpired(accessToken)) {
            return "redirect:/";
        }

        if (Boolean.TRUE.equals(error)) {
            model.addAttribute("errorMessage", "Invalid username or password");
        }
        if (Boolean.TRUE.equals(success)) {
            model.addAttribute("success", "Register success!");
        }
        if (Boolean.TRUE.equals(userExist)) {
            model.addAttribute("errorMessage", "Username exist!");
        }

        return "login-form";
    }

    @GetMapping("/logout")
    public String logout(HttpServletRequest request, HttpServletResponse response) {
        utils.removeTokenCookie(response);
        return "redirect:/login/form";
    }

    @GetMapping("/register/form")
    public String formRegister() {
        return "register";
    }

    @PostMapping("/register")
    public String register(@ModelAttribute LoginDto loginDto) {
        if (userService.getUserByUsername(loginDto.getUsername()) != null || loginDto.getPassword().isEmpty()) {
            return "redirect:/login/form?userExist=true";
        }

        String encodedPassword = passwordEncoder.encode(loginDto.getPassword());

        // Create and persist the User entity
        User user = new User();
        user.setUsername(loginDto.getUsername());
        user.setPasswordHash(encodedPassword);
        user.setRole("USER");
        user = userService.save(user);
        Profile profile = new Profile();
        profile.setUser(user);
        profile.setProfileId(user.getUserId());
        profile.setFullName(utils.renderUserName(10));
        profile.setAvatarUrl(
                "https://png.pngtree.com/element_our/20200610/ourlarge/pngtree-default-avatar-image_2237213.jpg");
        user.setProfile(profile);
        userService.save(user);
        userService.save(profile);

        return "redirect:/login/form?success=true";
    }

    @GetMapping("/change-password")
    public String changePasswordForm() {
        return "change-password";
    }

    @PostMapping("/change-password")
    public ResponseEntity<Map<String, String>> changePassword(@RequestBody Map<String, String> payload) {
        String oldPass = payload.get("oldPassword");
        String newPass = payload.get("newPassword");
        int userId = utils.getPrincipal().getUserId();
        User user = userService.getUserById(userId);
        Map<String, String> response = new HashMap<>();

        if (passwordEncoder.matches(oldPass, user.getPasswordHash())) {
            String newPassHash = passwordEncoder.encode(newPass);
            user.setPasswordHash(newPassHash);
            userService.save(user);
            response.put("message", "Password changed successfully.");
            return ResponseEntity.ok(response);
        } else {
            response.put("error", "Old password is incorrect.");
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(response);
        }
    }
}