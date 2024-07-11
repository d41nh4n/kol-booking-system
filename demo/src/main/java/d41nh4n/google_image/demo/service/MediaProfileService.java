package d41nh4n.google_image.demo.service;

import java.util.ArrayList;
import java.util.List;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import d41nh4n.google_image.demo.entity.user.MediaProfile;
import d41nh4n.google_image.demo.entity.user.Profile;
import d41nh4n.google_image.demo.repository.MediaProfileRepository;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class MediaProfileService {

    private final MediaProfileRepository mediaProfileRepository;
    private final UserService userService;

    public MediaProfile save(MediaProfile mediaProfile) {
        return mediaProfileRepository.save(mediaProfile);
    }

    public void delete(MediaProfile mediaProfile) {
        mediaProfileRepository.delete(mediaProfile);
    }

    public List<MediaProfile> getAllByProfileId(int id) {
        Profile profile = userService.getProfileById(id);
        Sort sort = Sort.by(Sort.Direction.DESC, "createAt");
        if (profile != null) {
            return mediaProfileRepository.findByProfile(profile, sort);
        }
        return new ArrayList<>();
    }

    public MediaProfile getById(Long id){
        return mediaProfileRepository.findById(id).orElse(null);
    }
}
