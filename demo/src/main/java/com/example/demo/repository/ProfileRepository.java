package d41nh4n.google_image.demo.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import d41nh4n.google_image.demo.entity.user.Profile;

public interface ProfileRepository extends JpaRepository<Profile, Integer> {

    public Profile findByFullName(String name);
}
