// package com.example.demo.api;

// import java.io.File;
// import java.io.IOException;
// import java.security.GeneralSecurityException;
// import java.util.Date;

// import org.springframework.beans.factory.annotation.Autowired;
// import org.springframework.web.bind.annotation.PostMapping;
// import org.springframework.web.bind.annotation.RequestMapping;
// import org.springframework.web.bind.annotation.RequestParam;
// import org.springframework.web.bind.annotation.RestController;
// import org.springframework.web.multipart.MultipartFile;

// import com.example.demo.dto.respone.ResponeUpload;
// import com.example.demo.security.JwtDecoder;
// import com.example.demo.security.JwtToPrincipalConverter;
// import com.example.demo.security.UserPrincipal;
// import com.example.demo.service.GoogleService;
// import com.example.demo.service.UserService;
// import jakarta.servlet.http.Cookie;
// import jakarta.servlet.http.HttpServletRequest;
// import lombok.AllArgsConstructor;

// @RestController
// @AllArgsConstructor
// public class GoogleRestController {

// @Autowired
// private final GoogleService googleService;
// @Autowired
// private final UserService userService;
// @Autowired
// private final JwtDecoder decoder;
// @Autowired
// private final JwtToPrincipalConverter converter;

// private static final long MAX_FILE_SIZE = 5 * 1024 * 1024; // 5MB
// private static final String[] ALLOWED_TYPES = { "image/jpeg", "image/png",
// "image/gif" };

// @PostMapping("/uploadToGoogleDrive")
// public Object handleFileUpload(@RequestParam("image") MultipartFile file,
// HttpServletRequest request)
// throws IllegalStateException, IOException, GeneralSecurityException {
// System.out.println("uploadToGoogleDrive!!!! ");
// if (file.isEmpty()) {
// return "File Is Empty";
// }

// if (file.getSize() > MAX_FILE_SIZE) {
// return "File To Large";
// }

// boolean isValidType = false;
// for (String type : ALLOWED_TYPES) {
// if (type.equals(file.getContentType())) {
// isValidType = true;
// break;
// }
// }
// if (!isValidType) {
// return "Invalid file type. Only JPEG, PNG, and GIF are allowed.";
// }

// File tempFile = File.createTempFile("temp", null);
// file.transferTo(tempFile);
// ResponeUpload res = googleService.uploadImageToDrive(tempFile);
// if (res.getStatus() == 200 && !res.getUrl().isEmpty()) {
// Cookie[] cookies = request.getCookies();
// if (cookies != null) {
// for (Cookie cookie : cookies) {
// if (cookie.getName().equals("accessToken")) {
// String accessToken = cookie.getValue();
// try {
// var decodeJwt = decoder.decode(accessToken);
// if (decodeJwt.getExpiresAt().before(new Date())) {
// System.err.println("JWT has expired.");
// } else {
// UserPrincipal principal = converter.convert(decodeJwt);
// if (principal != null) {
// User user = userService.getUserById(principal.getUserId());
// user.setAvatarUrl(res.getUrl());
// userService.save(user);
// }
// }
// } catch (Exception e) {
// System.err.println("Failed to authenticate JWT: " + e.getMessage());
// }
// }
// }
// }
// }
// return res;
// }
// }
