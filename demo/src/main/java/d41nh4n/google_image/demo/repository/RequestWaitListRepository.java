package d41nh4n.google_image.demo.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import d41nh4n.google_image.demo.entity.request.Request;
import d41nh4n.google_image.demo.entity.request.RequestWaitList;
import d41nh4n.google_image.demo.entity.user.User;
import java.util.List;

public interface RequestWaitListRepository extends JpaRepository<RequestWaitList, Integer> {

    void deleteByRequest(Request request);

    Optional<RequestWaitList> findByRequestAndResponder(Request request, User user);

    List<RequestWaitList> findByRequest(Request request);
}
