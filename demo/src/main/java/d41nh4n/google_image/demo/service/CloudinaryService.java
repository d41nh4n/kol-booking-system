package d41nh4n.google_image.demo.service;

import org.springframework.web.multipart.MultipartFile;
import com.cloudinary.utils.ObjectUtils;

import d41nh4n.google_image.demo.dto.chatdto.FileMessage;
import d41nh4n.google_image.demo.dto.respone.ResponeUpload;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.file.Files;
import java.util.Base64;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
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
        File uploadedFile = null;
        try {
            uploadedFile = convertMultiPartToFile(file);
            Map<String, Object> uploadResult = cloudinary.uploader().upload(uploadedFile, ObjectUtils.emptyMap());
            return uploadResult;
        } catch (IOException e) {
            throw new RuntimeException("Upload failed", e);
        } finally {
            if (uploadedFile != null) {
                Files.deleteIfExists(uploadedFile.toPath());
            }
        }
    }

    public ResponeUpload uploadAndGetUrl(MultipartFile file) throws IOException {
        Map<String, Object> uploadResult = upload(file);
        String urlImg = (String) uploadResult.get("secure_url");
        if (urlImg != null && !urlImg.isEmpty()) {
            return ResponeUpload.builder()
                    .status(200)
                    .message("Upload successful")
                    .url(urlImg)
                    .build();
        } else {
            return ResponeUpload.builder()
                    .status(500)
                    .message("Upload failed")
                    .url("")
                    .build();
        }
    }

    public ResponeUpload uploadFileFromMessage(MultipartFile file) throws IOException {
        if (file.isEmpty()) {
            throw new IllegalArgumentException("File is empty");
        }

        String fileType = file.getContentType();
        long fileSize = file.getSize();

        if (fileType.startsWith("video/") && fileSize > MAX_VIDEO_SIZE) {
            throw new IllegalArgumentException("Video size exceeds the limit");
        }

        if (fileType.startsWith("image/") && fileSize > MAX_IMAGE_SIZE) {
            throw new IllegalArgumentException("Image size exceeds the limit");
        }

        if (fileType.startsWith("audio/") && fileSize > MAX_AUDIO_SIZE) {
            throw new IllegalArgumentException("Audio size exceeds the limit");
        }

        try {
            return uploadAndGetUrl(file);
        } catch (IOException e) {
            throw new RuntimeException("Image upload failed", e);
        }
    }

    private File convertMultiPartToFile(MultipartFile file) throws IOException {
        File convFile = new File(System.getProperty("java.io.tmpdir") + "/" + file.getOriginalFilename());
        try (FileOutputStream fos = new FileOutputStream(convFile)) {
            fos.write(file.getBytes());
        }
        return convFile;
    }

    public String handleFileMessage(FileMessage fileMessage) throws IOException {
        String base64Data = fileMessage.getContent().split(",")[1];
        byte[] decodedBytes = Base64.getDecoder().decode(base64Data);

        Map uploadResult = cloudinary.uploader().upload(decodedBytes, ObjectUtils.asMap(
                "resource_type", "auto"));

        // Lấy URL của file đã tải lên
        String fileUrl = uploadResult.get("url").toString();
        System.out.println("File uploaded to: " + fileUrl);

        return fileUrl;
    }
}
