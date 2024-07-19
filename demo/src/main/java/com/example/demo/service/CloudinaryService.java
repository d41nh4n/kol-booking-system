package d41nh4n.google_image.demo.service;

import org.springframework.web.multipart.MultipartFile;
import com.cloudinary.utils.ObjectUtils;

import d41nh4n.google_image.demo.dto.chatdto.FileMessage;
import d41nh4n.google_image.demo.dto.respone.ResponeUpload;
import d41nh4n.google_image.demo.model.UploadRespone;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.file.Files;
import java.util.Base64;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;
import com.cloudinary.Cloudinary;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class CloudinaryService {

    private static final long MAX_VIDEO_SIZE = 25 * 1024 * 1024; // 25MB
    private static final long MAX_IMAGE_SIZE = 5 * 1024 * 1024; // 5MB
    private static final long MAX_AUDIO_SIZE = 10 * 1024 * 1024; // 10MB

    @Autowired
    private final Cloudinary cloudinary;

    public Map<String, Object> upload(MultipartFile file) throws IOException {
        try {
            Map<String, Object> uploadResult = cloudinary.uploader().upload(file.getBytes(), ObjectUtils.emptyMap());
            return uploadResult;
        } catch (IOException e) {
            throw new RuntimeException("Upload failed", e);
        }
    }

    public ResponeUpload uploadAndGetUrl(MultipartFile file) throws IOException {
        Map<String, Object> uploadResult = upload(file);
        String urlImg = (String) uploadResult.get("secure_url");
        String publicId = uploadResult.get("public_id").toString();
        if (urlImg != null && !urlImg.isEmpty()) {
            return ResponeUpload.builder()
                    .status(200)
                    .message("Upload successful")
                    .url(urlImg)
                    .publicId(publicId)
                    .build();
        } else {
            return ResponeUpload.builder()
                    .status(500)
                    .message("Upload failed")
                    .url("")
                    .publicId("")
                    .build();
        }
    }

    @Async
    public void deleteByPublicId(String publicId) throws IOException {
        cloudinary.uploader().destroy(publicId, ObjectUtils.emptyMap());
    }

    public ResponeUpload uploadFile(String file) throws IOException {
        if (file.isEmpty()) {
            throw new IllegalArgumentException("File is empty");
        }
        try {
            UploadRespone uploadRespone = handleFileMessage(file);
            if (uploadRespone != null && !uploadRespone.getUrl().isEmpty() && !uploadRespone.getPublic_id().isEmpty()) {
                return ResponeUpload.builder()
                        .status(200)
                        .message("Upload successful")
                        .url(uploadRespone.getUrl())
                        .publicId(uploadRespone.getPublic_id())
                        .build();
            } else {
                return ResponeUpload.builder()
                        .status(500)
                        .message("Upload failed")
                        .url("")
                        .publicId("")
                        .build();
            }
        } catch (IOException e) {
            throw new RuntimeException("Image upload failed", e);
        }
    }

    public UploadRespone handleFileMessage(String content) throws IOException {
        String base64Data = content.split(",")[1];
        byte[] decodedBytes = Base64.getDecoder().decode(base64Data);
        long fileSize = decodedBytes.length;

        if (base64Data.startsWith("video/") && fileSize > MAX_VIDEO_SIZE) {
            throw new IllegalArgumentException("Video size exceeds the limit");
        }

        if (base64Data.startsWith("image/") && fileSize > MAX_IMAGE_SIZE) {
            throw new IllegalArgumentException("Image size exceeds the limit");
        }

        if (base64Data.startsWith("audio/") && fileSize > MAX_AUDIO_SIZE) {
            throw new IllegalArgumentException("Audio size exceeds the limit");
        }

        Map uploadResult = cloudinary.uploader().upload(decodedBytes, ObjectUtils.asMap(
                "resource_type", "auto"));
        // Lấy URL của file đã tải lên
        String fileUrl = uploadResult.get("url").toString();
        String publicId = uploadResult.get("public_id").toString();
        UploadRespone uploadRespone = new UploadRespone(fileUrl, publicId);
        return uploadRespone;
    }
}
