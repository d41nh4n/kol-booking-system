package d41nh4n.google_image.demo.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.MailAuthenticationException;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import com.cloudinary.provisioning.Account;

import d41nh4n.google_image.demo.entity.user.User;
import d41nh4n.google_image.demo.model.Mail;

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

    public void sendRegistrationEmail(User user) {
        SimpleMailMessage mailMessage = new SimpleMailMessage();
        mailMessage.setFrom(fromMail);
        mailMessage.setTo(user.getEmail());
        mailMessage.setSubject("Registration Successful");
        mailMessage.setText("Dear " + user.getProfile().getFullName()
                + ",\n\nYour registration is successful. You can now log in.\n\nBest regards,\nYour Team");

        try {
            javaMailSender.send(mailMessage);
        } catch (MailAuthenticationException e) {
            // Log the error or handle it appropriately
            System.err.println("Failed to send email: " + e.getMessage());
        }
    }

    public void sendWelcomeEmail(User user) {
        SimpleMailMessage mailMessage = new SimpleMailMessage();
        mailMessage.setTo(user.getEmail());
        mailMessage.setSubject("Welcome to Our Application");
        mailMessage.setText("Dear " + user.getProfile().getFullName()
                + ",\n\nThank you for registering with our application. Your account has been successfully created.\n\nBest Regards,\nOur Application Team");

        try {
            javaMailSender.send(mailMessage);
        } catch (MailAuthenticationException e) {
            // Log the error or handle it appropriately
            System.err.println("Failed to send email: " + e.getMessage());
        }
    }
}
