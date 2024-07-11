package com.example.demo.service;

import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import com.example.demo.model.Province;
import com.example.demo.model.ProvinceApiRespone;

import java.util.ArrayList;
import java.util.List;

@Service
public class ProvinceService {

    private static final String API_URL = "https://esgoo.net/api-tinhthanh/1/0.htm";
    private static List<String> provinceNames = new ArrayList<>();

    static {
        // Khởi tạo danh sách tên tỉnh thành khi khởi động ứng dụng
        fetchProvinceNames();
    }

    private static void fetchProvinceNames() {
        RestTemplate restTemplate = new RestTemplate();
        ProvinceApiRespone response = restTemplate.getForObject(API_URL, ProvinceApiRespone.class);
        if (response != null && response.getError() == 0 && response.getData() != null) {
            for (Province province : response.getData()) {
                // Lấy tên của từng tỉnh thành và thêm vào danh sách
                provinceNames.add(province.getName());
            }
        } else {
            // Xử lý trường hợp không lấy được dữ liệu từ API
            System.out.println("Failed to fetch province data from API.");
        }
    }

    public List<String> getProvinceNames() {
        return provinceNames;
    }
}
