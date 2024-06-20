package d41nh4n.google_image.demo.dto.requestJob;
import d41nh4n.google_image.demo.dto.userdto.UserInfo;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class RequestPending {
    private UserInfo sender;
    private int requestId;
    private RequestDto requestDto ;
    private RequestByDay requestByDay;
    private RequestRepresentativeDto requestRepresentative;
    private double price;
}
