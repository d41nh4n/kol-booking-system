package com.example.demo.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.example.demo.entity.user.Profile;

public interface ProfileRepository extends JpaRepository<Profile, Integer> {

    public Profile findByFullName(String name);
}
