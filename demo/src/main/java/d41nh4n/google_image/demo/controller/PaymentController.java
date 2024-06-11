package d41nh4n.google_image.demo.controller;

import jakarta.servlet.http.HttpServletRequest;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import d41nh4n.google_image.demo.entity.Payment.Request;
import d41nh4n.google_image.demo.entity.Payment.TransactionHistory;
import d41nh4n.google_image.demo.entity.User.User;
import d41nh4n.google_image.demo.repository.RequestRepository;
import d41nh4n.google_image.demo.repository.TransactionHistoryRepository;
import d41nh4n.google_image.demo.service.UserService;
import d41nh4n.google_image.demo.service.VNPayService;

import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Optional;

@Controller
@RequiredArgsConstructor
@RequestMapping("/payment")
public class PaymentController {

    private final UserService userService;
    private final VNPayService vnPayService;
    private final RequestRepository requestRepository;
    private final TransactionHistoryRepository transactionHistoryRepository;



    @GetMapping
    public String index(Model model) {
        List<Request> requests = requestRepository.findAll();
        model.addAttribute("requests", requests);
        return "payment-detail";
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
        return "redirect:/payment/order";
    }

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
            return "payment-fail";
        }

        if (paymentStatus == 1) {
            User sender = userService.getUserById(requesterId);
            User receiver = userService.getUserById(responderId);
            Optional<Request> requestPayment = requestRepository.findById(Long.parseLong(requestId));

            TransactionHistory transaction = new TransactionHistory();
            transaction.setTransPayment(Double.parseDouble(totalPrice));
            transaction.setTransDate(timestamp);
            transaction.setSenderId(sender);
            transaction.setReceiverId(receiver);
            transaction.setRequest(requestPayment.get());
            transaction.setRequestStatus(requestStatusInt);
            Long idRe = requestPayment.get().getRequestId();
            transactionHistoryRepository.save(transaction);
            requestRepository.updateStatusById(idRe, true);
            model.addAttribute("orderId", orderInfo);
            model.addAttribute("totalPrice", totalPrice);
            model.addAttribute("paymentTime", paymentTime);
            model.addAttribute("transactionId", transactionId);

            return "payment-success";
        } else {
            return "payment-fail";
        }
    }

}
