package com.example.demo.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.example.demo.entity.user.MediaProfile;
import com.example.demo.entity.user.Profile;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;

import java.util.List;

public interface MediaProfileRepository extends JpaRepository<MediaProfile, Long> {

    List<MediaProfile> findByProfile(Profile profile, Sort sort);
}
