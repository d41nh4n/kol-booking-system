/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package d41nh4n.google_image.demo.service;

import java.time.LocalDate;
import java.time.ZoneId;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import d41nh4n.google_image.demo.dto.CategoryCountDTO;
import d41nh4n.google_image.demo.entity.user.Profile;
import d41nh4n.google_image.demo.entity.user.ProfileCategories;
import d41nh4n.google_image.demo.entity.user.User;
import d41nh4n.google_image.demo.repository.ProfileCategoriesRepository;

/**
 *
 * @author DAO
 */
@Service
public class ProfileCategoryService {
    @Autowired
    private ProfileCategoriesRepository profileCategoryRepository;

    @Autowired
    private UserService userService;

    @Autowired
    private ProfileService profileService;

    public List<CategoryCountDTO> getCategoryCounts() {
        return profileCategoryRepository.findCategoryCounts();
    }

    public void saveCategories(User user, List<Integer> categoryIds) {
        // Ensure User exists in the database
        if (userService.findById(user.getUserId()) == null) {
            throw new RuntimeException("User does not exist");
        }

        // Check if Profile exists, create one if it doesn't
        if (user.getProfile() == null) {
            Profile profile = new Profile();
            profile.setProfileId(user.getUserId());

            // Set other necessary fields for Profile
            profile.setFullName(user.getUsername()); // Full name derived from username or other sources
            profile.setBio("This is a default bio."); // Default bio
            profile.setAvatarUrl("default_avatar.png"); // Example: set default avatar URL
            profile.setLocation("Default Location"); // Example: set default or derived location
            profile.setPriceAPost(0L); // Initial price for a post
            profile.setPriceAVideo(0L); // Initial price for a video
            profile.setPriceAToHireADay(0L); // Initial price to hire per day
            profile.setRepresentativePrice(0L); // Initial representative price
            profile.setAverageRating(0.0); // Initial rating
            profile.setMoney(0.0); // Initial money value

            profileService.save(profile);
        }

        for (Integer categoryId : categoryIds) {
            ProfileCategories profileCategory = new ProfileCategories();
            profileCategory.setUserId(user.getUserId());
            profileCategory.setCategoryId(categoryId);
            profileCategoryRepository.save(profileCategory);
        }
    }
}
