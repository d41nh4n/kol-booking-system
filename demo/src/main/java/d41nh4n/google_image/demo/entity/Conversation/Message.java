package d41nh4n.google_image.demo.entity.conversation;

import java.time.ZonedDateTime;

import d41nh4n.google_image.demo.entity.user.User;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Entity
@Setter
@Getter
@NoArgsConstructor
@ToString
@Table(name = "tb_message")
public class Message {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "content", nullable = false, columnDefinition = "ntext")
    private String content;

    @Column(name = "type", nullable = false)
    private String type;

    @Column(name = "timestamp", nullable = false)
    private ZonedDateTime timestamp;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "sender_id", nullable = false)
    private User sender;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "recipient_id", nullable = false)
    private User recipient;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "conversation_id", nullable = false)
    private Conversation conversation;

    @Column(name = "is_read", nullable = false)
    private boolean isReaded;

    public Message(Long id, String content, String type, ZonedDateTime timestamp, User sender, User recipient,
            Conversation conversation) {
        this.id = id;
        this.content = content;
        this.type = type;
        this.timestamp = timestamp;
        this.sender = sender;
        this.recipient = recipient;
        this.conversation = conversation;
        this.isReaded = false;
    }
}
