package com.example.demo.model;

import java.util.List;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class ProvinceApiRespone {
    private int error;
    private String error_text;
    private String data_name;
    private List<Province> data;
}
