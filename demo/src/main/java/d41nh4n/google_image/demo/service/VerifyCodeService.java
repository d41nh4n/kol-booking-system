package d41nh4n.google_image.demo.service;

import org.springframework.stereotype.Service;

import d41nh4n.google_image.demo.entity.VerifyCode;
import d41nh4n.google_image.demo.repository.VerifyCodeRepository;
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
