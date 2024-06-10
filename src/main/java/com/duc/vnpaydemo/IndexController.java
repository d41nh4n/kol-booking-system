package com.duc.vnpaydemo;

import java.util.List;
import java.util.Optional;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.duc.vnpaydemo.model.Request;
import com.duc.vnpaydemo.repository.RequestRepository;

@Controller
public class IndexController {
    
    @Autowired
    private RequestRepository repository;

    @GetMapping("/")
    public String index(Model model) {
        List<Request> requests = repository.findAll();
        model.addAttribute("requests", requests);
        return "index";
    }

    @GetMapping("/order-save")
    public String initiatePayment(HttpServletRequest request) {
        HttpSession session = request.getSession();
        // Retrieve and store parameters in session
        String amount = request.getParameter("amount");
        String info = request.getParameter("info");
        String requesterId = request.getParameter("requesterId");
        String responderId = request.getParameter("responderId");
        String requestId = request.getParameter("requestId");
        String requestStatus = request.getParameter("requestStatus");
        session.setAttribute("amount", amount);
        session.setAttribute("info", info);
        session.setAttribute("requesterId", requesterId);
        session.setAttribute("responderId", responderId);
        session.setAttribute("requestId", requestId);
        session.setAttribute("requestStatus", requestStatus);
        return "redirect:/order";
    }

}
