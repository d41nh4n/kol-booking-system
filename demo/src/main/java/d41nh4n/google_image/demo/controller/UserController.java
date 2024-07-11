package d41nh4n.google_image.demo.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.data.domain.Page;
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
import d41nh4n.google_image.demo.dto.respone.ResponeJson;
import d41nh4n.google_image.demo.dto.respone.ResponeUpload;
import d41nh4n.google_image.demo.dto.respone.VerifyStatus;
import d41nh4n.google_image.demo.dto.userdto.UserDto;
import d41nh4n.google_image.demo.dto.userdto.UserDtoFilter;
import d41nh4n.google_image.demo.dto.userdto.UserFindedBySearch;
import d41nh4n.google_image.demo.dto.userdto.UserProfileUpdate;
import d41nh4n.google_image.demo.dto.userdto.MediaProfileDto;
import d41nh4n.google_image.demo.dto.userdto.MediaProfileUpload;
import d41nh4n.google_image.demo.entity.VerifyCode;
import d41nh4n.google_image.demo.entity.user.Gender;
import d41nh4n.google_image.demo.entity.user.MediaProfile;
import d41nh4n.google_image.demo.entity.user.Profile;
import d41nh4n.google_image.demo.entity.user.User;
import d41nh4n.google_image.demo.model.Mail;
import d41nh4n.google_image.demo.security.JwtIssuer;
import d41nh4n.google_image.demo.security.UserPrincipal;
import d41nh4n.google_image.demo.service.CategoryService;
import d41nh4n.google_image.demo.service.MailService;
import d41nh4n.google_image.demo.service.MediaProfileService;
import d41nh4n.google_image.demo.service.ProvinceService;
import d41nh4n.google_image.demo.service.CloudinaryService;
import d41nh4n.google_image.demo.service.CommentService;
import d41nh4n.google_image.demo.service.UserService;
import d41nh4n.google_image.demo.service.VerifyCodeService;
import d41nh4n.google_image.demo.validation.Utils;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("/")
public class UserController {

    public static final Long MAX_PRICE = 999999999999L;
    public static final Long MIN_PRICE = 0L;
    private final JwtIssuer jwtIssuer;
    private final MailService mailService;
    private final UserService userService;
    private final VerifyCodeService verifyCodeService;
    private final Utils utils;
    private final CategoryService categoryService;
    private final ProvinceService provinceService;
    private final CloudinaryService cloudinaryService;
    private final MediaProfileService mediaProfileService;
    private final CommentService commentService;

    @GetMapping()
    public String index(Model model, HttpServletRequest request) {
        List<String> categoies = categoryService.getAllCategoryNames();
        List<UserDtoFilter> listUser = userService.getUserListHomePage();
        List<UserDtoFilter> listTop = userService.getTop6UsersForHomePage();
        List<String> provinces = provinceService.getProvinceNames();

        List<UserDtoFilter> randomUsers = listUser.stream()
                .collect(Collectors.collectingAndThen(Collectors.toList(), collected -> {
                    Collections.shuffle(collected);
                    return collected.stream();
                }))
                .limit(12)
                .collect(Collectors.toList());

        model.addAttribute("topUsers", listTop);
        model.addAttribute("users", randomUsers);
        model.addAttribute("categories", categoies);
        model.addAttribute("provinces", provinces);
        return "home";
    }

    @GetMapping("/infor")
    public String login(Model model, HttpServletRequest request,
            @RequestParam(value = "invalidEmail", required = false) Boolean invalidEmail,
            @RequestParam(value = "emailExist", required = false) Boolean emailExist) {

        UserPrincipal principal = utils.getPrincipal();
        UserDto userDto = userService.getUserInforById(principal.getUserId());
        model.addAttribute("me", "me");
        model.addAttribute("userInformation", userDto);
        if (Boolean.TRUE.equals(invalidEmail)) {
            model.addAttribute("invalidEmail", "Invalid email!");
        }
        if (Boolean.TRUE.equals(emailExist)) {
            model.addAttribute("emailExist", "Existed email!");
        }
        List<MediaProfileDto> mediaProfile = mediaProfileService.getAllByProfileId(getUserId()).stream()
                .map(media -> new MediaProfileDto(media)).collect(Collectors.toList());
        if (principal.getRoles().equalsIgnoreCase("KOL")) {
            int totalRating = commentService.totalRatingByUserId(principal.getUserId());
            model.addAttribute("totalRating", totalRating);
        }
        model.addAttribute("medias", mediaProfile);
        if (principal.getRoles().equals("USER")) {
            return "infor-user";
        } else {
            return "infor-kol";
        }
    }

    @PostMapping("/update")
    public ResponseEntity<Map<String, String>> updateUser(@RequestBody UserProfileUpdate infor,
            HttpServletRequest request,
            HttpServletResponse response) {
        UserPrincipal principal = utils.getPrincipal();
        if (principal != null) {
            int userId = principal.getUserId();
            User user = userService.getUserById(userId);
            Profile profile = userService.getProfileById(userId);
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            profile.setFullName(infor.getFullName());
            try {
                if (infor.getDob() != null && !infor.getDob().isEmpty()) {
                    profile.setBirthday(dateFormat.parse(infor.getDob()));
                }
            } catch (ParseException e) {
                Map<String, String> responseBody = new HashMap<>();
                responseBody.put("message", "Invalid date format");
                return new ResponseEntity<>(responseBody, HttpStatus.BAD_REQUEST);
            }
            profile.setLocation(infor.getLocation());
            profile.setBio(infor.getDescription());

            try {
                if (infor.getPriceAPost() != null && !infor.getPriceAPost().isEmpty()) {
                    profile.setPriceAPost(Long.parseLong(infor.getPriceAPost()));
                }
                if (infor.getPriceAVideo() != null && !infor.getPriceAVideo().isEmpty()) {
                    profile.setPriceAVideo(Long.parseLong(infor.getPriceAVideo()));
                }
                if (infor.getPriceAToHireADay() != null && !infor.getPriceAToHireADay().isEmpty()) {
                    profile.setPriceAToHireADay(Long.parseLong(infor.getPriceAToHireADay()));
                }
                if (infor.getRepresentativePrice() != null && !infor.getRepresentativePrice().isEmpty()) {
                    profile.setRepresentativePrice(Long.parseLong(infor.getRepresentativePrice()));
                }
            } catch (NumberFormatException e) {
                Map<String, String> responseBody = new HashMap<>();
                responseBody.put("message", "Invalid price format");
                return new ResponseEntity<>(responseBody, HttpStatus.BAD_REQUEST);
            }

            // Cập nhật thông tin user
            user.setGender(Gender.valueOf(infor.getGender().toUpperCase()));
            userService.save(user);
            userService.save(profile);

            String newToken = jwtIssuer.createAccessToken(userId, profile.getFullName(), user.getRole(),
                    user.isLocked(), profile.getAvatarUrl());

            Cookie newTokenCookie = new Cookie("accessToken", newToken);
            newTokenCookie.setPath("/");
            newTokenCookie.setMaxAge(24 * 60 * 60);
            response.addCookie(newTokenCookie);

            Map<String, String> responseBody = new HashMap<>();
            responseBody.put("message", "User updated successfully");
            responseBody.put("accessToken", newToken);
            return new ResponseEntity<>(responseBody, HttpStatus.OK);
        }

        Map<String, String> responseBody = new HashMap<>();
        responseBody.put("message", "No valid access token found");
        return new ResponseEntity<>(responseBody, HttpStatus.UNAUTHORIZED);
    }

    @GetMapping("/update-profile-form")
    public String updateForm(Model model) {
        UserPrincipal principal = utils.getPrincipal();
        UserDto userDto = userService.getUserInforById(getUserId());
        List<String> provinces = provinceService.getProvinceNames();
        model.addAttribute("provinces", provinces);
        model.addAttribute("userInformation", userDto);
        return "information-update-form";
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
            @RequestParam(value = "confirmNotification", required = false) Boolean confirmNotification,
            Model model) {
        if (Boolean.TRUE.equals(invalidUser)) {
            model.addAttribute("invalidUser", "Invalid UserName!");
        }

        if (Boolean.TRUE.equals(emailNotVerified)) {
            model.addAttribute("emailNotVerified", "Account not verify email yet!");
        }

        if (Boolean.TRUE.equals(confirmNotification)) {
            model.addAttribute("confirmNotification", "Check email to get link reset!");
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
        userService.updateResetPasswordToken(code, email);
        String resetPasswordLink = "https://localhost:443/reset_password?token=" + code;
        Mail mail = new Mail();
        mail.setSubject("Reset Password:");
        mail.setMessage(resetPasswordLink);
        mailService.sendMail(email, mail);
        return "redirect:/forgotpassword?confirmNotification=true";
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
    public ResponseEntity<Object> findUser(@RequestParam String name) {
        if (name == null || name.isEmpty()) {
        }
        Map<String, List<UserFindedBySearch>> res = new HashMap<>();
        List<UserFindedBySearch> users = userService.searchUser(name);
        for (UserFindedBySearch userFindedBySearch : users) {
        }
        if (users.isEmpty()) {
            res.put("list", null);
            return ResponseEntity.ok(res);
        }
        res.put("list", users);
        return ResponseEntity.ok(res);
    }

    @GetMapping("/profile")
    public String getProfileByUserId(@RequestParam String userId, Model model,
            HttpServletRequest request) {
        int userIdNumber = Integer.parseInt(userId);
        UserPrincipal principal = utils.getPrincipal();

        if (userId == null || userId.isEmpty() || userId.trim().isEmpty()) {
            model.addAttribute("error", "User ID is required!");
            return "error";
        }
        if (principal != null) {
            if (userIdNumber == principal.getUserId())
                return "redirect:/infor";
        }

        User user = userService.getUserById(userIdNumber);
        if (user == null) {
            model.addAttribute("error", "User not found!");
            return "error";
        }
        UserDto userDto = userService.getUserInforById(userIdNumber);
        List<String> provinces = provinceService.getProvinceNames();
        List<MediaProfileDto> mediaProfile = mediaProfileService.getAllByProfileId(userIdNumber).stream()
                .map(media -> new MediaProfileDto(media)).collect(Collectors.toList());
        if (user.getRole().equalsIgnoreCase("KOL")) {
            int totalRating = commentService.totalRatingByUserId(userIdNumber);
            model.addAttribute("totalRating", totalRating);
        }
        model.addAttribute("provinces", provinces);
        model.addAttribute("userInformation", userDto);
        model.addAttribute("medias", mediaProfile);

        if (user.getRole().equals("USER")) {
            return "infor-user";
        } else {
            return "infor-kol";
        }
    }

    @GetMapping("/search-page")
    public String search(
            @RequestParam(name = "page", required = false) String page,
            @RequestParam(name = "location", required = false) String location,
            @RequestParam(name = "nameSearch", required = false) String nameSearch,
            @RequestParam(name = "gender", required = false) String gender,
            @RequestParam(name = "category", required = false) String category,
            @RequestParam(name = "maxPrice", required = false) String maxPrice,
            @RequestParam(name = "minPrice", required = false) String minPrice,
            @RequestParam(name = "aPost", required = false) String aPost,
            @RequestParam(name = "hireADay", required = false) String hireADay,
            @RequestParam(name = "aVideo", required = false) String aVideo,
            @RequestParam(name = "representative", required = false) String representative,
            Model model) {

        // Xử lý các giá trị filter
        location = "".equals(location) ? null : location;
        nameSearch = "".equals(nameSearch) ? null : nameSearch;
        gender = "".equals(gender) ? null : gender;
        category = "".equals(category.trim()) ? null : category;
        maxPrice = "".equals(maxPrice) ? null : maxPrice;
        minPrice = "".equals(minPrice) ? null : minPrice;
        aPost = "".equals(aPost) ? null : aPost;
        hireADay = "".equals(hireADay) ? null : hireADay;
        aVideo = "".equals(aVideo) ? null : aVideo;
        representative = "".equals(representative) ? null : representative;

        // Chuyển đổi giá trị chuỗi thành số
        Long maxPriceNumber = utils.stringParseToLong(maxPrice, MAX_PRICE);
        Long minPriceNumber = utils.stringParseToLong(minPrice, MIN_PRICE);

        // Xử lý giá trị giới tính
        Gender genderEnum = null;
        if (gender != null) {
            if (gender.equalsIgnoreCase("male")) {
                genderEnum = Gender.MALE;
            } else if (gender.equalsIgnoreCase("female")) {
                genderEnum = Gender.FEMALE;
            } else if (gender.equalsIgnoreCase("other")) {
                genderEnum = Gender.OTHER;
            }
        }

        int pageNumber = 0;
        if (page != null && !page.isEmpty()) {
            pageNumber = Integer.parseInt(page);
        }
        int pageSize = 18;

        Page<UserDtoFilter> userPage = userService.getUserByFilter(
                null, nameSearch, null, location, aPost, hireADay, aVideo, representative,
                maxPriceNumber, minPriceNumber, category, genderEnum, pageNumber, pageSize);

        // Lấy danh sách categories và provinces
        List<String> categories = categoryService.getAllCategoryNames();
        List<String> provinces = provinceService.getProvinceNames();

        if (maxPriceNumber == MAX_PRICE) {
            model.addAttribute("maxPrice", null);
        } else {
            model.addAttribute("maxPrice", maxPriceNumber);
        }

        if (minPriceNumber == MIN_PRICE) {
            model.addAttribute("minPrice", null);
        } else {
            model.addAttribute("minPrice", minPriceNumber);
        }

        model.addAttribute("location", location);
        model.addAttribute("nameSearch", nameSearch);
        model.addAttribute("gender", genderEnum);
        model.addAttribute("categoryName", category);
        model.addAttribute("aPost", aPost);
        model.addAttribute("hireADay", hireADay);
        model.addAttribute("aVideo", aVideo);
        model.addAttribute("representative", representative);
        model.addAttribute("listSearch", userPage.getContent());
        model.addAttribute("currentPage", pageNumber);
        model.addAttribute("totalPages", userPage.getTotalPages());
        model.addAttribute("categories", categories);
        model.addAttribute("provinces", provinces);

        return "search-page";
    }

    // @GetMapping("/find-user")
    // public String findUserByName(@RequestParam(name = "name", required = false)
    // String name) {
    // return "list-find-user";
    // }

    @PostMapping("/profile-media-add")
    public ResponseEntity<?> handleProfileMediaUpload(@RequestBody MediaProfileUpload content) {
        System.out.println(content.getContent());
        try {
            ResponeUpload responeUpload = cloudinaryService.uploadFile(content.getContent());
            Profile profile = userService.getProfileById(getUserId());
            if (responeUpload.getStatus() == 200) {
                MediaProfile mediaProfile = new MediaProfile();
                mediaProfile.setUrl(responeUpload.getUrl());
                String contentType = content.getContent().split(",")[0];
                if (contentType.contains("video") || contentType.contains("mp4")) {
                    mediaProfile.setType("VIDEO");
                } else if (contentType.contains("image")) {
                    mediaProfile.setType("IMAGE");
                }
                ZonedDateTime zonedDateTime = ZonedDateTime.parse(content.getCreateAt(),
                        DateTimeFormatter.ISO_DATE_TIME);
                mediaProfile.setCreateAt(zonedDateTime);
                if (profile.getMediaProfile() == null) {
                    profile.setMediaProfile(new ArrayList<>());
                    userService.save(profile);
                }
                mediaProfile.setProfile(profile);
                mediaProfileService.save(mediaProfile);
                Map<String, Object> responseMap = new HashMap<>();
                responseMap.put("status", 200);
                responseMap.put("result", "Media uploaded successfully.");
                return ResponseEntity.ok(responseMap);
            } else {
                // Prepare response
                Map<String, Object> responseMap = new HashMap<>();
                responseMap.put("status", responeUpload.getStatus());
                responseMap.put("result", "Failed to upload media: " + responeUpload.getMessage());
                return ResponseEntity.badRequest().body(responseMap);
            }
        } catch (Exception e) {
            e.printStackTrace();
            // Prepare response
            Map<String, Object> responseMap = new HashMap<>();
            responseMap.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
            responseMap.put("result", "Error uploading media.");
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(responseMap);
        }
    }

    @PostMapping("/profile-media-delete")
    public ResponseEntity<ResponeJson> handleProfileMediaDelete(@RequestParam(name = "id") String id) {

        try {
            Long idImg = Long.parseLong(id);

            int userId = utils.getPrincipal().getUserId();
            User user = userService.getUserById(userId);

            List<MediaProfile> mediaProfiles = mediaProfileService.getAllByProfileId(user.getProfile().getProfileId());

            for (MediaProfile mediaProfileTemp : mediaProfiles) {
                if (mediaProfileTemp.getId() != idImg) {
                    return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(
                            new ResponeJson(HttpStatus.BAD_REQUEST.value(), "You not have permission to delete!"));
                }
            }
            MediaProfile mediaProfile = mediaProfileService.getById(idImg);

            if (mediaProfile == null) {
                return ResponseEntity.status(HttpStatus.OK).body(
                        new ResponeJson(HttpStatus.OK.value(), "Image not found in database"));
            }

            mediaProfileService.delete(mediaProfile);
            return ResponseEntity.status(HttpStatus.OK).body(
                    new ResponeJson(HttpStatus.OK.value(), "Image deleted successfully"));
        } catch (NumberFormatException e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(
                    new ResponeJson(HttpStatus.BAD_REQUEST.value(), "Invalid image ID format"));
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(
                    new ResponeJson(HttpStatus.INTERNAL_SERVER_ERROR.value(), "Error deleting image"));
        }
    }

    @GetMapping("/getimg")
    public ResponseEntity<?> bla() {
        List<MediaProfileDto> mediaProfile = mediaProfileService.getAllByProfileId(getUserId()).stream()
                .map(media -> new MediaProfileDto(media)).collect(Collectors.toList());
        return ResponseEntity.ok(mediaProfile);
    }

    private int getUserId() {
        return utils.getPrincipal().getUserId();
    }
}
