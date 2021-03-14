package forFaith.type;

/**
 * @Class Name : LangType.java
 * @Description : 다국어 코드 타입
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

public enum LangType {

	KO("ko", "한국어"),
	EN("en", "영어"),
	ZH("zh", "중국어"),
	JA("ja", "일본어"),
	RU("ru", "러시아어");

	/* 그 외 언어들
	FR("fr", "프랑스어");
	DE("de", "독일어");
	IT("it", "이탈리아어");
	PL("pl", "폴란드어");
	ES("es", "스페인어");
	*/

	private String code;
	private String value;

	private LangType() {};
	private LangType(String code, String value) {
		this.code = code;
		this.value = value;
	}

	public String getCode() {
		return this.code;
	}

	public String getValue() {
		return this.value;
	}

	public int getOrdinal() {
		return this.ordinal();
	}

	public String toString() {
        return this.value;
    }
	
	// 해당 코드가 존재하는지 체크
	public static boolean isExists(String checkCode) {
		boolean result = false;
		LangType[] types = LangType.values();
		
		for (LangType temp : types) {
			if(temp.getCode().equals(checkCode)) {
				result = true;
				break;
			}
		}
		
		return result;
	}
	
	// index 별로 TYPE을 추출하기 위해 사용
	public static LangType getType(int ordinal) {
		LangType[] types = LangType.values();
		LangType selectType = LangType.KO;

		for (LangType temp : types) {
			if(temp.ordinal() == ordinal) {
				selectType = temp;
				break;
			}
		}

		return selectType;
	}
}
