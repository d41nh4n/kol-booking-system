package com.example.demo.controller;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

import com.example.demo.dto.userdto.UserInfo;
import com.example.demo.security.UserPrincipal;
import com.example.demo.service.UserService;
import com.example.demo.validation.Utils;
import com.example.demo.validation.ValidTokenService;
import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;

@Component
@ControllerAdvice
@RequiredArgsConstructor
public class GlobalControllerAdvice {
    private final ValidTokenService validTokenService;
    private final UserService userService;
    private final Utils utils;

    @ModelAttribute
    public void addUserAttributes(Model model, HttpServletRequest request) {

        String token = utils.getTokenFromCookies(request);
        UserPrincipal principal = validTokenService.principalFromToken(token);
        if (principal != null && !validTokenService.isTokenExpired(token)) {
            UserInfo info = new UserInfo(principal.getUserId(), principal.getFullName(), principal.getRoles(),
                    principal.getAvatar());

            Double balance = userService.getAccountBalanceByUserId(principal.getUserId());
            System.out.println("Balance " + balance);
            request.setAttribute("balance", balance);
            request.setAttribute("userInfor", info);
        }
    }
}