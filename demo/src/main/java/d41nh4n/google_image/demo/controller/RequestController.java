package d41nh4n.google_image.demo.controller;

import java.util.Map;

import org.springframework.data.domain.*;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.fasterxml.jackson.databind.ObjectMapper;
import d41nh4n.google_image.demo.dto.requestJob.RequestByDay;
import d41nh4n.google_image.demo.dto.requestJob.RequestDto;
import d41nh4n.google_image.demo.dto.requestJob.RequestPending;
import d41nh4n.google_image.demo.dto.requestJob.RequestRepresentativeDto;
import d41nh4n.google_image.demo.entity.request.Request;
import d41nh4n.google_image.demo.entity.request.RequestStatus;
import d41nh4n.google_image.demo.mapper.RequestDtoToRequest;
import d41nh4n.google_image.demo.service.RequestService;
import d41nh4n.google_image.demo.validation.Utils;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("/request")
public class RequestController {

    private final RequestService requestService;
    private final ObjectMapper mapper = new ObjectMapper();
    private final RequestDtoToRequest requestDtoToRequest;
    private final Utils utils;
    @PostMapping
    public ResponseEntity<?> requestJob(@RequestBody Map<String, Object> request) {
        String typeRequest = (String) request.get("typeRequest");

        if (typeRequest == null) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("typeRequest is missing");
        }

        try {
            if ("POST".equalsIgnoreCase(typeRequest) || "VIDEO".equalsIgnoreCase(typeRequest)) {
                RequestDto requestDto = mapper.convertValue(request.get("request"), RequestDto.class);
                System.out.println(requestDto);
                handlePostOrVideo(requestDto, typeRequest);
            } else if ("HIREBYDAY".equalsIgnoreCase(typeRequest)) {
                RequestByDay requestDto = mapper.convertValue(request.get("request"), RequestByDay.class);
                System.out.println(requestDto);
                handleHireByDay(requestDto, typeRequest);
            } else if ("REPRESENTATIVE".equalsIgnoreCase(typeRequest)) {
                RequestRepresentativeDto requestDto = mapper.convertValue(request.get("request"),
                        RequestRepresentativeDto.class);
                System.out.println(requestDto);
                handleRepresentative(requestDto, typeRequest);
            } else {
                return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Invalid typeRequest value");
            }
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("An error occurred while processing the request: " + e.getMessage());
        }

        return ResponseEntity.ok("Success");
    }

    @GetMapping("/pending")
    public String listRequestPending(Model model, @RequestParam(name = "page", required = false) String page) {
        int userId = utils.getPrincipal().getUserId();
        int pageNumber = 0;
        if (page != null && page.trim() != "" && !page.isEmpty()) {
            pageNumber = Integer.parseInt(page);
        }
        int pageSize = 5;
        Page<RequestPending> requestPage = requestService.getListRequestIsPending(userId,pageNumber, pageSize);
        System.out.println("REQ LIST: "+requestPage.getSize());
        int totalPages = requestPage.getTotalPages();

        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("list", requestPage.getContent());
        return "request-list";
    }

    @GetMapping("/accept")
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
                return ResponseEntity.ok("Accept Success");
            } catch (NumberFormatException e) {
                return new ResponseEntity<>("Invalid request id", HttpStatus.BAD_REQUEST);
            }
        }
        return new ResponseEntity<>("Request id is missing", HttpStatus.BAD_REQUEST);
    }

    @GetMapping("/deny")
    public ResponseEntity<String> denyRequest(@RequestParam(name = "request") String id) {
        if (id != null && !id.trim().isEmpty()) {
            try {
                int idNumber = Integer.parseInt(id);

                Request request = requestService.findRequestById(idNumber);
                if (request == null) {
                    return new ResponseEntity<>("Request not exist", HttpStatus.NOT_FOUND);
                }

                request.setRequestStatus(RequestStatus.CANCLE);
                requestService.save(request);
                return ResponseEntity.ok("Deny Success");
            } catch (NumberFormatException e) {
                return new ResponseEntity<>("Invalid request id", HttpStatus.BAD_REQUEST);
            }
        }
        return new ResponseEntity<>("Request id is missing", HttpStatus.BAD_REQUEST);
    }

    private void handlePostOrVideo(RequestDto requestDto, String typeRequest) {
        Request request = requestDtoToRequest.requestDtoToRequest(requestDto);
        request.setPublic(false);
        request.setRequestStatus(RequestStatus.PENDING);
        request.setRequestType(typeRequest);
        requestService.save(request);
    }

    private void handleHireByDay(RequestByDay requestDto, String typeRequest) {
        Request request = requestDtoToRequest.requestByDayToRequest(requestDto);
        request.setPublic(false);
        request.setRequestStatus(RequestStatus.PENDING);
        request.setRequestType(typeRequest);
        requestService.save(request);
    }

    private void handleRepresentative(RequestRepresentativeDto requestDto, String typeRequest) {
        Request request = requestDtoToRequest.requestRepresentativeToRequest(requestDto);
        request.setPublic(false);
        request.setRequestType(typeRequest);
        request.setRequestStatus(RequestStatus.PENDING);
        requestService.save(request);
    }
}
