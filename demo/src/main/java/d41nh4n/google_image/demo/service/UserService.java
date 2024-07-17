package d41nh4n.google_image.demo.service;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.data.domain.*;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;

import d41nh4n.google_image.demo.dto.UserDTO;
import d41nh4n.google_image.demo.dto.respone.ResponeJson;
import d41nh4n.google_image.demo.dto.userdto.UserDto;
import d41nh4n.google_image.demo.dto.userdto.UserDtoFilter;
import d41nh4n.google_image.demo.dto.userdto.UserFindedBySearch;
import d41nh4n.google_image.demo.entity.Category;
import d41nh4n.google_image.demo.entity.VerifyCode;
import d41nh4n.google_image.demo.entity.user.Gender;
import d41nh4n.google_image.demo.entity.user.Profile;
import d41nh4n.google_image.demo.entity.user.ProfileCategories;
import d41nh4n.google_image.demo.entity.user.User;
import d41nh4n.google_image.demo.mapper.UserMapper;
import d41nh4n.google_image.demo.mapper.UserToUserDto;
import d41nh4n.google_image.demo.repository.CategoryRepository;
import d41nh4n.google_image.demo.repository.ProfileCategoriesRepository;
import d41nh4n.google_image.demo.repository.ProfileRepository;
import d41nh4n.google_image.demo.repository.UserRepository;
import d41nh4n.google_image.demo.validation.Utils;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class UserService {

    private final UserRepository userRepository;
    private final ProfileRepository profileRepository;
    private final ProfileCategoriesRepository profileCategoriesRepository;
    private final CategoryRepository categoryRepository;
    private final UserMapper userMapper;
    private final Utils utils;
    private final VerifyCodeService verifyCodeService;
    private final PasswordEncoder passwordEncoder;

    @Transactional
    public User registerUser(User user, Profile profile) {
        // Persist the User entity
        User savedUser = userRepository.save(user);

        // Create and persist the Profile entity
        profile.setUser(savedUser);
        profileRepository.save(profile);

        return savedUser;
    }

    @Transactional
    public User save(User user) {
        return userRepository.save(user);
    }

    public User getUserById(int userId) {
        return userRepository.findById(userId).orElse(null);
    }

    public User getUserByUsernameAndPassword(String username, String password) {
        return userRepository.findByUsernameAndPasswordHash(username, password).orElse(null);
    }

    public User getUserByUsername(String username) {
        return userRepository.findByUsername(username).orElse(null);
    }

    public User getUserByEmail(String email) {
        return userRepository.findByEmail(email).orElse(null);
    }

    public User getUserByResetPasswordToken(String token) {
        return userRepository.findByResetPasswordToken(token).orElse(null);
    }

    public void updatePassword(User user, String newPassword) {
        BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
        String encodedPassword = passwordEncoder.encode(newPassword);
        user.setPasswordHash(encodedPassword);
        user.setResetPasswordToken(null);
        userRepository.save(user);
    }

    public void updateResetPasswordToken(String token, String email) {
        User user = getUserByEmail(email);
        if (user != null) {
            user.setResetPasswordToken(token);
            userRepository.save(user);
        }
    }

    public List<UserFindedBySearch> searchUser(String username) {
        return userRepository.getUsersByFullNameContaining(username);
    }

    public UserDto getUserInforById(int id) {
        User user = userRepository.findById(id).orElse(null);
        if (user != null) {
            UserDto userDto = UserToUserDto.mapToUserInfoResponse(user);

            List<ProfileCategories> profileCategories = user.getProfile().getProfileCategories();
            List<String> categoryNames = new ArrayList<>();
            for (ProfileCategories profileCategory : profileCategories) {
                Category category = categoryRepository.findById(profileCategory.getCategoryId()).orElse(null);
                if (category != null) {
                    categoryNames.add(category.getCategoryName());
                }
            }
            userDto.setCategories(categoryNames);
            return userDto;
        }
        return null;
    }

    @Transactional
    public Profile save(Profile profile) {
        return profileRepository.save(profile);
    }

    public Profile getProfileById(int id) {
        return profileRepository.findById(id).orElse(null);
    }

    public Profile getProfileByName(String name) {
        return profileRepository.findByFullName(name);
    }

    public List<UserDtoFilter> getUserListHomePage() {
        List<User> users = userRepository.findByRole("KOL");
        List<UserDtoFilter> userDtoList = new ArrayList<>();

        for (User user : users) {
            UserDtoFilter dto = new UserDtoFilter();
            dto.setUserId(user.getUserId());
            dto.setRating(user.getProfile().getAverageRating());
            // Fetch Profile
            Profile profile = user.getProfile();
            if (profile != null) {
                dto.setFullName(profile.getFullName());
                dto.setAvatarUrl(profile.getAvatarUrl());
                dto.setLocation(profile.getLocation());
                dto.setPricePost(profile.getPriceAPost());
                dto.setPriceVideo((profile.getPriceAVideo()));
                dto.setPriceHireByDay(profile.getPriceAToHireADay());
                dto.setRepresentativePrice(profile.getRepresentativePrice());
            }
            // Fetch Categories
            List<ProfileCategories> profileCategories = profileCategoriesRepository.findByUserId(user.getUserId());
            List<String> categoryNames = new ArrayList<>();
            for (ProfileCategories profileCategory : profileCategories) {
                Category category = categoryRepository.findById(profileCategory.getCategoryId()).orElse(null);
                if (category != null) {
                    categoryNames.add(category.getCategoryName());
                }
            }
            dto.setCatgories(categoryNames);
            userDtoList.add(dto);
        }
        return userDtoList;
    }

    public List<UserDtoFilter> getTop6UsersForHomePage() {
        List<User> topUsers = userRepository.findTop7ByRoleKolOrderByRatingPointDesc();
        List<UserDtoFilter> userDtoList = new ArrayList<>();
        List<User> top6Users = topUsers.subList(0, Math.min(topUsers.size(), 6));
        for (User user : top6Users) {
            UserDtoFilter dto = new UserDtoFilter();
            dto.setUserId(user.getUserId());
            dto.setRating(user.getProfile().getAverageRating());

            // Fetch Profile
            Profile profile = user.getProfile();
            if (profile != null) {
                dto.setFullName(profile.getFullName());
                dto.setAvatarUrl(profile.getAvatarUrl());
                dto.setLocation(profile.getLocation());
                dto.setPricePost(profile.getPriceAPost());
                dto.setPriceVideo((profile.getPriceAVideo()));
                dto.setPriceHireByDay(profile.getPriceAToHireADay());
                dto.setRepresentativePrice(profile.getRepresentativePrice());
            }
            // Fetch Categories
            List<ProfileCategories> profileCategories = profileCategoriesRepository.findByUserId(user.getUserId());
            List<String> categoryNames = new ArrayList<>();
            for (ProfileCategories profileCategory : profileCategories) {
                Category category = categoryRepository.findById(profileCategory.getCategoryId()).orElse(null);
                if (category != null) {
                    categoryNames.add(category.getCategoryName());
                }
            }
            dto.setCatgories(categoryNames);
            userDtoList.add(dto);
        }
        return userDtoList;
    }

    public Page<UserDtoFilter> getUserByFilter(Double averageRating, String fullName, String username,
            String location, String requestAPost, String priceAVideo, String priceAToHireADay,
            String representativePrice, Long maxPrice, Long minPrice,
            String categoryName, Gender gender, int pageNumber, int pageSize) {

        Pageable pageable = PageRequest.of(pageNumber, pageSize);
        Page<User> users = userRepository.findByFilters(averageRating, fullName, username, location, requestAPost,
                priceAVideo, priceAToHireADay, representativePrice, maxPrice, minPrice,
                categoryName, gender, pageable);

        List<UserDtoFilter> userDtoList = new ArrayList<>();

        for (User user : users) {
            UserDtoFilter dto = new UserDtoFilter();
            dto.setUserId(user.getUserId());
            if (user.getProfile() != null) {
                Profile profile = user.getProfile();
                dto.setFullName(profile.getFullName());
                dto.setAvatarUrl(profile.getAvatarUrl());
                dto.setLocation(profile.getLocation());
                dto.setPricePost(profile.getPriceAPost());
                dto.setPriceVideo(profile.getPriceAVideo());
                dto.setPriceHireByDay(profile.getPriceAToHireADay());
                dto.setRepresentativePrice(profile.getRepresentativePrice());
                dto.setRating(profile.getAverageRating());
            }

            // Fetch Categories
            List<String> categoryNames = new ArrayList<>();
            for (ProfileCategories profileCategory : profileCategoriesRepository.findByUserId(user.getUserId())) {
                Category category = profileCategory.getCategory();
                if (category != null) {
                    categoryNames.add(category.getCategoryName());
                }
            }
            dto.setCatgories(categoryNames);

            userDtoList.add(dto);
        }

        return new PageImpl<>(userDtoList, pageable, users.getTotalElements());
    }

    public Double getAccountBalanceByUserId(int userId) {

        User user = userRepository.findById(userId).orElse(null);
        if (user != null) {
            return user.getAccountBalance();
        }
        return null;
    }

    public void updateUserBalance(int userId, double amountPaid) {
        User user = userRepository.findById(userId).orElseThrow(() -> new RuntimeException("User not found"));
        double userBalance = user.getAccountBalance() + amountPaid;
        user.setAccountBalance(userBalance);
        save(user);
    }

    public User findById(Integer userId) {
        return userRepository.findById(userId).orElse(null);
    }

    public List<User> findAll() {
        return userRepository.findAll();
    }

    public List<UserDTO> getAllUserDTOs() {
        return userRepository.findAll().stream()
                .map(userMapper::toUserDTO)
                .collect(Collectors.toList());
    }

    public Page<UserDTO> findPaginated(Pageable pageable) {
        Page<User> usersPage = userRepository.findAll(pageable);
        return usersPage.map(user -> userMapper.toUserDTO(user));
    }

    public UserDTO getUserDTOById(Integer id) {
        User user = userRepository.findById(id).orElse(null);
        if (user != null) {
            return userMapper.toUserDTO(user);
        }
        return null;
    }

    public void deleteUserById(Integer id) {
        userRepository.deleteById(id);
    }

    public Page<UserDTO> searchUsers(String keyword, Gender gender, Pageable pageable) {
        return userRepository.searchUsers(keyword, gender, pageable).map(userMapper::toUserDTO);
    }

    public Page<UserDTO> searchUsersWithBan(String keyword, Gender gender, Pageable pageable) {
        return userRepository.searchUsersWithBan(keyword, gender, pageable).map(userMapper::toUserDTO);
    }

    public Page<UserDTO> searchUsersWithUnBan(String keyword, Gender gender, Pageable pageable) {
        return userRepository.searchUsersWithUnBan(keyword, gender, pageable).map(userMapper::toUserDTO);
    }

    public List<Long> getUserCountByMonthAndYear(int year) {
        List<Object[]> results = userRepository.findUserCountByMonthAndYear(year);
        List<Long> userCounts = new ArrayList<>();
        for (int i = 0; i < 12; i++) {
            userCounts.add(0L);
        }
        for (Object[] result : results) {
            Long count = (Long) result[0];
            int month = (int) result[1];
            userCounts.set(month - 1, count);
        }
        return userCounts;
    }

    public List<Integer> getYearsWithUsers() {
        return userRepository.findYearsWithUsers();
    }

    public boolean existsByEmail(String email) {
        return userRepository.findByEmail(email).isPresent();
    }

    public boolean existsByUsername(String username) {
        return userRepository.findByUsername(username).isPresent();
    }

    public void saveUser(User user) {
        userRepository.save(user);
    }

    public User findByUserNameAndEmail(String username, String email) {
        return userRepository.findByUsernameAndEmail(username, email);
    }

    public User createAAccount(String userName, String email, String password) {
        String encodedPassword = passwordEncoder.encode(password);

        User user = new User();
        user.setUsername(userName);
        user.setPasswordHash(encodedPassword);
        user.setRole("USER");
        user.setGender(Gender.OTHER);
        user = save(user);
        Profile profile = new Profile();
        profile.setUser(user);
        profile.setProfileId(user.getUserId());
        profile.setFullName(utils.renderUserName(10));
        profile.setAvatarUrl(
                "https://png.pngtree.com/element_our/20200610/ourlarge/pngtree-default-avatar-image_2237213.jpg");
        user.setProfile(profile);
        save(user);
        save(profile);

        return user;
    }

    public ResponseEntity<ResponeJson> registerUser(String userName, String password, String email, int codeId,
            String code) {
        ResponeJson responeJson = new ResponeJson();

        VerifyCode verifyCode = verifyCodeService.getById(codeId);

        if (verifyCode == null) {
            responeJson.setMessage("Invalid Code Id!");
            responeJson.setStatus(HttpStatus.BAD_REQUEST.value());
            return ResponseEntity.status(responeJson.getStatus()).body(responeJson);
        }

        if (verifyCodeService.isCodeExpired(verifyCode)) {
            responeJson.setMessage("Code Out Of Date, Let Get Another Code!");
            responeJson.setStatus(HttpStatus.LOCKED.value());
            verifyCodeService.delete(verifyCode);
            return ResponseEntity.status(responeJson.getStatus()).body(responeJson);
        }

        if (!verifyCode.getUserName().equals(userName)) {
            responeJson.setMessage("Invalid UserName In Code Id!");
            responeJson.setStatus(HttpStatus.BAD_REQUEST.value());
            return ResponseEntity.status(responeJson.getStatus()).body(responeJson);
        } else if (!verifyCode.getEmail().equals(email)) {
            responeJson.setMessage("Invalid Email In Code Id!");
            responeJson.setStatus(HttpStatus.BAD_REQUEST.value());
            return ResponseEntity.status(responeJson.getStatus()).body(responeJson);
        } else if (password.length() < 8) {
            responeJson.setMessage("This Password Must Be At Least 8 Characters Long!");
            responeJson.setStatus(HttpStatus.BAD_REQUEST.value());
            return ResponseEntity.status(responeJson.getStatus()).body(responeJson);
        }

        if (verifyCode.getCode().equalsIgnoreCase(code)) {
            User user = createAAccount(userName, email, password);
            if (user != null) {
                responeJson.setMessage("Register Success!");
                responeJson.setStatus(HttpStatus.CREATED.value());
                return ResponseEntity.status(responeJson.getStatus()).body(responeJson);
            } else {
                responeJson.setMessage("Failed to create account!");
                responeJson.setStatus(HttpStatus.INTERNAL_SERVER_ERROR.value());
                return ResponseEntity.status(responeJson.getStatus()).body(responeJson);
            }
        }

        if (verifyCode.getNumberOfAttempts() < 3) {
            verifyCode.setNumberOfAttempts(verifyCode.getNumberOfAttempts() + 1);
            verifyCodeService.save(verifyCode);
            responeJson.setMessage("Code Invalid!");
            responeJson.setStatus(HttpStatus.CONFLICT.value());
            return ResponseEntity.status(responeJson.getStatus()).body(responeJson);
        } else {
            responeJson.setMessage("Code Out Of Date, Let Get Another Code!");
            responeJson.setStatus(HttpStatus.LOCKED.value());
            verifyCodeService.delete(verifyCode);
            return ResponseEntity.status(responeJson.getStatus()).body(responeJson);
        }
    }

    public ResponseEntity<ResponeJson> getRegisterCode(
            String userName, String password, String email) {

        ResponeJson responeJson = new ResponeJson();

        if (userName == null || userName.isEmpty()) {
            responeJson.setMessage("UserName is required!");
            responeJson.setStatus(HttpStatus.BAD_REQUEST.value());
            return ResponseEntity.ok(responeJson);
        }

        if (password == null || password.isEmpty()) {
            responeJson.setMessage("Password is required!");
            responeJson.setStatus(HttpStatus.BAD_REQUEST.value());
            return ResponseEntity.ok(responeJson);
        }

        if (email == null || email.isEmpty()) {
            responeJson.setMessage("Email is required!");
            responeJson.setStatus(HttpStatus.BAD_REQUEST.value());
            return ResponseEntity.ok(responeJson);
        }

        if (existsByUsername(userName)) {
            responeJson.setMessage("This UserName Is Exist!");
            responeJson.setStatus(HttpStatus.BAD_REQUEST.value());
            return ResponseEntity.ok(responeJson);
        } else if (existsByEmail(email)) {
            responeJson.setMessage("This Email Is Exist!");
            responeJson.setStatus(HttpStatus.BAD_REQUEST.value());
            return ResponseEntity.ok(responeJson);
        } else if (password.length() < 8) {
            responeJson.setMessage("This Password Must Be At Least 8 Characters Long!");
            responeJson.setStatus(HttpStatus.BAD_REQUEST.value());
            return ResponseEntity.ok(responeJson);
        }

        int idCode = verifyCodeService.genarateCodeAndReturnId(email, userName);

        if (idCode != -1) {
            responeJson.setMessage(String.valueOf(idCode));
            responeJson.setStatus(HttpStatus.ACCEPTED.value());
        } else {
            responeJson.setMessage("Failed to generate verification code!");
            responeJson.setStatus(HttpStatus.INTERNAL_SERVER_ERROR.value());
        }

        return ResponseEntity.status(responeJson.getStatus()).body(responeJson);
    }
}
