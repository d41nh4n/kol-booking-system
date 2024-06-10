package com.duc.vnpaydemo.model;

import jakarta.persistence.*;

import java.sql.Timestamp;

@Entity
@Table(name = "TransactionHistory")
public class TransactionHistory {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long trans_id;

    @Column(name = "trans_payment")
    private double transPayment;

    @Column(name = "trans_date")
    private Timestamp transDate;

    @Column(name = "sender_id")
    private int senderId;

    @Column(name = "receiver_id")
    private int receiverId;

    @Column(name = "request_id")
    private int requestId;

    @Column(name = "request_status")
    private int requestStatus;

    public Long getTransId() {
        return trans_id;
    }

    public void setTransId(Long transId) {
        this.trans_id = transId;
    }

    public double getTransPayment() {
        return transPayment;
    }

    public void setTransPayment(double transPayment) {
        this.transPayment = transPayment;
    }

    public Timestamp getTransDate() {
        return transDate;
    }

    public void setTransDate(Timestamp transDate) {
        this.transDate = transDate;
    }

    public int getSenderId() {
        return senderId;
    }

    public void setSenderId(int senderId) {
        this.senderId = senderId;
    }

    public int getReceiverId() {
        return receiverId;
    }

    public void setReceiverId(int receiverId) {
        this.receiverId = receiverId;
    }

    public int getRequestId() {
        return requestId;
    }

    public void setRequestId(int requestId) {
        this.requestId = requestId;
    }

    public int getRequestStatus() {
        return requestStatus;
    }

    public void setRequestStatus(int requestStatus) {
        this.requestStatus = requestStatus;
    }

}