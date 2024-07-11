
package d41nh4n.google_image.demo.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import d41nh4n.google_image.demo.dto.ProfileDTO;
import d41nh4n.google_image.demo.entity.user.Profile;
import d41nh4n.google_image.demo.entity.user.User;
import d41nh4n.google_image.demo.mapper.ProfileMapper;
import d41nh4n.google_image.demo.repository.ProfileRepository;
import d41nh4n.google_image.demo.repository.UserRepository;

@Service
public class ProfileService {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private ProfileRepository profileRepository;

    @Autowired
    private ProfileMapper profileMapper;

    public Profile findById(Integer userId) {
        return profileRepository.findById(userId).orElse(null);
    }

    public List<Profile> findAll() {
        return profileRepository.findAll();
    }

    public Profile save(Profile profile) {
        return profileRepository.save(profile);
    }

    public void deleteById(Integer userId) {
        profileRepository.deleteById(userId);
    }

    public ProfileDTO getUserProfile(Integer userId) {
        User user = userRepository.findById(userId).orElse(null);
        Profile profile = profileRepository.findById(userId).orElse(null);
        if (user != null && profile != null) {
            return profileMapper.toProfileDTO(user, profile);
        }
        return null;
    }

    public void deleteProfileByUserId(Integer id) {
        profileRepository.deleteById(id);
    }
}
