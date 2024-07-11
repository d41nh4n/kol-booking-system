package com.example.demo.entity;

import java.time.LocalDateTime;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@Entity
@ToString
@Table(name = "tb_verifycode")
public class VerifyCode {
    @Id
    @Column(name = "id")
    private String id;
    @Column(name = "userid")
    private int userId;
    @Column(name = "email")
    private String email;
    @Column(name = "code")
    private String code;
    @Column(name = "expiryDateTime")
    private LocalDateTime expiryDateTime;
    @Column(name = "numberOfAttempts")
    private int numberOfAttempts;

    public VerifyCode() {
        this.expiryDateTime = LocalDateTime.now().plusMinutes(5);
    }

    public VerifyCode(String id, int userId, String email, String code, int numberOfAttempts) {
        this.id = id;
        this.userId = userId;
        this.email = email;
        this.code = code;
        this.numberOfAttempts = numberOfAttempts;
        this.expiryDateTime = LocalDateTime.now().plusMinutes(5);
    }
}
