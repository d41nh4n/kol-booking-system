package d41nh4n.google_image.demo.entity;

import jakarta.persistence.*;
import java.util.Date;

import d41nh4n.google_image.demo.entity.request.Request;
import d41nh4n.google_image.demo.entity.user.User;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "TRANSACTIONHISTORY")
@NoArgsConstructor
@AllArgsConstructor
@Setter
@Getter
public class TransactionHistory {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "trans_id")
    private int transId;

    @Column(name = "trans_payment", nullable = false)
    private double transPayment;

    @Column(name = "trans_time")
    private Date transDate;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "sender_id")
    private User sender;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "receiver_id")
    private User receiver;

    @Enumerated(EnumType.STRING)
    @Column(name = "type")
    private TypeTransaction type;

    @Column(name = "trans_status")
    private boolean transStatus;

    @Column(name = "transaction_id", unique = true, nullable = true)
    private String transactionId;

    @Column(name = "system-income", nullable = false)
    private double systemIncome;

    @Column(name = "refund", nullable = false)
    private double refund;

    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "request_id", referencedColumnName = "request_id")
    private Request request;

    @PrePersist
    protected void onCreate() {
        this.systemIncome = 0f;
        this.refund = 0f;
    }
}
