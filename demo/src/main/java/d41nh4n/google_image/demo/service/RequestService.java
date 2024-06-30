package d41nh4n.google_image.demo.service;

import java.util.List;

import org.springframework.data.domain.*;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import d41nh4n.google_image.demo.dto.requestJob.RequestDto;
import d41nh4n.google_image.demo.entity.request.Request;
import d41nh4n.google_image.demo.entity.request.RequestStatus;
import d41nh4n.google_image.demo.entity.request.RequestWaitList;
import d41nh4n.google_image.demo.entity.user.User;
import d41nh4n.google_image.demo.mapper.RequestDtoToRequest;
import d41nh4n.google_image.demo.repository.RequestRepository;
import d41nh4n.google_image.demo.repository.RequestWaitListRepository;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class RequestService {

    private final RequestRepository requestRepository;
    private final RequestDtoToRequest requestDtoToRequest;
    private final RequestWaitListRepository requestWaitListRepository;

    public Request save(Request request) {
        return requestRepository.save(request);
    }

    public Request findRequestById(int requestId) {
        return requestRepository.findById(requestId).orElse(null);
    }

    public Request changeRequestStatusById(int requestId, String status) {
        Request request = findRequestById(requestId);
        if (request != null) {
            request.setRequestStatus(RequestStatus.valueOf(status.toUpperCase()));
            requestRepository.save(request);
        }
        return request;
    }

    public Page<RequestDto> getListRequestIsPending(int userId, int pageNumber, int pageSize) {
        Pageable pageable = PageRequest.of(pageNumber, pageSize, Sort.by("request_date").descending());
        return requestRepository.findRequestIsPending(userId, pageable)
                .map(requestDtoToRequest::requestToRequestDto);
    }

    public long countPendingRequests() {
        return requestRepository.countByRequestStatus(0);
    }

    public List<Request> findByRequester(User user) {
        Sort sort =  Sort.by("requestDate").descending();
        return requestRepository.findByRequester(user, sort);
    }

    @Transactional
    public int cancelRequest(Request request) {
        return requestRepository.cancelRequest(request);
    }

    public Page<RequestDto> getListRequestPublicIsPending(int pageNumber, int pageSize) {
        Pageable pageable = PageRequest.of(pageNumber, pageSize, Sort.by("request_date").descending());
        return requestRepository.findRequestPublicIsPending(pageable)
                .map(requestDtoToRequest::requestToRequestDto);
    }

    public RequestWaitList save(RequestWaitList requestWaitList) {
        return requestWaitListRepository.save(requestWaitList);
    }

    public void delete(RequestWaitList requestWaitList) {
        requestWaitListRepository.delete(requestWaitList);
    }

    public void deleteAllByRequest(Request request) {
        requestWaitListRepository.deleteByRequest(request);
    }

    public RequestWaitList findByRequestAndResponder(Request request, User user) {
        return requestWaitListRepository.findByRequestAndResponder(request, user).orElse(null);
    }

    public List<RequestWaitList> findByRequest(Request request) {
        return requestWaitListRepository.findByRequest(request);
    }
}
