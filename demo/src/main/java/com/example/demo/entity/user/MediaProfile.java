package d41nh4n.google_image.demo.entity.user;

import java.time.ZonedDateTime;

import com.fasterxml.jackson.annotation.JsonIgnore;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "media_profile")
@NoArgsConstructor
@AllArgsConstructor
@Setter
@Getter
public class MediaProfile {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "url", length = 500, nullable = false)
    private String url;

    @Column(name = "public_id", nullable = false)
    private String publicId;

    @Column(name = "type", length = 50, nullable = false)
    private String type; // IMAGE or VIDEO

    @Column(name = "createAt", nullable = false)
    private ZonedDateTime createAt;

    @JsonIgnore
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "profile_id")
    private Profile profile;
}
