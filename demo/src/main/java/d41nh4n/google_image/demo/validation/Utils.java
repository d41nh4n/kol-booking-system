package d41nh4n.google_image.demo.validation;

import java.util.Arrays;
import java.util.Optional;
import java.util.Random;

import org.springframework.stereotype.Component;

import d41nh4n.google_image.demo.service.UserService;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;

@Component
@RequiredArgsConstructor
public class Utils {

    private final UserService service;

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

    public String renderUserId(int number) {

        while (true) {
            String id = "USER" + renderCode(number);
            if (service.getUserById(id) == null) {
                return id;
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

    public Optional<String> getTokenFromCookies(HttpServletRequest request) {
        Cookie[] cookies = request.getCookies();

        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("accessToken".equals(cookie.getName())) {
                    return Optional.of(cookie.getValue());
                }
            }
        }

        return Optional.empty();
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
        String[] array = { userIdA, userIdB };
        Arrays.sort(array);
        String combie = array[0] + array[1];
        System.out.println(combie);
        return combie;
    }
}
