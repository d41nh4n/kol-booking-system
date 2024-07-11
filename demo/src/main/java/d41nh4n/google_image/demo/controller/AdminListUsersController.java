package d41nh4n.google_image.demo.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import d41nh4n.google_image.demo.dto.ProfileDTO;
import d41nh4n.google_image.demo.dto.UserDTO;
import d41nh4n.google_image.demo.entity.user.Gender;
import d41nh4n.google_image.demo.entity.user.User;
import d41nh4n.google_image.demo.mapper.ProfileMapper;
import d41nh4n.google_image.demo.service.ProfileService;
import d41nh4n.google_image.demo.service.UserService;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;

import java.util.Optional;

@Controller
@RequestMapping("/admin")
public class AdminListUsersController {

    @Autowired
    private UserService userService;

    @Autowired
    private ProfileService profileService;

    @Autowired
    private ProfileMapper profileMapper;

    @GetMapping("/list_users")
    public String listUsers(Model model,
            @RequestParam("page") Optional<Integer> page,
            @RequestParam(value = "keyword", required = false) String keyword) {
        int currentPage = page.orElse(1);
        int pageSize = 10;
        Page<UserDTO> userPage;
        String processedKeyword = keyword != null ? keyword.trim() : "";

        if (!processedKeyword.isEmpty()) {
            Gender gender = null;
            boolean isBanKeyword = processedKeyword.equalsIgnoreCase("ban");
            boolean isUnbanKeyword = processedKeyword.equalsIgnoreCase("unban");

            // Adjust keyword if it contains 'ban' or 'unban'
            if (isBanKeyword) {
                processedKeyword = processedKeyword.replaceAll("(?i)ban", "").trim();
            } else if (isUnbanKeyword) {
                processedKeyword = processedKeyword.replaceAll("(?i)unban", "").trim();
            }

            // Determine the appropriate search method
            if (isBanKeyword) {
                userPage = userService.searchUsersWithBan(processedKeyword, gender,
                        PageRequest.of(currentPage - 1, pageSize));
            } else if (isUnbanKeyword) {
                userPage = userService.searchUsersWithUnBan(processedKeyword, gender,
                        PageRequest.of(currentPage - 1, pageSize));
            } else {
                // Check if the processedKeyword is directly a gender value
                try {
                    gender = Gender.valueOf(processedKeyword.toUpperCase());
                    userPage = userService.searchUsers(processedKeyword, gender,
                            PageRequest.of(currentPage - 1, pageSize));
                } catch (IllegalArgumentException e) {
                    // If not a valid enum value, treat it as a regular search keyword
                    userPage = userService.searchUsers(processedKeyword, null,
                            PageRequest.of(currentPage - 1, pageSize));
                }
            }

            model.addAttribute("keyword", keyword); // Original keyword for display
        } else {
            userPage = userService.findPaginated(PageRequest.of(currentPage - 1, pageSize));
        }

        model.addAttribute("userPage", userPage);
        model.addAttribute("users", userPage.getContent());
        model.addAttribute("currentPage", currentPage);
        model.addAttribute("totalPages", userPage.getTotalPages());
        model.addAttribute("viewName", "admin/users/listusers");

        return "admin-layout";
    }

    // //Hiển thị thông tin search theo phân trang
    // @GetMapping("/search-result")
    // public String searchUsers(@RequestParam("keyword") String keyword, Model
    // model, @RequestParam("page") Optional<Integer> page) {
    // int currentPage = page.orElse(1);
    // int pageSize = 10;
    // Page<UserDTO> userPage = null; // Khởi tạo userPage là null
    //
    // if (keyword.toLowerCase().contains("unban")) {
    // userPage = userService.searchUsersWithBan(keyword, PageRequest.of(currentPage
    // - 1, pageSize));
    // } else if (keyword.toLowerCase().contains("ban")) {
    // userPage = userService.searchUsersWithUnBan(keyword,
    // PageRequest.of(currentPage - 1, pageSize));
    // } else {
    // userPage = userService.searchUsers(keyword, PageRequest.of(currentPage - 1,
    // pageSize));
    // }
    //
    // model.addAttribute("userPage", userPage);
    // model.addAttribute("users", userPage.getContent());
    // model.addAttribute("currentPage", currentPage);
    // model.addAttribute("totalPages", userPage.getTotalPages());
    // model.addAttribute("keyword", keyword);
    //
    // return "admin/users/searchresult";
    // }

    // BanAction
    @PostMapping("/users/ban/{id}")
    public ResponseEntity<String> banUser(@PathVariable Integer id) {
        User user = userService.findById(id);
        if (user != null) {
            if (!user.isLocked()) {
                user.setLocked(true); // Set locked status to true
                userService.save(user);
                return ResponseEntity.ok("User with ID " + id + " has been banned.");
            } else {
                return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("User is already banned.");
            }
        }
        return ResponseEntity.status(HttpStatus.NOT_FOUND).body("User not found.");
    }

    @PostMapping("/users/unban/{id}")
    public ResponseEntity<String> unbanUser(@PathVariable Integer id) {
        User user = userService.findById(id);
        if (user != null) {
            if (user.isLocked()) {
                user.setLocked(false); // Set locked status to false
                userService.save(user);
                return ResponseEntity.ok("User with ID " + id + " has been unbanned.");
            } else {
                return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("User is not banned.");
            }
        }
        return ResponseEntity.status(HttpStatus.NOT_FOUND).body("User not found.");
    }

    // ViewAction
    @GetMapping("/users/view/{id}")
    public String viewUserProfile(@PathVariable Integer id, @RequestParam("page") Optional<Integer> page, Model model) {
        UserDTO userDTO = userService.getUserDTOById(id);
        ProfileDTO profileDTO = profileService.getUserProfile(id);
        int currentPage = page.orElse(1); // Lấy trang hiện tại từ tham số request (nếu có)

        if (userDTO != null && profileDTO != null) {
            model.addAttribute("profile", profileDTO);
            model.addAttribute("currentPage", currentPage); // Thêm currentPage vào model
            return "admin/users/profile";
        } else {
            return "admin/users/profile";
        }
    }
}

// @GetMapping("/list_users/{pageNo}")
// public String usersPage(@PathVariable("page") int pageNo, Model model){
// Page<User> users = userService.pageUsers(pageNo);
// model.addAttribute("users", users);
// model.addAttribute("Title", users.getContent());
// model.addAttribute("currentPage", pageNo);
// model.addAttribute("size", users.getSize());
// model.addAttribute("totalPages", users.getTotalPages());
// return "listusers";
// }

// @PostMapping("/users/delete/{id}")
// public String deleteUser(@PathVariable Integer id) {
// userService.deleteUserById(id);
// return "redirect:/admin/list_users";
// }