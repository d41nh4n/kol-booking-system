package d41nh4n.google_image.demo.service;

import java.time.LocalDateTime;

import org.springframework.stereotype.Service;

import d41nh4n.google_image.demo.entity.VerifyCode;
import d41nh4n.google_image.demo.model.Mail;
import d41nh4n.google_image.demo.repository.VerifyCodeRepository;
import d41nh4n.google_image.demo.validation.Utils;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class VerifyCodeService {

    private final VerifyCodeRepository codeRepository;
    private final Utils utils;
    private final MailService mailService;

    public VerifyCode save(VerifyCode verifyCode) {
        return codeRepository.save(verifyCode);
    }

    public VerifyCode getById(int id) {
        return codeRepository.findById(id).orElse(null);
    }

    public void delete(VerifyCode verifyCode) {
        codeRepository.delete(verifyCode);
    }

    public int genarateCodeAndReturnId(String email, String userName) {
        String code = utils.generateRandomCode();
        VerifyCode verifyCode = new VerifyCode(userName, email, code, 0);
        Mail mail = new Mail();
        mail.setSubject("Code Confirm:");
        mail.setMessage(code);
        mailService.sendMail(email, mail);
        return save(verifyCode).getId();
    }

    public boolean isCodeExpired(VerifyCode verifyCode) {
        return verifyCode.getExpiryDateTime().isBefore(LocalDateTime.now());
    }
}
