/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package d41nh4n.google_image.demo.service;


import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import d41nh4n.google_image.demo.entity.Comment;
import d41nh4n.google_image.demo.entity.report.Report;
import d41nh4n.google_image.demo.repository.CommentRepository;
import d41nh4n.google_image.demo.repository.ReportRepository;

/**
 *
 * @author DAO
 */
@Service
public class ReportService{
    @Autowired
    private ReportRepository reportRepository;
    
    @Autowired
    private CommentRepository commentRepository;
    
    public Page<Report> findPaginated(Pageable pageable) {
      return  reportRepository.findAll(pageable);
    }

    
    public Page<Report> searchCategories(String keyword, Pageable pageable) {
        return  reportRepository.searchReports(keyword, pageable);
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
}
