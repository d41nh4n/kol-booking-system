package d41nh4n.google_image.demo.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import d41nh4n.google_image.demo.dto.userdto.UserFindedBySearch;
import d41nh4n.google_image.demo.entity.user.Gender;
import d41nh4n.google_image.demo.entity.user.User;

public interface UserRepository extends JpaRepository<User, Integer> {

        Optional<User> findByUsernameAndPasswordHash(String username, String password);

        Optional<User> findByUsername(String username);

        Optional<User> findByEmail(String email);

        Optional<User> findByResetPasswordToken(String token);

        @Query("SELECT new d41nh4n.google_image.demo.dto.userdto.UserFindedBySearch(" +
                        "u.userId, p.fullName, p.avatarUrl, u.role) " +
                        "FROM User u JOIN u.profile p " +
                        "WHERE p.fullName LIKE %:searchTerm%")
        List<UserFindedBySearch> getUsersByFullNameContaining(@Param("searchTerm") String searchTerm);

        List<User> findByRole(String role);

        @Query("SELECT u FROM User u WHERE u.role = 'KOL' ORDER BY u.profile.averageRating DESC")
        List<User> findTop7ByRoleKolOrderByRatingPointDesc();

        @Query("SELECT DISTINCT u FROM User u "
                        + "JOIN u.profile p "
                        + "LEFT JOIN ProfileCategories pc ON p.profileId = pc.userId "
                        + "LEFT JOIN Category c ON pc.categoryId = c.categoryId "
                        + "WHERE (:averageRating IS NULL OR p.averageRating >= :averageRating) "
                        + "AND u.role = 'KOL' "
                        + "AND (:fullName IS NULL OR p.fullName LIKE %:fullName%) "
                        + "AND (:username IS NULL OR u.username LIKE %:username%) "
                        + "AND (:location IS NULL OR p.location = :location) "
                        + "AND (:priceAPost IS NULL OR (p.priceAPost <= :maxPrice AND p.priceAPost >= :minPrice)) "
                        + "AND (:priceAToHireADay IS NULL OR (p.priceAToHireADay <= :maxPrice AND p.priceAToHireADay >= :minPrice)) "
                        + "AND (:priceAVideo IS NULL OR (p.priceAVideo <= :maxPrice AND p.priceAVideo >= :minPrice)) "
                        + "AND (:representativePrice IS NULL OR (p.representativePrice <= :maxPrice AND p.representativePrice >= :minPrice)) "
                        + "AND (:categoryName IS NULL OR c.categoryName = :categoryName) "
                        + "AND (:gender IS NULL OR u.gender = :gender)")
        List<User> findByFilters(@Param("averageRating") Double averageRating,
                        @Param("fullName") String fullName,
                        @Param("username") String username,
                        @Param("location") String location,
                        @Param("priceAPost") String priceAPost,
                        @Param("priceAVideo") String priceAVideo,
                        @Param("priceAToHireADay") String priceAToHireADay,
                        @Param("representativePrice") String representativePrice,
                        @Param("maxPrice") Long maxPrice,
                        @Param("minPrice") Long minPrice,
                        @Param("categoryName") String categoryName,
                        @Param("gender") Gender gender);

}