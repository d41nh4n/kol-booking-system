package com.duc.vnpaydemo.model;

import jakarta.persistence.*;

import java.util.List;

@Entity
@Table(name = "Users")

public class Users {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long user_id;

    private String username;
    private String password_hash;
    private String email;
    private String gender;

    private double balance;

//    @OneToMany(fetch = FetchType.EAGER)
//    @JoinColumn(name = "sender_id")
//    private List<TransactionHistory> transactionHistories;


    // Default constructor
    public Users() {
    }

    public Users(String username, String password_hash) {
        this.username = username;
        this.password_hash = password_hash;
    }

    // Constructor với các tham số mới
    public Users(String username, String password_hash, String email, String gender) {
        this.username = username;
        this.password_hash = password_hash;
        this.email = email;
        this.gender = gender;
    }

    // Getters và Setters
    public Long getId() {
        return user_id;
    }

    public void setId(Long id) {
        this.user_id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password_hash;
    }

    public void setPassword(String password_hash) {
        this.password_hash = password_hash;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public double getBalance() {
        return balance;
    }

    public void setBalance(double balance) {
        this.balance = balance;
    }

//    public List<TransactionHistory> getTransactionHistories() {
//        return transactionHistories;
//    }
//
//    public void setTransactionHistories(List<TransactionHistory> transactionHistories) {
//        this.transactionHistories = transactionHistories;
//    }
}
