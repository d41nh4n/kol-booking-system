package d41nh4n.google_image.demo.dto.userdto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

import java.text.SimpleDateFormat;
import java.util.Date;

import d41nh4n.google_image.demo.entity.user.User;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@ToString
public class UserDto {
    private int userId;
    private String email;
    private String createAt;
    private String role;
    private String fullName;
    private String bio;
    private String gender;
    private String avatarUrl;
    private String birthday;
    private String phoneNumber;
    private String address;

    private static final SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

    public UserDto(User user) {
        this.userId = user.getUserId();
        this.email = user.getEmail();
        if (gender != null) {
            this.gender = user.getGender().toString();
        } else {
            this.gender = null;
        }
        if (user.getCreateAt() != null) {
            this.createAt = dateFormat.format(user.getCreateAt());
        } else {
            this.createAt = null;
        }
        this.role = user.getRole();
        if (user.getProfile() != null) {
            this.fullName = user.getProfile().getFullName();
            this.bio = user.getProfile().getBio();
            this.avatarUrl = user.getProfile().getAvatarUrl();
            if (user.getProfile().getBirthday() != null) {
                this.birthday = dateFormat.format(user.getProfile().getBirthday());
            } else {
                this.birthday = null;
            }
            this.phoneNumber = user.getProfile().getPhoneNumber();
            this.address = user.getProfile().getAddress();
        }
    }
}
