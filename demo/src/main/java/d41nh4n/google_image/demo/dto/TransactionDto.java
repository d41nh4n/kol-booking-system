package d41nh4n.google_image.demo.dto;

import java.text.SimpleDateFormat;
import java.util.Date;

import d41nh4n.google_image.demo.entity.TransactionHistory;
import d41nh4n.google_image.demo.entity.TypeTransaction;
import d41nh4n.google_image.demo.entity.user.User;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class TransactionDto {
    private int transId;
    private double transPayment;
    private String transDate;
    private String type;
    private boolean transStatus;
    private String typeRequest;
    private double refund;
    private int requestId;

    public TransactionDto(TransactionHistory transactionHistory) {
        this.transId = transactionHistory.getTransId();

        if (transactionHistory.getTransDate() != null) {
            SimpleDateFormat formatter = new SimpleDateFormat("MM/dd/yyyy");
            this.transDate = formatter.format(transactionHistory.getTransDate());
        }

        this.transPayment = transactionHistory.getTransPayment();
        this.type = transactionHistory.getType().name();
        this.transStatus = transactionHistory.isTransStatus();
        this.typeRequest = transactionHistory.getRequest().getRequestStatus().name();
        this.refund = transactionHistory.getRefund();
        this.requestId = transactionHistory.getRequest().getRequestId();
    }
}
