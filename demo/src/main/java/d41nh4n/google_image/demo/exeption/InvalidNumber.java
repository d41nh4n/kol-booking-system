package d41nh4n.google_image.demo.exeption;

public class InvalidNumber extends RuntimeException {
    public InvalidNumber(String message, Throwable cause) {
        super(message, cause);
    }
}
