// package d41nh4n.google_image.demo.security;

// import java.io.IOException;

// import jakarta.servlet.FilterChain;
// import jakarta.servlet.ServletException;
// import jakarta.servlet.http.Cookie;
// import jakarta.servlet.http.HttpServletRequest;
// import jakarta.servlet.http.HttpServletResponse;
// import lombok.AllArgsConstructor;

// import org.springframework.stereotype.Component;
// import org.springframework.web.filter.OncePerRequestFilter;
// import d41nh4n.google_image.demo.service.jwtTokenService.ValidTokenService;

// @Component
// @AllArgsConstructor
// public class CustomCheckExsistTokenFilter extends OncePerRequestFilter {

//     private static final String TOKEN_COOKIE_NAME = "accessToken";
//     private static final String LOGIN_PATH = "/login/form";
//     private static final String HOME_PATH = "/";
//     private final ValidTokenService validTokenService;

//     @Override
//     protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain)
//             throws ServletException, IOException {

//         String token = null;
//         if (request.getCookies() != null) {
//             for (Cookie cookie : request.getCookies()) {
//                 if (TOKEN_COOKIE_NAME.equals(cookie.getName())) {
//                     token = cookie.getValue();
//                     break;
//                 }
//             }
//         }

//         boolean isTokenValid = token != null && validTokenService.validJwtToken(token) != null;

//         // Nếu truy cập vào /login và token hợp lệ, chuyển hướng đến /home
//         if (LOGIN_PATH.equals(request.getRequestURI()) && isTokenValid) {
//             response.sendRedirect(request.getContextPath() + HOME_PATH);
//             return;
//         }

//         // Nếu không phải truy cập /home và token không hợp lệ, chuyển hướng đến /login
//         if (!isTokenValid && !HOME_PATH.equals(request.getRequestURI())) {
//             response.sendRedirect(request.getContextPath() + LOGIN_PATH);
//             return;
//         }

//         // Thêm attribute vào request để sử dụng trong JSP
//         if (isTokenValid) {
//             UserPrincipal principal = validTokenService.validJwtToken(token);
//             String username = principal.getUsername();
//             String role = principal.getAuthorityStrings().getFirst();
//             request.setAttribute("username", username);
//             request.setAttribute("role", role);
//         }
//         filterChain.doFilter(request, response);
//     }
// }
