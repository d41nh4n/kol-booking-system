package com.duc.vnpaydemo;

import com.duc.vnpaydemo.model.Request;
import com.duc.vnpaydemo.model.Users;
import com.duc.vnpaydemo.model.TransactionHistory;
import com.duc.vnpaydemo.repository.RequestRepository;
import com.duc.vnpaydemo.repository.UserRepository;
import com.duc.vnpaydemo.repository.TransactionHistoryRepository;
import com.duc.vnpaydemo.service.UserService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.*;

@Controller
public class LoginController {

    @Autowired
    private RequestRepository repository;

    @Autowired
    private UserService userService;

    @Autowired
    private UserRepository usersRepository;

    @Autowired
    private TransactionHistoryRepository transactionHistoryRepository;

    public static String vnpayUrl = "https://sandbox.vnpayment.vn/paymentv2/vpcpay.html";
    public static String vnpayReturnUrl = "http://localhost:9453/profile/vnpay-return";
    public static String vnpayTmnCode = "SIS8ACPU";
    public static String vnpayHashSecret = "PKQCVSGLRUNJLZBSVOQREXNIKZHWPTMW";

    @GetMapping("/login")
    public String loginForm() {
        return "login"; // Return the login page
    }

    @GetMapping("/transactionHistory")
    public String transactionHistory(HttpSession session, Model model) {
        Users loggedInUser = (Users) session.getAttribute("loggedInUser");
        if (loggedInUser == null) {
            return "redirect:/login";
        }

        List<TransactionHistory> transactions = transactionHistoryRepository.findBySenderId(loggedInUser.getId());
        model.addAttribute("transactions", transactions);
        return "transactionHistory";
    }

    @PostMapping("/login")
    public String loginSubmit(@RequestParam String username,
                              @RequestParam String password,
                              HttpSession session,
                              RedirectAttributes redirectAttributes) {
        // Authenticate login credentials
        if (username.equals("admin") && password.equals("admin")) {
            // Fetch user details from the database
            Users user = userService.findByUsername(username);
            // Save user details in session
            session.setAttribute("loggedInUser", user);
            // Redirect to main page after successful login
            return "redirect:/index-2";
        } else {
            // Redirect back to login page if authentication fails
            redirectAttributes.addFlashAttribute("error", "Invalid username or password");
            return "redirect:/login";
        }
    }

    @GetMapping("/index-2")
    public String index(Model model, HttpSession session) {
        // Fetch requests from the repository
        List<Request> requests = repository.findAll();
        model.addAttribute("requests", requests);

        // Retrieve logged-in user details from session
        Users loggedInUser = (Users) session.getAttribute("loggedInUser");
        if (loggedInUser != null) {
            model.addAttribute("loggedInUser", loggedInUser);
        }

        return "index"; // Return the main page after login
    }

    @GetMapping("/profile/vnpay-return")
    public String vnpayReturn(HttpServletRequest request, HttpSession session, Model model) {
        Map<String, String> fields = new HashMap<>();
        for (Enumeration<String> params = request.getParameterNames(); params.hasMoreElements(); ) {
            String fieldName = params.nextElement();
            String fieldValue = request.getParameter(fieldName);
            if ((fieldValue != null) && (fieldValue.length() > 0)) {
                fields.put(fieldName, fieldValue);
            }
        }

        String vnp_ResponseCode = fields.get("vnp_ResponseCode");
        String vnp_SecureHash = request.getParameter("vnp_SecureHash");

        Users loggedInUser = (Users) session.getAttribute("loggedInUser");
        double amount = Double.parseDouble(fields.get("vnp_Amount")) / 100;

        // Check the response code
        if ("00".equals(vnp_ResponseCode)) {
            // Successful payment
            if (loggedInUser != null) {
                double currentBalance = loggedInUser.getBalance();
                double updatedBalance = currentBalance + amount;
                loggedInUser.setBalance(updatedBalance);
                usersRepository.save(loggedInUser);
                model.addAttribute("updatedBalance", updatedBalance);
            }
            return "topup"; // Return the topup page after successful top-up
        } else {
            // Failed payment
            return "topdown"; // Return the topdown page after failed top-up
        }
    }
}
