/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.example.demo.entity;

/**
 *
 * @author DAO
 */
import jakarta.persistence.*;

import java.time.ZonedDateTime;
import java.util.Date;

import com.example.demo.entity.user.User;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "Comment")
@NoArgsConstructor
@AllArgsConstructor
@Setter
@Getter
public class Comment {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int commentId;

    @Column(nullable = false, columnDefinition = "NVARCHAR(MAX)")
    private String commentContent;

    @ManyToOne
    @JoinColumn(name = "commenter_id", nullable = false)
    private User commenter;

    @ManyToOne
    @JoinColumn(name = "receiver_id")
    private User receiver;

    @Column(nullable = false)
    private ZonedDateTime createdAt = ZonedDateTime.now();

    @Column(nullable = false)
    private Boolean isViolation = false;

    @Column(name = "rating_value", nullable = true)
    private int ratingValue;
    // Getters and setters
}
