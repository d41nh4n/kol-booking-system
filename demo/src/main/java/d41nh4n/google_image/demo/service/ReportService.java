/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package d41nh4n.google_image.demo.service;

import java.sql.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import d41nh4n.google_image.demo.dto.respone.ResponeJson;
import d41nh4n.google_image.demo.entity.Comment;
import d41nh4n.google_image.demo.entity.report.Report;
import d41nh4n.google_image.demo.entity.user.User;
import d41nh4n.google_image.demo.repository.CommentRepository;
import d41nh4n.google_image.demo.repository.ReportRepository;
import d41nh4n.google_image.demo.validation.Utils;

/**
 *
 * @author DAO
 */
@Service
public class ReportService {
    @Autowired
    private ReportRepository reportRepository;

    @Autowired
    private CommentRepository commentRepository;

    @Autowired
    private UserService userService;

    @Autowired
    private CommentService commentService;

    @Autowired
    private Utils utils;

    public Page<Report> findPaginated(Pageable pageable) {
        return reportRepository.findAll(pageable);
    }

    public Page<Report> searchCategories(String keyword, Pageable pageable) {
        return reportRepository.searchReports(keyword, pageable);
    }

    public void deleteReportById(int reportId) {
        if (reportRepository.existsById(reportId)) {
            reportRepository.deleteById(reportId);
        }
    }

    public void saveReport(Report report) {
        // Ensure the comment is saved first
        Comment comment = report.getReportedComment();
        if (comment != null) {
            commentRepository.save(comment);
        }
        // Now save the report
        reportRepository.save(report);
    }

    public ResponseEntity<ResponeJson> reportComment(int userId, String reportedUserId, String commentId,
            String reason,
            String decription, Date date) {
        ResponeJson responeJson = new ResponeJson();
        try {
            int reportedUserIdNum = utils.stringToInt(reportedUserId);
            int commentIdNum = utils.stringToInt(commentId);

            User userReport = userService.findById(userId);
            User userReported = userService.findById(reportedUserIdNum);

            Comment comment = commentService.findById(commentIdNum);

            Report report = new Report();
            report.setDescription(decription);
            report.setCreateDate(date);
            report.setReason(reason);
            report.setReportUser(userReport);
            report.setReportedUser(userReported);
            report.setReportedComment(comment);

            saveReport(report);

            responeJson.setStatus(HttpStatus.OK.value());
            responeJson.setMessage("Report success!");
            return ResponseEntity.ok(responeJson);
        } catch (Exception e) {
            responeJson.setStatus(HttpStatus.BAD_REQUEST.value());
            responeJson.setMessage("Invalid report!");
            return ResponseEntity.ok(responeJson);
        }
    }
}
