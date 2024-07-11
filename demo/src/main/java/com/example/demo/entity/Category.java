/*
* Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
* Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
*/
package com.example.demo.entity;

import java.lang.annotation.Repeatable;

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
@Table(name = "CATEGORIESINFO")
@NoArgsConstructor
@AllArgsConstructor
@Setter
@Getter
public class Category {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "category_id")
    private int categoryId;

    @Column(name = "category_name", length = 100, nullable = false)
    private String categoryName;

    @Column(name = "Description", columnDefinition = "NVARCHAR(255)")
    private String description;

    // Getters and setters
}
