/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package d41nh4n.google_image.demo.service;

/**
 *
 * @author DAO
 */

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import d41nh4n.google_image.demo.entity.Comment;
import d41nh4n.google_image.demo.entity.notification.Notification;
import d41nh4n.google_image.demo.entity.notification.TypeNotification;
import d41nh4n.google_image.demo.entity.report.CommentViolation;
import d41nh4n.google_image.demo.entity.report.ViolationWord;
import d41nh4n.google_image.demo.entity.user.User;
import d41nh4n.google_image.demo.repository.CommentViolationRepository;
import d41nh4n.google_image.demo.repository.ViolationWordRepository;

import java.util.List;

@Service
public class ViolationCheckService {

    @Autowired
    private ViolationWordRepository violationWordRepository;

    @Autowired
    private CommentViolationRepository commentViolationRepository;

    @Autowired
    private NotificationService notificationService;

    @Autowired
    private UserService userService;

    public void checkCommentForViolations(Comment comment) {
        List<ViolationWord> violationWords = violationWordRepository.findAll();
        for (ViolationWord word : violationWords) {
            if (comment.getCommentContent().contains(word.getWord())) {
                CommentViolation commentViolation = new CommentViolation();
                commentViolation.setComment(comment);
                commentViolation.setViolationWord(word);
                comment.setIsViolation(Boolean.TRUE);
                commentViolationRepository.save(commentViolation);

                if (word.getViolationLevel() == 1) {
                    Notification notification = new Notification();
                    notification.setType(TypeNotification.ACCOUNT);
                    notification.setContent("You have used a prohibited word in your comment.");
                    notification.setUser(comment.getCommenter());
                    notification.setReferenceId(null);
                    notificationService.createNotification(notification);
                } else if (word.getViolationLevel() == 2) {
                    User user = comment.getCommenter();
                    user.setLocked(true);
                    userService.save(user);
                }
            }
        }
    }
}
