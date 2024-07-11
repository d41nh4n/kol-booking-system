package com.example.demo.exeption;

public class InvalidNumber extends RuntimeException {
    public InvalidNumber(String message, Throwable cause) {
        super(message, cause);
    }
}
