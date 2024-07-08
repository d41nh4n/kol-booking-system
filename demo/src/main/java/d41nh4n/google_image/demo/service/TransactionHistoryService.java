package d41nh4n.google_image.demo.service;

import d41nh4n.google_image.demo.entity.TransactionHistory;
import d41nh4n.google_image.demo.entity.TypeTransaction;
import d41nh4n.google_image.demo.entity.notification.Notification;
import d41nh4n.google_image.demo.entity.notification.TypeNotification;
import d41nh4n.google_image.demo.entity.request.Request;
import d41nh4n.google_image.demo.entity.request.RequestStatus;
import d41nh4n.google_image.demo.entity.user.User;
import d41nh4n.google_image.demo.repository.TransactionHistoryRepository;
import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.time.temporal.ChronoUnit;
import java.util.Date;

@Service
@RequiredArgsConstructor
public class TransactionHistoryService {
    private final TransactionHistoryRepository transactionHistoryRepository;
    private final UserService userService;
    private final NotificationService notificationService;

    public TransactionHistory findByRequest(Request request) {
        return transactionHistoryRepository.findByRequest(request).orElse(null);
    }

    public TransactionHistory depositMoneyForRequest(int senderId, int receiverId, double amount,
            String transactionId) {
        User sender = userService.getUserById(senderId);
        User receiver = userService.getUserById(receiverId);
        if (sender == null || amount <= 0) {
            return null; // Invalid transaction
        }

        if (sender.getAccountBalance() < amount) {
            return null; // Insufficient funds
        }

        // Deduct from sender
        sender.setAccountBalance(sender.getAccountBalance() - amount);
        userService.save(sender);

        // Save transaction history
        TransactionHistory transactionHistory = new TransactionHistory();
        transactionHistory.setSender(sender);
        transactionHistory.setReceiver(receiver);
        transactionHistory.setTransPayment(amount);
        transactionHistory.setTransDate(new Date());
        transactionHistory.setType(TypeTransaction.PAY_FOR);
        transactionHistory.setTransStatus(false);
        transactionHistory.setTransactionId(transactionId);
        transactionHistoryRepository.save(transactionHistory);

        Notification notification = new Notification();
        notification.setContent("Your account has been deducted " + amount);
        notification.setReferenceId(null);
        notification.setCreateAt(ZonedDateTime.now());
        notification.setType(TypeNotification.MONEY);
        notification.setUser(sender);
        notificationService.save(notification);

        return transactionHistory;
    }

    public boolean refundMoneyToRequester(Request request) {
        if (request.getRequestStatus() == RequestStatus.PENDING) {
            try {
                User requester = request.getRequester();
                if (requester == null) {
                    throw new IllegalArgumentException("Requester is null");
                }

                double moneyAmount = request.getPayment();
                if (moneyAmount <= 0) {
                    throw new IllegalArgumentException("Refund amount must be greater than zero");
                }

                double requesterAmount = requester.getAccountBalance();
                double totalMoneyAfterRefund = requesterAmount + moneyAmount;

                requester.setAccountBalance(totalMoneyAfterRefund);
                userService.save(requester);

                Notification notification = new Notification();
                notification.setContent("Your account has been added " + totalMoneyAfterRefund);
                notification.setReferenceId(null);
                notification.setCreateAt(ZonedDateTime.now());
                notification.setType(TypeNotification.MONEY);
                notification.setUser(requester);
                notificationService.save(notification);

                return true;
            } catch (Exception e) {
                // Log the exception
                Logger logger = LoggerFactory.getLogger(TransactionHistoryService.class);
                logger.error("Error refunding money to requester: {}", e.getMessage());
                return false;
            }
        }
        return false;
    }

    public boolean transferMoneyToResponder(Request request) {
        try {
            User requester = request.getRequester();
            User responder = request.getResponder();

            if (requester == null || responder == null) {
                throw new IllegalArgumentException("Requester or Responder is null");
            }

            double moneyAmount = request.getPayment();
            if (moneyAmount <= 0) {
                throw new IllegalArgumentException("Transfer amount must be greater than zero");
            }

            if (requester.getAccountBalance() < moneyAmount) {
                throw new IllegalArgumentException("Insufficient funds in requester's account");
            }

            TransactionHistory transactionHistory = findByRequest(request);
            if (!transactionHistory.isTransStatus()) {
                transactionHistory.setTransDate(new Date());
                transactionHistory.setTransStatus(true);
                transactionHistoryRepository.save(transactionHistory);
                double moneyLeft = moneyAmount - (moneyAmount * 0.2);
                responder.setAccountBalance(responder.getAccountBalance() + moneyLeft);
                userService.save(responder);

                Notification notification = new Notification();
                notification.setContent("Your account has been added " + moneyLeft);
                notification.setReferenceId(null);
                notification.setCreateAt(ZonedDateTime.now());
                notification.setType(TypeNotification.MONEY);
                notification.setUser(responder);
                notificationService.save(notification);
            }
            return true;
        } catch (Exception e) {
            Logger logger = LoggerFactory.getLogger(TransactionHistoryService.class);
            logger.error("Error transferring money to responder: {}", e.getMessage());
            return false;
        }
    }

    public boolean refundMoneyToRequesterIfRequestCancel(Request request) {
        if (request.getRequestStatus() == RequestStatus.PENDING) {
            try {
                User requester = request.getRequester();
                if (requester == null) {
                    throw new IllegalArgumentException("Requester is null");
                }

                double moneyAmount = request.getPayment();

                if (moneyAmount <= 0) {
                    throw new IllegalArgumentException("Refund amount must be greater than zero");
                }

                double requesterAmount = requester.getAccountBalance();
                double requesterAmountLeft = 0;

                Date requestDateAsDate = request.getRequestDate();
                LocalDate requestDate = requestDateAsDate.toInstant().atZone(ZoneId.systemDefault()).toLocalDate();

                long numberDays = ChronoUnit.DAYS.between(requestDate, LocalDate.now());

                if (numberDays < 30) {
                    requesterAmountLeft = requesterAmount - (requesterAmount * 0.1); // Giảm 10% nếu số ngày nhỏ hơn
                                                                                     // 30
                } else {
                    requesterAmountLeft = requesterAmount; // Không giảm nếu số ngày lớn hơn hoặc bằng 30
                }

                double totalMoneyAfterRefund = requesterAmountLeft + moneyAmount;

                requester.setAccountBalance(totalMoneyAfterRefund);
                userService.save(requester);

                Notification notification = new Notification();
                notification.setContent("Your account has been added " + requesterAmountLeft);
                notification.setReferenceId(null);
                notification.setCreateAt(ZonedDateTime.now());
                notification.setType(TypeNotification.MONEY);
                notification.setUser(requester);
                notificationService.save(notification);

                return true;
            } catch (Exception e) {
                // Log the exception
                Logger logger = LoggerFactory.getLogger(TransactionHistoryService.class);
                logger.error("Error refunding money to requester: {}", e.getMessage());
                return false;
            }
        }
        return false;
    }

    public void save(TransactionHistory transactionHistory) {
        if (transactionHistory != null) {
            transactionHistoryRepository.save(transactionHistory);
        }
    }
}