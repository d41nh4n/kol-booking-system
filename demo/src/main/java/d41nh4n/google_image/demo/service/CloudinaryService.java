package d41nh4n.google_image.demo.service;

import org.springframework.web.multipart.MultipartFile;
import com.cloudinary.utils.ObjectUtils;

import d41nh4n.google_image.demo.dto.respone.ResponeUploadImage;

import java.io.IOException;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.cloudinary.Cloudinary;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class CloudinaryService {

    @Autowired
    private final Cloudinary cloudinary;

    public Map<String, Object> upload(MultipartFile file) throws IOException {
        try {
            Map<String, Object> uploadResult = cloudinary.uploader().upload(file.getBytes(), ObjectUtils.emptyMap());
            return uploadResult;
        } catch (IOException e) {
            throw new RuntimeException("Image upload failed", e);
        }
    }

    public ResponeUploadImage uploadAndGetUrl(MultipartFile file) throws IOException {
        Map<String, Object> uploadResult = upload(file);
        String urlImg = (String) uploadResult.get("secure_url");
        if (urlImg != null && !urlImg.isEmpty()) {
            return ResponeUploadImage.builder()
                    .status(200)
                    .message("Upload successful")
                    .urlImg(urlImg)
                    .build();
        } else {
            return ResponeUploadImage.builder()
                    .status(500)
                    .message("Upload failed")
                    .urlImg("")
                    .build();
        }
    }
}
