package d41nh4n.google_image.demo.repository;

import jakarta.transaction.Transactional;

import org.springframework.data.domain.*;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import d41nh4n.google_image.demo.entity.request.Request;

public interface RequestRepository extends JpaRepository<Request, Integer> {

    @Transactional
    @Modifying // giúp nâng cao @Query(không chỉ select) mà có thể thêm update, insert, delete,
    @Query("UPDATE Request r SET r.requestStatus = :status WHERE r.requestId = :requestId")
    void updateStatusById(@Param("requestId") Long requestId, @Param("status") boolean status);

    @Query(value = "SELECT * FROM Requests r WHERE r.request_status = 0 AND r.responder_id = :userId", nativeQuery = true)
    Page<Request> findRequestIsPending(@Param("userId") int userId, Pageable pageable);

    long countByRequestStatus(int status);
}
