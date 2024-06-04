package d41nh4n.google_image.demo.entity;

import java.time.ZonedDateTime;

import jakarta.persistence.PrePersist;

public class Notification {

    private String id; 
    private String type;
    private Long referenceId;
    private String content;
    private ZonedDateTime createAt;


     @PrePersist
    protected void onCreate() {
        createAt = ZonedDateTime.now();
    }
}
