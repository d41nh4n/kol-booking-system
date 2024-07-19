/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package d41nh4n.google_image.demo.controller;

import java.time.ZonedDateTime;
import java.util.Date;
import java.util.Optional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import d41nh4n.google_image.demo.dto.ReportDto;
import d41nh4n.google_image.demo.entity.Comment;
import d41nh4n.google_image.demo.entity.notification.Notification;
import d41nh4n.google_image.demo.entity.notification.TypeNotification;
import d41nh4n.google_image.demo.entity.report.Report;
import d41nh4n.google_image.demo.repository.CommentRepository;
import d41nh4n.google_image.demo.repository.ReportRepository;
import d41nh4n.google_image.demo.service.CommentService;
import d41nh4n.google_image.demo.service.NotificationService;
import d41nh4n.google_image.demo.service.ReportService;
import d41nh4n.google_image.demo.service.UserService;
import d41nh4n.google_image.demo.service.ViolationCheckService;
import d41nh4n.google_image.demo.validation.Utils;

/**
 *
 * @author DAO
 */
@Controller
@RequestMapping("/admin/reports")
public class AdminReportController {

    @Autowired
    private ReportService reportService;

    @Autowired
    private UserService userService;

    @Autowired
    private NotificationService notificationService;

    @Autowired
    private CommentService commentService;

    @Autowired
    private ViolationCheckService violationCheckService;

    @Autowired
    private ReportRepository reportRepository;

    @Autowired
    private Utils utils;

    @GetMapping
    public String listReports(@RequestParam("page") Optional<Integer> page,
            @RequestParam("size") Optional<Integer> size,
            @RequestParam(value = "keyword", required = false) String keyword,
            Model model) {
        int currentPage = page.orElse(1);
        int pageSize = size.orElse(10);

        Pageable pageable = PageRequest.of(currentPage - 1, pageSize, Sort.by("createDate").descending());
        Page<Report> reportPage;

        if (keyword != null && !keyword.isEmpty()) {
            reportPage = reportService.searchCategories(keyword, pageable);
            model.addAttribute("keyword", keyword);
        } else {
            reportPage = reportService.findPaginated(pageable);
        }

        model.addAttribute("reportPage", reportPage);

        model.addAttribute("viewName", "list_reports");

        return "admin-layout";
    }

    @PostMapping("/submit")
    public ResponseEntity<?> submitReport(@RequestBody ReportDto reportDto, Model model) {
        int userId = utils.getPrincipal().getUserId();

        return reportService.reportComment(userId, reportDto.getReportedUserId(), reportDto.getCommentId(),
                reportDto.getDescription(), reportDto.getReason(), reportDto.getCreateAt());
    }

    @PostMapping("/delete/{id}")
    public String deleteReport(@PathVariable("id") int reportId, Model model, RedirectAttributes redirectAttributes) {
        try {
            reportService.deleteReportById(reportId);
            redirectAttributes.addFlashAttribute("notification", "Report deleted successfully");
        } catch (Exception ex) {
            redirectAttributes.addFlashAttribute("notification", "Report deleted unSuccessfully");
        }
        return "redirect:/admin/reports"; // Redirect to the list of reports
    }
}
