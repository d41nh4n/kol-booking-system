package d41nh4n.google_image.demo.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import d41nh4n.google_image.demo.entity.Category;

import java.util.List;

@Repository
public interface CategoryRepository extends JpaRepository<Category, Integer> {

    @Query("SELECT c.categoryName FROM Category c")
    List<String> findAllCategoryNames();

    @Query("select c from Category c where c.categoryName LIKE %?1% or c.description LIKE %?1%")
    Page<Category> searchCategories(String keyword, Pageable pageable);
}
