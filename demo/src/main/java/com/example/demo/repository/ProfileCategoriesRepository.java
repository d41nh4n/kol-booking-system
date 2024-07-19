package d41nh4n.google_image.demo.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import d41nh4n.google_image.demo.dto.CategoryCountDTO;
import d41nh4n.google_image.demo.entity.user.ProfileCategories;

@Repository
public interface ProfileCategoriesRepository extends JpaRepository<ProfileCategories, Integer> {
    List<ProfileCategories> findByUserId(int userId);

    @Query("SELECT new d41nh4n.google_image.demo.dto.CategoryCountDTO(c.categoryName, COUNT(pc)) " +
           "FROM ProfileCategories pc JOIN pc.category c " +
           "GROUP BY c.categoryName")
    List<CategoryCountDTO> findCategoryCounts();
}