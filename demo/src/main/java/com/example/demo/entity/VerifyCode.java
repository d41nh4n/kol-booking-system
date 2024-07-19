package d41nh4n.google_image.demo.entity;

import java.time.LocalDateTime;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@Entity
@ToString
@Table(name = "tb_verifycode")
public class VerifyCode {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private int id;
    @Column(name = "userName", nullable = true)
    private String userName;
    @Column(name = "email")
    private String email;
    @Column(name = "code", unique = true)
    private String code;
    @Column(name = "expiryDateTime")
    private LocalDateTime expiryDateTime;
    @Column(name = "numberOfAttempts")
    private int numberOfAttempts;

    public VerifyCode() {
        this.expiryDateTime = LocalDateTime.now().plusMinutes(5);
    }

    public VerifyCode( String userName, String email, String code, int numberOfAttempts) {
        this.userName = userName;
        this.email = email;
        this.code = code;
        this.numberOfAttempts = numberOfAttempts;
        this.expiryDateTime = LocalDateTime.now().plusMinutes(5);
    }
}
