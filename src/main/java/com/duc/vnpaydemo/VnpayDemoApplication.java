package com.duc.vnpaydemo;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.domain.EntityScan;

@SpringBootApplication
@EntityScan(basePackages = {"com.duc.vnpaydemo.model"})
//Hello my love ,my name is Trac 
public class VnpayDemoApplication {

    public static void main(String[] args) {
        SpringApplication.run(VnpayDemoApplication.class, args);
    }

}
