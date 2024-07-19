package d41nh4n.google_image.demo.service;

import d41nh4n.google_image.demo.dto.TransactionDto;
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
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

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

                TransactionHistory transactionHistory = request.getTransactionHistory();
                transactionHistory.setRefund(moneyAmount);
                save(transactionHistory);

                Notification notification = new Notification();
                notification.setContent("Your account has been added " + moneyAmount);
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
                double moneyLeft = moneyAmount - (moneyAmount * 0.2);
                responder.setAccountBalance(responder.getAccountBalance() + moneyLeft);
                transactionHistory.setSystemIncome(moneyAmount * 0.2);
                transactionHistory.setTransDate(new Date());
                transactionHistory.setTransStatus(true);
                transactionHistoryRepository.save(transactionHistory);
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

                TransactionHistory transactionHistory = findByRequest(request);
                Notification notification = new Notification();
                if (numberDays < 30) {
                    double moneyRefund = moneyAmount - (moneyAmount * 0.1);
                    requesterAmountLeft = requesterAmount + moneyRefund; // Giảm 10% nếu số ngày nhỏ hơn 30
                    transactionHistory.setRefund(moneyRefund);
                    transactionHistory.setSystemIncome((moneyAmount - moneyRefund));
                    transactionHistoryRepository.save(transactionHistory);
                    notification.setContent("Your account has been added " + moneyRefund);
                } else {
                    requesterAmountLeft = requesterAmount; // Không giảm nếu số ngày lớn hơn hoặc bằng 30\
                    transactionHistory.setRefund(requesterAmountLeft);
                    transactionHistoryRepository.save(transactionHistory);
                    notification.setContent("Your account has been added " + requesterAmountLeft);
                }
                double totalMoneyAfterRefund = requesterAmountLeft + moneyAmount;
            
                requester.setAccountBalance(totalMoneyAfterRefund);
                userService.save(requester);
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

    public Page<TransactionDto> findTransactionHistoryBySenderId(int senderId, int pageNumber) {
        User user = userService.getUserById(senderId);
        if (user == null) {
            throw new RuntimeException("User not found!");
        }

        Pageable pageable = PageRequest.of(pageNumber, 6, Sort.by("transDate").descending());
        Page<TransactionHistory> transactionHistories = transactionHistoryRepository.findBySender(user, pageable);
        Page<TransactionDto> transactionDtos = transactionHistories
                .map(transactionHistory -> new TransactionDto(transactionHistory));
        return transactionDtos;
    }

    public Page<TransactionDto> findTransactionHistoryByReceiverId(int senderId, int pageNumber) {
        User user = userService.getUserById(senderId);
        if (user == null) {
            throw new RuntimeException("User not found!");
        }

        Pageable pageable = PageRequest.of(pageNumber, 6, Sort.by("transDate").descending());
        Page<TransactionHistory> transactionHistories = transactionHistoryRepository.findByReceiver(user, pageable);
        Page<TransactionDto> transactionDtos = transactionHistories
                .map(transactionHistory -> new TransactionDto(transactionHistory));
        return transactionDtos;
    }

    public List<Double> getTotalPaymentPerMonth(int year) {
        List<Double> totalPayments = new ArrayList<>();
        Calendar calendar = Calendar.getInstance();
        for (int i = 0; i < 12; i++) {
            calendar.set(year, i, 1, 0, 0, 0);
            Date startDate = calendar.getTime();

            calendar.set(Calendar.MONTH, i + 1); 
            if (i == 11) { 
                calendar.set(Calendar.YEAR, year + 1);
            }
            Date endDate = calendar.getTime();

            List<TransactionHistory> transactions = transactionHistoryRepository.findByTransDateBetween(startDate, endDate);
            System.out.println("getTotalPaymentPerMonth :" + startDate + ":" +endDate);
            double totalPayment = 0.0;
            for (TransactionHistory transaction : transactions) {
                totalPayment += transaction.getSystemIncome();
            }
            totalPayments.add(totalPayment);
        }
        return totalPayments;
    }

    
    public List<Integer> getYearsWithPayment() {
        return transactionHistoryRepository.findYearsWithPayment();
    }
}