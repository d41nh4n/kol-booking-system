/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package d41nh4n.google_image.demo.entity.request;

/**
 *
 * @author DAO
 */
import jakarta.persistence.*;
import java.util.Date;

import d41nh4n.google_image.demo.entity.TransactionHistory;
import d41nh4n.google_image.demo.entity.user.User;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "Requests")
@NoArgsConstructor
@AllArgsConstructor
@Setter
@Getter
public class Request {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "request_id")
    private int requestId;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "requester_id")
    private User requester;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "responder_id")
    private User responder;

    @Column(name = "request_description", columnDefinition = "NVARCHAR(MAX)", nullable = false)
    private String requestDescription;

    @Column(name = "request_location", length = 80, nullable = false)
    private String requestLocation;

    @Column(name = "payment", nullable = false)
    private double payment;

    @Column(name = "request_date")
    private Date requestDate;

    @Column(name = "request_date_end")
    private Date requestDateEnd;

    @Column(name = "request_status")
    private boolean requestStatus;

    @Column(name = "req_type")
    private boolean request_type;

    @Column(name = "requester_confirm")
    private boolean requesterConfirm;

    @Column(name = "responer_confirm")
    private boolean responderConfirm;
    // Getters and setters
    @OneToOne(mappedBy = "request", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private TransactionHistory transactionHistory;
}