package com.duc.vnpaydemo.service;

import com.duc.vnpaydemo.model.Users;
import com.duc.vnpaydemo.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
@Service
public class UserService {

    @Autowired
    private UserRepository userRepository;

    public Users findByUsername(String username) {
        return userRepository.findByUsername(username);
    }

    public Users findByUsernameAndPassword(String username, String password) {
        return userRepository.findByUsernameAndPassword(username, password);
    }
}
