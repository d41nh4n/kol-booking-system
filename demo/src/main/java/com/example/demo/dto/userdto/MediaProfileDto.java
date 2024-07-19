package d41nh4n.google_image.demo.dto.userdto;

import java.time.ZonedDateTime;

import d41nh4n.google_image.demo.entity.user.MediaProfile;
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
public class MediaProfileDto {
    private String url;
    private String id;
    private String type;
    private String createAt;

    public MediaProfileDto(MediaProfile mediaProfile) {
        this.url = mediaProfile.getUrl();
        this.id = String.valueOf(mediaProfile.getId());
        this.type = mediaProfile.getType();
        this.createAt = mediaProfile.getCreateAt().toString();
    }
}
