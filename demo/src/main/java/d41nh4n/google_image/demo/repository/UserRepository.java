package d41nh4n.google_image.demo.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import d41nh4n.google_image.demo.dto.userdto.UserFindedBySearch;
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
}
