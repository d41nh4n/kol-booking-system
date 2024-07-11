package com.example.demo.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import com.example.demo.model.Mail;

@Service
public class MailService {

    @Value("${spring.mail.username}")
    private String fromMail;

    @Autowired
    private JavaMailSender javaMailSender;

    public void sendMail(String mail, Mail mailStruct) {
        SimpleMailMessage mailMessage = new SimpleMailMessage();
        mailMessage.setFrom(fromMail);
        mailMessage.setSubject(mailStruct.getSubject());
        mailMessage.setText(mailStruct.getMessage());
        mailMessage.setTo(mail);

        javaMailSender.send(mailMessage);
    }
}
