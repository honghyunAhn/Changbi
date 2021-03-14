package forFaith.domain;

/**
 * @Class Name : NaverSmartEditor.java
 * @Description : 네이버 에디터에서 사용 되는 객체
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

public class NaverSmartEditor {

    /** NewLine 사용 여부 */
	private String bNewLine;

	/** 원본 파일 명 */
	private String sFileName;

	/** 파일 URL */
	private String sFileURL;

	/** 파일 Upload 후 호출할 함수 */
	private String callbackFunc;

	public String getbNewLine() {
		return bNewLine;
	}

	public void setbNewLine(String bNewLine) {
		this.bNewLine = bNewLine;
	}

	public String getsFileName() {
		return sFileName;
	}

	public void setsFileName(String sFileName) {
		this.sFileName = sFileName;
	}

	public String getsFileURL() {
		return sFileURL;
	}

	public void setsFileURL(String sFileURL) {
		this.sFileURL = sFileURL;
	}

	public String getCallbackFunc() {
		return callbackFunc;
	}

	public void setCallbackFunc(String callbackFunc) {
		this.callbackFunc = callbackFunc;
	}
}
