package d41nh4n.google_image.demo.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class ReportDto {
    private String commentId;
    private String reportedUserId;
    private Date createAt;
    private String reason;
    private String description;
}
