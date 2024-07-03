package d41nh4n.google_image.demo.dto.userdto;

import java.util.Date;

import d41nh4n.google_image.demo.entity.user.User;
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
public class UserInfo {
    private int id;
    private String fullName;
    private String role;
    private String avatar;

    public UserInfo(User user) {
        this.id = user.getUserId();
        this.fullName = user.getProfile().getFullName();
        this.avatar = user.getProfile().getAvatarUrl();
        this.role = user.getRole();
    }
}
