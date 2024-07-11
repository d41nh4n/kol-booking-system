/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package d41nh4n.google_image.demo.controller;
/**
 *
 * @author DAO
 */    

import java.util.Optional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import d41nh4n.google_image.demo.entity.report.ViolationWord;
import d41nh4n.google_image.demo.service.ViolationWordService;

@Controller
@RequestMapping("admin/violationWords")
public class AdminViolationWordController {

    @Autowired
    private ViolationWordService violationWordService;

    @GetMapping
    public String getAllViolationWords(Model model, 
                                       @RequestParam(defaultValue = "0") int page, 
                                       @RequestParam(defaultValue = "10") int size) {
        Page<ViolationWord> violationWordsPage = violationWordService.findPaginated(PageRequest.of(page, size));
        model.addAttribute("violationWords", violationWordsPage.getContent());
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", violationWordsPage.getTotalPages());
        model.addAttribute("viewName", "admin/ViolationWords/violationWords");
        return "admin-layout";
    }

    @GetMapping("/add")
    public String showAddForm(Model model) {
        model.addAttribute("violationWord", new ViolationWord());
        
        model.addAttribute("viewName", "admin/ViolationWords/addForm");
        return "admin-layout";
    }

    @PostMapping("/save")
    public String saveViolationWord(@ModelAttribute("violationWord") ViolationWord violationWord, Model model,
                               RedirectAttributes redirectAttributes) {
        String result = violationWordService.saveViolationWord(violationWord);
        if ("Duplicate violation word".equals(result)) {
            model.addAttribute("violationWord", violationWord);
            model.addAttribute("duplicateMessage", "Violation word already exists.");
            if (violationWord.getWordId() == null) {
                model.addAttribute("viewName", "admin/ViolationWords/addForm");
            } else {
                model.addAttribute("viewName", "admin/ViolationWords/editForm");
            }
            return "admin-layout";
        }
        redirectAttributes.addFlashAttribute("notification", "Violation Word added/edited successfully!");
        return "redirect:/admin/violationWords";
    }

    @GetMapping("/edit/{id}")
    public String editViolationWord(@PathVariable("id") Integer id, Model model) {
        Optional<ViolationWord> violationWord = violationWordService.findById(id);
        model.addAttribute("violationWord", violationWord);
        
        model.addAttribute("viewName", "admin/ViolationWords/editForm");
        return "admin-layout";
    }

    @GetMapping("/delete/{id}")
    public String deleteViolationWord(@PathVariable("id") Integer id, RedirectAttributes redirectAttributes) {
        violationWordService.deleteById(id);
        redirectAttributes.addFlashAttribute("notification", "Category deleted successfully!");
        return "redirect:/admin/violationWords";
    }
}


