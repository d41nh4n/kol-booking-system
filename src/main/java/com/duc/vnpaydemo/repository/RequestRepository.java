package com.duc.vnpaydemo.repository;

import com.duc.vnpaydemo.model.Request;

import jakarta.transaction.Transactional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

public interface RequestRepository extends JpaRepository<Request, Long> {
    @Transactional
    @Modifying
    @Query("UPDATE Request r SET r.requestStatus = :status WHERE r.requestId = :requestId")
    void updateStatusById(Long requestId, boolean status);
}
