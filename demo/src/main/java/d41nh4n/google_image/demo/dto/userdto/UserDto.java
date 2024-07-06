package d41nh4n.google_image.demo.dto.userdto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import d41nh4n.google_image.demo.entity.user.User;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@ToString
public class UserDto {
    private int userId;
    private String createAt;
    private String role;
    private String fullName;
    private String bio;
    private String gender;
    private String avatarUrl;
    private String birthday;
    private String location;
    private double rating;
    private double pricePost;
    private double priceVideo;
    private double priceHireByDay;
    private double representativePrice;
    private double averageRating;
    private List<String> categories;

}
