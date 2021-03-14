package forFaith.dev.util;

/**
 * @Class Name : GlobalConst.java
 * @Description : 공통 상수 정의
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

public class GlobalConst {
	final public static String	CHAR_SET 		= "UTF-8";

	/** Controller **/
	public final static String URL_LOGIN		= "/forFaith/base/login";
	public final static String URL_MAIN			= "/forFaith/base/main";
	public final static String URL_FORWARD		= "/common/forward";			// 페이지 이동
	public final static String URL_LOGOUOT 		= "/forFaith/base/logout";		// 로그아웃 URL
	public final static String ACTION_MESSAGE_NAME = "actionMessage";			// controller 메시지명

	/** 파일업로드 **/
	public final static String FILE_UPLOAD_PREFIX = "FILE_";

	/** ajax 응답 **/
	public final static String AJAX_RESPONSE_CODE = "CODE";
	public final static String AJAX_RESPONSE_MESSAGE = "MESSAGE";
	public final static String TEXT_SUCCESS = "SUCCESS";			// 성공
	public final static String TEXT_FAIL = "FAIL";					// 실패
	/** 공통코드 **/
	public final static String CODE_GROUP_EMAIL = "email";			// 이메일도메인
	public final static String CODE_GROUP_PHONE1 = "phone1";		// 무선 통신사
	public final static String CODE_GROUP_TEL1 = "tel1";			// 유선 지역번호
	public static final String CODE_GROUP_POSITION = "sposition";	// 학교직위
	public static final String CODE_GROUP_REGION = "region";		// 시도교육청관리
	public static final String CODE_GROUP_COURSE = "course";		// 과정분류
	public static final String CODE_GROUP_ALLIANCE_TYPE = "alliancetype";		// 제휴구분
	public static final String CODE_GROUP_FQA = "faq";				// FAQ 카테고리

	/** 포인트 **/
	public final static String POINT_TITLE_JOIN = "신규회원가입";
	public final static String POINT_TITLE_APPLY = "수강신청";
	public final static String POINT_TITLE_APPLY_USE = "수강신청시사용";
	public final static String POINT_TITLE_TRAIN = "연수후기작성";
	public final static String POINT_TITLE_RECOMM_ID = "추천인등록";

	/** 결제 **/
	public final static String PAYMENT_TYPE_DIRECT = "1";	// 무통장입금
	public final static String PAYMENT_TYPE_BANK = "2";		// 계좌이체
	public final static String PAYMENT_TYPE_VBANK = "3";	// 가상계좌
	public final static String PAYMENT_TYPE_CARD = "4";		// 신용카드
	public final static String PAYMENT_TYPE_DELAY = "5";	// 지난연기결제
	public final static String PAYMENT_TYPE_FREE = "6";		// 무료
	public final static String PAYMENT_TYPE_GROUP = "7";	// 단체연수결제

	public final static String PAYMENT_STATE_READY = "1";		// 미결제(결제대기)
	public final static String PAYMENT_STATE_DONE = "2";		// 결제완료
	public final static String PAYMENT_STATE_PARTDONE = "3";	// 일부결제
	public final static String PAYMENT_STATE_BACKDONE = "4";	// 환불

	/** 본인인증 **/
	public final static String SESSION_KEY_IDEN_DI = "SS_IDEN_DI";	// 본인인증DI를 세션에 저장하여 본인인증 이후 화면에서 활용

	/** 시퀀스 **/
	public static final String SEQ_NAME_ORDERNUMBER = "DAILY_ORDER";	// 주문번호생성용 시퀀스

	/** 게시판 **/
	public final static String BBS_TYPE_NOTICE = "1";					// 공지사항
	public final static String BBS_TYPE_DATAROOM = "2";			//자료실
	public final static String BBS_TYPE_FAQ = "3";						// FAQ
	public final static String BBS_TYPE_CONSULT = "4";				//1:1상담
	public final static String BBS_TYPE_REVIEW = "5";					// 연수후기
	public final static String BBS_TYPE_QNA = "6";						// 질의응답
	public final static String BBS_NOTICE_TYPE_OFFICEDOCUMENT = "7";	// 공지구분 - 공문

	/** 시험 유형 **/
	public final static String QUIZ_OFFLINE = "1"; //출석고사
	public final static String QUIZ_EXAM = "2";		//온라인시험
	public final static String QUIZ_REPORT = "3";	//온라인과제

	/** 문제 유형 **/
	public final static String EXAM_TYPE_CHOICE = "O";	//객관식
	public final static String EXAM_TYPE_OPENENDED = "S"; //주관식

	/** 변경요청 유형 **/
	public final static String REQ_TYPE_DELAY = "1";				//연기요청
	public final static String REQ_TYPE_DELAY_END = "3";		//수강연기
	public final static String REQ_TYPE_CANCEL = "2";				//취소요청
	public final static String REQ_TYPE_CANCEL_END = "4";	//수강취소
	public final static String REQ_TYPE_CHANGE = "5";				//변경요청
	public final static String REQ_TYPE_CHANGE_END = "6";	//수강변경
}
