package forFaith.exceptions;
/**
 * 로그인 필요 사용자 Exception
 * @author Park
 *
 */
@SuppressWarnings("serial")
public class UserMustLoginException extends RuntimeException {

	public UserMustLoginException() {
		super("login required");
	}

	public UserMustLoginException(String message) {
		super(message);
	}

	public UserMustLoginException(Throwable cause) {
		super(cause);
	}

	public UserMustLoginException(String message, Throwable cause) {
		super(message, cause);
	}

	public UserMustLoginException(String message, Throwable cause, boolean enableSuppression, boolean writableStackTrace) {
		super(message, cause, enableSuppression, writableStackTrace);
	}

}
