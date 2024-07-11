package d41nh4n.google_image.demo.controller;

import d41nh4n.google_image.demo.entity.Category;
import d41nh4n.google_image.demo.service.CategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.Optional;

@Controller
@RequestMapping("/admin/categories")
public class AdminCategoryController {

    @Autowired
    private CategoryService categoryService;

    @GetMapping
    public String listCategories(Model model,
            @RequestParam("page") Optional<Integer> page,
            @RequestParam(value = "keyword", required = false) String keyword) {
        int currentPage = page.orElse(1);
        int pageSize = 10;
        Pageable pageable = PageRequest.of(currentPage - 1, pageSize);

        Page<Category> categoryPage;
        if (keyword != null && !keyword.isEmpty()) {
            categoryPage = categoryService.searchCategories(keyword, pageable);
            model.addAttribute("keyword", keyword);
        } else {
            categoryPage = categoryService.findPaginated(pageable);
        }

        model.addAttribute("categoryPage", categoryPage);
        model.addAttribute("currentPage", currentPage);
        model.addAttribute("totalPages", categoryPage.getTotalPages());
        model.addAttribute("viewName", "admin/category/listcategories");

        return "admin-layout";
    }

    @GetMapping("/new")
    public String showNewCategoryForm(Model model) {
        Category category = new Category();
        model.addAttribute("category", category);
        model.addAttribute("viewName", "admin/category/newcategory");
        return "admin-layout";
    }

    @PostMapping
    public String saveCategory(@ModelAttribute("category") Category category, Model model,
            RedirectAttributes redirectAttributes) {
        boolean isDuplicate = categoryService.checkDuplicateCategory(category);

        if (isDuplicate) {
            model.addAttribute("duplicateMessage", "Category with the same name already exists!");
            model.addAttribute("viewName", "admin/category/newcategory");
            return "admin-layout";
        }

        categoryService.saveCategory(category);
        redirectAttributes.addFlashAttribute("notification", "Category added successfully!");
        return "redirect:/admin/categories";
    }

    @GetMapping("/edit/{id}")
    public String showEditCategoryForm(@PathVariable("id") int id, Model model) {
        Optional<Category> category = categoryService.getCategoryById(id);
        if (category.isPresent()) {
            model.addAttribute("category", category.get());
            model.addAttribute("viewName", "admin/category/editcategory");
            return "admin-layout";
        } else {
            return "redirect:/admin/categories";
        }
    }

    @PostMapping("/update/{id}")
    public String updateCategory(@PathVariable("id") int id, @ModelAttribute("category") Category category, Model model,
            RedirectAttributes redirectAttributes) {
        Optional<Category> existingCategory = categoryService.getCategoryById(id);
        if (existingCategory.isPresent()) {
            String existingCategoryName = existingCategory.get().getCategoryName();
            if (!existingCategoryName.equals(category.getCategoryName())) {
                boolean isDuplicate = categoryService.checkDuplicateCategory(category);
                if (isDuplicate) {
                    model.addAttribute("duplicateMessage", "Category with the same name already exists!");
                    model.addAttribute("category", existingCategory.get());
                    model.addAttribute("viewName", "admin/category/editcategory");
                    return "admin-layout";
                }
            }
            category.setCategoryId(id);
            categoryService.saveCategory(category);
            redirectAttributes.addFlashAttribute("notification", "Category updated successfully!");
            return "redirect:/admin/categories";
        } else {
            return "redirect:/admin/categories";
        }
    }

    @GetMapping("/delete/{id}")
    public String deleteCategory(@PathVariable("id") int id, RedirectAttributes redirectAttributes) {
        categoryService.deleteCategoryById(id);
        redirectAttributes.addFlashAttribute("notification", "Category deleted successfully!");
        return "redirect:/admin/categories";
    }
}
