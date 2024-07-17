package d41nh4n.google_image.demo.controller;

import java.util.*;
import java.time.ZonedDateTime;
import java.util.stream.Collectors;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.data.domain.*;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import com.fasterxml.jackson.databind.ObjectMapper;
import d41nh4n.google_image.demo.dto.requestJob.RequesPostOrVideotDto;
import d41nh4n.google_image.demo.dto.requestJob.RequestByDay;
import d41nh4n.google_image.demo.dto.requestJob.RequestDto;
import d41nh4n.google_image.demo.dto.requestJob.RequestRepresentativeDto;
import d41nh4n.google_image.demo.dto.userdto.UserDto;
import d41nh4n.google_image.demo.entity.TransactionHistory;
import d41nh4n.google_image.demo.entity.notification.Notification;
import d41nh4n.google_image.demo.entity.notification.TypeNotification;
import d41nh4n.google_image.demo.entity.request.Request;
import d41nh4n.google_image.demo.entity.request.RequestStatus;
import d41nh4n.google_image.demo.entity.request.RequestWaitList;
import d41nh4n.google_image.demo.entity.user.User;
import d41nh4n.google_image.demo.mapper.RequestDtoToRequest;
import d41nh4n.google_image.demo.mapper.UserToUserDto;
import d41nh4n.google_image.demo.service.ChatMessageService;
import d41nh4n.google_image.demo.service.NotificationService;
import d41nh4n.google_image.demo.service.ProvinceService;
import d41nh4n.google_image.demo.service.RequestService;
import d41nh4n.google_image.demo.service.TransactionHistoryService;
import d41nh4n.google_image.demo.service.UserService;
import d41nh4n.google_image.demo.validation.Utils;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("/request")
public class RequestController {

    private final RequestService requestService;
    private final ObjectMapper mapper = new ObjectMapper();
    private final RequestDtoToRequest requestDtoToRequest;
    private final NotificationService notificationService;
    private final ProvinceService provinceService;
    private final Utils utils;
    private final UserService userService;
    private final SimpMessagingTemplate messagingTemplate;
    private final TransactionHistoryService transactionHistoryService;

    @PostMapping("/private")
    public ResponseEntity<?> requestJob(@RequestBody Map<String, Object> request) {
        Logger logger = LoggerFactory.getLogger(RequestController.class);
        Map<String, String> res = new HashMap<>();
        String typeRequest = (String) request.get("typeRequest");

        try {
            // Log the incoming request
            logger.info("Received request: {}", request);
        } catch (Exception e) {
            res.put("error", "Error logging the request: " + e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(res);
        }

        if (typeRequest == null || typeRequest.isEmpty()) {
            res.put("error", "typeRequest is missing");
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(res);
        }

        int recipientId = 0;
        double amount = 0;
        String transactionId = null;
        Date date = new Date();
        try {
            switch (typeRequest.toUpperCase()) {
                case "POST":
                case "VIDEO": {

                    RequesPostOrVideotDto requestDto = mapper.convertValue(request.get("request"),
                            RequesPostOrVideotDto.class);
                    // check ngày hợp lệ
                    if (utils.stringToDate(requestDto.getDeadline()).compareTo(date) <= 0) {
                        res.put("error", "The deadline must be greater than the current date!");
                        return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(res);
                    }
                    recipientId = Integer.parseInt(requestDto.getRecipientId());
                    amount = (requestDto.getType().equalsIgnoreCase("POST"))
                            ? userService.getProfileById(recipientId).getPriceAPost()
                            : userService.getProfileById(recipientId).getPriceAVideo();

                    TransactionHistory depositSuccess = transactionHistoryService.depositMoneyForRequest(
                            utils.getPrincipal().getUserId(),
                            recipientId, amount, transactionId);
                    if (depositSuccess == null) {
                        res.put("error", "Insufficient funds");
                        res.put("type", "ERROR_MONEY");
                        return ResponseEntity.ok(res);
                    }

                    requestService.handlePostOrVideo(requestDto, typeRequest, depositSuccess);
                    break;
                }
                case "HIREBYDAY": {
                    RequestByDay requestDto = mapper.convertValue(request.get("request"), RequestByDay.class);
                    recipientId = Integer.parseInt(requestDto.getRecipientId());
                    // check ngày hợp lệ
                    List<Date> days = requestDto.getDaysRequire().stream().map(day -> utils.stringToDate(day))
                            .collect(Collectors.toList());
                    for (Date dateRequired : days) {
                        if (dateRequired.compareTo(date) <= 0) {
                            res.put("error", "The date required must be greater than the current date!");
                            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(res);
                        }
                    }
                    int numberDay = requestDto.getDaysRequire().size();
                    amount = userService.getProfileById(recipientId).getPriceAToHireADay() * numberDay;
                    TransactionHistory depositSuccess = transactionHistoryService.depositMoneyForRequest(
                            utils.getPrincipal().getUserId(),
                            recipientId, amount, transactionId);
                    if (depositSuccess == null) {
                        res.put("error", "Insufficient funds");
                        res.put("type", "ERROR_MONEY");
                        return ResponseEntity.ok(res);
                    }

                    requestService.handleHireByDay(requestDto, typeRequest, depositSuccess);
                    break;
                }
                case "REPRESENTATIVE": {
                    RequestRepresentativeDto requestDto = mapper.convertValue(request.get("request"),
                            RequestRepresentativeDto.class);
                    // check ngày hợp lệ
                    if (utils.stringToDate(requestDto.getDateStart()).compareTo(date) <= 0) {
                        res.put("error", "The date start must be greater than the current date!");
                        return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(res);
                    }
                    recipientId = Integer.parseInt(requestDto.getRecipientId());
                    amount = userService.getProfileById(recipientId).getRepresentativePrice();

                    TransactionHistory depositSuccess = transactionHistoryService.depositMoneyForRequest(
                            utils.getPrincipal().getUserId(),
                            recipientId, amount, transactionId);
                    if (depositSuccess == null) {
                        res.put("error", "Insufficient funds");
                        res.put("type", "ERROR_MONEY");
                        return ResponseEntity.ok(res);
                    }

                    requestService.handleRepresentative(requestDto, typeRequest, depositSuccess);
                    break;
                }
                default:
                    res.put("error", "Invalid typeRequest value");
                    return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(res);
            }
        } catch (Exception e) {
            logger.error("An error occurred while processing the request: {}", e.getMessage(), e);
            res.put("error", "An error occurred while processing the request: " + e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(res);
        }

        res.put("result", "Success");
        return ResponseEntity.ok(res);
    }

    @GetMapping("/pending")
    public String listRequestPending(Model model, @RequestParam(name = "page", required = false) String page) {
        if (utils.getPrincipal().getRoles().equalsIgnoreCase("KOL")) {
            return listRequestsByStatus(model, page, RequestStatus.PENDING);
        }
        return userRequestList(model, page, RequestStatus.PENDING);

    }

    @GetMapping("/in-process")
    public String listRequestInProgress(Model model, @RequestParam(name = "page", required = false) String page) {

        requestService.checkFinishRequest();

        if (utils.getPrincipal().getRoles().equalsIgnoreCase("KOL")) {
            return listRequestsByStatus(model, page, RequestStatus.IN_PROGRESS);
        }
        return userRequestList(model, page, RequestStatus.IN_PROGRESS);
    }

    @GetMapping("/finish")
    public String listRequestFinished(Model model, @RequestParam(name = "page", required = false) String page) {

        requestService.checkFinishRequest();

        if (utils.getPrincipal().getRoles().equalsIgnoreCase("KOL")) {
            return listRequestsByStatus(model, page, RequestStatus.FINISHED);
        }
        return userRequestList(model, page, RequestStatus.FINISHED);
    }

    @GetMapping("/cancel")
    public String listRequestCancelled(Model model, @RequestParam(name = "page", required = false) String page) {
        if (utils.getPrincipal().getRoles().equalsIgnoreCase("KOL")) {
            return listRequestsByStatus(model, page, RequestStatus.CANCEL);
        }
        return userRequestList(model, page, RequestStatus.CANCEL);
    }

    private String userRequestList(Model model, String page, RequestStatus status) {
        int pageNumber = 0;
        int userId = utils.getPrincipal().getUserId();
        User user = userService.getUserById(userId);
        if (page != null && page.trim() != "" && !page.isEmpty()) {
            pageNumber = Integer.parseInt(page);
        }
        int pageSize = 5;
        Page<Request> requestPage = requestService.findByRequesterAndStatus(user, status, pageNumber,
                pageSize);
        Page<RequestDto> requestDtoPage = requestPage.map(request -> requestDtoToRequest.requestToRequestDto(request));

        int totalPages = requestPage.getTotalPages();
        model.addAttribute("currentPage", pageNumber);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("list", requestDtoPage.getContent());
        return "request-list-user";
    }

    private String listRequestsByStatus(Model model, String page, RequestStatus status) {
        int pageNumber = 0;
        int userId = utils.getPrincipal().getUserId();
        User user = userService.getUserById(userId);
        if (page != null && page.trim() != "" && !page.isEmpty()) {
            pageNumber = Integer.parseInt(page);
        }
        int pageSize = 5;
        Page<Request> requestPage = requestService.getListRequestByResponderAndStatus(user, status, pageNumber,
                pageSize);
        Page<RequestDto> requestDtoPage = requestPage.map(request -> requestDtoToRequest.requestToRequestDto(request));

        int totalPages = requestPage.getTotalPages();

        model.addAttribute("currentPage", pageNumber);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("list", requestDtoPage.getContent());
        return "request-list-kol";
    }

    @PostMapping("/accept")
    public ResponseEntity<String> acceptRequest(@RequestParam(name = "request") String id) {
        if (id != null && !id.trim().isEmpty()) {
            try {
                int idNumber = Integer.parseInt(id);
                Request request = requestService.findRequestById(idNumber);
                if (request == null) {
                    return new ResponseEntity<>("Request not exist", HttpStatus.NOT_FOUND);
                }

                request.setRequestStatus(RequestStatus.IN_PROGRESS);
                requestService.save(request);

                Notification notification = new Notification();
                notification.setContent(request.getResponder().getProfile().getFullName() + " accepted your request");
                notification.setCreateAt(ZonedDateTime.now());
                notification.setType(TypeNotification.ACCEPT_REQUEST);
                notification.setUser(request.getRequester());
                notificationService.save(notification);

                return ResponseEntity.ok("Accept Success");
            } catch (NumberFormatException e) {
                return new ResponseEntity<>("Invalid request id", HttpStatus.BAD_REQUEST);
            }
        }
        return new ResponseEntity<>("Request id is missing", HttpStatus.BAD_REQUEST);
    }

    @PostMapping("/deny")
    public ResponseEntity<String> denyRequest(@RequestParam(name = "request") String id) {
        if (id != null && !id.trim().isEmpty()) {
            try {
                int idNumber = Integer.parseInt(id);

                Request request = requestService.findRequestById(idNumber);
                if (request == null) {
                    return new ResponseEntity<>("Request not exist", HttpStatus.NOT_FOUND);
                }

                request.setRequestStatus(RequestStatus.CANCEL);
                requestService.save(request);

                Notification notification = new Notification();
                notification.setContent(request.getResponder().getProfile().getFullName() + " denied your request");
                notification.setCreateAt(ZonedDateTime.now());
                notification.setType(TypeNotification.DENY_REQUEST);
                notification.setUser(request.getRequester());
                notificationService.save(notification);

                // refund money to user
                transactionHistoryService.refundMoneyToRequester(request);
                return ResponseEntity.ok("Deny Success");
            } catch (NumberFormatException e) {
                return new ResponseEntity<>("Invalid request id", HttpStatus.BAD_REQUEST);
            }
        }
        return new ResponseEntity<>("Request id is missing", HttpStatus.BAD_REQUEST);
    }

    @GetMapping("/job-market")
    public String getListpublicRequest(@RequestParam(name = "page", required = false) String page,
            @RequestParam(name = "requestTypes", required = false) List<String> requestTypes,
            @RequestParam(name = "requestLocation", required = false) String requestLocation, Model model) {

        Page<RequestDto> requestPage = requestService.getFilteredRequests(requestTypes, requestLocation, page, 10);
        int totalPages = requestPage.getTotalPages();
        List<String> provinces = provinceService.getProvinceNames();
        model.addAttribute("requestTypes", requestTypes);
        model.addAttribute("requestLocation", requestLocation);
        model.addAttribute("provinces", provinces);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("list", requestPage.getContent());
        return "job-market";
    }

    // @GetMapping("/job-market-add")
    // public String addpublicRequest(@RequestParam(name = "page", required = false)
    // String page, Model model) {
    // int pageNumber = 0;
    // if (page != null && page.trim() != "" && !page.isEmpty()) {
    // pageNumber = Integer.parseInt(page);
    // }
    // Page<RequestDto> requestPage =
    // requestService.getListRequestPublicIsPending(pageNumber, 10);
    // int totalPages = requestPage.getTotalPages();
    // model.addAttribute("currentPage", page);
    // model.addAttribute("totalPages", totalPages);
    // model.addAttribute("list", requestPage.getContent());
    // return "job-market";
    // }

    @PostMapping("/public")
    public ResponseEntity<?> publicRequestJob(@RequestBody Map<String, Object> request) {
        Logger logger = LoggerFactory.getLogger(RequestController.class);
        Map<String, String> res = new HashMap<>();
        String typeRequest = (String) request.get("typeRequest");
        String moneyStr = (String) request.get("money");
        Double money = null;

        try {
            // Log the incoming request
            logger.info("Received request: {}", request);

            // Validate and parse money
            money = Double.parseDouble(moneyStr);
            System.out.println("money = " + money);
            if (money < 0) {
                res.put("error", "Invalid money");
                return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(res);
            }
        } catch (Exception e) {
            res.put("error", "Invalid number: " + e.getMessage());
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(res);
        }

        if (typeRequest == null) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("typeRequest is missing");
        }

        int recipientId = 0;
        String transactionId = null;

        try {
            switch (typeRequest.toUpperCase()) {
                case "POST":
                case "VIDEO": {
                    RequesPostOrVideotDto requestDto = mapper.convertValue(request.get("request"),
                            RequesPostOrVideotDto.class);

                    TransactionHistory depositSuccess = transactionHistoryService.depositMoneyForRequest(
                            utils.getPrincipal().getUserId(),
                            recipientId, money, transactionId);
                    if (depositSuccess == null) {
                        res.put("error", "Insufficient funds");
                        res.put("type", "ERROR_MONEY");
                        return ResponseEntity.ok(res);
                    }
                    requestService.handlePostOrVideoPublic(requestDto, typeRequest, money, depositSuccess);
                    break;
                }
                case "HIREBYDAY": {
                    RequestByDay requestDto = mapper.convertValue(request.get("request"), RequestByDay.class);

                    TransactionHistory depositSuccess = transactionHistoryService.depositMoneyForRequest(
                            utils.getPrincipal().getUserId(),
                            recipientId, money, transactionId);
                    if (depositSuccess == null) {
                        res.put("error", "Insufficient funds");
                        res.put("type", "ERROR_MONEY");
                        return ResponseEntity.ok(res);
                    }
                    requestService.handleHireByDayPublic(requestDto, typeRequest, money, depositSuccess);
                    break;
                }
                case "REPRESENTATIVE": {
                    RequestRepresentativeDto requestDto = mapper.convertValue(request.get("request"),
                            RequestRepresentativeDto.class);

                    TransactionHistory depositSuccess = transactionHistoryService.depositMoneyForRequest(
                            utils.getPrincipal().getUserId(),
                            recipientId, money, transactionId);
                    if (depositSuccess == null) {
                        res.put("error", "Insufficient funds");
                        res.put("type", "ERROR_MONEY");
                        return ResponseEntity.ok(res);
                    }
                    requestService.handleRepresentativePublic(requestDto, typeRequest, money, depositSuccess);
                    break;
                }
                default:
                    res.put("result", "Invalid typeRequest value");
                    return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(res);
            }
        } catch (Exception e) {
            // Log the error details
            logger.error("An error occurred while processing the request: {}", e.getMessage(), e);
            res.put("result", "An error occurred while processing the request: " + e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(res);
        }

        res.put("result", "Success");
        return ResponseEntity.ok(res);
    }

    @PostMapping("/apply")
    public ResponseEntity<?> acceptPublicRequest(@RequestParam(name = "requestId", required = true) String requestId) {
        Map<String, String> res = new HashMap<>();
        try {
            int reqIdNum = utils.stringToInt(requestId);
            Request request = requestService.findRequestById(reqIdNum);
            if (request == null) {
                res.put("error", "RequestID not exsist!");
                return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(res);
            }
            User user = userService.getUserById(utils.getPrincipal().getUserId());
            if (requestService.findByRequestAndResponder(request, user) != null) {
                res.put("message", "You have applied this request!");
                return ResponseEntity.status(HttpStatus.OK).body(res);
            }
            RequestWaitList requestWaitList = new RequestWaitList();
            requestWaitList.setRequest(request);
            requestWaitList.setResponder(user);
            requestService.save(requestWaitList);

            // create notification
            Notification notification = new Notification();
            notification.setReferenceId(requestId);
            notification.setCreateAt(ZonedDateTime.now());
            notification.setReferenceId(requestId);
            notification.setContent(user.getProfile().getFullName() + " applied for you request");
            notification.setType(TypeNotification.JOIN_REQUEST);
            notification.setUser(request.getRequester());
            notificationService.save(notification);

            messagingTemplate.convertAndSendToUser(String.valueOf(request.getRequester().getUserId()),
                    "/queue/notification",
                    "You have new notification");

            res.put("message", "Apply Success!");
            return ResponseEntity.status(HttpStatus.OK).body(res);

        } catch (Exception e) {
            res.put("error", "Invalid RequestI Id");
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(res);
        }
    }

    @PostMapping("/cancel-request")
    public ResponseEntity<?> cancelRequest(@RequestParam(name = "requestId") int requestId) {
        Map<String, String> res = new HashMap<>();

        Request request = requestService.findRequestById(requestId);
        if (request == null) {
            res.put("message", "Request not found");
            return ResponseEntity.status(404).body(res);
        }

        List<RequestWaitList> RequestWaitList = request.getRequestWaitList();

        for (RequestWaitList requestWait : RequestWaitList) {
            Notification notification = new Notification();
            notification.setContent(request.getRequester().getProfile().getFullName() + " canceled request");
            notification.setCreateAt(ZonedDateTime.now());
            notification.setType(TypeNotification.CANCEL_REQUEST);
            notification.setUser(requestWait.getResponder());
            notificationService.save(notification);
        }

        int updateCount = requestService.cancelRequest(request);

        // create notification

        transactionHistoryService.refundMoneyToRequesterIfRequestCancel(request);
        if (updateCount > 0) {
            res.put("message", "Request cancelled successfully");
            return ResponseEntity.ok(res);
        } else {
            res.put("message", "Failed to cancel request");
            return ResponseEntity.status(500).body(res);
        }
    }

    @GetMapping("/candidate-list")
    public String getAllCandidate(@RequestParam(name = "requestId") String requestId, Model model) {

        int reqIdNumber = utils.stringToInt(requestId);
        Request request = requestService.findRequestById(reqIdNumber);
        if (request.isPublic() && request.getRequestStatus().equals(RequestStatus.PENDING)
                && request.getResponder() == null) {
            List<RequestWaitList> requestWaitLists = requestService.findByRequest(request);

            List<UserDto> userDtos = requestWaitLists.stream()
                    .map(requestWaitList -> UserToUserDto.mapToUserInfoResponse(requestWaitList.getResponder()))
                    .collect(Collectors.toList());
            model.addAttribute("requestId", reqIdNumber);
            model.addAttribute("candidates", userDtos);

            return "candidate-list";
        }
        return null;
    }

    @PostMapping("/accept-candidate")
    public ResponseEntity<?> choiceCandidate(@RequestParam(name = "requestId") String requestId,
            @RequestParam(name = "userId") String userId) {
        Map<String, String> res = new HashMap<>();

        try {
            int reqId = utils.stringToInt(requestId);
            int userIdNumber = utils.stringToInt(userId);

            Request request = requestService.findRequestById(reqId);
            User user = userService.getUserById(userIdNumber);

            messagingTemplate.convertAndSendToUser(String.valueOf(request.getRequester().getUserId()),
                    "/queue/notification",
                    "You have new notification");

            if (request != null && user != null) {
                request.setResponder(user);
                request.setRequestStatus(RequestStatus.IN_PROGRESS);
                requestService.save(request);

                TransactionHistory transactionHistory = transactionHistoryService.findByRequest(request);
                transactionHistory.setReceiver(user);
                transactionHistoryService.save(transactionHistory);
                
                // tạo thông báo
                Notification notification = new Notification();
                notification.setCreateAt(ZonedDateTime.now());
                notification.setType(TypeNotification.ACCEPT_REQUEST);
                notification.setContent("You was accepted in a request");
                notification.setReferenceId(null);
                notification.setUser(user);
                notificationService.save(notification);

                // Xóa candidate đi
                // requestService.deleteAllByRequest(request);

                res.put("message", "Candidate accepted successfully");
                return ResponseEntity.ok(res);
            } else {
                res.put("error", "Request or User not found");
                return ResponseEntity.status(HttpStatus.NOT_FOUND).body(res);
            }
        } catch (NumberFormatException e) {
            res.put("error", "Invalid format for requestId or userId: " + e.getMessage());
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(res);
        } catch (Exception e) {
            res.put("error", "An error occurred while processing the request: " + e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(res);
        }
    }

    @PostMapping("/submit")
    public ResponseEntity<?> submitResult(@RequestBody Map<String, String> payload) {
        String urlResult = payload.get("url");
        String requestId = payload.get("requestId");

        Map<String, String> res = new HashMap<>();
        if (urlResult == null || urlResult.isEmpty()) {
            res.put("message", "Invalid url submit");
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(res);
        }

        try {
            int requestIdNumber = utils.stringToInt(requestId);
            Request request = requestService.findRequestById(requestIdNumber);
            if (request != null && (request.getRequestType().equalsIgnoreCase("POST")
                    || request.getRequestType().equalsIgnoreCase("VIDEO"))) {
                request.setResultLink(urlResult);
                requestService.save(request);

                Notification notification = new Notification();
                notification.setContent(request.getResponder().getProfile().getFullName() +
                        " submitted result of your request!");
                notification.setReferenceId(null);
                notification.setCreateAt(ZonedDateTime.now());
                notification.setType(TypeNotification.SUBMIT);
                notification.setUser(request.getRequester());
                notificationService.save(notification);

                messagingTemplate.convertAndSendToUser(String.valueOf(request.getRequester().getUserId()),
                        "/queue/notification",
                        "You have new notification");

                res.put("message", "Result submitted successfully");
                return ResponseEntity.ok(res);
            } else {
                res.put("message", "Invalid request type");
                return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(res);
            }

        } catch (Exception e) {
            res.put("message", "Request id invalid!");
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(res);
        }
    }

    @PostMapping("/finish-request")
    public ResponseEntity<?> finishRequest(@RequestParam(name = "requestId") String requestId) {
        Map<String, String> response = new HashMap<>();

        try {
            int reqIdNumber = utils.stringToInt(requestId);
            Request request = requestService.findRequestById(reqIdNumber);

            if (request == null) {
                response.put("message", "Request not found");
                return ResponseEntity.status(HttpStatus.NOT_FOUND).body(response);
            }

            request.setRequestStatus(RequestStatus.FINISHED);
            requestService.save(request);

            Notification notification = new Notification();
            notification.setContent(request.getRequester().getProfile().getFullName() +
                    " accepted your result");
            notification.setReferenceId(null);
            notification.setCreateAt(ZonedDateTime.now());
            notification.setType(TypeNotification.SUBMIT);
            notification.setUser(request.getRequester());
            notificationService.save(notification);

            // tranfer money to kol
            transactionHistoryService.transferMoneyToResponder(request);

            response.put("message", "Request finished successfully");
            return ResponseEntity.ok(response);

        } catch (NumberFormatException e) {
            response.put("message", "Invalid request ID format");
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(response);
        } catch (Exception e) {
            response.put("message", "An error occurred while finishing the request");
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
        }
    }

    @PostMapping("/get-money")
    public ResponseEntity<?> getMoneyForResponder(@RequestParam int requestId) {
        try {
            // Retrieve the request by requestId
            Request request = requestService.findRequestById(requestId);
            if (request == null) {
                return ResponseEntity.status(HttpStatus.NOT_FOUND)
                        .body("Request with ID " + requestId + " not found");
            }

            if (request.getRequestStatus().equals(RequestStatus.FINISHED)
                    && (request.getRequestType().equalsIgnoreCase("HIREBYDAY")
                            || (request.getRequestType().equalsIgnoreCase("REPRESENTATIVE")))
                    && !request.getTransactionHistory().isTransStatus()) {
                User responder = request.getResponder();
                if (responder == null) {
                    return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                            .body("No responder found for request ID " + requestId);
                }
                // Perform money transfer to responder
                boolean transferSuccess = transactionHistoryService.transferMoneyToResponder(request);

                if (!transferSuccess) {
                    return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                            .body("Failed to transfer money to responder for request ID " + requestId);
                }
                return ResponseEntity.ok("Money successfully transferred to responder for request ID " + requestId);
            }
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Error");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("Error processing request: " + e.getMessage());
        }
    }

}