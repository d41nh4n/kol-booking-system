package com.example.demo.exeption;

import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.web.access.AccessDeniedHandlerImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

public class CustomAccessDeniedHandler extends AccessDeniedHandlerImpl {

    private final String errorPage;

    public CustomAccessDeniedHandler(String errorPage) {
        this.errorPage = errorPage;
    }

    @Override
    public void handle(HttpServletRequest request, HttpServletResponse response,
            AccessDeniedException accessDeniedException) throws IOException, ServletException {
        response.sendRedirect(errorPage);
    }
}