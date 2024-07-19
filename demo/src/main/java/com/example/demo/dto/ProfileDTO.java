/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package d41nh4n.google_image.demo.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

/**
 *
 * @author DAO
 */


@Data
@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public class ProfileDTO {
    private Integer id;
    private String name;
    private String email;
    private String gender;
    private String role;
    private String createdAt;
    private String banAction;
    private String fullName;
    private String bio;
    private String address;
    private String birthday;
     private String avatar;
}

