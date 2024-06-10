package d41nh4n.google_image.demo.mapper;

import java.text.SimpleDateFormat;
import java.util.Date;

import d41nh4n.google_image.demo.dto.respone.UserFindedBySearch;
import d41nh4n.google_image.demo.dto.respone.UserInfoRespone;
import d41nh4n.google_image.demo.entity.User.User;

public final class UserToUserDto {
    private UserToUserDto() {
    }

    public static UserInfoRespone mapToUserInfoResponse(User user) {
        UserInfoRespone userInfoRespone = new UserInfoRespone();
        userInfoRespone.setId(user.getUserId());
        userInfoRespone.setUsername(user.getUsername());
        userInfoRespone.setRole(user.getRole());
        userInfoRespone.setEmail(user.getEmail());
        userInfoRespone.setPhone(user.getPhone());
        userInfoRespone.setDateOfBirth(formatDateOfBirth(user.getDob()));
        userInfoRespone.setAvatarUrl(user.getAvatarUrl());
        userInfoRespone.setAddress(user.getAddress());
        userInfoRespone.setGender(user.isGender());
        userInfoRespone.setProfileDesc(user.getProfileDesc());
        return userInfoRespone;
    }

    private static String formatDateOfBirth(Date dateOfBirth) {
        if (dateOfBirth == null) {
            return null;
        }
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
        return formatter.format(dateOfBirth);
    }

    public static UserFindedBySearch mapToUserFindedBySearch(User user) {
        UserFindedBySearch userFindedBySearch = new UserFindedBySearch();
        userFindedBySearch.setId(user.getUserId());
        userFindedBySearch.setUsername(user.getUsername());
        return userFindedBySearch;
    }
}
