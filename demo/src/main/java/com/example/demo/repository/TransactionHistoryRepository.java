package d41nh4n.google_image.demo.repository;

import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import d41nh4n.google_image.demo.entity.TransactionHistory;

import java.util.Date;
import java.util.List;
import d41nh4n.google_image.demo.entity.request.Request;
import d41nh4n.google_image.demo.entity.user.User;

@Repository
public interface TransactionHistoryRepository extends JpaRepository<TransactionHistory, Integer> {
    Optional<TransactionHistory> findByTransactionId(String transactionId);

    Optional<TransactionHistory> findByRequest(Request request);

    Page<TransactionHistory> findBySender(User sender, Pageable pageable);

    Page<TransactionHistory> findByReceiver(User receiver, Pageable pageable);

    List<TransactionHistory> findByTransDateBetween(Date startDate, Date endDate);

    @Query("SELECT DISTINCT YEAR(th.transDate) FROM TransactionHistory th WHERE th.systemIncome > 0")
    List<Integer> findYearsWithPayment();

}
