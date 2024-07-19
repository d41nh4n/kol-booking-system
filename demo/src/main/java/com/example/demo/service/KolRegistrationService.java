/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package d41nh4n.google_image.demo.service;


import java.util.List;
import java.util.Optional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import d41nh4n.google_image.demo.entity.KolRegistration;
import d41nh4n.google_image.demo.repository.KolRegistrationRepository;

/**
 *
 * @author DAO
 */
@Service
public class KolRegistrationService {

    @Autowired
    private KolRegistrationRepository kolRegistrationRepository;
        
   
    public List<KolRegistration> getAllRegistrations() {
        return kolRegistrationRepository.findAll();
    }

   
    public void saveRegistration(KolRegistration registration) {
        kolRegistrationRepository.save(registration);
    }

   
    public Optional<KolRegistration> getRegistrationById(Long id) {
        return kolRegistrationRepository.findById(id);
    }

   
    public void deleteRegistration(Long id) {
        kolRegistrationRepository.deleteById(id);
    }
    
}
