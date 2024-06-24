package d41nh4n.google_image.demo.service;

import java.util.ArrayList;
import java.util.List;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import d41nh4n.google_image.demo.dto.userdto.UserDto;
import d41nh4n.google_image.demo.dto.userdto.UserDtoFilter;
import d41nh4n.google_image.demo.dto.userdto.UserFindedBySearch;
import d41nh4n.google_image.demo.entity.Category;
import d41nh4n.google_image.demo.entity.user.Gender;
import d41nh4n.google_image.demo.entity.user.Profile;
import d41nh4n.google_image.demo.entity.user.ProfileCategories;
import d41nh4n.google_image.demo.entity.user.User;
import d41nh4n.google_image.demo.repository.CategoryRepository;
import d41nh4n.google_image.demo.repository.ProfileCategoriesRepository;
import d41nh4n.google_image.demo.repository.ProfileRepository;
import d41nh4n.google_image.demo.repository.UserRepository;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class UserService {

    private final UserRepository userRepository;
    private final ProfileRepository profileRepository;
    private final ProfileCategoriesRepository profileCategoriesRepository;
    private final CategoryRepository categoryRepository;

    @Transactional
    public User registerUser(User user, Profile profile) {
        // Persist the User entity
        User savedUser = userRepository.save(user);

        // Create and persist the Profile entity
        profile.setUser(savedUser);
        profileRepository.save(profile);

        return savedUser;
    }

    @Transactional
    public User save(User user) {
        return userRepository.save(user);
    }

    public User getUserById(int userId) {
        return userRepository.findById(userId).orElse(null);
    }

    public User getUserByUsernameAndPassword(String username, String password) {
        return userRepository.findByUsernameAndPasswordHash(username, password).orElse(null);
    }

    public User getUserByUsername(String username) {
        return userRepository.findByUsername(username).orElse(null);
    }

    public User getUserByEmail(String email) {
        return userRepository.findByEmail(email).orElse(null);
    }

    public User getUserByResetPasswordToken(String token) {
        return userRepository.findByResetPasswordToken(token).orElse(null);
    }

    public void updatePassword(User user, String newPassword) {
        BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
        String encodedPassword = passwordEncoder.encode(newPassword);
        user.setPasswordHash(encodedPassword);
        user.setResetPasswordToken(null);
        userRepository.save(user);
    }

    public void updateResetPasswordToken(String token, String email) {
        User user = getUserByEmail(email);
        if (user != null) {
            user.setResetPasswordToken(token);
            userRepository.save(user);
        }
    }

    public List<UserFindedBySearch> searchUser(String username) {
        return userRepository.getUsersByFullNameContaining(username);
    }

    public UserDto getUserInforById(int id) {
        User user = userRepository.findById(id).orElse(null);
        if (user != null) {
            return new UserDto(user);
        }
        return null;
    }

    @Transactional
    public Profile save(Profile profile) {
        return profileRepository.save(profile);
    }

    public Profile getProfileById(int id) {
        return profileRepository.findById(id).orElse(null);
    }

    public Profile getProfileByName(String name) {
        return profileRepository.findByFullName(name);
    }

    public List<UserDtoFilter> getUserListHomePage() {
        List<User> users = userRepository.findByRole("KOL");
        List<UserDtoFilter> userDtoList = new ArrayList<>();

        for (User user : users) {
            UserDtoFilter dto = new UserDtoFilter();
            dto.setUserId(user.getUserId());
            dto.setRating(user.getProfile().getAverageRating());
            // Fetch Profile
            Profile profile = user.getProfile();
            if (profile != null) {
                dto.setFullName(profile.getFullName());
                dto.setAvatarUrl(profile.getAvatarUrl());
                dto.setLocation(profile.getLocation());
                dto.setPricePost(profile.getPriceAPost());
                dto.setPriceVideo((profile.getPriceAVideo()));
                dto.setPriceHireByDay(profile.getPriceAToHireADay());
                dto.setRepresentativePrice(profile.getRepresentativePrice());
            }
            // Fetch Categories
            List<ProfileCategories> profileCategories = profileCategoriesRepository.findByUserId(user.getUserId());
            List<String> categoryNames = new ArrayList<>();
            for (ProfileCategories profileCategory : profileCategories) {
                Category category = categoryRepository.findById(profileCategory.getCategoryId()).orElse(null);
                if (category != null) {
                    categoryNames.add(category.getCategoryName());
                }
            }
            dto.setCatgories(categoryNames);
            userDtoList.add(dto);
        }
        return userDtoList;
    }

    public List<UserDtoFilter> getTop6UsersForHomePage() {
        List<User> topUsers = userRepository.findTop7ByRoleKolOrderByRatingPointDesc();
        List<UserDtoFilter> userDtoList = new ArrayList<>();
        List<User> top6Users = topUsers.subList(0, Math.min(topUsers.size(), 6));
        for (User user : top6Users) {
            UserDtoFilter dto = new UserDtoFilter();
            dto.setUserId(user.getUserId());
            dto.setRating(user.getProfile().getAverageRating());

            // Fetch Profile
            Profile profile = user.getProfile();
            if (profile != null) {
                dto.setFullName(profile.getFullName());
                dto.setAvatarUrl(profile.getAvatarUrl());
                dto.setLocation(profile.getLocation());
                dto.setPricePost(profile.getPriceAPost());
                dto.setPriceVideo((profile.getPriceAVideo()));
                dto.setPriceHireByDay(profile.getPriceAToHireADay());
                dto.setRepresentativePrice(profile.getRepresentativePrice());
            }
            // Fetch Categories
            List<ProfileCategories> profileCategories = profileCategoriesRepository.findByUserId(user.getUserId());
            List<String> categoryNames = new ArrayList<>();
            for (ProfileCategories profileCategory : profileCategories) {
                Category category = categoryRepository.findById(profileCategory.getCategoryId()).orElse(null);
                if (category != null) {
                    categoryNames.add(category.getCategoryName());
                }
            }
            dto.setCatgories(categoryNames);
            userDtoList.add(dto);
        }
        return userDtoList;
    }

    public List<UserDtoFilter> getUserByFilter(Double averageRating, String fullName, String username,
            String location, String requestAPost, String priceAVideo, String priceAToHireADay,
            String representativePrice,
            Long maxPrice, Long minPrice,
            String categoryName, Gender gender) {

        System.out.println(fullName);
        System.out.println(location);
        System.out.println(requestAPost);
        System.out.println(priceAVideo);
        System.out.println(priceAToHireADay);
        System.out.println(representativePrice);
        System.out.println(gender);
        List<User> users = userRepository.findByFilters(averageRating, fullName, username, location, requestAPost,
                priceAVideo, priceAToHireADay, representativePrice, maxPrice, minPrice,
                categoryName, gender);

        List<UserDtoFilter> userDtoList = new ArrayList<>();

        for (User user : users) {
            UserDtoFilter dto = new UserDtoFilter();
            dto.setUserId(user.getUserId());
            dto.setRating(user.getProfile().getAverageRating());

            // Fetch Profile
            Profile profile = user.getProfile();
            if (profile != null) {
                dto.setFullName(profile.getFullName());
                dto.setAvatarUrl(profile.getAvatarUrl());
                dto.setLocation(profile.getLocation());
                dto.setPricePost(profile.getPriceAPost());
                dto.setPriceVideo(profile.getPriceAVideo());
                dto.setPriceHireByDay(profile.getPriceAToHireADay());
                dto.setRepresentativePrice(profile.getRepresentativePrice());
            }

            // Fetch Categories
            List<String> categoryNames = new ArrayList<>();
            for (ProfileCategories profileCategory : profileCategoriesRepository.findByUserId(user.getUserId())) {
                Category category = profileCategory.getCategory();
                if (category != null) {
                    categoryNames.add(category.getCategoryName());
                }
            }
            dto.setCatgories(categoryNames);

            userDtoList.add(dto);
        }
        return userDtoList;
    }

}
