package forFaith.exceptions;

@SuppressWarnings("serial")
public class InvalidRightException extends RuntimeException {

	public InvalidRightException() {
		super("invalid right");
	}

	public InvalidRightException(String message) {
		super(message);
	}

	public InvalidRightException(Throwable cause) {
		super(cause);
	}

	public InvalidRightException(String message, Throwable cause) {
		super(message, cause);
	}

	public InvalidRightException(String message, Throwable cause, boolean enableSuppression,
			boolean writableStackTrace) {
		super(message, cause, enableSuppression, writableStackTrace);
	}

}
