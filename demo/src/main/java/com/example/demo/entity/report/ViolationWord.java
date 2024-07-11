/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.example.demo.entity.report;

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
@Table(name = "VIOLATIONWORDS")
@NoArgsConstructor
@AllArgsConstructor
@Setter
@Getter
public class ViolationWord {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer wordId;

    @Column(nullable = false)
    private String word;

    @Column(nullable = false)
    private int violationLevel;

    // Getters and setters
}
