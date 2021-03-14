package forFaith.exceptions;

@SuppressWarnings("serial")
public class InvalidAccessException extends RuntimeException {

	public InvalidAccessException() {
		super("invalid access");
	}

	public InvalidAccessException(String message) {
		super(message);
	}

	public InvalidAccessException(Throwable cause) {
		super(cause);
	}

	public InvalidAccessException(String message, Throwable cause) {
		super(message, cause);
	}

	public InvalidAccessException(String message, Throwable cause, boolean enableSuppression,
			boolean writableStackTrace) {
		super(message, cause, enableSuppression, writableStackTrace);
	}

}
