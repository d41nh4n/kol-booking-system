package com.example.demo.dto.respone;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
public class VerifyStatus {
    private int status;
    private String message;
}
