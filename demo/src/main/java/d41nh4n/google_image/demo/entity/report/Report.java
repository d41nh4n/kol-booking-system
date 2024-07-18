        /*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package d41nh4n.google_image.demo.entity.report;

/**
 *
 * @author DAO
 */
import jakarta.persistence.*;
import java.time.LocalDateTime;
import java.util.Date;

import d41nh4n.google_image.demo.entity.Comment;
import d41nh4n.google_image.demo.entity.user.User;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "Report")
@NoArgsConstructor
@AllArgsConstructor
@Setter
@Getter
public class Report {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "report_id")
    private Integer reportId;

    @Column(name = "description", length = 50, nullable = false)
    private String description;

    @Column(name = "reason", columnDefinition = "NVARCHAR(MAX)", nullable = false)
    private String reason;

    @Column(name = "create_date")
    private Date createDate;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "report_user")
    private User reportUser;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "reported_user")
    private User reportedUser;
    
    @ManyToOne
    @JoinColumn(name = "comment_id", nullable = true)
    private Comment reportedComment;

    // Getters and setters
}
