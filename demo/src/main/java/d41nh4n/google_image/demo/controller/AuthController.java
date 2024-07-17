package d41nh4n.google_image.demo.controller;

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

import d41nh4n.google_image.demo.dto.request.LoginDto;
import d41nh4n.google_image.demo.dto.request.RegisterDto;
import d41nh4n.google_image.demo.dto.respone.ResponeJson;
import d41nh4n.google_image.demo.dto.userdto.UserInfo;
import d41nh4n.google_image.demo.entity.VerifyCode;
import d41nh4n.google_image.demo.entity.user.Profile;
import d41nh4n.google_image.demo.entity.user.User;
import d41nh4n.google_image.demo.security.UserPrincipal;
import d41nh4n.google_image.demo.service.AuthService;
import d41nh4n.google_image.demo.service.UserService;
import d41nh4n.google_image.demo.service.VerifyCodeService;
import d41nh4n.google_image.demo.validation.Utils;
import d41nh4n.google_image.demo.validation.ValidTokenService;
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
            if (userPrincipal == null) {
                return "redirect:/login/form?error=true";
            }
            if (userPrincipal.getRoles().equalsIgnoreCase("KOL") || userPrincipal.getRoles().equalsIgnoreCase("USER")) {
                return "redirect:/";
            } else if (userPrincipal.getRoles().equals("ADMIN")) {
                return "redirect:/admin/home";
            }
            return "redirect:/login/form?error=true";

        } catch (AuthenticationException e) {
            return "redirect:/login/form?error=true";
        }
    }

    @GetMapping("/form")
    public String loginForm(HttpServletRequest request, Model model,
            @RequestParam(value = "error", required = false) Boolean error,
            @RequestParam(value = "success", required = false) Boolean success,
            @RequestParam(value = "userExist", required = false) Boolean userExist,
            @RequestParam(value = "registerSuccess", required = false) Boolean registerSuccess) {
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
        if (Boolean.TRUE.equals(registerSuccess)) {
            model.addAttribute("success", "Check email to verify code!");
        }

        return "login-form";
    }

    @GetMapping("/logout")
    public String logout(HttpServletRequest request, HttpServletResponse response) {
        utils.removeTokenCookie(response);
        return "redirect:/login/form";
    }

    @PostMapping("/api/register-get-code")
    public ResponseEntity<ResponeJson> getRegisterCode(
            @RequestParam(name = "userName") String userName,
            @RequestParam(name = "password") String password,
            @RequestParam(name = "email") String email) {

        return userService.getRegisterCode(userName, password, email);
    }

    @PostMapping("/api/register")
    public ResponseEntity<ResponeJson> createAAccount(
            @RequestParam(name = "userName") String userName,
            @RequestParam(name = "password") String password,
            @RequestParam(name = "email") String email,
            @RequestParam(name = "codeId") int codeId,
            @RequestParam(name = "code") String code) {

        return userService.registerUser(userName, password, email, codeId, code);
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