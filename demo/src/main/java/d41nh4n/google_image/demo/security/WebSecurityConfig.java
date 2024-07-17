package d41nh4n.google_image.demo.security;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpStatus;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.access.AccessDeniedHandler;
import org.springframework.security.web.authentication.HttpStatusEntryPoint;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

import d41nh4n.google_image.demo.exeption.CustomAccessDeniedHandler;
import lombok.RequiredArgsConstructor;

@Configuration
@EnableWebSecurity
@RequiredArgsConstructor
public class WebSecurityConfig {

        private final JwtAuthenticationFilter jwtAuthenticationFilter;
        private final CustomUserDetailService customUserDetailService;
        private final PasswordEncoder passwordEncoder;
        // private final CustomCheckExsistTokenFilter customCheckExsistTokenFilter;

        @Bean
        public SecurityFilterChain applicationSecurity(HttpSecurity http) throws Exception {
                http
                                .csrf(csrf -> csrf.disable())
                                .sessionManagement(sessionManagement -> sessionManagement
                                                .sessionCreationPolicy(SessionCreationPolicy.STATELESS))
                                .securityMatcher("/**")
                                .authorizeHttpRequests(authorizeRequests -> authorizeRequests
                                                .requestMatchers("/", "/search", "/login/auth", "/login/error",
                                                                "/login/form", "/register/form", "/register",
                                                                "/findUser", "/profile",
                                                                "/search-page", "/getimg", "/comment**")
                                                .permitAll()
                                                .requestMatchers("/uploadToGoogleDrive",
                                                                "/checkAccount", "/ws", "/chatbox",
                                                                "/chat.sendMessage", "/infor",
                                                                "/request/pending", "/request/in-process",
                                                                "/request/finish",
                                                                "/request/cancel", "/job-market", "/change-password",
                                                                "/chat.sendMessage",
                                                                "/chatbox", "/getChat", "/getUserChatted")
                                                .hasAnyAuthority("USER", "KOL")
                                                .requestMatchers("/accept", "/deny", "/job-market-add", "/public",
                                                                "/cancel-request", "/candidate-list",
                                                                "/accept-candidate", "/request/rating-page**",
                                                                "/comment-rating",
                                                                "/finish-request",
                                                                "/private")
                                                .hasAuthority("USER")
                                                .requestMatchers("/apply", "/submit",
                                                                "/profile-media-add", "/profile-media-delete")
                                                .hasAuthority("KOL")
                                                .anyRequest().permitAll())
                                .formLogin(formLogin -> formLogin
                                                .loginPage("/login/form"))
                                .addFilterBefore(jwtAuthenticationFilter,
                                                UsernamePasswordAuthenticationFilter.class)
                                .exceptionHandling(exceptionHandling -> exceptionHandling
                                                .accessDeniedPage("/login/form"));

                return http.build();
        }

        @Bean
        public AuthenticationManager authenticationManager(HttpSecurity http) throws Exception {
                var builder = http.getSharedObject(AuthenticationManagerBuilder.class);
                builder
                                .userDetailsService(customUserDetailService)
                                .passwordEncoder(passwordEncoder);
                return builder.build();
        }
}
