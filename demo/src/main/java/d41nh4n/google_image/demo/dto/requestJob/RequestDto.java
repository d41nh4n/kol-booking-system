package d41nh4n.google_image.demo.dto.requestJob;

import java.util.List;
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
public class RequestDto {
    private UserInfo sender;
    private UserInfo responder;
    private int requestId;
    private RequesPostOrVideotDto requestDto;
    private RequestByDay requestByDay;
    private RequestRepresentativeDto requestRepresentative;
    private String status;
    private double price;
    private boolean isPublic;
    private String urlResult; // Đổi tên cho đúng chính tả
    private List<UserInfo> listWaitList;

    public Boolean getIsPublic() {
        return isPublic;
    }

    public void setIsPublic(Boolean isPublic) {
        this.isPublic = isPublic;
    }

    public String getUrlResult() {
        return urlResult;
    }

    public void setUrlResult(String urlResult) {
        this.urlResult = urlResult;
    }
}
