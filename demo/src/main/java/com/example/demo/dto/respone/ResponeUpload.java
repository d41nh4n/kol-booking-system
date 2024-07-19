package d41nh4n.google_image.demo.dto.respone;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
@Builder
public class ResponeUpload {
    private int status;
    private String message;
    private String url;
    private String publicId;
}