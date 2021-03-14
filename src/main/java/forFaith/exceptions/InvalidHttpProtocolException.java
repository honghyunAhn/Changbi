package forFaith.exceptions;

/**
 * @Class Name : InvalidHttpProtocolException.java
 * @Description : 유효하지 않은 http 프로토콜 요청 Exception
 * @Modification Information
 * @
 * @  수정일                 수정자                       수정내용
 * @ -------    --------    ---------------------------
 * @ 2017.03.21   김준석                      최초 생성
 *
 *  @author kjs
 *  @since 2017.03.21
 *  @version 1.0
 *  @see
 *
 */

@SuppressWarnings("serial")
public class InvalidHttpProtocolException extends Exception {
	public InvalidHttpProtocolException() {
	}

	public InvalidHttpProtocolException(String arg0) {
		super(arg0);
	}

	public InvalidHttpProtocolException(Throwable arg0) {
		super(arg0);
	}

	public InvalidHttpProtocolException(String arg0, Throwable arg1) {
		super(arg0, arg1);
	}
}
