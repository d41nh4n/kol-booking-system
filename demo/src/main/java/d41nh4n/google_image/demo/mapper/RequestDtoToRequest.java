package d41nh4n.google_image.demo.mapper;

import java.time.LocalDate;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.util.Date;
import java.util.stream.Collectors;

import org.springframework.stereotype.Component;

import com.fasterxml.jackson.databind.ObjectMapper;

import d41nh4n.google_image.demo.dto.requestJob.RequestByDay;
import d41nh4n.google_image.demo.dto.requestJob.RequestDto;
import d41nh4n.google_image.demo.dto.requestJob.RequestPending;
import d41nh4n.google_image.demo.dto.requestJob.RequestRepresentativeDto;
import d41nh4n.google_image.demo.dto.userdto.UserInfo;
import d41nh4n.google_image.demo.entity.request.Request;
import d41nh4n.google_image.demo.entity.request.RequestRepresentative;
import d41nh4n.google_image.demo.entity.user.User;
import d41nh4n.google_image.demo.service.RequestService;
import d41nh4n.google_image.demo.service.UserService;
import d41nh4n.google_image.demo.validation.Utils;
import lombok.RequiredArgsConstructor;

@Component
@RequiredArgsConstructor
public class RequestDtoToRequest {

    private final UserService userService;
    private final Utils utils;

    public Request requestByDayToRequest(RequestByDay requestByDay) {
        Request request = new Request();
        int senderId = utils.getPrincipal().getUserId();
        int recipientId = Integer.parseInt(requestByDay.getRecipientId());

        User sender = userService.getUserById(senderId);
        User recipient = userService.getUserById(recipientId);

        Date requireDate = utils.stringToDate(requestByDay.getDateRequire());

        request.setRequester(sender);
        request.setResponder(recipient);
        request.setRequestDescription(requestByDay.getDecription());
        request.setRequestLocation(requestByDay.getLocation());
        request.setRequestDate(requireDate);
        request.setDaysRequest(requestByDay.getDaysRequire().stream().map(day -> utils.stringToDate(day))
                .collect(Collectors.toList()));
        return request;
    }

    public RequestByDay mapToRequestByDay(Request request) {
        RequestByDay requestByDay = new RequestByDay();

        // Thiết lập các giá trị cho RequestByDay từ Request
        requestByDay.setRecipientId(String.valueOf(request.getResponder().getUserId())); // Ví dụ: Lấy ID của người phản
                                                                                         // hồi
        requestByDay.setLocation(request.getRequestLocation());
        requestByDay.setType(request.getRequestType());
        requestByDay.setDateRequire(utils.dateToString(request.getRequestDate()));
        requestByDay.setDecription(request.getRequestDescription());
        requestByDay.setDaysRequire(request.getDaysRequest().stream().map(day -> utils.dateToString(day))
                .collect(Collectors.toList()));

        return requestByDay;
    }

    public Request requestDtoToRequest(RequestDto requestDto) {
        Request request = new Request();
        int senderId = utils.getPrincipal().getUserId();
        int recipientId = Integer.parseInt(requestDto.getRecipientId());

        User sender = userService.getUserById(senderId);
        User recipient = userService.getUserById(recipientId);

        Date requireDate = utils.stringToDate(requestDto.getDateRequire());
        Date deadline = utils.stringToDate(requestDto.getDeadline());

        request.setRequester(sender);
        request.setResponder(recipient);
        request.setRequestDescription(requestDto.getDecription());
        request.setRequestLocation(requestDto.getLocation());
        request.setRequestDate(requireDate);
        request.setRequestDateEnd(deadline);
        return request;
    }

    public RequestDto requestToRequestDto(Request request) {
        RequestDto requestDto = new RequestDto();

        // Lấy thông tin về người gửi và người nhận từ Request
        User responder = request.getResponder();

        // Thiết lập các thuộc tính của RequestDto từ Request
        requestDto.setRecipientId(String.valueOf(responder.getUserId())); // ID của người nhận
        requestDto.setLocation(request.getRequestLocation());
        requestDto.setDateRequire(utils.dateToString(request.getRequestDate()));
        requestDto.setDeadline(utils.dateToString(request.getRequestDateEnd()));
        requestDto.setDecription(request.getRequestDescription());
        requestDto.setType(request.getRequestType());
        // Các thuộc tính khác của RequestDto có thể được thiết lập ở đây nếu cần

        return requestDto;
    }

    public Request requestRepresentativeToRequest(RequestRepresentativeDto requestRepDto) {
        int senderId = utils.getPrincipal().getUserId();
        int recipientId = Integer.parseInt(requestRepDto.getRecipientId());
        User sender = userService.getUserById(senderId);
        User recipient = userService.getUserById(recipientId);
        Date requireDate = utils.stringToDate(requestRepDto.getDateRequire());
        Request request = new Request();

        request.setRequester(sender);
        request.setResponder(recipient);
        request.setRequestDescription(requestRepDto.getDecription());
        request.setRequestLocation(requestRepDto.getLocation());
        request.setRequestDate(requireDate);

        // Thiết lập các thuộc tính của request từ requestRepDto
        RequestRepresentative requestRepresentative = new RequestRepresentative();
        requestRepresentative.setStartDate(utils.stringToDate(requestRepDto.getDateStart()));
        requestRepresentative.setMonths(utils.stringToInt(requestRepDto.getNumberMonths()));

        LocalDate startDate = utils.stringToLocalDate(requestRepDto.getDateStart());
        int numberMonths = utils.stringToInt(requestRepDto.getNumberMonths());
        LocalDate endDate = startDate.plusMonths(numberMonths);

        requestRepresentative.setEndDate(Date.from(endDate.atStartOfDay(ZoneId.systemDefault()).toInstant()));
        requestRepresentative.setRequest(request);
        request.setRequestRepresentative(requestRepresentative);

        return request;
    }

    public RequestRepresentativeDto requestToRequestRepresentativeDto(Request request) {
        RequestRepresentativeDto requestRepDto = new RequestRepresentativeDto();

        // Chuyển đổi thông tin người gửi và người nhận
        User recipient = request.getResponder();
        requestRepDto.setRecipientId(String.valueOf(recipient.getUserId()));

        // Thiết lập thông tin cơ bản của yêu cầu đại diện
        requestRepDto.setLocation(request.getRequestLocation());
        requestRepDto.setType(request.getRequestType());
        requestRepDto.setDateRequire(request.getRequestDate().toString());
        requestRepDto.setDecription(request.getRequestDescription());

        // Lấy thông tin từ đối tượng RequestRepresentative (nếu có)
        RequestRepresentative requestRepresentative = request.getRequestRepresentative();
        if (requestRepresentative != null) {
            requestRepDto.setDateStart(utils.dateToString(requestRepresentative.getStartDate()));
            requestRepDto.setNumberMonths(String.valueOf(requestRepresentative.getMonths()));
        }

        return requestRepDto;
    }

    public RequestPending requestToRequestPending(Request request) {
        RequestPending requestPending = new RequestPending();

        UserInfo userSender = new UserInfo(request.getRequester().getUserId(),
                request.getRequester().getProfile().getFullName(), request.getRequester().getRole(),
                request.getRequester().getProfile().getAvatarUrl());

        requestPending.setSender(userSender);
        if ("VIDEO".equalsIgnoreCase(request.getRequestType())) {
            RequestDto requestDto = requestToRequestDto(request);
            requestPending.setRequestDto(requestDto);
        }
        if ("POST".equalsIgnoreCase(request.getRequestType())) {
            RequestDto requestDto = requestToRequestDto(request);
            requestPending.setRequestDto(requestDto);
        }
        if ("HIREBYDAY".equalsIgnoreCase(request.getRequestType())) {
            RequestByDay requestByDay = mapToRequestByDay(request);
            requestPending.setRequestByDay(requestByDay);
        }
        if ("REPRESENTATIVE".equalsIgnoreCase(request.getRequestType())) {
            RequestRepresentativeDto requestRepresentative = requestToRequestRepresentativeDto(request);
            requestPending.setRequestRepresentative(requestRepresentative);
        }
        requestPending.setRequestId(request.getRequestId());
        requestPending.setPrice(request.getPayment());
        return requestPending;
    }
}
