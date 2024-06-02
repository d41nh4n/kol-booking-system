package d41nh4n.google_image.demo.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.PrePersist;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

import java.util.Date;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "tb_User")
@ToString
public class User {

    @Id
    @Column(name = "user_id", nullable = false, unique = true, length = 255)
    private String userId;

    @Column(name = "username", unique = true, length = 255, nullable = false)
    private String username;

    @Column(name = "password", length = 255, nullable = false)
    private String password;

    @Column(name = "email", length = 255)
    private String email;

    @Column(name = "create_at")
    private Date createAt;

    @Column(name = "is_locked")
    private boolean isLocked;

    @Column(name = "role", length = 10)
    private String role;

    @Column(name = "profile_desc", length = 500)
    private String profileDesc;

    @Column(name = "avatar_url", length = 500)
    private String avatarUrl;

    @Column(name = "dob")
    private Date dob;

    @Column(name = "phone", length = 15)
    private String phone;

    @Column(name = "address", length = 255)
    private String address;

    @Column(name = "gender")
    private boolean gender;

    @Column(name = "reset_password_token")
    private String resetPasswordToken;

      @PrePersist
    protected void onCreate() {
        this.createAt = new Date();
    }
}
