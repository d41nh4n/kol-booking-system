package d41nh4n.google_image.demo.mapper;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import d41nh4n.google_image.demo.dto.userdto.UserDto;
import d41nh4n.google_image.demo.entity.Category;
import d41nh4n.google_image.demo.entity.user.Gender;
import d41nh4n.google_image.demo.entity.user.ProfileCategories;
import d41nh4n.google_image.demo.entity.user.User;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
public final class UserToUserDto {

    private static final SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

    public static UserDto mapToUserInfoResponse(User user) {
        UserDto userInfo = new UserDto();
        userInfo.setUserId(user.getUserId());
        userInfo.setFullName(user.getProfile().getFullName());
        userInfo.setRole(user.getRole());
        userInfo.setAvatarUrl(user.getProfile().getAvatarUrl());
        if (user.getProfile().getBirthday() != null) {
            userInfo.setBirthday(dateFormat.format(user.getProfile().getBirthday()));
        }
        userInfo.setLocation(user.getProfile().getLocation());
        if (user.getGender() == null) {
            userInfo.setGender(Gender.OTHER.toString());
        } else {
            userInfo.setGender(user.getGender().toString());
        }
        userInfo.setBio(user.getProfile().getBio());
        userInfo.setRating(user.getProfile().getAverageRating());
        userInfo.setPricePost(user.getProfile().getPriceAPost());
        userInfo.setPriceVideo(user.getProfile().getPriceAVideo());
        userInfo.setPriceHireByDay(user.getProfile().getPriceAToHireADay());
        userInfo.setRepresentativePrice(user.getProfile().getRepresentativePrice());
        userInfo.setAverageRating(user.getProfile().getAverageRating());
        List<ProfileCategories> profileCategories = user.getProfile().getProfileCategories();
        List<String> categoryNames = new ArrayList<>();
        for (ProfileCategories profileCategory : profileCategories) {
            Category category = profileCategory.getCategory();
            if (category != null) {
                categoryNames.add(category.getCategoryName());
            }
        }
        userInfo.setCategories(categoryNames);

        return userInfo;
    }

    // private static String formatDateOfBirth(Date dateOfBirth) {
    // if (dateOfBirth == null) {
    // return null;
    // }
    // SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
    // return formatter.format(dateOfBirth);
    // }

    // public static UserFindedBySearch mapToUserFindedBySearch(User user) {
    // UserFindedBySearch userFindedBySearch = new UserFindedBySearch();
    // userFindedBySearch.setId(user.getUserId());
    // userFindedBySearch.setUsername(user.getUsername());
    // return userFindedBySearch;
    // }
}
