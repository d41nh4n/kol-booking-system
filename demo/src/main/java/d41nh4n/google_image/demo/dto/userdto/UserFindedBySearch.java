package d41nh4n.google_image.demo.dto.userdto;

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
public class UserFindedBySearch {
    private int id;
    private String fullname;
    private String avatar;
    private String role;

    public UserFindedBySearch(User user) {
        this.id = user.getUserId();
        if (user.getProfile() != null) {
            this.fullname = user.getProfile().getFullName();
            this.avatar = user.getProfile().getAvatarUrl();
        } else {
            this.fullname = null;
            this.avatar = null;
        }
        this.role = user.getRole();
    }
}
