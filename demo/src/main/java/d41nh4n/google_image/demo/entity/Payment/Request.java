package d41nh4n.google_image.demo.entity.Payment;

import java.sql.Timestamp;

import d41nh4n.google_image.demo.entity.User.User;
import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Setter
@Getter
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "Requests")
public class Request {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    public Long requestId;

    @ManyToOne(fetch = FetchType.LAZY)
    public User requesterId;

    @ManyToOne(fetch = FetchType.LAZY)
    public User responderId;

    @Column(name = "request_desc")
    public String requestDescription;

    @Column(name = "request_location")
    public String requestLocation;

    @Column(name = "payment")
    public Long payment;

    @Column(name = "request_date")
    public Timestamp requestDate;

    @Column(name = "request_date_end")
    public Timestamp requestDateEnd;

    @Column(name = "request_status")
    public boolean requestStatus;

    @OneToOne(mappedBy = "request", cascade = CascadeType.ALL)
    public TransactionHistory transactionHistory;

}
