package com.example.demo.repository;

import jakarta.transaction.Transactional;

import org.springframework.data.domain.*;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.example.demo.entity.request.Request;
import com.example.demo.entity.request.RequestStatus;

import java.util.List;
import com.example.demo.entity.user.User;
import java.util.Date;

public interface RequestRepository extends JpaRepository<Request, Integer> {

        @Transactional
        @Modifying // giúp nâng cao @Query(không chỉ select) mà có thể thêm update, insert, delete,
        @Query("UPDATE Request r SET r.requestStatus = :status WHERE r.requestId = :requestId")
        void updateStatusById(@Param("requestId") Long requestId, @Param("status") boolean status);

        @Query("SELECT r FROM Request r WHERE r.requestStatus = :requestStatus AND r.responder = :user")
        Page<Request> findRequestByResponderAndStatus(@Param("user") User user,
                        @Param("requestStatus") RequestStatus requestStatus,
                        Pageable pageable);

        long countByRequestStatus(int status);

        @Query(value = "SELECT * FROM Requests r WHERE r.request_status = 0 AND r.is_Public = 1", nativeQuery = true)
        Page<Request> findRequestPublicIsPending(Pageable pageable);

        @Query(value = "SELECT r FROM Request r WHERE r.requester = :requester AND r.requestStatus = :status")
        Page<Request> findByRequesterAndStatus(@Param("requester") User requester,
                        @Param("status") RequestStatus status,
                        Pageable pageable);

        @Modifying
        @Transactional
        @Query("UPDATE Request r SET r.requestStatus = 3 WHERE r = :request")
        int cancelRequest(Request request);

        @Query("SELECT r FROM Request r WHERE "
                        + "(:requestTypes IS NULL OR r.requestType IN :requestTypes) AND "
                        + "(:requestLocation IS NULL OR r.requestLocation = :requestLocation) AND "
                        + "r.isPublic = true AND r.requestStatus = :requestStatus")
        Page<Request> findFilteredRequests(
                        @Param("requestTypes") List<String> requestTypes,
                        @Param("requestLocation") String requestLocation,
                        @Param("requestStatus") RequestStatus requestStatus,
                        Pageable pageable);

        @Query("SELECT r FROM Request r WHERE r.requestDateEnd <= :endDate")
        List<Request> findRequestsEndingBeforeOrOn(@Param("endDate") Date endDate);
}
