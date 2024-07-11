package com.example.demo.dto.userdto;

import java.text.SimpleDateFormat;
import java.util.List;

import com.example.demo.entity.user.User;
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
