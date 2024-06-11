package d41nh4n.google_image.demo.entity.Payment;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

import java.sql.Timestamp;

import d41nh4n.google_image.demo.entity.User.User;

@Entity
@Setter
@Getter
@ToString
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "TransactionHistory")
public class TransactionHistory {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long trans_id;

    @Column(name = "trans_payment")
    private double transPayment;

    @Column(name = "trans_date")
    private Timestamp transDate;

    @ManyToOne(fetch = FetchType.LAZY)
    private User senderId;

    @ManyToOne(fetch = FetchType.LAZY)
    private User receiverId;

    @OneToOne(cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    @JoinColumn(name = "request_id", referencedColumnName = "requestId")
    private Request request;

    @Column(name = "request_status")
    private int requestStatus;
}