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
                                                                "/login/form", "/register/form", "/register", "/findUser","/profile")
                                                .permitAll()
                                                .requestMatchers("/infor").hasAnyAuthority("USER", "ADMIN")
                                                .requestMatchers("/uploadToGoogleDrive", "/cloudinary/upload",
                                                                "/update", "/checkAccount", "/ws","/chatbox","/chat.sendMessage")
                                                .hasAnyAuthority("USER", "ADMIN")
                                                .requestMatchers("/auth/admin").hasAuthority("ADMIN")
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
        public PasswordEncoder passwordEncoder() {
                return new BCryptPasswordEncoder();
        }

        @Bean
        public AuthenticationManager authenticationManager(HttpSecurity http) throws Exception {
                var builder = http.getSharedObject(AuthenticationManagerBuilder.class);
                builder
                                .userDetailsService(customUserDetailService)
                                .passwordEncoder(passwordEncoder());
                return builder.build();
        }
}
