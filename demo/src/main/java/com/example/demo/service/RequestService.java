package com.example.demo.service;

import java.time.ZonedDateTime;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

import org.springframework.data.domain.*;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.demo.dto.requestJob.RequesPostOrVideotDto;
import com.example.demo.dto.requestJob.RequestByDay;
import com.example.demo.dto.requestJob.RequestDto;
import com.example.demo.dto.requestJob.RequestRepresentativeDto;
import com.example.demo.entity.TransactionHistory;
import com.example.demo.entity.notification.Notification;
import com.example.demo.entity.notification.TypeNotification;
import com.example.demo.entity.request.Request;
import com.example.demo.entity.request.RequestStatus;
import com.example.demo.entity.request.RequestWaitList;
import com.example.demo.entity.user.User;
import com.example.demo.exeption.InvalidNumber;
import com.example.demo.mapper.RequestDtoToRequest;
import com.example.demo.repository.RequestRepository;
import com.example.demo.repository.RequestWaitListRepository;
import com.example.demo.validation.Utils;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class RequestService {

    private final RequestRepository requestRepository;
    private final RequestDtoToRequest requestDtoToRequest;
    private final RequestWaitListRepository requestWaitListRepository;
    private final Utils utils;
    private final TransactionHistoryService transactionHistoryService;
    private final UserService userService;
    private final ChatMessageService chatMessageService;
    private final NotificationService notificationService;

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

    public void handlePostOrVideoPublic(RequesPostOrVideotDto requestDto, String typeRequest, Double money,
            TransactionHistory transactionHistory) {
        Request request = requestDtoToRequest.requestDtoToRequest(requestDto);
        request.setPublic(true);
        request.setRequestStatus(RequestStatus.PENDING);
        request.setRequestType(typeRequest);
        request.setPayment(money);
        request.setTransactionHistory(transactionHistory);
        save(request);
        transactionHistory.setRequest(request);
        transactionHistoryService.save(transactionHistory);

        Notification notification = new Notification();
        notification.setContent(request.getResponder().getProfile().getFullName() + " sent you a request");
        notification.setCreateAt(ZonedDateTime.now());
        notification.setType(TypeNotification.REQUEST);
        notification.setUser(request.getRequester());
        notificationService.save(notification);
        chatMessageService.createAConversation(request.getRequester().getUserId(), request.getResponder().getUserId());
    }

    public void handleHireByDayPublic(RequestByDay requestDto, String typeRequest, Double money,
            TransactionHistory transactionHistory) {
        Request request = requestDtoToRequest.requestByDayToRequest(requestDto);
        request.setPublic(true);
        request.setRequestStatus(RequestStatus.PENDING);
        request.setRequestType(typeRequest);
        request.setPayment(money);
        request.setTransactionHistory(transactionHistory);
        save(request);
        transactionHistory.setRequest(request);
        transactionHistoryService.save(transactionHistory);

        Notification notification = new Notification();
        notification.setContent(request.getResponder().getProfile().getFullName() + " sent you a request");
        notification.setCreateAt(ZonedDateTime.now());
        notification.setType(TypeNotification.REQUEST);
        notification.setUser(request.getRequester());
        notificationService.save(notification);
        chatMessageService.createAConversation(request.getRequester().getUserId(), request.getResponder().getUserId());
    }

    public void handleRepresentativePublic(RequestRepresentativeDto requestDto, String typeRequest, Double money,
            TransactionHistory transactionHistory) {
        Request request = requestDtoToRequest.requestRepresentativeToRequest(requestDto);
        request.setPublic(true);
        request.setRequestType(typeRequest);
        request.setRequestStatus(RequestStatus.PENDING);
        request.setPayment(money);
        request.setTransactionHistory(transactionHistory);
        save(request);
        transactionHistory.setRequest(request);
        transactionHistoryService.save(transactionHistory);

        Notification notification = new Notification();
        notification.setContent(request.getResponder().getProfile().getFullName() + " sent you a request");
        notification.setCreateAt(ZonedDateTime.now());
        notification.setType(TypeNotification.REQUEST);
        notification.setUser(request.getRequester());
        notificationService.save(notification);
        chatMessageService.createAConversation(request.getRequester().getUserId(), request.getResponder().getUserId());
    }

    public void handlePostOrVideo(RequesPostOrVideotDto requestDto, String typeRequest,
            TransactionHistory transactionHistory) {
        Request request = requestDtoToRequest.requestDtoToRequest(requestDto);
        request.setPublic(false);
        request.setRequestStatus(RequestStatus.PENDING);
        request.setRequestType(typeRequest);
        if (requestDto.getType().equalsIgnoreCase("POST")) {
            request.setPayment(
                    userService.getProfileById(Integer.parseInt(requestDto.getRecipientId())).getPriceAPost());
        } else if (requestDto.getType().equalsIgnoreCase("VIDEO")) {
            request.setPayment(
                    userService.getProfileById(Integer.parseInt(requestDto.getRecipientId())).getPriceAVideo());
        }
        request.setTransactionHistory(transactionHistory);
        save(request);
        transactionHistory.setRequest(request);
        transactionHistoryService.save(transactionHistory);

        Notification notification = new Notification();
        notification.setContent(request.getResponder().getProfile().getFullName() + " sent you a request");
        notification.setCreateAt(ZonedDateTime.now());
        notification.setType(TypeNotification.REQUEST);
        notification.setUser(request.getRequester());
        notificationService.save(notification);

        chatMessageService.createAConversation(request.getRequester().getUserId(), request.getResponder().getUserId());
    }

    public void handleHireByDay(RequestByDay requestDto, String typeRequest, TransactionHistory transactionHistory) {
        int numberDay = requestDto.getDaysRequire().size();
        Request request = requestDtoToRequest.requestByDayToRequest(requestDto);
        request.setPublic(false);
        request.setRequestStatus(RequestStatus.PENDING);
        request.setRequestType(typeRequest);
        request.setPayment(
                userService.getProfileById(Integer.parseInt(requestDto.getRecipientId())).getPriceAToHireADay()
                        * numberDay);
        request.setTransactionHistory(transactionHistory);
        save(request);
        transactionHistory.setRequest(request);
        transactionHistoryService.save(transactionHistory);

        Notification notification = new Notification();
        notification.setContent(request.getResponder().getProfile().getFullName() + " sent you a request");
        notification.setCreateAt(ZonedDateTime.now());
        notification.setType(TypeNotification.REQUEST);
        notification.setUser(request.getRequester());
        notificationService.save(notification);
        chatMessageService.createAConversation(request.getRequester().getUserId(), request.getResponder().getUserId());
    }

    public void handleRepresentative(RequestRepresentativeDto requestDto, String typeRequest,
            TransactionHistory transactionHistory) {
        Request request = requestDtoToRequest.requestRepresentativeToRequest(requestDto);
        request.setPublic(false);
        request.setRequestType(typeRequest);
        request.setRequestStatus(RequestStatus.PENDING);
        int months = utils.stringToInt(requestDto.getNumberMonths());
        if (months == 3) {
            request.setPayment(
                    userService.getProfileById(Integer.parseInt(requestDto.getRecipientId())).getRepresentativePrice());
        } else if (months == 6) {
            request.setPayment(
                    userService.getProfileById(Integer.parseInt(requestDto.getRecipientId())).getRepresentativePrice()
                            * 2);
        } else if (months == 9) {
            request.setPayment(
                    userService.getProfileById(Integer.parseInt(requestDto.getRecipientId())).getRepresentativePrice()
                            * 3);
        }
        request.setTransactionHistory(transactionHistory);
        save(request);
        transactionHistory.setRequest(request);
        transactionHistoryService.save(transactionHistory);

        Notification notification = new Notification();
        notification.setContent(request.getResponder().getProfile().getFullName() + " sent you a request");
        notification.setCreateAt(ZonedDateTime.now());
        notification.setType(TypeNotification.REQUEST);
        notification.setUser(request.getRequester());
        notificationService.save(notification);
        chatMessageService.createAConversation(request.getRequester().getUserId(), request.getResponder().getUserId());
    }

    public void checkFinishRequest() {
        Date currentDate = new Date();
        System.out.println(currentDate);
        List<Request> requests = requestRepository.findRequestsEndingBeforeOrOn(currentDate);
        System.out.println("Total request: " + requests.size());
        for (Request request : requests) {

            if (request.getRequestType().equals("HIREBYDAY") || request.getRequestType().equals("REPRESENTATIVE")
                    && request.getRequestStatus().equals(RequestStatus.IN_PROGRESS)) {
                request.setRequestStatus(RequestStatus.FINISHED);
                save(request);
            }
        }
    }
}
