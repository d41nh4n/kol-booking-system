/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package d41nh4n.google_image.demo.controller;

import d41nh4n.google_image.demo.dto.CategoryCountDTO;
import d41nh4n.google_image.demo.service.ProfileCategoryService;
import d41nh4n.google_image.demo.service.TransactionHistoryService;
import d41nh4n.google_image.demo.service.UserService;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

/**
 *
 * @author DAO
 */
@RequestMapping("/admin/home")
@Controller
public class AdminHome {

    @Autowired
    private TransactionHistoryService transactionHistoryService;

    @Autowired
    private UserService userService;

    @Autowired
    private ProfileCategoryService profileCategoryService;
    
    @GetMapping
    public String getAdminHome(Model model) {
        int currentYear = java.util.Calendar.getInstance().get(java.util.Calendar.YEAR);
        List<Integer> yearsWithPayment = transactionHistoryService.getYearsWithPayment();
        List<Integer> yearsWithUsers = userService.getYearsWithUsers();
        List<Integer> years = yearsWithPayment.stream()
                                              .filter(yearsWithUsers::contains)
                                              .collect(Collectors.toList());

        model.addAttribute("years", years);
        model.addAttribute("currentYear", currentYear);
        model.addAttribute("viewName", "combined_home");

        return "admin-layout";
    }

    @PostMapping("/totalPaymentPerMonth")
    public ResponseEntity<?> showTotalPaymentPerMonth(@RequestParam("year") int year) {
        List<Double> totalPayments = transactionHistoryService.getTotalPaymentPerMonth(year);
        System.out.println("Total Payment " + totalPayments.size());
        Map<String, Object> responseData = new HashMap<>();
        responseData.put("year", year);
        responseData.put("totalPayments", totalPayments);
        return ResponseEntity.ok(responseData);
    }

    @PostMapping("/userCountPerMonth")
    public ResponseEntity<?> showUserCountPerMonth(@RequestParam("year") int year) {
        List<Long> userCounts = userService.getUserCountByMonthAndYear(year);
        Map<String, Object> responseData = new HashMap<>();
        responseData.put("year", year);
        responseData.put("userCounts", userCounts);
        return ResponseEntity.ok(responseData);
    }
    
    @PostMapping("/categoryCount")
    public ResponseEntity<?> showCategoryCount() {
        List<CategoryCountDTO> categoryCounts = profileCategoryService.getCategoryCounts();
        Map<String, Object> responseData = new HashMap<>();
        responseData.put("categoryCounts", categoryCounts);
        return ResponseEntity.ok(responseData);
    }
}

//@Controller
//public class AdminHome {
//
//    @Autowired
//    private TransactionHistoryService transactionHistoryService;
//
//    @GetMapping("/totalPaymentPerMonth")
//    public String getTotalPaymentPerMonth(@RequestParam("year") int year, Model model) {
//        List<Double> totalPayments = transactionHistoryService.getTotalPaymentPerMonth(year);
//        model.addAttribute("year", year);
//        model.addAttribute("totalPayments", totalPayments);
//        return "/transaction_history/chart"; // Tên của trang HTML bạn muốn chuyển hướng đến
//    }
//}


//@Controller
//public class AdminHome {
//
//    @Autowired
//    private TransactionHistoryService transactionHistoryService;
//    @Autowired
//    private UserService userService;
////    @GetMapping("/admin/year")
////    public String getTotalPaymentPerMonth(Model model) {
////        // Truy vấn lịch sử giao dịch để lấy danh sách các năm có chuyển tiền
////        List<Integer> yearsWithPayment = transactionHistoryService.getYearsWithPayment();
////        // Truyền danh sách các năm này từ controller đến trang HTML
////        model.addAttribute("years", yearsWithPayment);
////        return "transaction_history/select_year";
////    }
////
////    @PostMapping("/totalPaymentPerMonth")
////    public String showTotalPaymentPerMonth(@RequestParam("year") int year, Model model) {
////        // Lấy dữ liệu từ service dựa trên năm được chọn
////        List<Double> totalPayments = transactionHistoryService.getTotalPaymentPerMonth(year);
////        // Chuyển dữ liệu đến trang hiển thị biểu đồ
////        model.addAttribute("year", year);
////        model.addAttribute("totalPayments", totalPayments);
////        return "transaction_history/chart";
////    }
//    
//    @GetMapping("/admin/year")
//    public String getTotalPaymentPerMonth(Model model) {
//        // Truy vấn lịch sử giao dịch để lấy danh sách các năm có chuyển tiền
//        List<Integer> yearsWithPayment = transactionHistoryService.getYearsWithPayment();
//        // Truyền danh sách các năm này từ controller đến trang HTML
//        model.addAttribute("years", yearsWithPayment);
//        return "transaction_history/select_year";
//    }
//
//    @PostMapping("/admin/totalPaymentPerMonth")
//    public ResponseEntity<?> showTotalPaymentPerMonth(@RequestParam("year") int year) {
//        // Lấy dữ liệu từ service dựa trên năm được chọn
//        List<Double> totalPayments = transactionHistoryService.getTotalPaymentPerMonth(year);
//        // Tạo một đối tượng JSON chứa dữ liệu
//        Map<String, Object> responseData = new HashMap<>();
//        responseData.put("year", year);
//        responseData.put("totalPayments", totalPayments);
//        // Trả về dữ liệu dưới dạng JSON
//        return ResponseEntity.ok(responseData);
//    }
//    
//    
//        @GetMapping("/admin/home")
//    public String getAdminHome(Model model) {
//        int currentYear = java.util.Calendar.getInstance().get(java.util.Calendar.YEAR);
//        List<Integer> yearsWithUsers = userService.getYearsWithUsers();
//        model.addAttribute("years", yearsWithUsers);
//        model.addAttribute("currentYear", currentYear);
//        return "transaction_history/admin_home";
//    }
//
//    @PostMapping("/admin/userCountPerMonth")
//    public ResponseEntity<?> showUserCountPerMonth(@RequestParam("year") int year) {
//        List<Long> userCounts = userService.getUserCountByMonthAndYear(year);
//        Map<String, Object> responseData = new HashMap<>();
//        responseData.put("year", year);
//        responseData.put("userCounts", userCounts);
//        return ResponseEntity.ok(responseData);
//    }
//}
