package forFaith.exceptions;

@SuppressWarnings("serial")
public class UserFileUploadException extends RuntimeException {

	public UserFileUploadException() {
		super("file upload exception");
	}

	public UserFileUploadException(String message) {
		super(message);
	}

	public UserFileUploadException(Throwable cause) {
		super(cause);
	}

	public UserFileUploadException(String message, Throwable cause) {
		super(message, cause);
	}

	public UserFileUploadException(String message, Throwable cause, boolean enableSuppression, boolean writableStackTrace) {
		super(message, cause, enableSuppression, writableStackTrace);
	}

}
