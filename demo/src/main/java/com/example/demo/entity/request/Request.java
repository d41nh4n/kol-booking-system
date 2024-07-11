package com.example.demo.entity.request;

import jakarta.persistence.*;
import java.util.Date;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonIgnore;

import java.util.ArrayList;

import com.example.demo.entity.TransactionHistory;
import com.example.demo.entity.user.User;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Entity
@Table(name = "Requests")
@NoArgsConstructor
@AllArgsConstructor
@Setter
@Getter
@ToString
public class Request {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "request_id")
    private int requestId;

    @JsonIgnore
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "requester_id")
    private User requester;

    @JsonIgnore
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "responder_id", nullable = true)
    private User responder;

    @Column(name = "request_description", columnDefinition = "NVARCHAR(MAX)", nullable = true)
    private String requestDescription;

    @Column(name = "request_location", length = 80, nullable = true, columnDefinition = "NVARCHAR(155)")
    private String requestLocation;

    @Column(name = "payment", nullable = true)
    private double payment;

    @Column(name = "request_date", nullable = true)
    private Date requestDate;

    @Column(name = "request_date_end", nullable = true)
    private Date requestDateEnd;

    @Column(name = "request_status")
    private RequestStatus requestStatus;

    @Column(name = "is_public")
    private boolean isPublic;

    @Column(name = "requester_confirm")
    private boolean requesterConfirm;

    @Column(name = "responer_confirm")
    private boolean responderConfirm;

    @Column(name = "result_link", nullable = true)
    private String resultLink;

    @Column(name = "request_type")
    private String requestType;
    // Chỉ sử dụng cho loại "HIREBYDAY"
    @ElementCollection
    @CollectionTable(name = "DayRequest", joinColumns = @JoinColumn(name = "request_id"))
    @Column(name = "day_request")
    private List<Date> daysRequest = new ArrayList<>();

    // Chỉ sử dụng cho loại "REPRESENTATIVE"
    @OneToOne(mappedBy = "request", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private RequestRepresentative requestRepresentative;

    @OneToOne(mappedBy = "request", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private TransactionHistory transactionHistory;

    @OneToMany(mappedBy = "request", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<RequestWaitList> requestWaitList;
}
