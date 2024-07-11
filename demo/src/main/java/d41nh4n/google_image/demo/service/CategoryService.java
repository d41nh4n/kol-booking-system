package d41nh4n.google_image.demo.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import d41nh4n.google_image.demo.entity.Category;
import d41nh4n.google_image.demo.repository.CategoryRepository;

import java.util.List;
import java.util.Optional;

@Service
public class CategoryService {

    @Autowired
    private CategoryRepository categoryRepository;

    public List<String> getAllCategoryNames() {
        return categoryRepository.findAllCategoryNames();
    }

    public List<Category> getAllCategories() {
        return categoryRepository.findAll();
    }

    public Optional<Category> getCategoryById(int id) {
        return categoryRepository.findById(id);
    }

    public Category saveCategory(Category category) {
        return categoryRepository.save(category);
    }

    public void deleteCategoryById(int id) {
        categoryRepository.deleteById(id);
    }

    public Page<Category> findPaginated(Pageable pageable) {
        return categoryRepository.findAll(pageable);
    }

    public Page<Category> searchCategories(String keyword, Pageable pageable) {
        return categoryRepository.searchCategories(keyword, pageable);
    }

    public boolean checkDuplicateCategory(Category category) {
        List<Category> existingCategories = categoryRepository.findAll();

        for (Category existingCategory : existingCategories) {
            if (existingCategory.getCategoryName().equalsIgnoreCase(category.getCategoryName())) {
                return true;
            }
        }
        return false;
    }
}
