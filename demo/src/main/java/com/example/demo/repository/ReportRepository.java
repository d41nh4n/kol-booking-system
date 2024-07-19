/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package d41nh4n.google_image.demo.repository;

import java.util.List;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import d41nh4n.google_image.demo.entity.report.Report;

/**
 *
 * @author DAO
 */
@Repository
public interface ReportRepository extends JpaRepository<Report, Integer> {
    @Query("SELECT r FROM Report r WHERE " +
            "CAST(r.reportId AS string) LIKE %?1% OR " +
            "r.description LIKE %?1% OR " +
            "r.reason LIKE %?1% OR " +
            "CAST(r.createDate AS string) LIKE %?1% OR " +
            "r.reportUser.username LIKE %?1% OR " +
            "r.reportedUser.username LIKE %?1%")
    Page<Report> searchReports(String keyword, Pageable pageable);
    
}

