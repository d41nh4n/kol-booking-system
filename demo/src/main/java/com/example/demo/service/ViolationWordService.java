/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package d41nh4n.google_image.demo.service;

import java.util.List;
import java.util.Optional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import d41nh4n.google_image.demo.entity.report.ViolationWord;
import d41nh4n.google_image.demo.repository.ViolationWordRepository;

/**
 *
 * @author DAO
 */
@Service
public class ViolationWordService {

    @Autowired
    private ViolationWordRepository violationWordRepository;

    public Optional<ViolationWord> findById(Integer id) {
        return violationWordRepository.findById(id);
    }

    public List<ViolationWord> findAll() {
        return violationWordRepository.findAll();
    }

    public String saveViolationWord(ViolationWord violationWord) {
        boolean isDuplicate = checkDuplicateViolationWord(violationWord);
        if (isDuplicate) {
            return "Duplicate violation word";
        }
        violationWordRepository.save(violationWord);
        return "Success";
    }

    public void deleteById(int id) {
        violationWordRepository.deleteById(id);
    }

    public Page<ViolationWord> findPaginated(Pageable pageable) {
        return violationWordRepository.findAll(pageable);
    }

    public boolean checkDuplicateViolationWord(ViolationWord violationWord) {
        List<ViolationWord> existingViolationWords = violationWordRepository.findAll();
        for (ViolationWord existingViolationWord : existingViolationWords) {
            if (!existingViolationWord.getWordId().equals(violationWord.getWordId())
                    && existingViolationWord.getWord().equalsIgnoreCase(violationWord.getWord())) {
                return true;
            }
        }
        return false;
    }
}
