package d41nh4n.google_image.demo.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import d41nh4n.google_image.demo.entity.user.ProfileCategories;

@Repository
public interface ProfileCategoriesRepository extends JpaRepository<ProfileCategories, Integer> {
    List<ProfileCategories> findByUserId(int userId);
}