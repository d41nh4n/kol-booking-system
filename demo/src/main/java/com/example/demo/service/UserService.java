package com.example.demo.service;

import java.util.ArrayList;
import java.util.List;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.data.domain.*;
import com.example.demo.dto.userdto.UserDto;
import com.example.demo.dto.userdto.UserDtoFilter;
import com.example.demo.dto.userdto.UserFindedBySearch;
import com.example.demo.entity.Category;
import com.example.demo.entity.request.Request;
import com.example.demo.entity.request.RequestWaitList;
import com.example.demo.entity.user.Gender;
import com.example.demo.entity.user.Profile;
import com.example.demo.entity.user.ProfileCategories;
import com.example.demo.entity.user.User;
import com.example.demo.mapper.UserToUserDto;
import com.example.demo.repository.CategoryRepository;
import com.example.demo.repository.ProfileCategoriesRepository;
import com.example.demo.repository.ProfileRepository;
import com.example.demo.repository.RequestWaitListRepository;
import com.example.demo.repository.UserRepository;
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
            UserDto userDto = UserToUserDto.mapToUserInfoResponse(user);

            List<ProfileCategories> profileCategories = user.getProfile().getProfileCategories();
            List<String> categoryNames = new ArrayList<>();
            for (ProfileCategories profileCategory : profileCategories) {
                Category category = categoryRepository.findById(profileCategory.getCategoryId()).orElse(null);
                if (category != null) {
                    categoryNames.add(category.getCategoryName());
                }
            }
            userDto.setCategories(categoryNames);
            return userDto;
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

    public Page<UserDtoFilter> getUserByFilter(Double averageRating, String fullName, String username,
            String location, String requestAPost, String priceAVideo, String priceAToHireADay,
            String representativePrice, Long maxPrice, Long minPrice,
            String categoryName, Gender gender, int pageNumber, int pageSize) {

        Pageable pageable = PageRequest.of(pageNumber, pageSize);
        Page<User> users = userRepository.findByFilters(averageRating, fullName, username, location, requestAPost,
                priceAVideo, priceAToHireADay, representativePrice, maxPrice, minPrice,
                categoryName, gender, pageable);

        List<UserDtoFilter> userDtoList = new ArrayList<>();

        for (User user : users) {
            UserDtoFilter dto = new UserDtoFilter();
            dto.setUserId(user.getUserId());
            if (user.getProfile() != null) {
                Profile profile = user.getProfile();
                dto.setFullName(profile.getFullName());
                dto.setAvatarUrl(profile.getAvatarUrl());
                dto.setLocation(profile.getLocation());
                dto.setPricePost(profile.getPriceAPost());
                dto.setPriceVideo(profile.getPriceAVideo());
                dto.setPriceHireByDay(profile.getPriceAToHireADay());
                dto.setRepresentativePrice(profile.getRepresentativePrice());
                dto.setRating(profile.getAverageRating());
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

        return new PageImpl<>(userDtoList, pageable, users.getTotalElements());
    }

    public Double getAccountBalanceByUserId(int userId) {

        User user = userRepository.findById(userId).orElse(null);
        if (user != null) {
            return user.getAccountBalance();
        }
        return null;
    }

    public void updateUserBalance(int userId, double amountPaid) {
        User user = userRepository.findById(userId).orElseThrow(() -> new RuntimeException("User not found"));
        double userBalance = user.getAccountBalance() + amountPaid;
        user.setAccountBalance(userBalance);
        save(user);
    }
}
