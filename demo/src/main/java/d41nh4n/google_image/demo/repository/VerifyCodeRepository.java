package d41nh4n.google_image.demo.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import d41nh4n.google_image.demo.entity.VerifyCode;

public interface VerifyCodeRepository extends JpaRepository<VerifyCode, Integer>{
    
}
