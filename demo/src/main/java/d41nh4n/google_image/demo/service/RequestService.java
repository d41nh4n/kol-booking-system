package d41nh4n.google_image.demo.service;

import org.springframework.data.domain.*;

import org.springframework.stereotype.Service;

import d41nh4n.google_image.demo.dto.requestJob.RequestPending;
import d41nh4n.google_image.demo.entity.request.Request;
import d41nh4n.google_image.demo.entity.request.RequestStatus;
import d41nh4n.google_image.demo.mapper.RequestDtoToRequest;
import d41nh4n.google_image.demo.repository.RequestRepository;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class RequestService {

    private final RequestRepository requestRepository;
    private final RequestDtoToRequest requestDtoToRequest;

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

    public Page<RequestPending> getListRequestIsPending(int userId,int pageNumber, int pageSize) {
        Pageable pageable = PageRequest.of(pageNumber, pageSize, Sort.by("request_date").descending());
        return requestRepository.findRequestIsPending(userId,pageable)
                .map(requestDtoToRequest::requestToRequestPending);
    }

    public long countPendingRequests() {
        return requestRepository.countByRequestStatus(0);
    }
}
