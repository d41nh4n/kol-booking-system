package com.duc.vnpaydemo;

import com.duc.vnpaydemo.config.VNPayService;
import com.duc.vnpaydemo.model.TransactionHistory;
import com.duc.vnpaydemo.repository.RequestRepository;
import com.duc.vnpaydemo.repository.TransactionHistoryRepository;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;

@org.springframework.stereotype.Controller
public class Controller {
    @Autowired
    private VNPayService vnPayService;

    @Autowired
    private RequestRepository requestRepository;

    @Autowired
    private TransactionHistoryRepository transactionHistoryRepository;

    @GetMapping("/order")
    public String submidOrder(HttpServletRequest request) {
        HttpSession session = request.getSession();
        int orderTotal = Integer.parseInt((String) session.getAttribute("amount"));
        String orderInfo = (String) session.getAttribute("info");
        String baseUrl = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort();
        String vnpayUrl = vnPayService.createOrder(orderTotal, orderInfo, baseUrl);
        return "redirect:" + vnpayUrl;
    }

    @GetMapping("/order-status")
    public String GetMapping(HttpServletRequest request, Model model) {
        HttpSession session = request.getSession();
        int paymentStatus = vnPayService.orderReturn(request);

        String orderInfo = request.getParameter("vnp_OrderInfo");
        String paymentTime = request.getParameter("vnp_PayDate");
        String transactionId = request.getParameter("vnp_TransactionNo");
        String totalPrice = request.getParameter("vnp_Amount");

        String requesterId = (String) session.getAttribute("requesterId");
        String responderId = (String) session.getAttribute("responderId");
        String requestId = (String) session.getAttribute("requestId");
        String requestStatus = (String) session.getAttribute("requestStatus");
        int requestStatusInt = requestStatus.toLowerCase().equals("true") ? 1 : 0;

        Timestamp timestamp = null;
        try {
            SimpleDateFormat inputFormat = new SimpleDateFormat("yyyyMMddHHmmss");
            SimpleDateFormat outputFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            java.util.Date parsedDate = inputFormat.parse(paymentTime);
            String formattedDate = outputFormat.format(parsedDate);
            timestamp = Timestamp.valueOf(formattedDate);
        } catch (ParseException e) {
            e.printStackTrace();
            return "orderfail";
        }

        if (paymentStatus == 1) {
            TransactionHistory transaction = new TransactionHistory();
            transaction.setTransPayment(Double.parseDouble(totalPrice));
            transaction.setTransDate(timestamp);
            transaction.setSenderId(Integer.parseInt(requesterId));
            transaction.setReceiverId(Integer.parseInt(responderId));
            transaction.setRequestId(Integer.parseInt(requestId));
            transaction.setRequestStatus(requestStatusInt);

            transactionHistoryRepository.save(transaction);
            Long idRe = Long.parseLong(requestId);
            requestRepository.updateStatusById(idRe, true);
            model.addAttribute("orderId", orderInfo);
            model.addAttribute("totalPrice", totalPrice);
            model.addAttribute("paymentTime", paymentTime);
            model.addAttribute("transactionId", transactionId);

            return "ordersuccess";
        } else {
            return "orderfail";
        }
    }

}
