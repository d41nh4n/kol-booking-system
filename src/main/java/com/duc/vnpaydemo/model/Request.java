package com.duc.vnpaydemo.model;

import java.sql.Timestamp;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "Requests")
public class Request {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    public Long requestId;

    public Long requesterId;

    public Long responderId;

    public String requestDescription;

    public String requestLocation;

    public int payment;

    public Timestamp requestDate;

    public Timestamp requestDateEnd;

    public boolean requestStatus;

}
