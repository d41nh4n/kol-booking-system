package d41nh4n.google_image.demo.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.repository.query.Param;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import d41nh4n.google_image.demo.dto.request.UserInfor;
import d41nh4n.google_image.demo.dto.respone.UserFindedBySearch;
import d41nh4n.google_image.demo.dto.respone.UserInfoRespone;
import d41nh4n.google_image.demo.dto.respone.VerifyStatus;
import d41nh4n.google_image.demo.entity.VerifyCode;
import d41nh4n.google_image.demo.entity.User.User;
import d41nh4n.google_image.demo.mapper.UserToUserDto;
import d41nh4n.google_image.demo.model.Mail;
import d41nh4n.google_image.demo.security.UserPrincipal;
import d41nh4n.google_image.demo.service.MailService;
import d41nh4n.google_image.demo.service.UserService;
import d41nh4n.google_image.demo.service.VerifyCodeService;
import d41nh4n.google_image.demo.validation.Utils;
import d41nh4n.google_image.demo.validation.Utils;
import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("/")
public class UserController {

    private final MailService mailService;
    private final UserService userService;
    private final VerifyCodeService verifyCodeService;
    private final Utils utils;

    @GetMapping()
    public String index(Model model, HttpServletRequest request) {
        return "home";
    }

    @GetMapping("/infor")
    public String login(Model model, HttpServletRequest request,
            @RequestParam(value = "invalidEmail", required = false) Boolean invalidEmail,
            @RequestParam(value = "emailExist", required = false) Boolean emailExist) {

        if (Boolean.TRUE.equals(invalidEmail)) {
            model.addAttribute("invalidEmail", "Invalid email!");
        }
        if (Boolean.TRUE.equals(emailExist)) {
            model.addAttribute("emailExist", "Existed email!");
        }
        return "infor";
    }

    @PostMapping("/update")
    public ResponseEntity<String> updateUser(@RequestBody UserInfor infor, HttpServletRequest request) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication != null && authentication.isAuthenticated()
                && !"anonymousUser".equals(authentication.getPrincipal())) {
            UserPrincipal userDetails = (UserPrincipal) authentication.getPrincipal();
            User user = userService.getUserById(userDetails.getUserId());
            user.setPhone(infor.getPhone());
            user.setDob(infor.getDob());
            user.setAddress(infor.getAddress());
            user.setGender(infor.isGender());
            user.setProfileDesc(infor.getDescription());
            userService.save(user);
            return new ResponseEntity<>("User updated successfully", HttpStatus.OK);
        }
        return new ResponseEntity<>("No valid access token found", HttpStatus.UNAUTHORIZED);
    }

    @GetMapping("/userexist")
    public ResponseEntity<Map<String, Boolean>> checkExistUsername(@RequestParam String username) {
        Map<String, Boolean> res = new HashMap<>();
        boolean userExists = userService.getUserByUsername(username) != null;
        res.put("userExist", userExists);
        return ResponseEntity.ok(res);
    }

    @PostMapping("/verifyemail")
    public String checkCodeForm(@RequestParam String email, HttpServletRequest request, Model model) {
        if (!utils.isValidEmail(email)) {
            return "redirect:/infor?invalidEmail=true";
        }

        if (userService.getUserByEmail(email) != null) {
            return "redirect:/infor?emailExist=true";
        }

        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication != null && authentication.isAuthenticated()
                && !"anonymousUser".equals(authentication.getPrincipal())) {
            UserPrincipal userDetails = (UserPrincipal) authentication.getPrincipal();
            String id = utils.renderCode(8);
            String code = utils.generateRandomCode();
            int numberOfAttempts = 0;
            VerifyCode verifyCode = new VerifyCode(id, userDetails.getUserId(), email, code, numberOfAttempts);
            verifyCodeService.save(verifyCode);

            Mail mail = new Mail();
            mail.setMessage("Your code is: " + verifyCode.getCode());
            mail.setSubject("Confirmation Code");
            mailService.sendMail(verifyCode.getEmail(), mail);

            model.addAttribute("idCode", id);
            model.addAttribute("email", email);
        }
        return "checkcode";
    }

    @PostMapping("/verifycode")
    public ResponseEntity<VerifyStatus> checkValidCode(@RequestParam(value = "idCode", required = false) String idCode,
            @RequestParam(value = "verifyCode", required = false) String verifyCode) {
        VerifyCode code = verifyCodeService.getById(idCode);
        VerifyStatus status = new VerifyStatus();
        System.out.println("Idcode:" + idCode);
        System.out.println("verifyCode:" + verifyCode);
        if (code == null) {
            status.setStatus(HttpStatus.INTERNAL_SERVER_ERROR.value());
            status.setMessage("Invalid code");
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(status);
        } else if (code.getNumberOfAttempts() >= 3) {
            verifyCodeService.delete(code);
            status.setStatus(HttpStatus.INTERNAL_SERVER_ERROR.value());
            status.setMessage("Too many incorrect attempts");
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(status);
        }

        if (verifyCode.equals(code.getCode())) {

            User user = userService.getUserById(code.getUserId());
            user.setEmail(code.getEmail());
            userService.save(user);
            verifyCodeService.delete(code);
            status.setStatus(HttpStatus.OK.value());
            status.setMessage("Code is valid");
            return ResponseEntity.ok(status);
        } else {
            code.setNumberOfAttempts(code.getNumberOfAttempts() + 1);
            verifyCodeService.save(code);
            status.setStatus(HttpStatus.BAD_REQUEST.value());
            status.setMessage("Invalid verification code");
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(status);
        }
    }

    @GetMapping("/verifySuccess")
    public String verifySuccess() {
        return "verifySuccess";
    }

    @GetMapping("/verifyFailure")
    public String verifyFailure() {
        return "verifyFailure";
    }

    @GetMapping("/forgotpassword")
    public String showForgotPasswordPage(@RequestParam(value = "invalidUser", required = false) Boolean invalidUser,
            @RequestParam(value = "emailNotVerified", required = false) Boolean emailNotVerified,
            Model model) {
        if (Boolean.TRUE.equals(invalidUser)) {
            model.addAttribute("invalidUser", "Invalid UserName!");
        }

        if (Boolean.TRUE.equals(emailNotVerified)) {
            model.addAttribute("emailNotVerified", "Account not verify email yet!");
        }

        return "forgot_password";
    }

    @PostMapping("/forgotpassword")
    public String resetPassword(@RequestParam("username") String username, HttpServletRequest request) {
        User user = userService.getUserByUsername(username);
        if (user == null) {
            return "redirect:/forgotpassword?invalidUser=true";
        }

        if (user.getEmail() == null || user.getEmail().isEmpty()) {
            return "redirect:/forgotpassword?emailNotVerified=true";
        }

        String email = user.getEmail();
        String code = utils.renderCode(40);
        System.out.println(code);
        userService.updateResetPasswordToken(code, email);
        String resetPasswordLink = "http://localhost:8080/reset_password?token=" + code;
        Mail mail = new Mail();
        mail.setSubject("Reset Password:");
        mail.setMessage(resetPasswordLink);
        mailService.sendMail(email, mail);
        return "redirect:/forgotpassword";
    }

    @GetMapping("/reset_password")
    public String showResetPasswordForm(@Param(value = "token") String token, Model model) {
        User user = userService.getUserByResetPasswordToken(token);
        model.addAttribute("token", token);
        if (user == null) {
            return "redirect:/verifyFailure";
        }
        return "reset_password_form";
    }

    @PostMapping("/reset_password")
    public String processResetPassword(HttpServletRequest request, Model model) {
        String token = request.getParameter("token");
        String password = request.getParameter("password");
        User user = userService.getUserByResetPasswordToken(token);
        model.addAttribute("title", "Reset your password");

        if (user == null) {
            model.addAttribute("message", "Invalid Token");
            return "message";
        } else {
            userService.updatePassword(user, password);
            model.addAttribute("message", "You have successfully changed your password.");
        }
        return "message";
    }

    @GetMapping("/checkAccount")
    public ResponseEntity<Object> checkAccount(HttpServletRequest request) {
        Map<String, Boolean> res = new HashMap<>();

        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication != null && authentication.isAuthenticated()
                && !"anonymousUser".equals(authentication.getPrincipal())) {
            UserPrincipal userDetails = (UserPrincipal) authentication.getPrincipal();
            User user = userService.getUserById(userDetails.getUserId());
            if (user.getEmail() == null || user.getEmail().isEmpty()) {
                res.put("status", false);
                return ResponseEntity.ok(res);
            }
        }

        res.put("status", true);
        return ResponseEntity.ok(res);
    }

    @GetMapping("/findUser")
    public ResponseEntity<Object> findUser(@RequestParam String username) {
        if (username == null || username.isEmpty()) {
        }
        System.out.println(username);
        Map<String, List<UserFindedBySearch>> res = new HashMap<>();
        List<User> users = userService.searchUser(username);
        if (users.isEmpty()) {
            res.put("list", null);
            return ResponseEntity.ok(res);
        }

        List<UserFindedBySearch> userList = users.stream().map(user -> UserToUserDto.mapToUserFindedBySearch(user))
                .collect(Collectors.toList());
        res.put("list", userList);
        return ResponseEntity.ok(res);
    }

    @GetMapping("/profile")
    public String getProfileByUserId(@RequestParam String userId, Model model, HttpServletRequest request) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        Object userPrincipal = authentication.getPrincipal();

        if (userId == null || userId.isEmpty() || userId.trim().isEmpty()) {
            model.addAttribute("error", "User ID is required!");
            return "error";
        }
        if (userPrincipal instanceof UserPrincipal) {
            UserPrincipal principal = (UserPrincipal) userPrincipal;
            if(userId.equals(principal.getUserId()))
            return "redirect:/infor";
        }

        User user = userService.getUserById(userId);
        if (user == null) {
            model.addAttribute("error", "User not found!");
            return "error";
        }
        
        UserInfoRespone userInfoRespone = UserToUserDto.mapToUserInfoResponse(user);
        model.addAttribute("user", userInfoRespone);

        return "profile";
    }
}
