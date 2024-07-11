package com.example.demo.service;

import org.springframework.stereotype.Service;

import com.example.demo.entity.VerifyCode;
import com.example.demo.repository.VerifyCodeRepository;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class VerifyCodeService {

    private final VerifyCodeRepository codeRepository;

    public void save(VerifyCode verifyCode) {
        codeRepository.save(verifyCode);
    }

    public VerifyCode getById(String id) {
        return codeRepository.findById(id).orElse(null);
    }

    public void delete(VerifyCode verifyCode) {
        codeRepository.delete(verifyCode);
    }
}
