/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package d41nh4n.google_image.demo.entity.user;

/**
 *
 * @author DAO
 */
import jakarta.persistence.*;
import java.util.Date;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Entity
@Table(name = "Users")
@NoArgsConstructor
@AllArgsConstructor
@Setter
@Getter
@ToString
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int userId;

    @Column(length = 50, nullable = false, unique = true)
    private String username;

    @Column(length = 255, nullable = false)
    private String passwordHash;

    @Column(length = 100, nullable = true, unique = true)
    private String email;

    @Enumerated(EnumType.STRING)
    @Column(length = 6, nullable = true)
    private Gender gender;

    @Column(name = "is_locked")
    private boolean locked;

    @Column(name = "create_at")
    private Date createAt;

    @Column(name = "what_role", length = 20, nullable = false)
    private String role;

    @Column(name = "reset_password_token")
    private String resetPasswordToken;

    @Column(name = "account_balance")
    private Double accountBalance;

    @OneToOne(mappedBy = "user", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private Profile profile;

    @PrePersist
    protected void onCreate() {
        this.createAt = new Date();
        if (this.accountBalance == null) {
            this.accountBalance = 0.0;
        }
    }
}