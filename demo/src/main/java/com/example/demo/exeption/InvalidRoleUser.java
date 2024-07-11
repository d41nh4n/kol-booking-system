package com.example.demo.exeption;

public class InvalidRoleUser extends RuntimeException {
    public InvalidRoleUser(String message) {
        super(message);
    }
}
