package d41nh4n.google_image.demo.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import d41nh4n.google_image.demo.entity.TransactionHistory;
import java.util.List;
import d41nh4n.google_image.demo.entity.request.Request;


@Repository
public interface TransactionHistoryRepository extends JpaRepository<TransactionHistory, Integer> {
    Optional<TransactionHistory> findByTransactionId(String transactionId);

    Optional<TransactionHistory> findByRequest(Request request);
}
