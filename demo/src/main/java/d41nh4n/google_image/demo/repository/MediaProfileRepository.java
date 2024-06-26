package d41nh4n.google_image.demo.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import d41nh4n.google_image.demo.entity.user.MediaProfile;
import d41nh4n.google_image.demo.entity.user.Profile;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;

import java.util.List;

public interface MediaProfileRepository extends JpaRepository<MediaProfile, Long> {

    List<MediaProfile> findByProfile(Profile profile, Sort sort);
}
