package d41nh4n.google_image.demo.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import d41nh4n.google_image.demo.repository.CategoryRepository;

import java.util.List;

@Service
public class CategoryService {

    @Autowired
    private CategoryRepository categoryRepository;

    public List<String> getAllCategoryNames() {
        return categoryRepository.findAllCategoryNames();
    }
}
