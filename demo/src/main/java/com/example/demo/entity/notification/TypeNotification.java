package com.example.demo.entity.notification;

import jakarta.annotation.security.DenyAll;

public enum TypeNotification {

    ACCOUNT,
    MONEY,
    JOIN_REQUEST,
    ACCEPT_REQUEST,
    REQUEST,
    DENY_REQUEST,
    CANCEL_REQUEST,
    SUBMIT
}
