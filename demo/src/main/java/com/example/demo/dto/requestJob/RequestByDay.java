package com.example.demo.dto.requestJob;

import java.util.Date;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class RequestByDay {
    private String recipientId;
    private String location;
    private String type;
    private String dateRequire;
    private String decription;
    private List<String> daysRequire;
}
