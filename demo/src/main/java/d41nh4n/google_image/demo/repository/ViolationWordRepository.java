/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package d41nh4n.google_image.demo.repository;

/**
 *
 * @author DAO
 */
import org.springframework.data.jpa.repository.JpaRepository;

import d41nh4n.google_image.demo.entity.report.ViolationWord;

public interface ViolationWordRepository extends JpaRepository<ViolationWord, Integer> {
}
