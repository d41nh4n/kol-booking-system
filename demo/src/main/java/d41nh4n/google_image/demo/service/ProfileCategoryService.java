/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package d41nh4n.google_image.demo.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import d41nh4n.google_image.demo.dto.CategoryCountDTO;
import d41nh4n.google_image.demo.repository.ProfileCategoriesRepository;

/**
 *
 * @author DAO
 */
@Service
public class ProfileCategoryService{
    @Autowired
    private ProfileCategoriesRepository profileCategoryRepository;

    public List<CategoryCountDTO> getCategoryCounts() {
        return profileCategoryRepository.findCategoryCounts();
    }
}
