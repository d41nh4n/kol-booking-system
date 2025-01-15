package d41nh4n.google_image.demo.controller;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import d41nh4n.google_image.demo.entity.TransactionHistory;
import d41nh4n.google_image.demo.entity.TypeTransaction;
import d41nh4n.google_image.demo.entity.user.User;
import d41nh4n.google_image.demo.repository.RequestRepository;
import d41nh4n.google_image.demo.repository.TransactionHistoryRepository;
import d41nh4n.google_image.demo.service.UserService;
import d41nh4n.google_image.demo.service.VNPayService;
import d41nh4n.google_image.demo.validation.Utils;

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
    private final Utils utils;

    @GetMapping
    public String index(Model model) {
        List<d41nh4n.google_image.demo.entity.request.Request> requests = requestRepository.findAll();
        model.addAttribute("requests", requests);
        return "payment-detail";
    }

    @PostMapping("/order")
    public String submitOrder(@RequestParam(name = "amount") String amount, HttpServletRequest request, Model model) {
        int amountNumber;
        try {
            amountNumber = utils.stringToInt(amount);
            if (amountNumber <= 0) {
                throw new NumberFormatException("Amount must be greater than zero");
            }
        } catch (Exception e) {
            return "redirect:/payment/recharge?invalidNumber=true";
        }
        HttpSession session = request.getSession();
        String orderInfo = "Recharge Account";
        String baseUrl = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort();
        String vnpayUrl = vnPayService.createOrder(amountNumber, orderInfo, baseUrl);
        session.setAttribute("userId", utils.getPrincipal().getUserId());
        return "redirect:" + vnpayUrl;
    }

    @GetMapping("/order-status")
    public String handlePaymentStatus(HttpServletRequest request, Model model) {
        HttpSession session = request.getSession();
        int paymentStatus = vnPayService.orderReturn(request);

        String orderInfo = request.getParameter("vnp_OrderInfo");
        String paymentTime = request.getParameter("vnp_PayDate");
        String transactionId = request.getParameter("vnp_TransactionNo");
        String totalPrice = request.getParameter("vnp_Amount");

        // Retrieve user ID from session
        int userId = (int) session.getAttribute("userId");

        // Convert totalPrice from string to double
        double amountPaid = Double.parseDouble(totalPrice) / 100; // Assuming the amount is in minor units

        // Check if the transaction has already been processed using the VNPay
        // transaction ID
        Optional<TransactionHistory> existingTransaction = transactionHistoryRepository
                .findByTransactionId(transactionId);
        if (existingTransaction.isPresent()) {
            model.addAttribute("orderId", orderInfo);
            model.addAttribute("totalPrice", totalPrice);
            model.addAttribute("paymentTime", paymentTime);
            model.addAttribute("transactionId", transactionId);
            return "payment-success";
        }

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
            // Update user's balance
            userService.updateUserBalance(userId, amountPaid);
            User userReceiver = userService.getUserById(userId);

            // Save transaction history
            TransactionHistory transaction = new TransactionHistory();
            transaction.setTransactionId(transactionId); // Set VNPay transaction ID
            transaction.setReceiver(userReceiver);
            transaction.setTransPayment(amountPaid);
            transaction.setType(TypeTransaction.PAY_IN);
            transaction.setTransStatus(true);
            transaction.setTransDate(timestamp);
            transactionHistoryRepository.save(transaction);

            model.addAttribute("orderId", orderInfo);
            model.addAttribute("totalPrice", totalPrice);
            model.addAttribute("paymentTime", paymentTime);
            model.addAttribute("transactionId", transactionId);

            return "payment-success";
        } else {
            return "payment-fail";
        }
    }

    @GetMapping("/recharge")
    public String showRechargePage(@RequestParam(name = "invalidNumber", required = false) Boolean invalidNumber,
            Model model) {
        model.addAttribute("invalidNumber", invalidNumber);
        return "recharge-page";
    }
}
