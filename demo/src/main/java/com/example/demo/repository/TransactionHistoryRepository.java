package com.example.demo.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.example.demo.entity.TransactionHistory;
import java.util.List;
import com.example.demo.entity.request.Request;

@Repository
public interface TransactionHistoryRepository extends JpaRepository<TransactionHistory, Integer> {
    Optional<TransactionHistory> findByTransactionId(String transactionId);

    Optional<TransactionHistory> findByRequest(Request request);
}
