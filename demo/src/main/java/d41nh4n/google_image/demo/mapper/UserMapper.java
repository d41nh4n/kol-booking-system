/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package d41nh4n.google_image.demo.mapper;

import org.springframework.stereotype.Component;

import d41nh4n.google_image.demo.dto.UserDTO;
import d41nh4n.google_image.demo.entity.user.User;

/**
 *
 * @author DAO
 */

@Component
public class UserMapper {

    public UserDTO toUserDTO(User user) {
        String banAction = user.isLocked() ? "Unban" : "Ban";
        String viewAction = "/admin/users/view/" + user.getUserId();

        return new UserDTO(
                user.getUserId(),
                user.getUsername(),
                user.getEmail(),
                user.getGender() == null ? null : user.getGender().toString(),
                user.getRole(),
                banAction,
                viewAction);    
    }
}
