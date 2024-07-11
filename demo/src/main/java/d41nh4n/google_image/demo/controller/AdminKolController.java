/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package d41nh4n.google_image.demo.controller;

import d41nh4n.google_image.demo.entity.KolRegistration;
import d41nh4n.google_image.demo.entity.user.Gender;
import d41nh4n.google_image.demo.entity.user.User;
import d41nh4n.google_image.demo.service.EmailService;
import d41nh4n.google_image.demo.service.KolRegistrationService;
import d41nh4n.google_image.demo.service.UserService;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Optional;
import java.util.Random;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

/**
 *
 * @author DAO
 */
@Controller
@RequestMapping("/admin")
public class AdminKolController {

    @Autowired
    private KolRegistrationService kolRegistrationService;

    @Autowired
    private UserService userService;

    @Autowired
    private EmailService emailService;

    @GetMapping("/kolList")
    public String showKolList(Model model) {
        List<KolRegistration> kolRegistrations = kolRegistrationService.getAllRegistrations();

        // Thêm thuộc tính imageUrlsList cho từng KolRegistration để hiển thị nhiều ảnh
        for (KolRegistration kol : kolRegistrations) {
            if (kol.getImageUrls() != null && !kol.getImageUrls().isEmpty()) {
                String[] imageUrls = kol.getImageUrls().split(",");
                kol.setImageUrlsList(Arrays.asList(imageUrls)); // Chuyển mảng thành List và gán vào imageUrlsList
            } else {
                kol.setImageUrlsList(new ArrayList<>()); // Khởi tạo List rỗng nếu không có ảnh
            }
        }

        model.addAttribute("kolRegistrations", kolRegistrations);
        model.addAttribute("viewName", "kolList");

        return "admin-layout";
    }

    @PostMapping("/createAccounts")
    public String createKolAccounts(@RequestParam(name = "kolIds", required = false) List<Long> kolIds,
            RedirectAttributes redirectAttributes) {
        if (kolIds == null || kolIds.isEmpty()) {
            redirectAttributes.addFlashAttribute("messageError", "No KOL IDs provided.");
            return "redirect:/admin/kolList";
        }
        List<Long> successfullyCreatedIds = new ArrayList<>();
        List<Long> failedIds = new ArrayList<>();

        for (Long kolId : kolIds) {
            Optional<KolRegistration> kolRegistrationOpt = kolRegistrationService.getRegistrationById(kolId);
            if (kolRegistrationOpt.isPresent()) {
                KolRegistration kolRegistration = kolRegistrationOpt.get();
                String email = kolRegistration.getEmail();
                String username = email.split("@")[0];

                if (userService.existsByEmail(email) || userService.existsByUsername(username)) {
                    failedIds.add(kolId);
                    continue;
                }

                String password = generateRandomPassword();
                String hashedPassword = hashPassword(password);

                User newUser = new User();
                newUser.setEmail(email);
                newUser.setGender(Gender.OTHER);
                newUser.setLocked(false);
                newUser.setPasswordHash(hashedPassword);
                newUser.setRole("KOL");
                newUser.setUsername(username);
                userService.save(newUser);

                sendEmailWithCredentials(email, username, password);

                kolRegistrationService.deleteRegistration(kolId);
                successfullyCreatedIds.add(kolId);
            } else {
                failedIds.add(kolId);
            }
        }

        if (!successfullyCreatedIds.isEmpty()) {
            redirectAttributes.addFlashAttribute("message",
                    "Accounts created successfully for IDs: " + successfullyCreatedIds);
        }

        if (!failedIds.isEmpty()) {
            redirectAttributes.addFlashAttribute("messageError", "Failed to create accounts for IDs: " + failedIds);
        }

        return "redirect:/admin/kolList";
    }

    private String generateRandomPassword() {
        String characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
        Random random = new Random();
        StringBuilder password = new StringBuilder();
        for (int i = 0; i < 10; i++) {
            password.append(characters.charAt(random.nextInt(characters.length())));
        }
        return password.toString();
    }

    private String hashPassword(String password) {
        return new BCryptPasswordEncoder().encode(password);
    }

    private void sendEmailWithCredentials(String email, String username, String password) {
        String subject = "Your KOL Account Credentials";
        String body = "Dear " + username + ",\n\nYour KOL account has been created.\n\nUsername: " + username
                + "\nPassword: " + password
                + "\n\nPlease change your password after logging in for the first time.\n\nBest regards,\nAdmin Team";
        emailService.sendEmail(email, subject, body);
    }

    private void sendRejectionEmail(String email, String username) {
        String subject = "KOL Registration Rejected";
        String body = "Dear " + username
                + ",\n\nWe regret to inform you that your request to become a KOL has been rejected.\n\nBest regards,\nAdmin Team";
        emailService.sendEmail(email, subject, body);
    }

    @PostMapping("/deleteKol")
    public String deleteKol(@RequestParam("kolId") Long kolId, RedirectAttributes redirectAttributes) {
        // Retrieve the KOL registration details before deleting
        Optional<KolRegistration> kolRegistration = kolRegistrationService.getRegistrationById(kolId);

        if (kolRegistration != null) {
            // Send rejection email
            sendRejectionEmail(kolRegistration.get().getEmail(), kolRegistration.get().getName());

            // Delete the registration
            kolRegistrationService.deleteRegistration(kolId);
            redirectAttributes.addFlashAttribute("message", "KOL deleted successfully");
        } else {
            redirectAttributes.addFlashAttribute("error", "KOL registration not found.");
        }

        return "redirect:/admin/kolList";
    }
}
