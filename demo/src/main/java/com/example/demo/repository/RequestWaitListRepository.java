package com.example.demo.repository;

import java.util.Optional;

import org.springframework.data.jdbc.repository.query.Modifying;
import org.springframework.data.jdbc.repository.query.Query;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.repository.query.Param;

import com.example.demo.entity.request.Request;
import com.example.demo.entity.request.RequestWaitList;
import com.example.demo.entity.user.User;
import jakarta.transaction.Transactional;

import java.util.List;

public interface RequestWaitListRepository extends JpaRepository<RequestWaitList, Integer> {

    @Modifying
    @Transactional
    @Query("DELETE FROM RequestWaitList r WHERE r.request = :request")
    void deleteAllByRequest(Request request);

    Optional<RequestWaitList> findByRequestAndResponder(Request request, User user);

    @Query("SELECT r FROM RequestWaitList r WHERE r.request.requestStatus = 0 AND r.isPublic = true AND r.request = :request")
    List<RequestWaitList> findByRequest(@Param("request") Request request);

}
