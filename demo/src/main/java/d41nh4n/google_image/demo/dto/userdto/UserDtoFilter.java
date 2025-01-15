package d41nh4n.google_image.demo.dto.userdto;

import java.text.SimpleDateFormat;
import java.util.List;

import d41nh4n.google_image.demo.entity.user.User;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class UserDtoFilter {
    private int userId;
    private String fullName;
    private String gender;
    private List<String> catgories;
    private String avatarUrl;
    private String location;
    private double rating;
    private double pricePost;
    private double priceVideo;
    private double priceHireByDay;
    private double representativePrice;
}
