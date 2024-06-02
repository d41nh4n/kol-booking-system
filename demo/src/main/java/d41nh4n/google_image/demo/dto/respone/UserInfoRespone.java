package d41nh4n.google_image.demo.dto.respone;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class UserInfoRespone {
    private String id;
    private String username;
    private String role;
    private String email;
    private String phone;
    private String dateOfBirth;
    private String avatarUrl;
    private String address;
    private boolean gender;
    private String profileDesc;
}
