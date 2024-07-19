package d41nh4n.google_image.demo.controller;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import d41nh4n.google_image.demo.dto.TransactionDto;
import d41nh4n.google_image.demo.service.TransactionHistoryService;
import d41nh4n.google_image.demo.validation.Utils;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class TransactionController {

    private final TransactionHistoryService transactionHistoryService;
    private final Utils utils;

    @RequestMapping("/transaction")
    public String getTransaction(@RequestParam(name = "page", required = false) Integer page, Model model) {

        if (page == null) {
            page = 0;
        }
        Page<TransactionDto> transactionDtos;
        int userid = utils.getPrincipal().getUserId();
        if (utils.getPrincipal().getRoles().equalsIgnoreCase("USER")) {
            transactionDtos = transactionHistoryService.findTransactionHistoryBySenderId(userid,
                    page);
        } else {
            transactionDtos = transactionHistoryService.findTransactionHistoryByReceiverId(userid,
                    page);
        }
        model.addAttribute("transactions", transactionDtos.getContent());
        return "transaction-list";
    }
}
