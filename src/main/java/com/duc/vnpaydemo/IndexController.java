package com.duc.vnpaydemo;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

import com.duc.vnpaydemo.Config.VNPayConfig;
import com.duc.vnpaydemo.model.Request;
import com.duc.vnpaydemo.model.TransactionHistory;
import com.duc.vnpaydemo.model.Users;
import com.duc.vnpaydemo.repository.RequestRepository;
import com.duc.vnpaydemo.repository.TransactionHistoryRepository;
import com.duc.vnpaydemo.repository.UserRepository;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class IndexController {
    @Autowired
    private RequestRepository repository;

    @Autowired
    private UserRepository usersRepository;

    @Autowired
    private RequestRepository requestRepository;

    public static String vnpayUrl = "https://sandbox.vnpayment.vn/paymentv2/vpcpay.html";
    public static String vnpayReturnUrl = "http://localhost:9453/profile/vnpay-return";
    public static String vnpayTmnCode = "SIS8ACPU";
    public static String vnpayHashSecret = "PKQCVSGLRUNJLZBSVOQREXNIKZHWPTMW";


    @Autowired
    private TransactionHistoryRepository transactionHistoryRepository;

    @GetMapping("/")
    public String index(Model model) {
        List<Request> requests = repository.findAll();
        model.addAttribute("requests", requests);
        return "login";
    }


    @GetMapping("/index")
    public String indexHome(Model model, HttpSession session) {
        List<Request> requests = repository.findAll();
        model.addAttribute("requests", requests);

        Users loggedInUser = (Users) session.getAttribute("loggedInUser");
        if (loggedInUser != null) {
            model.addAttribute("loggedInUser", loggedInUser);
        }

        return "index";
    }

    @GetMapping("/order-save")
    public String initiatePayment(HttpServletRequest request) {
        HttpSession session = request.getSession();
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

    @PostMapping("/process-payment")
    public String processPayment(HttpServletRequest request, HttpSession session1, RedirectAttributes redirectAttributes) {
        double paymentAmount = Double.parseDouble(request.getParameter("paymentAmount"));
        HttpSession session = request.getSession();
        String amount = request.getParameter("amount");
        String info = request.getParameter("info");
        String requesterId = request.getParameter("requesterId");
        String responderId = request.getParameter("responderId");
        String requestId = request.getParameter("requestId");
        String requestStatus = request.getParameter("requestStatus");
        int requestStatusInt = requestStatus.toLowerCase().equals("true") ? 1 : 0;

        Users loggedInUser = (Users) session.getAttribute("loggedInUser");

        Timestamp timestamp = null;

        Date currentDate = new Date();

        // Chuyển đổi thành Timestamp
        timestamp = new Timestamp(currentDate.getTime());

        if (loggedInUser == null) {
            redirectAttributes.addFlashAttribute("error", "User not logged in.");
            return "redirect:/login";
        }

        TransactionHistory transaction = new TransactionHistory();
        transaction.setTransPayment(Double.parseDouble(amount));
        transaction.setTransDate(timestamp);
        transaction.setSenderId(Integer.parseInt(requesterId));
        transaction.setReceiverId(Integer.parseInt(responderId));
        transaction.setRequestId(Integer.parseInt(requestId));
        transaction.setRequestStatus(requestStatusInt);

        transactionHistoryRepository.save(transaction);
        Long idRe = Long.parseLong(requestId);
        requestRepository.updateStatusById(idRe, true);

        double currentBalance = loggedInUser.getBalance();

        if (currentBalance >= paymentAmount) {
            double updatedBalance = currentBalance - paymentAmount;
            loggedInUser.setBalance(updatedBalance);
            usersRepository.save(loggedInUser);



            redirectAttributes.addFlashAttribute("success", "Payment successful.");
        } else {
            redirectAttributes.addFlashAttribute("error", "Insufficient balance.");
        }

        return "redirect:/index";
    }

    @GetMapping("/profile")
    public String profile(Model model, HttpSession session) {
        Users loggedInUser = (Users) session.getAttribute("loggedInUser");
        if (loggedInUser != null) {
            model.addAttribute("loggedInUser", loggedInUser);
        }
        return "profile";
    }

    @PostMapping("/profile/process-topup")
    public String processTopUp(@RequestParam("amount") double amount, HttpSession session, RedirectAttributes redirectAttributes) {
        Users loggedInUser = (Users) session.getAttribute("loggedInUser");

        if (loggedInUser == null) {
            return "redirect:/login";
        }

        double currentBalance = loggedInUser.getBalance();
        double updatedBalance = currentBalance + amount;
        loggedInUser.setBalance(updatedBalance);
        usersRepository.save(loggedInUser);

        redirectAttributes.addFlashAttribute("success", "Top up successful.");

        return "redirect:/profile";
    }

    @PostMapping("/profile/process-payment")
    public String processPayment(@RequestParam("amount") double amount, HttpSession session, HttpServletRequest request, Model model) {
        Users loggedInUser = (Users) session.getAttribute("loggedInUser");

        if (loggedInUser == null) {
            return "redirect:/login";
        }

        String vnpTxnRef = UUID.randomUUID().toString();
        String vnpOrderInfo = "Top-up balance";
        String vnpLocale = "vn";
        String vnpCurrCode = "VND";
        long vnpAmount = (long) (amount * 100);

        String vnpCreateDate = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
        Calendar cld = Calendar.getInstance(TimeZone.getTimeZone("Etc/GMT+7"));
        cld.add(Calendar.MINUTE, 15);
        String vnpExpireDate = new SimpleDateFormat("yyyyMMddHHmmss").format(cld.getTime());

        Map<String, String> vnpParams = new HashMap<>();
        vnpParams.put("vnp_Version", "2.1.0");
        vnpParams.put("vnp_Command", "pay");
        vnpParams.put("vnp_TmnCode", vnpayTmnCode);
        vnpParams.put("vnp_Amount", String.valueOf(vnpAmount));
        vnpParams.put("vnp_CurrCode", vnpCurrCode);
        vnpParams.put("vnp_TxnRef", vnpTxnRef);
        vnpParams.put("vnp_OrderInfo", vnpOrderInfo);
        vnpParams.put("vnp_OrderType", "other");
        vnpParams.put("vnp_Locale", vnpLocale);
        vnpParams.put("vnp_ReturnUrl", vnpayReturnUrl);
        vnpParams.put("vnp_IpAddr", request.getRemoteAddr());
        vnpParams.put("vnp_CreateDate", vnpCreateDate);
        vnpParams.put("vnp_ExpireDate", vnpExpireDate);

        // Build the query string and secure hash
        String queryUrl = buildQueryUrl(vnpParams, vnpayUrl, vnpayHashSecret);

        return "redirect:" + queryUrl;
    }



    // Helper method to build the query URL
    private String buildQueryUrl(Map<String, String> vnpParams, String vnpayUrl, String vnpayHashSecret) {
        List<String> fieldNames = new ArrayList<>(vnpParams.keySet());
        Collections.sort(fieldNames);

        StringBuilder query = new StringBuilder();
        StringBuilder hashData = new StringBuilder();
        Iterator<String> itr = fieldNames.iterator();
        while (itr.hasNext()) {
            String fieldName = itr.next();
            String fieldValue = vnpParams.get(fieldName);
            if (fieldValue != null && !fieldValue.isEmpty()) {
                try {
                    String encodedFieldName = URLEncoder.encode(fieldName, StandardCharsets.US_ASCII.toString());
                    String encodedFieldValue = URLEncoder.encode(fieldValue, StandardCharsets.US_ASCII.toString());

                    query.append(encodedFieldName);
                    query.append('=');
                    query.append(encodedFieldValue);

                    hashData.append(encodedFieldName);
                    hashData.append('=');
                    hashData.append(encodedFieldValue);

                    if (itr.hasNext()) {
                        query.append('&');
                        hashData.append('&');
                    }
                } catch (UnsupportedEncodingException e) {
                    e.printStackTrace();
                }
            }
        }

        String vnp_SecureHash = VNPayConfig.hmacSHA512(vnpayHashSecret, hashData.toString());
        query.append("&vnp_SecureHash=").append(vnp_SecureHash);

        return vnpayUrl + "?" + query.toString();
    }


    // Helper method to verify the signature
    private boolean verifySignature(Map<String, String> fields, String vnp_SecureHash, String vnpayHashSecret) {
        StringBuilder hashData = new StringBuilder();
        List<String> fieldNames = new ArrayList<>(fields.keySet());
        Collections.sort(fieldNames);
        for (String fieldName : fieldNames) {
            if (!fieldName.equals("vnp_SecureHash") && !fieldName.equals("vnp_SecureHashType")) {
                String fieldValue = fields.get(fieldName);
                if ((fieldValue != null) && (fieldValue.length() > 0)) {
                    hashData.append(fieldName);
                    hashData.append('=');
                    hashData.append(fieldValue);
                    hashData.append('&');
                }
            }
        }
        // Remove the last '&'
        if (hashData.length() > 0) {
            hashData.setLength(hashData.length() - 1);
        }

        String calculatedHash = VNPayConfig.hmacSHA512(vnpayHashSecret, hashData.toString());
        return calculatedHash.equals(vnp_SecureHash);
    }
}
