package d41nh4n.google_image.demo.dto.userdto;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class UserProfileUpdate {
    private String fullName;
    private String gender;
    private String phone;
    private String dob;
    private String location;
    private String description;
}
