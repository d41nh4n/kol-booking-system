package d41nh4n.google_image.demo.entity.Conversation;

import java.time.ZonedDateTime;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Setter
@Getter
@AllArgsConstructor
@NoArgsConstructor
@Table(name = "tb_conversation")
public class Conversation {

    @Id
    @Column(name = "id")
    private String id;
    @Column(name = "created_at")
    private ZonedDateTime CreatedAt;
    @Column(name = "updated_at")
    private ZonedDateTime updatedAt;
    @Column(name = "lastMessage")
    private String lastMessage;
    @Enumerated(EnumType.STRING)
    @Column(name = "type", nullable = false)
    private TypeConversation type;
}
