package d41nh4n.google_image.demo.api;

import java.io.IOException;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import d41nh4n.google_image.demo.dto.respone.ResponeUpload;
import d41nh4n.google_image.demo.dto.userdto.UserDto;
import d41nh4n.google_image.demo.entity.user.User;
import d41nh4n.google_image.demo.security.JwtDecoder;
import d41nh4n.google_image.demo.security.JwtIssuer;
import d41nh4n.google_image.demo.security.JwtToPrincipalConverter;
import d41nh4n.google_image.demo.security.UserPrincipal;
import d41nh4n.google_image.demo.service.CloudinaryService;
import d41nh4n.google_image.demo.service.UserService;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("/cloudinary/upload")
@RequiredArgsConstructor
public class CloudinaryImageUploadController {

    private final CloudinaryService cloudinaryService;
    private static final long MAX_FILE_SIZE = 10 * 1024 * 1024; // 10MB
    private static final String[] ALLOWED_TYPES = { "image/jpeg", "image/png", "image/gif" };
    private final UserService userService;
    private final JwtDecoder decoder;
    private final JwtToPrincipalConverter converter;
    private final JwtIssuer jwtIssuer;

    @PostMapping
    public ResponseEntity<?> uploadImage(@RequestParam("image") MultipartFile file, HttpServletRequest request,
            HttpServletResponse response) throws IOException {
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

        // Upload file to Cloudinary
        ResponeUpload uploadResponse = cloudinaryService.uploadAndGetUrl(file);
        if (uploadResponse.getStatus() != 200 || uploadResponse.getUrl().isEmpty()) {
            return new ResponseEntity<>("Failed to upload image to Cloudinary", HttpStatus.INTERNAL_SERVER_ERROR);
        }

        // Update user profile with new avatar URL
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals("accessToken")) {
                    String accessToken = cookie.getValue();
                    try {
                        var decodeJwt = decoder.decode(accessToken);
                        if (decodeJwt.getExpiresAt().before(new Date())) {
                            System.err.println("JWT has expired.");
                            return new ResponseEntity<>("JWT has expired", HttpStatus.UNAUTHORIZED);
                        }
                        UserPrincipal principal = converter.convert(decodeJwt);
                        if (principal != null) {
                            User user = userService.getUserById(principal.getUserId());
                            user.getProfile().setAvatarUrl(uploadResponse.getUrl());
                            userService.save(user);

                            // Create new access token with updated avatar URL
                            UserDto userDto = userService.getUserInforById(principal.getUserId());
                            String newToken = jwtIssuer.createAccessToken(principal.getUserId(), userDto.getFullName(),
                                    user.getRole(), user.isLocked(), userDto.getAvatarUrl());

                            // Set new access token in response cookie
                            Cookie newTokenCookie = new Cookie("accessToken", newToken);
                            newTokenCookie.setPath("/");
                            newTokenCookie.setMaxAge(24 * 60 * 60);
                            response.addCookie(newTokenCookie);

                            Map<String, Object> responseBody = new HashMap<>();
                            responseBody.put("message", "User avatar updated successfully");
                            responseBody.put("accessToken", newToken);
                            return new ResponseEntity<>(responseBody, HttpStatus.OK);
                        }
                    } catch (Exception e) {
                        System.err.println("Failed to authenticate JWT: " + e.getMessage());
                        return new ResponseEntity<>("Failed to authenticate JWT", HttpStatus.UNAUTHORIZED);
                    }
                }
            }
        }
        return new ResponseEntity<>("No valid accessToken found in cookies", HttpStatus.UNAUTHORIZED);
    }

    // @PostMapping("/test")
    // public ResponseEntity<Map<String, Object>> uploadFile(@RequestParam("file") MultipartFile file) {
    //     try {
    //         Map<String, Object> result = cloudinaryService.upload(file);
    //         return ResponseEntity.ok(result);
    //     } catch (IOException e) {
    //         return ResponseEntity.status(500).body(Map.of("error", "Upload failed", "message", e.getMessage()));
    //     }
    // }

    // @DeleteMapping("/{publicId}")
    // public ResponseEntity<?> deleteFile(@PathVariable String publicId) {
    //     try {
    //         cloudinaryService.deleteByPublicId(publicId);
    //         return ResponseEntity.ok().build();
    //     } catch (IOException e) {
    //         return ResponseEntity.status(500).body(Map.of("error", "Deletion failed", "message", e.getMessage()));
    //     }
    // }
}
