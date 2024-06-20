package d41nh4n.google_image.demo.dto.requestJob;

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
public class RequestRepresentativeDto {
    private String recipientId;
    private String location;
    private String type;
    private String dateRequire;
    private String dateStart;
    private String numberMonths;
    private String decription;
}
