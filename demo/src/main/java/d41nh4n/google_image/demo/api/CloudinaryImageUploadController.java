package d41nh4n.google_image.demo.api;

import java.io.IOException;
import java.util.Date;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import d41nh4n.google_image.demo.dto.respone.ResponeUploadImage;
import d41nh4n.google_image.demo.entity.User;
import d41nh4n.google_image.demo.security.JwtDecoder;
import d41nh4n.google_image.demo.security.JwtToPrincipalConverter;
import d41nh4n.google_image.demo.security.UserPrincipal;
import d41nh4n.google_image.demo.service.CloudinaryService;
import d41nh4n.google_image.demo.service.UserService;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("/cloudinary/upload")
@RequiredArgsConstructor
public class CloudinaryImageUploadController {

    private final CloudinaryService cloudinaryService;
    private static final long MAX_FILE_SIZE = 5 * 1024 * 1024; // 5MB
    private static final String[] ALLOWED_TYPES = { "image/jpeg", "image/png", "image/gif" };
    private final UserService userService;
    private final JwtDecoder decoder;
    private final JwtToPrincipalConverter converter;

    @PostMapping
    public ResponseEntity<?> uploadImage(@RequestParam("image") MultipartFile file, HttpServletRequest request)
            throws IOException {
        if (file.isEmpty()) {
            return new ResponseEntity<>("File is empty", HttpStatus.BAD_REQUEST);
        }

        if (file.getSize() > MAX_FILE_SIZE) {
            return new ResponseEntity<>("File is too large", HttpStatus.BAD_REQUEST);
        }

        boolean isValidType = false;
        for (String type : ALLOWED_TYPES) {
            if (type.equals(file.getContentType())) {
                isValidType = true;
                break;
            }
        }
        if (!isValidType) {
            return new ResponseEntity<>("Invalid file type. Only JPEG, PNG, and GIF are allowed.",
                    HttpStatus.BAD_REQUEST);
        }

        ResponeUploadImage res = cloudinaryService.uploadAndGetUrl(file);
        if (res.getStatus() == 200 && !res.getUrlImg().isEmpty()) {
            Cookie[] cookies = request.getCookies();
            if (cookies != null) {
                for (Cookie cookie : cookies) {
                    if (cookie.getName().equals("accessToken")) {
                        String accessToken = cookie.getValue();
                        try {
                            var decodeJwt = decoder.decode(accessToken);
                            if (decodeJwt.getExpiresAt().before(new Date())) {
                                System.err.println("JWT has expired.");
                            } else {
                                UserPrincipal principal = converter.convert(decodeJwt);
                                if (principal != null) {
                                    User user = userService.getUserById(principal.getUserId());
                                    user.setAvatarUrl(res.getUrlImg());
                                    userService.save(user);
                                }
                            }
                        } catch (Exception e) {
                            System.err.println("Failed to authenticate JWT: " + e.getMessage());
                        }
                    }
                }
            }
        }
        return new ResponseEntity<>(res, HttpStatus.OK);
    }
}
