package com.example.demo.validation;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.Arrays;
import java.util.Date;
import java.util.Optional;
import java.util.Random;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;

import com.example.demo.security.UserPrincipal;
import com.example.demo.service.UserService;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;

@Component
@RequiredArgsConstructor
public class Utils {

    private final UserService service;

    private static final String DATE_FORMAT_1 = "MM/dd/yyyy";
    private static final String DATE_FORMAT_2 = "yyyy-MM-dd";

    public String renderCode(int number) {

        String characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
        StringBuilder userID = new StringBuilder();
        Random random = new Random();

        for (int i = 0; i < number; i++) {
            int index = random.nextInt(characters.length());
            userID.append(characters.charAt(index));
        }

        return userID.toString();
    }

    public String renderUserName(int number) {

        while (true) {
            String name = "USER_" + renderCode(number);
            if (service.getProfileByName(name) == null) {
                return name;
            }
        }
    }

    public String generateRandomCode() {
        Random random = new Random();
        StringBuilder codeBuilder = new StringBuilder();

        for (int i = 0; i < 6; i++) {
            int randomNumber = random.nextInt(10);
            codeBuilder.append(randomNumber);
        }

        return codeBuilder.toString();
    }

    public String getTokenFromCookies(HttpServletRequest request) {
        Cookie[] cookies = request.getCookies();

        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("accessToken".equals(cookie.getName())) {
                    return cookie.getValue();
                }
            }
        }

        return null;
    }

    public void removeTokenCookie(HttpServletResponse response) {
        Cookie cookie = new Cookie("accessToken", "");
        cookie.setHttpOnly(true);
        cookie.setPath("/");
        cookie.setMaxAge(0);
        response.addCookie(cookie);
    }

    public boolean isValidEmail(String email) {
        String regex = "^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$";
        return email.matches(regex);
    }

    public String getSiteURL(HttpServletRequest request) {
        String siteURL = request.getRequestURL().toString();
        return siteURL.replace(request.getServletPath(), "");
    }

    public String generateChatRoomId(String userIdA, String userIdB) {
        String[] array = { String.valueOf(userIdA), String.valueOf(userIdB) };
        Arrays.sort(array);
        String combie = array[0] + ":" + array[1];
        return combie;
    }

    public UserPrincipal getPrincipal() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication != null && authentication.isAuthenticated()
                && !"anonymousUser".equals(authentication.getPrincipal())) {
            return (UserPrincipal) authentication.getPrincipal();
        }
        return null;
    }

    public Date stringToDate(String dateString) {
        Date date = null;
        SimpleDateFormat formatter = new SimpleDateFormat(DATE_FORMAT_1);

        try {
            // Thử phân tích chuỗi ngày với định dạng DATE_FORMAT_1
            date = formatter.parse(dateString);
        } catch (ParseException e1) {
            // Nếu không thành công, thử với định dạng DATE_FORMAT_2
            formatter.applyPattern(DATE_FORMAT_2);
            try {
                date = formatter.parse(dateString);
            } catch (ParseException e2) {
                // Nếu vẫn không thành công, in ra lỗi và trả về null
                e2.printStackTrace();
            }
        }
        return date;
    }

    public LocalDate stringToLocalDate(String dateString) {
        LocalDate localDate = null;

        // Cố gắng phân tích chuỗi ngày với định dạng DATE_FORMAT_1
        try {
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern(DATE_FORMAT_1);
            localDate = LocalDate.parse(dateString, formatter);
        } catch (DateTimeParseException e1) {
            // Nếu không thành công, thử với định dạng DATE_FORMAT_2
            try {
                DateTimeFormatter formatter = DateTimeFormatter.ofPattern(DATE_FORMAT_2);
                localDate = LocalDate.parse(dateString, formatter);
            } catch (DateTimeParseException e2) {
                // Nếu vẫn không thành công, in ra lỗi và trả về null
                e2.printStackTrace();
            }
        }

        return localDate;
    }

    public String dateToString(Date date) {
        SimpleDateFormat formatter = new SimpleDateFormat(DATE_FORMAT_1);
        return formatter.format(date);
    }

    public int stringToInt(String number) {
        return Integer.parseInt(number);
    }

    public Long stringParseToLong(String numberStr, Long defaultValue) {
        try {
            Long result = Long.parseLong(numberStr);
            if (result < 0L) {
                return defaultValue;
            }
            return result;
        } catch (Exception e) {
            return defaultValue;
        }
    }
}
