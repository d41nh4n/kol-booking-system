package com.duc.vnpaydemo.repository;

import com.duc.vnpaydemo.model.Users;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

public interface UserRepository extends JpaRepository<Users, Long> {
    Users findByUsername(String username);

    @Query("SELECT u FROM Users u WHERE u.username = :username AND u.password_hash = :password")
    Users findByUsernameAndPassword(String username, String password);
}
