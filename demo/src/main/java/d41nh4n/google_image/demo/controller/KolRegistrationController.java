/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package d41nh4n.google_image.demo.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import d41nh4n.google_image.demo.dto.respone.ResponeUpload;
import d41nh4n.google_image.demo.entity.Category;
import d41nh4n.google_image.demo.entity.KolRegistration;
import d41nh4n.google_image.demo.service.CategoryService;
import d41nh4n.google_image.demo.service.CloudinaryService;
import d41nh4n.google_image.demo.service.KolRegistrationService;
import jakarta.annotation.PostConstruct;
import org.springframework.beans.factory.annotation.Value;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/guest")
public class KolRegistrationController {

    @Autowired
    private KolRegistrationService kolRegistrationService;

    @Autowired
    private CategoryService categoryService;

    @Autowired
    private CloudinaryService cloudinaryService;


    @GetMapping("/register")
    public String showRegistrationForm(Model model) {
        List<Category> categories = categoryService.getAllCategories();
        model.addAttribute("kolRegistration", new KolRegistration());
        model.addAttribute("categories", categories);
        return "registerKol";
    }

    @PostMapping("/register")
    public String registerKol(@ModelAttribute KolRegistration kolRegistration,
            @RequestParam("images") MultipartFile[] images, @RequestParam("categories") List<String> categories,
            RedirectAttributes redirectAttributes) {
        List<String> imageUrls = new ArrayList<>();

        for (MultipartFile image : images) {
            if (!image.isEmpty()) {
                try {
                    ResponeUpload responeUpload = cloudinaryService.uploadAndGetUrl(image);
                    System.out.println(responeUpload.toString());
                    if (responeUpload != null) {
                        String imageUrl = "[" + responeUpload.getPublicId() + "]" + responeUpload.getUrl();
                        imageUrls.add(imageUrl);
                    }

                } catch (IOException e) {
                    e.printStackTrace();
                    // Log the exception
                    System.out.println("Error: " + e.getMessage());
                    redirectAttributes.addFlashAttribute("message", "Failed to upload the file: " + e.getMessage());
                    return "redirect:/guest/register";
                }
            }
        }

        StringBuilder imageUrlsString = new StringBuilder();

        for (String string : imageUrls) {
            if (imageUrlsString.length() > 0) {
                imageUrlsString.append(",");
            }

            imageUrlsString.append(string);
        }

        kolRegistration.setImageUrls(imageUrlsString.toString());

        kolRegistration.setCategories(String.join(",", categories));

        kolRegistrationService.saveRegistration(kolRegistration);

        redirectAttributes.addFlashAttribute("message", "Registration successful");
        return "redirect:/guest/register";
    }
}