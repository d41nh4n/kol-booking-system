package d41nh4n.google_image.demo.dto.respone;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Setter
@Getter
@AllArgsConstructor
@NoArgsConstructor
public class ConversationExsisted {
    private String conversationId;
    private String recipientId;
    private String recipientName;
    private String avatarUrl;
    private String lastMessage;
}
