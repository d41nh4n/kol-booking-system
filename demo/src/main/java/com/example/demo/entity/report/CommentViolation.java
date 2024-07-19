/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package d41nh4n.google_image.demo.entity.report;

import d41nh4n.google_image.demo.entity.Comment;
/**
 *
 * @author DAO
 */
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "COMMENTVIOLATION")
@NoArgsConstructor
@AllArgsConstructor
@Setter
@Getter
public class CommentViolation{
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer commentViolationId;

    @ManyToOne
    @JoinColumn(name = "comment_id", nullable = false)
    private Comment comment;

    @ManyToOne
    @JoinColumn(name = "word_id", nullable = false)
    private ViolationWord violationWord;

    @Column(nullable = false)
    private int violationLevel;

    // Getters and setters
}

