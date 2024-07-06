package d41nh4n.google_image.demo.service;

import java.util.Arrays;
import java.util.List;

import org.springframework.data.domain.*;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import d41nh4n.google_image.demo.dto.requestJob.RequestDto;
import d41nh4n.google_image.demo.entity.request.Request;
import d41nh4n.google_image.demo.entity.request.RequestStatus;
import d41nh4n.google_image.demo.entity.request.RequestWaitList;
import d41nh4n.google_image.demo.entity.user.User;
import d41nh4n.google_image.demo.exeption.InvalidNumber;
import d41nh4n.google_image.demo.mapper.RequestDtoToRequest;
import d41nh4n.google_image.demo.repository.RequestRepository;
import d41nh4n.google_image.demo.repository.RequestWaitListRepository;
import d41nh4n.google_image.demo.validation.Utils;
import io.micrometer.core.instrument.config.validate.Validated.Invalid;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class RequestService {

    private final RequestRepository requestRepository;
    private final RequestDtoToRequest requestDtoToRequest;
    private final RequestWaitListRepository requestWaitListRepository;
    private final Utils utils;

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

    public Page<Request> getListRequestByResponderAndStatus(User user, RequestStatus status, int pageNumber,
            int pageSize) {
        Pageable pageable = PageRequest.of(pageNumber, pageSize, Sort.by("requestDate").descending());
        return requestRepository.findRequestByResponderAndStatus(user, status, pageable);
    }

    public long countPendingRequests() {
        return requestRepository.countByRequestStatus(0);
    }

    public Page<Request> findByRequesterAndStatus(User user, RequestStatus status, int pageNumber,
            int pageSize) {
        Pageable pageable = PageRequest.of(pageNumber, pageSize, Sort.by("requestDate").descending());
        return requestRepository.findByRequesterAndStatus(user, status, pageable);
    }

    @Transactional
    public int cancelRequest(Request request) {
        return requestRepository.cancelRequest(request);
    }

    // public Page<RequestDto> getListRequestPublicIsPending(int pageNumber, int
    // pageSize) {
    // Pageable pageable = PageRequest.of(pageNumber, pageSize,
    // Sort.by("request_date").descending());
    // return requestRepository.findRequestPublicIsPending(pageable)
    // .map(requestDtoToRequest::requestToRequestDto);
    // }

    public RequestWaitList save(RequestWaitList requestWaitList) {
        return requestWaitListRepository.save(requestWaitList);
    }

    public void delete(RequestWaitList requestWaitList) {
        requestWaitListRepository.delete(requestWaitList);
    }

    @Transactional
    public void deleteAllByRequest(Request request) {
        requestWaitListRepository.deleteAllByRequest(request);
    }

    public RequestWaitList findByRequestAndResponder(Request request, User user) {
        return requestWaitListRepository.findByRequestAndResponder(request, user).orElse(null);
    }

    public List<RequestWaitList> findByRequest(Request request) {
        return requestWaitListRepository.findByRequest(request);
    }

    public Page<RequestDto> getFilteredRequests(List<String> requestTypes, String requestLocation, String pageNumberStr,
            int pageSize) {

        try {
            int pageNumber = 0;
            if (pageNumberStr != null && pageNumberStr.trim() != "" && !pageNumberStr.isEmpty()) {
                pageNumber = Integer.parseInt(pageNumberStr);
            }
            // Set default request types if none are provided
            if (requestTypes == null || requestTypes.isEmpty()) {
                requestTypes = Arrays.asList("POST", "VIDEO", "HIREBYDAY", "REPRESENTATIVE");
            }
            RequestStatus requestStatus = RequestStatus.PENDING; // Or any other default status

            // If no location is provided, pass null
            if (requestLocation != null && requestLocation.trim().isEmpty()) {
                requestLocation = null;
            }

            Pageable pageable = PageRequest.of(pageNumber, pageSize, Sort.by("requestDate").descending());
            // If no location is provided, pass null
            return requestRepository.findFilteredRequests(requestTypes, requestLocation, requestStatus, pageable)
                    .map(requestDtoToRequest::requestToRequestDto);
        } catch (Exception e) {
            throw new InvalidNumber("Invalid page number", e);
        }
    }
}
