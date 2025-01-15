package d41nh4n.google_image.demo.dto;

import d41nh4n.google_image.demo.entity.Comment;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class CommentDto {
    private int commentId;
    private int idSender;
    private String nameSender;
    private String urlAvatarSender;
    private String createAt;
    private String content;
    private int rating;

    public CommentDto(Comment comment) {
        this.commentId = comment.getCommentId();
        this.idSender = comment.getCommenter().getUserId();
        this.nameSender = comment.getCommenter().getProfile().getFullName();
        this.urlAvatarSender = comment.getCommenter().getProfile().getAvatarUrl();
        this.createAt = comment.getCreatedAt().toString();
        this.content = comment.getCommentContent();
        this.rating = comment.getRatingValue();
    }
}
