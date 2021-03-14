/**
 * 
 */
package com.lms.student.util;

/**
 * @Author : 이종호
 * @Date : 2017. 7. 17.
 * @Class 설명 : 요청, 응답 경로 중복 확인 인터페이스
 * 
 */
public interface PathConstants {

	/**
	 * SEgroup 기본 주소
	 */
	public static final String SEGROUP = "segroup";

	/**
	 * 소사이어티의 Global Engineer 양성 url
	 */
	public static final String SOCIETY_ICTCENTER = "/ictcenter";

	/**
	 * 소사이어티의 관리자 페이지
	 */
	public static final String SES_SOCIETY_ADMIN = "/gesadmin";

	/**
	 * FS시스템 리다이렉트 - sesoc.global/hr
	 */
	public static final String SES_FS_SOCIETY = "/hr";

	/**
	 * FS시스템 리다이렉트 - sesoc.global/society_admin/societyMain
	 */
	public static final String SES_FS_SOCIETY_ADMIN = "/society_admin/societyMain";

	/**
	 * 개인정보처리방침 페이지 주소
	 */
	public static final String PRIVACY_POLICY = "/privacy_policy";

	/**
	 * 이용정책 페이지 주소
	 */
	public static final String USAGE_POLICY = "/usage_policy";

	/**
	 * School 기본 주소
	 */
	public static final String SEGROUP_SCHOOL = SEGROUP + "/school";

	/**
	 * Society 기본 주소
	 */
	public static final String SEGROUP_SOCIETY = SEGROUP + "/society";
	
	/**
	 * SES 메인 기업리스트 팝업 호출
	 * */
	public static final String SEGROUP_MAIN_COMPLIST = "/main_complist";
	
	/**
	 * SES 메인 언어팩 변경
	 * */
	public static final String SES_MAIN_LANGUAGE_CHANGE = "/main_lang_change";

	/**
	 * 스쿨의 도서관리 기본 주소
	 */
	public static final String SCHOOL_BOOK = "/book";

	/**
	 * 스쿨의 도서관리의 utility
	 */
	public static final String SCHOOL_BOOK_UTILITY = SCHOOL_BOOK + "/utility";

	/**
	 * 정식 (7/27) ISBN 검색하는 페이지 열기
	 */
	public static final String SCHOOL_BOOK_UTILITY_SEARCHISBN = SCHOOL_BOOK_UTILITY + "/searchIsbn";

	/**
	 * 정식 (8/1) client(user + admin)한테 책 제목 받아 책 검색
	 */
	public static final String SCHOOL_BOOK_UTILITY_SEARCH_BY_TITLE = SCHOOL_BOOK_UTILITY + "/byTitle";

	/**
	 * 정식 (8/1) client(user + admin)한테 책 저자 받아 책 검색
	 */
	public static final String SCHOOL_BOOK_UTILITY_SEARCH_BY_AUTHOR = SCHOOL_BOOK_UTILITY + "/byAuthor";

	/**
	 * 정식 (8/1) client(user + admin)한테 책 목차 받아 책 검색
	 */
	public static final String SCHOOL_BOOK_UTILITY_SEARCH_BY_CONTENTS = SCHOOL_BOOK_UTILITY + "/byContents";

	/**
	 * 정식 (8/1) client(user + admin)한테 ISBN 받아 책 검색
	 */
	public static final String SCHOOL_BOOK_UTILITY_SEARCH_BY_ISBN = SCHOOL_BOOK_UTILITY + "/byIsbn";

	/**
	 * 스쿨의 도서관리의 회원 주소
	 */
	public static final String SCHOOL_BOOK_USER = SCHOOL_BOOK + "/user";

	/**
	 * 스쿨의 도서관리의 회원 정보 검색
	 */
	public static final String SCHOOL_BOOK_USER_SELECT = SCHOOL_BOOK_USER + "/select";

	/**
	 * 스쿨의 도서관리의 회원 로그인 요청
	 */
	public static final String SCHOOL_BOOK_USER_LOGIN = SCHOOL_BOOK_USER + "/login";

	/**
	 * 정식 (7/27) 스쿨의 도서관리의 회원 - 대여현황
	 */
	public static final String SCHOOL_BOOK_USER_STATUS = SCHOOL_BOOK_USER + "/user_status";

	/**
	 * 정식 (7/27) 스쿨의 도서관리의 회원 - 관심 도서
	 */
	public static final String SCHOOL_BOOK_USER_BOOKMARK = SCHOOL_BOOK_USER + "/user_bookmark";

	/**
	 * 정식 (7/27) 스쿨의 도서관리의 회원 - 도서 신청
	 */
	public static final String SCHOOL_BOOK_USER_REQUEST = SCHOOL_BOOK_USER + "/user_request";

	/**
	 * 정식 (7/27) 스쿨의 도서관리의 회원 - 대여 기록
	 */
	public static final String SCHOOL_BOOK_USER_RENT_RECORD = SCHOOL_BOOK_USER + "/user_rent_record";

	/**
	 * 정식 (7/27) 스쿨의 도서관리의 회원 - 내 글 보기
	 */
	public static final String SCHOOL_BOOK_USER_REVIEW = SCHOOL_BOOK_USER + "/user_review";

	/**
	 * 상철 (7/28) 스쿨의 도서관리의 회원 - 랜딩페이지
	 */
	public static final String SCHOOL_BOOK_USER_MAIN = SCHOOL_BOOK_USER + "/user_main";

	/**
	 * 상철 (8/1) 스쿨의 도서관리의 회원 - 책 정보 요청
	 */
	public static final String SCHOOL_BOOK_USER_BOOKINFO = SCHOOL_BOOK_USER + "/book_info";

	/**
	 * 상철 (8/1) 스쿨의 도서관리의 회원 - 책 정보 요청
	 */
	public static final String SCHOOL_BOOK_USER_SEARCH_RESULT = SCHOOL_BOOK_USER + "/search_result";

	/**
	 * 상철 (8/7) 스쿨의 도서관리의 회원 - 책 세부정보
	 */
	public static final String SCHOOL_BOOK_USER_DETAILED_BOOKINFO = SCHOOL_BOOK_USER + "/detailed_bookinfo";

	/**
	 * 도서관리 로그인 성공
	 */
	public static final String SCHOOL_BOOK_USER_LOGIN_SUCCESS = SCHOOL_BOOK_USER + "/user_login_success";

	/**
	 * 도서관리 회원 접근 제한
	 */
	public static final String SCHOOL_BOOK_USER_ACCESS_DENIED = SCHOOL_BOOK_USER + "/user_access_denied";

	// 관리자 관련 주소들

	/**
	 * 스쿨의 도서관리의 관리자 주소
	 */
	public static final String SCHOOL_BOOK_ADMIN = SCHOOL_BOOK + "/admin";

	/**
	 * 스쿨의 도서관리의 관리자 주소
	 */
	public static final String SCHOOL_BOOK_ADMIN_MAIN = SCHOOL_BOOK_ADMIN + "/admin_main";

	/**
	 * 스쿨의 도서관리의 관리자 - 대여현황
	 */
	public static final String SCHOOL_BOOK_ADMIN_STATUS_MANAGE = SCHOOL_BOOK_ADMIN + "/status_manage";

	/**
	 * 스쿨의 도서관리의 관리자 - 예약 현황
	 */
	public static final String SCHOOL_BOOK_ADMIN_STATUS_RESERV = SCHOOL_BOOK_ADMIN + "/status_reserv";

	/**
	 * 스쿨의 도서관리의 관리자 - 대여 신청
	 */
	public static final String SCHOOL_BOOK_ADMIN_BOOK_LENDING = SCHOOL_BOOK_ADMIN + "/book_lend";

	/**
	 * 스쿨의 도서관리의 관리자 - 회원 관리
	 */
	public static final String SCHOOL_BOOK_ADMIN_MANAGE_MEMBER = SCHOOL_BOOK_ADMIN + "/admin_member";

	/**
	 * 스쿨의 도서관리의 관리자 - 도서 관리
	 */
	public static final String SCHOOL_BOOK_ADMIN_MANAGE_BOOK = SCHOOL_BOOK_ADMIN + "/book_list";

	/**
	 * 스쿨의 도서관리의 관리자 - 도서 정보 추가
	 */
	public static final String SCHOOL_BOOK_ADMIN_REGIST_BOOKINFO = SCHOOL_BOOK_ADMIN + "/regist_bookinfo";

	/**
	 * 스쿨의 도서관리의 관리자 - 도서 정보 추가
	 */
	public static final String SCHOOL_BOOK_ADMIN_REGIST_BOOK = SCHOOL_BOOK_ADMIN + "/regist_book";

	public static final String SCHOOL_BOOK_ADMIN_SEARCH_BY_ISBN_ON_SESBOOK = SCHOOL_BOOK_ADMIN
			+ "/search_by_isbn_on_sesbook";
	/**
	 * 스쿨의 도서관리의 관리자 - 도서 신청
	 */
	public static final String SCHOOL_BOOK_ADMIN_BOOK_APPLY = SCHOOL_BOOK_ADMIN + "/book_apply";

	/**
	 * 스쿨의 도서관리의 관리자 - 부계정 관리
	 */
	public static final String SCHOOL_BOOK_ADMIN_MANAGE_SUBADMIN = SCHOOL_BOOK_ADMIN + "/admin_subadmin";

	/**
	 * 스쿨의 도서관리의 관리자 - 환경 설정
	 */
	public static final String SCHOOL_BOOK_ADMIN_MANAGE_SETTING = SCHOOL_BOOK_ADMIN + "/admin_setting";

	public static final String SCHOOL_BOOK_ADMIN_GET_BOOKINFO_LIST = SCHOOL_BOOK_ADMIN + "/getBookInfoList";

	public static final String SCHOOL_BOOK_ADMIN_GET_BOOK_LIST = SCHOOL_BOOK_ADMIN + "/getBookList";
	/**
	 * 스쿨의 도서관리 - 대분류 가져오기
	 */
	public static final String SCHOOL_BOOK_UTILITY_GET_CATEGORY = SCHOOL_BOOK_UTILITY + "/get_category";

	public static final String SCHOOL_BOOK_UTILITY_GET_DIVISION = SCHOOL_BOOK_UTILITY + "/get_division";

	public static final String SCHOOL_BOOK_UTILITY_IMAGE_DOWNLOAD = SCHOOL_BOOK_UTILITY + "/download_bookinfo_image";

	/**
	 * 스쿨의 도서관리의 관리자 - 도서 반납 처리
	 */
	public static final String SCHOOL_BOOK_ADMIN_BOOK_RETURN = SCHOOL_BOOK_ADMIN + "/book_return";

	// Society 모집홍보 관련

	/**
	 * 소사이어티의 모집홍보 기본 주소
	 */
	public static final String SOCIETY_EDU = "/edu";

	/**
	 * 소사이어티의 모집홍보의 메인 주소
	 */
	public static final String SOCIETY_EDU_MAIN = SOCIETY_EDU + "/main";

	/**
	 * 소사이어티의 모집홍보의 로그아웃 주소
	 */
	public static final String SOCIETY_EDU_LOGOUT = SOCIETY_EDU + "/logout";

	/**
	 * 소사이어티의 모집홍보의 지원신청 기본 주소
	 */
	public static final String SOCIETY_EDU_APPLY = SOCIETY_EDU + "/apply";

	/**
	 * 소사이어티의 ContctUs 메일보내기
	 */
	public static final String SOCIETY_EDU_MAIL = SOCIETY_EDU + "/sendmail";

	/**
	 * 소사이어티의 모집홍보의 지원신청 메인 페이지
	 */
	public static final String SOCIETY_EDU_APPLY_MAIN = SOCIETY_EDU_APPLY + "/apply_main";
	
	/**
	 * 소사이어티의 모집홍보의 지원신청 메인 페이지
	 */
	public static final String SOCIETY_EDU_APPLY_SHORT = SOCIETY_EDU_APPLY + "/apply_short";

	/**
	 * 소사이어티의 모집홍보의 마스터 안내 페이지
	 */
	public static final String SOCIETY_EDU_APPLY_GUIDE = SOCIETY_EDU_APPLY + "/apply_guide";

	/**
	 * 소사이어티의 모집홍보의 사전교육과정 페이지
	 */
	public static final String SOCIETY_EDU_APPLY_PRIOREDU = SOCIETY_EDU_APPLY + "/apply_priorEdu";

	/**
	 * 소사이어티의 모집홍보의 SC IT MASTER(서울) 안내 페이지
	 */
	public static final String SOCIETY_EDU_APPLY_SCITMASTER_SEOUL = SOCIETY_EDU_APPLY + "/scitmaster_seoul";

	/**
	 * 소사이어티의 모집홍보의 K-Move 스쿨 안내페이지
	 */
	public static final String SOCIETY_EDU_APPLY_KMOVE = SOCIETY_EDU_APPLY + "/kmove";
	
	/**
	 * 소사이어티의 모집홍보의 일본취업학교
	 */
	public static final String SOCIETY_EDU_APPLY_JAPANJOB = SOCIETY_EDU_APPLY + "/japanjob";
	
	/**
	 * 소사이어티의 모집홍보의 미융복합인턴쉽
	 */
	public static final String SOCIETY_EDU_APPLY_USINTERN = SOCIETY_EDU_APPLY + "/usintern";

	/**
	 * 소사이어티의 모집홍보의 마스터 서울(지원) 페이지
	 */
	public static final String SOCIETY_EDU_APPLY_SEOUL = SOCIETY_EDU_APPLY + "/seoul";

	/**
	 * 소사이어티의 모집홍보의 K-Move CUP과정 안내페이지
	 */
	public static final String SOCIETY_EDU_APPLY_KMOVE_CUP = SOCIETY_EDU_APPLY + "/kmove_cup";
	
	/**
	 * 소사이어티의 모집홍보의 교수진 소개 페이지
	 */
	public static final String SOCIETY_EDU_APPLY_TEACHER = SOCIETY_EDU_APPLY + "/apply_teacher";

	/**
	 * 소사이어티의 모집홍보의 겔러리 페이지
	 */
	public static final String SOCIETY_EDU_APPLY_GALLARY = SOCIETY_EDU_APPLY + "/apply_gallary";

	/**
	 * 소사이어티의 모집홍보의 커뮤니티 기본 주소
	 */
	public static final String SOCIETY_EDU_COMMUNITY = SOCIETY_EDU + "/community";

	/**
	 * 소사이어티의 모집홍보의 공지사항 페이지
	 */
	public static final String SOCIETY_EDU_COMMUNITY_NOTICE = SOCIETY_EDU_COMMUNITY + "/notice";

	/**
	 * 소사이어티의 모집홍보의 공지사항 게시판 내용보기 페이지
	 */
	public static final String SOCIETY_EDU_COMMUNITY_NOTICE_DETAIL = SOCIETY_EDU_COMMUNITY + "/notice_detail";

	/**
	 * 소사이어티의 모집홍보의 재학생(합격자) 전용 공지사항 페이지
	 */
	public static final String SOCIETY_EDU_COMMUNITY_NOTICE2 = SOCIETY_EDU_COMMUNITY + "/notice2";

	/**
	 * 소사이어티의 모집홍보의 재학생(합격자) 전용 공지사항 게시판 내용보기 페이지
	 */
	public static final String SOCIETY_EDU_COMMUNITY_NOTICE2_DETAIL = SOCIETY_EDU_COMMUNITY + "/notice2_detail";

	/**
	 * 소사이어티의 모집홍보의 졸업생마당 페이지
	 */
	public static final String SOCIETY_EDU_COMMUNITY_GRADUATE_COMMUNITY = SOCIETY_EDU_COMMUNITY
			+ "/graduate_community";

	/**
	 * 소사이어티의 모집홍보의 졸업생마당 게시판 내용보기 페이지
	 */
	public static final String SOCIETY_EDU_COMMUNITY_GRADUATE_COMMUNITY_DETAIL = SOCIETY_EDU_COMMUNITY
			+ "/graduate_community_detail";

	/**
	 * 소사이어티의 모집홍보의 미디어 속 IT 페이지
	 */
	public static final String SOCIETY_EDU_COMMUNITY_MEDIA_IN_IT = SOCIETY_EDU_COMMUNITY + "/media_in_it";

	/**
	 * 소사이어티의 모집홍보의 미디어 속 IT 게시판 내용보기 페이지
	 */
	public static final String SOCIETY_EDU_COMMUNITY_MEDIA_IN_IT_DETAIL = SOCIETY_EDU_COMMUNITY + "/media_in_it_detail";

	/**
	 * 소사이어티의 모집홍보의 자료실 페이지
	 */
	public static final String SOCIETY_EDU_COMMUNITY_PDS = SOCIETY_EDU_COMMUNITY + "/pds";

	/**
	 * 소사이어티의 모집홍보의 자료실 게시판 내용보기 페이지
	 */
	public static final String SOCIETY_EDU_COMMUNITY_PDS_DETAIL = SOCIETY_EDU_COMMUNITY + "/pds_detail";

	/**
	 * 소사이어티의 모집홍보의 상담센터 기본 주소
	 */
	public static final String SOCIETY_EDU_CONSULTING = SOCIETY_EDU + "/consulting";

	/**
	 * 소사이어티의 모집홍보의 FAQ 페이지
	 */
	public static final String SOCIETY_EDU_CONSULTING_FAQ = SOCIETY_EDU_CONSULTING + "/faq";

	public static final String SOCIETY_EDU_CONSULTING_FAQ_REQUEST = SOCIETY_EDU_CONSULTING + "/faq_request";

	/**
	 * 소사이어티의 모집홍보의 온라인 상담 페이지
	 */
	public static final String SOCIETY_EDU_CONSULTING_ONLINE = SOCIETY_EDU_CONSULTING + "/online_consulting";

	/**
	 * 소사이어티의 모집홍보의 온라인 상담 작성 페이지
	 */
	public static final String SOCIETY_EDU_CONSULTING_ONLINE_WRITE_FORM = SOCIETY_EDU_CONSULTING
			+ "/online_consulting_write_form";

	/**
	 * 소사이어티의 모집홍보의 온라인 상담서비스 신청하기
	 */
	public static final String SOCIETY_EDU_CONSULTING_ONLINE_APPLY = SOCIETY_EDU_CONSULTING + "/apply_online";

	/**
	 * 소사이어티의 모집홍보의 온라인 상담 수정 페이지
	 */
	public static final String SOCIETY_EDU_CONSULTING_ONLINE_UPDATE_FORM = SOCIETY_EDU_CONSULTING
			+ "/online_consulting_update_form";

	/**
	 * 소사이어티의 모집홍보의 온라인 상담 내역 수정요청
	 */
	public static final String SOCIETY_EDU_CONSULTING_ONLINE_APPLY_UPDATE = SOCIETY_EDU_CONSULTING
			+ "/apply_online_udt";

	/**
	 * 소사이어티의 모집홍보의 온라인 상담 내역 삭제요청
	 */
	public static final String SOCIETY_EDU_CONSULTING_ONLINE_APPLY_DELETE = SOCIETY_EDU_CONSULTING
			+ "/apply_online_del";

	/**
	 * 소사이어티의 모집홍보의 온라인 상담 내용보기 페이지
	 */
	public static final String SOCIETY_EDU_CONSULTING_ONLINE_DETAIL = SOCIETY_EDU_CONSULTING
			+ "/online_consulting_detail";

	/**
	 * 소사이어티의 모집홍보의 오프라인 상담 페이지
	 */
	public static final String SOCIETY_EDU_CONSULTING_OFFLINE = SOCIETY_EDU_CONSULTING + "/offline_consulting";

	/**
	 * 소사이어티의 모집홍보의 오프라인 상담서비스 신청하기
	 */
	public static final String SOCIETY_EDU_CONSULTING_OFFLINE_APPLY = SOCIETY_EDU_CONSULTING + "/apply_offline";

	/**
	 * 소사이어티의 모집홍보의 이미지 게시판 페이지
	 */
	public static final String SOCIETY_EDU_IMAGE_NOTICE = SOCIETY_EDU_APPLY + "/image_notice";

	/**
	 * 소사이어티의 모집홍보의 이미지 게시판 내용보기 페이지
	 */
	public static final String SOCIETY_EDU_IMAGE_NOTICE_DETAIL = SOCIETY_EDU_APPLY + "/image_notice_detail";

	/**
	 * 소사이어티의 모집홍보의 지원신청서 폼 주소
	 */
	public static final String SOCIETY_EDU_APPLY_FORM = SOCIETY_EDU_APPLY + "/apply_form";

	/**
	 * 소사이어티의 모집홍보의 지원신청 수정 폼 주소
	 */
	public static final String SOCIETY_EDU_APPLY_UPDATE_FORM = SOCIETY_EDU_APPLY + "/apply_update_form";
	
	/**
	 * 소사이어티의 모집홍보의 서울 지원신청서 폼 주소
	 */
	public static final String SOCIETY_EDU_APPLY_SEOUL_FORM = SOCIETY_EDU_APPLY + "/apply_seoul_form";

	/**
	 * 소사이어티의 모집홍보의 서울 지원신청 수정 폼 주소
	 */
	public static final String SOCIETY_EDU_APPLY_SEOUL_UPDATE_FORM = SOCIETY_EDU_APPLY + "/apply_seoul_update_form";

	/**
	 * 소사이어티의 모집홍보의 지원신청 장기과정 리스트 주소
	 */
	public static final String SOCIETY_EDU_APPLY_LONG_TERM_LIST = SOCIETY_EDU_APPLY + "/long_term_list";

	/**
	 * 소사이어티의 모집홍보의 지원신청 단기과정 리스트 주소
	 */
	public static final String SOCIETY_EDU_APPLY_SHORT_TERM_LIST = SOCIETY_EDU_APPLY + "/short_term_list";
	
	/**
	 * 소사이어티의 모집홍보의 지원신청 단기과정 CUP(사전학습반) 지원페이지 주소
	 */
	public static final String SOCIETY_EDU_APPLY_CUP = SOCIETY_EDU_APPLY + "/cup";

	/**
	 * 소사이어티의 모집홍보의 지원신청 단기과정 CUP(사전학습반) 리스트 주소
	 */
	public static final String SOCIETY_EDU_APPLY_CUP_MENU = SOCIETY_EDU_APPLY + "/cup_menu";
	
	/**
	 * 소사이어티의 모집홍보의 지원신청 C 단기 과정1 주소
	 */
	public static final String SOCIETY_EDU_APPLY_SHORT_TERM_C1 = SOCIETY_EDU_APPLY + "/short_term_c1";
	
	/**
	 * 소사이어티의 모집홍보의 지원신청 C 단기 과정2 주소
	 */
	public static final String SOCIETY_EDU_APPLY_SHORT_TERM_C2 = SOCIETY_EDU_APPLY + "/short_term_c2";
	
	/**
	 * 소사이어티의 모집홍보의 지원신청 Spring Boot 2 단기 과정 주소
	 */
	public static final String SOCIETY_EDU_APPLY_SHORT_TERM_SPRINGBOOT2 = SOCIETY_EDU_APPLY + "/short_term_springboot2";
	
	/**
	 * 소사이어티의 모집홍보의 지원신청 Python 단기 과정 주소
	 */
	public static final String SOCIETY_EDU_APPLY_SHORT_TERM_PYTHON = SOCIETY_EDU_APPLY + "/short_term_python";
	
	/**
	 * 소사이어티의 모집홍보의 지원신청 JAVA 단기 과정1 주소
	 */
	public static final String SOCIETY_EDU_APPLY_SHORT_TERM_JAVA1 = SOCIETY_EDU_APPLY + "/short_term_java1";
	
	/**
	 * 소사이어티의 모집홍보의 지원신청 JAVA 단기 과정2 주소
	 */
	public static final String SOCIETY_EDU_APPLY_SHORT_TERM_JAVA2 = SOCIETY_EDU_APPLY + "/short_term_java2";
	
	/**
	 * 소사이어티의 모집홍보의 지원신청 일본취업 프로그램 단기 과정 주소
	 */
	public static final String SOCIETY_EDU_APPLY_SHORT_TERM_WORK_IN_JAPAN = SOCIETY_EDU_APPLY + "/short_term_work_in_japan";
	
	/**
	 * 소사이어티의 모집홍보의 지원신청 일본어 OA 단기 과정 주소
	 */
	public static final String SOCIETY_EDU_APPLY_SHORT_TERM_JAPAN_OA = SOCIETY_EDU_APPLY + "/short_term_japan_oa";
	
	/**
	 * 소사이어티의 모집홍보의 지원신청 일본어 On Demand 단기 과정 주소
	 */
	public static final String SOCIETY_EDU_APPLY_SHORT_TERM_JAPAN_ON_DEMAND = SOCIETY_EDU_APPLY + "/short_term_japan_on_demand";
	
	/**
	 * 소사이어티의 모집홍보의 지원신청 일본어 Employment 단기 과정 주소
	 */
	public static final String SOCIETY_EDU_APPLY_SHORT_TERM_JAPAN_EMPLOYMENT = SOCIETY_EDU_APPLY + "/short_term_japan_employment";

	/**
	 * 소사이어티의 모집홍보의 지원신청 일본어 Employment 단기 과정 주소
	 */
	public static final String SOCIETY_EDU_APPLY_SHORT_TERM_JAPAN_SJPT = SOCIETY_EDU_APPLY + "/short_term_japan_sjpt";
	/**
	 * 소사이어티의 모집홍보의 지원신청 일본어 비즈니스회화 단기 과정 주소
	 */
	public static final String SOCIETY_EDU_APPLY_SHORT_TERM_JAPAN_BUSINESS = SOCIETY_EDU_APPLY + "/short_term_japan_business";
	/**
	 * 소사이어티의 모집홍보의 지원신청 일본어 jpt 단기 과정 주소
	 */
	public static final String SOCIETY_EDU_APPLY_SHORT_TERM_JAPAN_JPT = SOCIETY_EDU_APPLY + "/short_term_japan_jpt";
	/**
	 * 소사이어티의 모집홍보의 지원신청 일본어 개인지도 단기 과정 주소
	 */
	public static final String SOCIETY_EDU_APPLY_SHORT_TERM_JAPAN_FREETALK = SOCIETY_EDU_APPLY + "/short_term_japan_freetalk";
	/**
	 * 소사이어티의 모집홍보의 지원신청 일본어 비즈니스회화 단기 과정 주소 일반인 대상
	 */
	public static final String SOCIETY_EDU_APPLY_SHORT_TERM_JAPAN_BUSINESS_ALL = SOCIETY_EDU_APPLY + "/short_term_japan_business_all";
	/**
	 * 소사이어티의 모집홍보의 지원신청 일본어 jpt 단기 과정 주소 일반인 대상
	 */
	public static final String SOCIETY_EDU_APPLY_SHORT_TERM_JAPAN_JPT_ALL = SOCIETY_EDU_APPLY + "/short_term_japan_jpt_all";
	/**
	 * 소사이어티의 모집홍보의 지원신청 일본어 개인지도 단기 과정 주소 일반인 대상
	 */
	public static final String SOCIETY_EDU_APPLY_SHORT_TERM_JAPAN_FREETALK_ALL = SOCIETY_EDU_APPLY + "/short_term_japan_freetalk_all";

	/**
	 * 소사이어티의 모집홍보의 지원신청 단기과정 IT101 리스트 주소
	 */
	public static final String SOCIETY_EDU_APPLY_IT101_MENU = SOCIETY_EDU_APPLY + "/it101_menu";

	/**
	 * 소사이어티의 모집홍보의 지원신청 단기과정 오라클 리스트 주소
	 */
	public static final String SOCIETY_EDU_APPLY_ORACLE_MENU = SOCIETY_EDU_APPLY + "/oracle_menu";

	/**
	 * 소사이어티의 모집홍보의 지원신청 단기과정 CUP(사전학습반) 상세화면 주소
	 */
	public static final String SOCIETY_EDU_APPLY_CUP_DETAIL = SOCIETY_EDU_APPLY + "/cup_detail";

	/**
	 * 소사이어티의 모집홍보의 지원신청 단기과정 IT101 상세화면 주소
	 */
	public static final String SOCIETY_EDU_APPLY_IT101_DETAIL = SOCIETY_EDU_APPLY + "/it101_detail";

	/**
	 * 소사이어티의 모집홍보의 지원신청 단기과정 오라클 상세화면 주소
	 */
	public static final String SOCIETY_EDU_APPLY_ORACLE_DETAIL = SOCIETY_EDU_APPLY + "/oracle_detail";

	/**
	 * 소사이어티의 모집홍보의 지원신청 요청
	 */
	public static final String SOCIETY_EDU_APPLY_INSERT = SOCIETY_EDU_APPLY + "/apply_insert";

	/**
	 * 소사이어티의 모집홍보의 지원신청 수정 요청
	 */
	public static final String SOCIETY_EDU_APPLY_UPDATE = SOCIETY_EDU_APPLY + "/apply_update";

	/**
	 * 소사이어티의 모집홍보의 관리자 기본 주소
	 */
	public static final String SOCIETY_EDU_ADMIN = SOCIETY_EDU + "/admin";

	/**
	 * 소사이어티의 모집홍보의 관리자 기본 폼 주소
	 */
	public static final String SOCIETY_EDU_ADMIN_FORM = SOCIETY_EDU_ADMIN + "/admin_form";

	/**
	 * 소사이어티의 모집홍보의 관리자의 과정 개설 폼 주소
	 */
	public static final String SOCIETY_EDU_ADMIN_CURRICULUM_INSERT_FORM = SOCIETY_EDU_ADMIN + "/curriculum_insert_form";

	/**
	 * 소사이어티의 모집홍보의 관리자의 과정 개설 등록
	 */
	public static final String SOCIETY_EDU_ADMIN_CURRICULUM_INSERT = SOCIETY_EDU_ADMIN + "/curriculum_insert";

	/**
	 * 소사이어티의 모집홍보의 관리자의 과정 관리 폼 주소
	 */
	public static final String SOCIETY_EDU_ADMIN_CURRICULUM_MANAGER_FORM = SOCIETY_EDU_ADMIN
			+ "/curriculum_manager_form";

	/**
	 * 소사이어티의 모집홍보의 관리자의 과정 수정 폼 주소
	 */
	public static final String SOCIETY_EDU_ADMIN_CURRICULUM_UPDATE_FORM = SOCIETY_EDU_ADMIN + "/curriculum_update_form";

	/**
	 * 소사이어티의 모집홍보의 관리자의 과정 수정
	 */
	public static final String SOCIETY_EDU_ADMIN_CURRICULUM_UPDATE = SOCIETY_EDU_ADMIN + "/curriculum_update";

	/**
	 * 소사이어티의 모집홍보의 관리자의 과정 승인 정보 수정
	 */
	public static final String SOCIETY_EDU_ADMIN_CURRICULUM_PERMISSION_UPDATE = SOCIETY_EDU_ADMIN
			+ "/curriculum_permission_update";

	/**
	 * 소사이어티의 모집홍보의 관리자의 기수 개설 폼 주소
	 */
	public static final String SOCIETY_EDU_ADMIN_CURRICULUM_GISU_INSERT_FORM = SOCIETY_EDU_ADMIN
			+ "/curriculum_gisu_insert_form";

	/**
	 * 소사이어티의 모집홍보의 관리자의 기수 등록
	 */
	public static final String SOCIETY_EDU_ADMIN_CURRICULUM_GISU_INSERT = SOCIETY_EDU_ADMIN + "/curriculum_gisu_insert";

	/**
	 * 소사이어티의 모집홍보의 관리자의 기수 정보 수정 폼 주소
	 */
	public static final String SOCIETY_EDU_ADMIN_CURRICULUM_GISU_UPDATE_FORM = SOCIETY_EDU_ADMIN
			+ "/curriculum_gisu_update_form";

	/**
	 * 소사이어티의 모집홍보의 관리자의 기수 정보 수정
	 */
	public static final String SOCIETY_EDU_ADMIN_CURRICULUM_GISU_UPDATE = SOCIETY_EDU_ADMIN + "/curriculum_gisu_update";

	/**
	 * 소사이어티의 모집홍보의 관리자의 기수 정보 삭제
	 */
	public static final String SOCIETY_EDU_ADMIN_CURRICULUM_GISU_DELETE = SOCIETY_EDU_ADMIN + "/curriculum_gisu_delete";

	/**
	 * 소사이어티의 모집홍보의 관리자의 기수 관리 폼 주소
	 */
	public static final String SOCIETY_EDU_ADMIN_CURRICULUM_GISU_MANAGER_FORM = SOCIETY_EDU_ADMIN
			+ "/curriculum_gisu_manager_form";

	/**
	 * 소사이어티의 모집홍보의 관리자의 기수 결제 관리 폼 주소
	 */
	public static final String SOCIETY_EDU_ADMIN_PAYMENT_MANAGER_FORM = SOCIETY_EDU_ADMIN + "/payment_manager_form";

	/**
	 * 소사이어티의 모집홍보의 관리자의 유저 결제 관리 폼 주소
	 */
	public static final String SOCIETY_EDU_ADMIN_PAYMENT_USER_FORM = SOCIETY_EDU_ADMIN + "/payment_manager_user";

	/**
	 * 소사이어티의 모집홍보의 관리자의 유저 결제 관리 폼 주소
	 */
	public static final String SOCIETY_EDU_ADMIN_PAYMENT_USER_REFUND = SOCIETY_EDU_ADMIN + "/payment_manager_refund";

	/**
	 * 소사이어티의 모집홍보의 관리자의 FAQ 상담 게시판 관리 폼 주소
	 */
	public static final String SOCIETY_EDU_ADMIN_FAQ_CONSULTING_MANAGER_FORM = SOCIETY_EDU_ADMIN + "/faq_manager_form";

	/**
	 * 소사이어티의 모집홍보의 관리자의 FAQ 상담 게시판 내용 검색
	 */
	public static final String SOCIETY_EDU_ADMIN_FAQ_CONSULTING_CONTENTS_SEARCH = SOCIETY_EDU_ADMIN
			+ "/faq_manager_contents_search";

	/**
	 * 소사이어티의 모집홍보의 관리자의 FAQ 상담 게시판 세부 내용 표시
	 */
	public static final String SOCIETY_EDU_ADMIN_FAQ_CONSULTING_CONTENTS_DETAIL = SOCIETY_EDU_ADMIN
			+ "/faq_manager_detail";

	/**
	 * 소사이어티의 모집홍보의 관리자의 오프라인 상담 상세내용 폼 주소
	 */
	public static final String SOCIETY_EDU_ADMIN_FAQ_CONSULTING_DETAIL_FORM = SOCIETY_EDU_ADMIN
			+ "/faq_manager_detail_form";

	/**
	 * 소사이어티의 모집홍보의 관리자의 FAQ 상담 게시판 세부 내용 등록
	 */
	public static final String SOCIETY_EDU_ADMIN_FAQ_CONSULTING_CONTENTS_INSERT = SOCIETY_EDU_ADMIN
			+ "/faq_manager_contents_insert";

	/**
	 * 소사이어티의 모집홍보의 관리자의 FAQ 상담 게시판 세부 내용 등록 폼 이동
	 */
	public static final String SOCIETY_EDU_ADMIN_FAQ_CONSULTING_CONTENTS_INSERT_FORM = SOCIETY_EDU_ADMIN
			+ "/faq_manager_insert_form";

	/**
	 * 소사이어티의 모집홍보의 관리자의 FAQ 상담 게시판 세부 내용 수정
	 */
	public static final String SOCIETY_EDU_ADMIN_FAQ_CONSULTING_CONTENTS_UPDATE = SOCIETY_EDU_ADMIN
			+ "/faq_manager_contents_update";

	/**
	 * 소사이어티의 모집홍보의 관리자의 FAQ 상담 게시판 세부 내용 수정 폼 이동
	 */
	public static final String SOCIETY_EDU_ADMIN_FAQ_CONSULTING_CONTENTS_UPDATE_FORM = SOCIETY_EDU_ADMIN
			+ "/faq_manager_update_form";

	/**
	 * 소사이어티의 모집홍보의 관리자의 온라인 상담 게시판 관리 폼 주소
	 */
	public static final String SOCIETY_EDU_ADMIN_ONLINE_CONSULTING_MANAGER_FORM = SOCIETY_EDU_ADMIN
			+ "/online_manager_form";

	/**
	 * 소사이어티의 모집홍보의 관리자의 온라인 상담 게시판 리스트표시
	 */
	public static final String SOCIETY_EDU_ADMIN_ONLINE_CONSULTING_LIST_VIEW = SOCIETY_EDU_ADMIN
			+ "/online_manager_list_view";

	/**
	 * 소사이어티의 모집홍보의 관리자의 온라인 상담 게시판 내용 검색
	 */
	public static final String SOCIETY_EDU_ADMIN_ONLINE_CONSULTING_CONTENTS_SEARCH = SOCIETY_EDU_ADMIN
			+ "/online_manager_contents_search";

	/**
	 * 소사이어티의 모집홍보의 관리자의 온라인 상담 게시판 조회수 증가
	 */
	public static final String SOCIETY_EDU_ADMIN_ONLINE_CONSULTING_HIT_UPDATE = SOCIETY_EDU_ADMIN
			+ "/online_manager_hit_update";

	/**
	 * 소사이어티의 모집홍보의 관리자의 온라인 상담 게시판 세부 내용 표시
	 */
	public static final String SOCIETY_EDU_ADMIN_ONLINE_CONSULTING_CONTENTS_DETAIL = SOCIETY_EDU_ADMIN
			+ "/online_manager_contents_detail";

	/**
	 * 소사이어티의 모집홍보의 관리자의 온라인 상담 게시판 세부 내용 폼 이동
	 */
	public static final String SOCIETY_EDU_ADMIN_ONLINE_CONSULTING_CONTENTS_DETAIL_FORM = SOCIETY_EDU_ADMIN
			+ "/online_manager_detail_form";

	/**
	 * 소사이어티의 모집홍보의 관리자의 온라인 상담 게시판 세부 내용 등록 (온라인상담 답변 포함)
	 */
	public static final String SOCIETY_EDU_ADMIN_ONLINE_CONSULTING_CONTENTS_INSERT = SOCIETY_EDU_ADMIN
			+ "/online_manager_contents_insert";

	/**
	 * 소사이어티의 모집홍보의 관리자의 온라인 상담 게시판 세부 내용 등록 폼 이동 (온라인상담 답변 포함)
	 */
	public static final String SOCIETY_EDU_ADMIN_ONLINE_CONSULTING_CONTENTS_INSERT_FORM = SOCIETY_EDU_ADMIN
			+ "/online_manager_insert_form";

	/**
	 * 소사이어티의 모집홍보의 관리자의 온라인 상담 게시판 세부 내용 수정 (온라인상담 답변 포함)
	 */
	public static final String SOCIETY_EDU_ADMIN_ONLINE_CONSULTING_CONTENTS_UPDATE = SOCIETY_EDU_ADMIN
			+ "/online_manager_contents_update";

	/**
	 * 소사이어티의 모집홍보의 관리자의 온라인 상담 게시판 세부 내용 수정 폼 이동 (온라인상담 답변 포함)
	 */
	public static final String SOCIETY_EDU_ADMIN_ONLINE_CONSULTING_CONTENTS_UPDATE_FORM = SOCIETY_EDU_ADMIN
			+ "/online_manager_update_form";

	/**
	 * 소사이어티의 모집홍보의 관리자의 온라인 상담 답변 세부 내용 등록
	 */
	public static final String SOCIETY_EDU_ADMIN_ONLINE_CONSULTING_REPLY_INSERT = SOCIETY_EDU_ADMIN
			+ "/online_manager_reply_insert";

	/**
	 * 소사이어티의 모집홍보의 관리자의 온라인 상담 답변 세부 내용 수정
	 */
	public static final String SOCIETY_EDU_ADMIN_ONLINE_CONSULTING_REPLY_UPDATE = SOCIETY_EDU_ADMIN
			+ "/online_manager_reply_update";

	/**
	 * 소사이어티의 모집홍보의 관리자의 온라인 상담 게시판 세부 내용 수정 폼 이동 (온라인상담 답변 포함)
	 */
	public static final String SOCIETY_EDU_ADMIN_ONLINE_CONSULTING_REPLY_UPDATE_FORM = SOCIETY_EDU_ADMIN
			+ "/online_manager_reply_update_form";

	/**
	 * 소사이어티의 모집홍보의 관리자의 오프라인 상담 관리 폼 주소
	 */
	public static final String SOCIETY_EDU_ADMIN_OFFLINE_CONSULTING_MANAGER_FORM = SOCIETY_EDU_ADMIN
			+ "/offline_manager_form";

	/**
	 * 소사이어티의 모집홍보의 관리자의 오프라인 상담 상세내용 폼 주소
	 */
	public static final String SOCIETY_EDU_ADMIN_OFFLINE_CONSULTING_DETAIL_FORM = SOCIETY_EDU_ADMIN
			+ "/offline_manager_detail_form";

	/**
	 * 소사이어티의 모집홍보의 관리자의 오프라인 상담 메일발송
	 */
	public static final String SOCIETY_EDU_ADMIN_OFFLINE_CONSULTING_MAIL_SEND = SOCIETY_EDU_ADMIN
			+ "/offline_manager_mail_send";

	/**
	 * 소사이어티의 모집홍보의 관리자의 결제 폼 주소
	 */
	public static final String SOCIETY_EDU_ADMIN_PAYMENT_FORM = SOCIETY_EDU_ADMIN + "/payment_form";

	/**
	 * 소사이어티의 모집홍보의 관리자의 결제 정보 등록 주소
	 */
	public static final String SOCIETY_EDU_ADMIN_PAYMENT_INSERT_FORM = SOCIETY_EDU_ADMIN + "/payment_insert";

	/**
	 * 소사이어티의 모집홍보의 관리자의 결제 정보 등록 주소
	 */
	public static final String SOCIETY_EDU_ADMIN_PAYMENT_DELETE_FORM = SOCIETY_EDU_ADMIN + "/payment_delete";

	/**
	 * 소사이어티의 모집홍보의 관리자의 기수 노출 승인 정보 수정
	 */
	public static final String SOCIETY_EDU_ADMIN_CURRICULUM_GISU_PERMISSION_UPDATE = SOCIETY_EDU_ADMIN
			+ "/curriculum_gisu_permission_update";

	/**
	 * 소사이어티의 모집홍보의 관리자의 과정 및 기수정보들 검색
	 */
	public static final String SOCIETY_EDU_ADMIN_SEARCH_CURRICULUM_AND_GISU = SOCIETY_EDU_ADMIN
			+ "/search_curriculum_and_gisu";

	/**
	 * 소사이어티의 모집홍보의 관리자의 특정 과정 검색
	 */
	public static final String SOCIETY_EDU_ADMIN_SEARCH_CURRICULUM = SOCIETY_EDU_ADMIN + "/search_curriculum";

	/**
	 * 소사이어티의 모집홍보의 관리자의 특정 과정의 기수 정보들 검색
	 */
	public static final String SOCIETY_EDU_ADMIN_SEARCH_CUR_GISU = SOCIETY_EDU_ADMIN + "/search_cur_gisu";

	/**
	 * 소사이어티의 모집홍보의 관리자의 특정 과정의 결제 정보들 검색
	 */
	public static final String SOCIETY_EDU_ADMIN_SEARCH_CUR_ORDER = SOCIETY_EDU_ADMIN + "/search_cur_order";

	/**
	 * 소사이어티의 모집홍보의 관리자의 특정 기수의 지원자들 정보 검색
	 */
	public static final String SOCIETY_EDU_ADMIN_SEARCH_APPLY_LIST = SOCIETY_EDU_ADMIN + "/search_apply_list";

	/**
	 * 소사이어티의 모집홍보의 관리자의 특정 기수의 지원자들 대상 메일 발송
	 */
	public static final String SOCIETY_EDU_ADMIN_SEND_MAIL = SOCIETY_EDU_ADMIN + "/send_mail";

	/**
	 * 소사이어티의 모집홍보의 관리자의 특정 기수의 지원자들 대상 문자 발송
	 */
	public static final String SOCIETY_EDU_ADMIN_SEND_SMS = SOCIETY_EDU_ADMIN + "/send_sms";

	/**
	 * 소사이어티의 모집홍보의 관리자의 특정 기수의 지원자들 정보 검색
	 */
	public static final String SOCIETY_EDU_ADMIN_SEARCH_PAID_LIST = SOCIETY_EDU_ADMIN + "/search_paid_list";

	/**
	 * 소사이어티의 모집홍보의 관리자의 특정 기수의 지원자들 정보 검색
	 */
	public static final String SOCIETY_EDU_ADMIN_SEARCH_REFUND_LIST = SOCIETY_EDU_ADMIN + "/search_refund_list";

	/**
	 * 환불처리 후 환불완료 등록
	 */
	public static final String SOCIETY_EDU_ADMIN_PROCEED_REFUND = SOCIETY_EDU_ADMIN + "/proceed_refund";

	/**
	 * 환불 메모내용 변경
	 */
	public static final String SOCIETY_EDU_ADMIN_REFUND_MEMO_UPDATE = SOCIETY_EDU_ADMIN + "/refund_memo_update";

	/**
	 * 소사이어티의 모집홍보의 관리자의 특정 기수의 지원자를 이름으로 정보 검색
	 */
	public static final String SOCIETY_EDU_ADMIN_SEARCH_PAID_NAME = SOCIETY_EDU_ADMIN + "/search_paid_name";

	/**
	 * 소사이어티의 모집홍보의 관리자의 특정 기수의 지원자를 이름으로 정보 검색
	 */
	public static final String SOCIETY_EDU_ADMIN_SEARCH_REFUND_NAME = SOCIETY_EDU_ADMIN + "/search_refund_name";

	/**
	 * 소사이어티의 모집홍보의 관리자의 지원자 관리 폼 주소
	 */
	public static final String SOCIETY_EDU_ADMIN_APPLY_MANAGER_FORM = SOCIETY_EDU_ADMIN + "/apply_manager_form";

	/**
	 * 소사이어티의 모집홍보의 관리자의 지원신청서 보기 주소
	 */
	public static final String SOCIETY_EDU_ADMIN_APPLY_INFO_UPDATE_FORM = SOCIETY_EDU_ADMIN + "/apply_info_update_form";

	/**
	 * 소사이어티의 모집홍보의 관리자의 지원신청서 인쇄용 페이지
	 */
	public static final String SOCIETY_EDU_ADMIN_APPLY_INFO_PRINT_FORM = SOCIETY_EDU_ADMIN + "/apply_info_print_form";

	/**
	 * 소사이어티의 모집홍보의 관리자의 지원자 결과 수정
	 */
	public static final String SOCIETY_EDU_ADMIN_APPLY_RESULT_UPDATE = SOCIETY_EDU_ADMIN + "/apply_result_update";

	/**
	 * 소사이어티의 모집홍보의 관리자의 게시판 관리 폼 주소
	 */
	public static final String SOCIETY_EDU_ADMIN_BOARD_MANAGER_FORM = SOCIETY_EDU_ADMIN + "/board_manager_form";

	/**
	 * 소사이어티의 모집홍보의 관리자의 게시판 이름 검색
	 */
	public static final String SOCIETY_EDU_ADMIN_BOARD_NAME_SEARCH = SOCIETY_EDU_ADMIN + "/board_name_search";

	/**
	 * 소사이어티의 모집홍보의 관리자의 게시판 내용 검색
	 */
	public static final String SOCIETY_EDU_ADMIN_BOARD_CONTENTS_SEARCH = SOCIETY_EDU_ADMIN + "/board_contents_search";

	/**
	 * 소사이어티의 모집홍보의 관리자의 게시판 세부 내용 검색
	 */
	public static final String SOCIETY_EDU_ADMIN_BOARD_CONTENTS_DETAIL = SOCIETY_EDU_ADMIN + "/board_contents_detail";

	/**
	 * 소사이어티의 모집홍보의 관리자의 게시판 세부 내용 등록
	 */
	public static final String SOCIETY_EDU_ADMIN_BOARD_CONTENTS_INSERT = SOCIETY_EDU_ADMIN + "/board_contents_insert";

	/**
	 * 소사이어티의 모집홍보의 관리자의 게시판 세부 내용 등록 폼 이동
	 */
	public static final String SOCIETY_EDU_ADMIN_BOARD_CONTENTS_INSERT_FORM = SOCIETY_EDU_ADMIN
			+ "/board_contents_insert_form";

	/**
	 * 소사이어티의 모집홍보의 관리자의 게시판 세부 내용 수정
	 */
	public static final String SOCIETY_EDU_ADMIN_BOARD_CONTENTS_UPDATE = SOCIETY_EDU_ADMIN + "/board_contents_update";

	/**
	 * 소사이어티의 모집홍보의 관리자의 게시판 세부 내용 수정 폼 이동
	 */
	public static final String SOCIETY_EDU_ADMIN_BOARD_CONTENTS_UPDATE_FORM = SOCIETY_EDU_ADMIN
			+ "/board_contents_update_form";

	/**
	 * 소사이어티의 모집홍보의 관리자의 게시판 세부 내용 삭제
	 */
	public static final String SOCIETY_EDU_ADMIN_BOARD_CONTENTS_DELETE = SOCIETY_EDU_ADMIN + "/board_contents_delete";

	/**
	 * 소사이어티의 모집홍보의 관리자의 회원 정보 폼 이동
	 */
	public static final String SOCIETY_EDU_ADMIN_USER_MANAGER_FORM = SOCIETY_EDU_ADMIN + "/user_manager_form";

	/**
	 * 소사이어티의 모집홍보의 관리자의 회원 정보 수정 폼 이동
	 */
	public static final String SOCIETY_EDU_ADMIN_USER_INFO_UPDATE_FORM = SOCIETY_EDU_ADMIN + "/user_info_update_form";

	/**
	 * 소사이어티의 모집홍보의 회원 기본 주소
	 */
	public static final String SOCIETY_EDU_USER = SOCIETY_EDU + "/user";

	/**
	 * 소사이어티의 모집홍보의 회원 로그인 주소
	 */
	public static final String SOCIETY_EDU_USER_LOGIN = SOCIETY_EDU_USER + "/user_login";

	/**
	 * 소사이어티의 모집홍보의 회원 로그인 폼 주소
	 */
	public static final String SOCIETY_EDU_USER_LOGIN_FORM = SOCIETY_EDU_USER + "/user_login_form";

	/**
	 * 소사이어티의 모집홍보의 로그인 성공 주소
	 */
	public static final String SOCIETY_EDU_USER_LOGIN_SUCCESS = SOCIETY_EDU_USER + "/user_login_success";

	/**
	 * 소사이어티의 모집홍보의 아이디 찾기 폼 주소
	 */
	public static final String SOCIETY_EDU_USER_FORGOT_ID = SOCIETY_EDU_USER + "/user_forgot_id";

	/**
	 * 소사이어티의 모집홍보의 아이디 찾기 결과 주소
	 */
	public static final String SOCIETY_EDU_USER_FORGOT_ID_RESULT = SOCIETY_EDU_USER + "/user_forgot_id_result";

	/**
	 * 소사이어티의 모집홍보의 비밀번호 찾기 주소
	 */
	public static final String SOCIETY_EDU_USER_FORGOT_PASSWORD = SOCIETY_EDU_USER + "/user_forgot_password";

	/**
	 * 소사이어티의 모집홍보의 비밀번호 변경 폼 주소
	 */
	public static final String SOCIETY_EDU_USER_FORGOT_PASSWORD_FORM = SOCIETY_EDU_USER + "/user_forgot_password_form";

	/**
	 * 소사이어티의 모집홍보의 비밀번호 변경 주소
	 */
	public static final String SOCIETY_EDU_USER_FORGOT_PASSWORD_CHANGE = SOCIETY_EDU_USER
			+ "/user_forgot_password_change";

	/**
	 * 소사이어티의 모집홍보의 비밀번호 찾기 결과 주소
	 */
	public static final String SOCIETY_EDU_USER_FORGOT_PASSWORD_RESULT = SOCIETY_EDU_USER
			+ "/user_forgot_password_result";

	/**
	 * 소사이어티의 공통 회원의 인증 코드 발행 주소
	 */
	public static final String SOCIETY_COM_USER_REQUEST_CERTIFICATION_CODE = SOCIETY_EDU_USER
			+ "/user_request_certification_code";

	/**
	 * 소사이어티의 공통 회원의 인증 코드 체크 주소
	 */
	public static final String SOCIETY_COM_USER_CHECK_CERTIFICATION_CODE = SOCIETY_EDU_USER
			+ "/user_check_certification_code";

	/**
	 * 소사이어티의 모집홍보의 회원 접근 거부 주소
	 */
	public static final String SOCIETY_EDU_USER_ACCESS_DENIED = SOCIETY_EDU_USER + "/user_access_denied";
	
	/**
	 * 소사이어티의 모집홍보의 회원 시큐리티 초기화 주소
	 * */
	public static final String SOCIETY_EDU_USER_SECURITY_INVALIDATE = SOCIETY_EDU_USER + "/user_security_invalidate";

	/**
	 * 소사이어티의 모집홍보의 휴면 계정 회원 폼 주소
	 */
	public static final String SOCIETY_EDU_USER_DORMANCY_FORM = SOCIETY_EDU_USER + "/user_dormancy_form";

	/**
	 * 소사이어티의 모집홍보의 탈퇴 계정 회원 폼 주소
	 */
	public static final String SOCIETY_EDU_USER_EXPIRED_FORM = SOCIETY_EDU_USER + "/user_expired_form";

	/**
	 * 소사이어티의 모집홍보의 정지 계정 회원 폼 주소
	 */
	public static final String SOCIETY_EDU_USER_LOCKED_FORM = SOCIETY_EDU_USER + "/user_locked_form";
	
	/**
	 * 소사이어티의 모집홍보의 승인 대기 계정 회원 폼 주소
	 * */
	public static final String SOCIETY_EDU_USER_PENDING_APPROVAL_FORM = SOCIETY_EDU_USER + "/user_pending_approval_form";

	/**
	 * 소사이어티의 공통 회원의 가입 폼 주소
	 */
	public static final String SOCIETY_COM_USER_JOIN_FORM = SOCIETY_EDU_USER + "/user_join_form";

	/**
	 * 소사이어티의 공통 회원의 가입 주소
	 */
	public static final String SOCIETY_COM_USER_JOIN = SOCIETY_EDU_USER + "/user_join";

	/**
	 * 소사이어티의 공통 회원의 약관 폼 주소
	 */
	public static final String SOCIETY_COM_USER_JOIN_TERMS = SOCIETY_EDU_USER + "/user_join_terms";
	
	/**
	 * 소사이어티의 공통 회원의 모바일인증 주소
	 */
	public static final String SOCIETY_COM_USER_MOBILE_VERIFICATION = SOCIETY_EDU_USER + "/user_mobile_verification";
	/**
	 * 소사이어티의 공통 회원의 모바일인증 주소
	 */
	public static final String SOCIETY_COM_USER_MOBILE_VERIFICATION_FAILED = SOCIETY_EDU_USER + "/user_mobile_verification_failed";
	/**
	 * 소사이어티의 공통 회원의 모바일인증 주소
	 */
	public static final String SOCIETY_COM_USER_MOBILE_VERIFICATION_DUPLICATED = SOCIETY_EDU_USER + "/user_mobile_verification_duplicated";

	/**
	 * 소사이어티의 공통 회원의 약관 동의 주소
	 */
	public static final String SOCIETY_COM_USER_JOIN_TERMS_AGREE = SOCIETY_EDU_USER + "/user_join_terms_agree";

	/**
	 * 소사이어티의 공통 회원의 가입 성공 주소
	 */
	public static final String SOCIETY_COM_USER_JOIN_SUCCESS = SOCIETY_EDU_USER + "/user_join_success";

	/**
	 * 소사이어티의 공통 회원의 정보 수정 폼
	 */
	public static final String SOCIETY_COM_USER_UPDATE_FORM = SOCIETY_EDU_USER + "/user_update_form";

	/**
	 * 소사이어티의 공통 회원의 결제 폼
	 */
	public static final String SOCIETY_COM_USER_PAY_INI = SOCIETY_EDU_USER + "/user_pay_ini";

	/**
	 * 소사이어티의 공통 회원의 결제 정보폼
	 */
	public static final String SOCIETY_COM_USER_PAY_INFO = SOCIETY_EDU_USER + "/user_pay_info";

	/**
	 * 소사이어티의 공통 회원의 결제 현황폼
	 */
	public static final String SOCIETY_COM_USER_PAY_STATUS = SOCIETY_EDU_USER + "/user_pay_status";

	/**
	 * 소사이어티의 공통 회원의 온라인상담 현황폼
	 */
	public static final String SOCIETY_COM_USER_CONSULTING_STATUS = SOCIETY_EDU_USER + "/user_consulting_list";

	/**
	 * 소사이어티의 유저 환불 요청 변수
	 */
	public static final String SOCIETY_COM_USER_REFUND_REQ = SOCIETY_EDU_USER + "/user_refund_req";

	/**
	 * 소사이어티의 유저 환불 확인 변수
	 */
	public static final String SOCIETY_COM_USER_REFUND_STATUS = SOCIETY_EDU_USER + "/user_refund_status";

	/**
	 * 소사이어티의 공통 회원의 정보 수정 폼
	 */
	public static final String SOCIETY_COM_USER_UPDATE_JSON = SOCIETY_EDU_USER + "/user_update_json";

	/**
	 * 소사이어티의 공통 회원의 정보 수정 폼
	 */
	public static final String SOCIETY_COM_USER_APPLY_HISTORY = SOCIETY_EDU_USER + "/user_apply_history";

	/**
	 * 소사이어티의 공통 회원의 정보 수정 주소
	 */
	public static final String SOCIETY_COM_USER_UPDATE = SOCIETY_EDU_USER + "/user_update";

	/**
	 * 소사이어티의 공통 회원의 탈퇴 주소
	 */
	public static final String SOCIETY_COM_USER_DELETE = SOCIETY_EDU_USER + "/user_delete";

	/**
	 * 소사이어티의 공통 회원의 아이디 중복 확인 주소
	 */
	public static final String SOCIETY_COM_USER_DUPLICATED = SOCIETY_EDU_USER + "/user_duplicated";

	/**
	 * 소사이어티의 공통 회원의 이메일 중복 확인 주소
	 */
	public static final String SOCIETY_COM_USER_EMAIL_DUPLICATED = SOCIETY_EDU_USER + "/user_email_duplicated";

	/**
	 * 소사이어티의 모집홍보의 관리자의 회원 가입 폼 주소
	 * */
	public static final String SOCIETY_EDU_ADMIN_JOIN_FORM = SOCIETY_EDU_ADMIN + "/admin_join_form";
	
	/**
	 * 소사이어티의 모집홍보의 관리자의 회원 가입 요청 주소
	 * */
	public static final String SOCIETY_EDU_ADMIN_JOIN = SOCIETY_EDU_ADMIN + "/admin_join";
	
	/**
	 * 소사이어티의 모집홍보의 관리자의 로그인 주소
	 */
	public static final String SOCIETY_EDU_ADMIN_LOGIN = SOCIETY_EDU_ADMIN + "/login";

	/**
	 * 소사이어티의 모집홍보의 관리자의 로그인 폼 주소
	 */
	public static final String SOCIETY_EDU_ADMIN_LOGIN_FORM = SOCIETY_EDU_ADMIN + "/admin_login_form";

	/**
	 * 소사이어티의 모집홍보의 관리자의 로그인 성공 주소
	 */
	public static final String SOCIETY_EDU_ADMIN_LOGIN_SUCCESS = SOCIETY_EDU_ADMIN + "/admin_login_success";

	/**
	 * 소사이어티의 모집홍보의 관리자 접근 거부 주소
	 */
	public static final String SOCIETY_EDU_ADMIN_ACCESS_DENIED = SOCIETY_EDU_ADMIN + "/admin_access_denied";
	
	/**
	 * 소사이어티의 모집홍보의 관리자 시큐리티 초기화 주소
	 * */
	public static final String SOCIETY_EDU_ADMIN_SECURITY_INVALIDATE = SOCIETY_EDU_ADMIN + "/admin_security_invalidate";
	
	/**
	 * 소사이어티의 모집홍보의 관리자 휴면 계정 회원 폼 주소
	 */
	public static final String SOCIETY_EDU_ADMIN_DORMANCY_FORM = SOCIETY_EDU_ADMIN + "/admin_dormancy_form";

	/**
	 * 소사이어티의 모집홍보의 관리자 탈퇴 계정 회원 폼 주소
	 */
	public static final String SOCIETY_EDU_ADMIN_EXPIRED_FORM = SOCIETY_EDU_ADMIN + "/admin_expired_form";

	/**
	 * 소사이어티의 모집홍보의 관리자 정지 계정 회원 폼 주소
	 */
	public static final String SOCIETY_EDU_ADMIN_LOCKED_FORM = SOCIETY_EDU_ADMIN + "/admin_locked_form";
	
	/**
	 * 소사이어티의 모집홍보의 관리자 승인 대기 계정 회원 폼 주소
	 * */
	public static final String SOCIETY_EDU_ADMIN_PENDING_APPROVAL_FORM = SOCIETY_EDU_ADMIN + "/admin_pending_approval_form";
	
	/**
	 * 소사이어티의 모집홍보의 관리자 권한 기간 만료 폼 주소
	 * */
	public static final String SOCIETY_EDU_ADMIN_TERMINATION_FORM = SOCIETY_EDU_ADMIN + "/admin_termination_form";
	
	/**
	 * 소사이어티의 모집홍보의 관리자 정보 셋팅 폼 주소
	 * */
	public static final String SOCIETY_EDU_ADMIN_INFO_SETTING_FORM = SOCIETY_EDU_ADMIN + "/admin_info_setting_form";
	
	/**
	 * 소사이어티의 모집홍보의 관리자 정보 수정 주소
	 * */
	public static final String SOCIETY_EDU_ADMIN_INFO_UPDATE = SOCIETY_EDU_ADMIN +"/admin_info_update";
	
	/**
	 * 소사이어티의 모집홍보의 관리자화면에서 회원탈퇴 기능 주소
	 * */
	public static final String SOCIETY_EDU_ADMIN_USER_INFO_DELETE = SOCIETY_EDU_ADMIN + "/user_info_delete";
	
	// File 관련

	/**
	 * 임시 파일 저장 요청
	 */
	public static final String TEMPORARILY_UPLOAD = "/temporarily_upload";

	/**
	 * 임시 파일 다운로드 요청
	 */
	public static final String TEMPORARILY_DOWNLOAD = "/temporarily_download";

	/**
	 * 파일 다운로드 요청
	 */
	public static final String FILE_DOWNLOAD = "/file_download";

	/**
	 * 파일 업로드 요청
	 */
	public static final String FILE_UPLOAD = "/file_upload";

	/**
	 * sesoc.global 기본 주소
	 */
	public static final String SES = "ses";

	/**
	 * sesoc.global 메인 주소
	 */
	public static final String SES_MAIN = "/main";
	
	/**
	 * sesoc.global 리뉴얼 메인 주소
	 */
	public static final String SES_NEW_MAIN = "/new_main";

	/**
	 * sesoc.global의 Vision 주소
	 */
	public static final String SES_SOCIETY_VISION = "/society_vision";

	/**
	 * sesoc.global의 History 주소
	 */
	public static final String SES_SOCIETY_HISTORY = "/society_history";

	/**
	 * 가상계좌 결제이후 호출 JSP
	 */

	public static final String SOCIETY_EDU_USER_AFTERPAY = SOCIETY_EDU_USER + "/user_pay_after";

	/**
	 * test
	 */
	public static final String SOCIETY_EDU_APPLY_TEST = SOCIETY_EDU_APPLY + "/faq_test_search";
	
	/**
	 * 과정설명회신청폼 이동
	 */
	public static final String SOCIETY_EDU_APPLY_COURSEJOINFORM = SOCIETY_EDU_APPLY + "/courseJoinForm";
	
	/**
	 * FS메인 페이지 요청 주소
	 * */
	public static final String SOCIETY_FS_MAIN = "/society/index";
	/**
	 * FS관리자 페이지 요청 주소
	 * */
	public static final String SOCIETY_FS_ADMIN = "/society_admin/societyMain";
	/**
	 * 토플 페이지 요청 주소
	 * */
	public static final String SOCIETY_TOEFL_MAIN = "/main";
	/**
	 * 서브 배너 관리페이지 요청 주소
	 * */
	public static final String SOCIETY_EDU_ADMIN_SUBBANNER_MANAGER_FORM = SOCIETY_EDU_ADMIN + "/subbanner_manager_form";
	/**
	 * 서브 배너 저장페이지 요청 주소
	 * */
	public static final String SOCIETY_EDU_ADMIN_SUBBANNER_INSERT_FORM = SOCIETY_EDU_ADMIN + "/subbanner_insert_form";
	/**
	 * 서브 배너 저장 요청
	 * */
	public static final String SOCIETY_EDU_ADMIN_SUBBANNER_INSERT = SOCIETY_EDU_ADMIN + "/subbanner_insert";
	/**
	 * 서브 배너 삭제 요청
	 * */
	public static final String SOCIETY_EDU_ADMIN_SUBBANNER_DELETE = SOCIETY_EDU_ADMIN + "/subbanner_delete";
	/**
	 * 서브 배너 수정페이지 요청 주소
	 * */
	public static final String SOCIETY_EDU_ADMIN_SUBBANNER_UPDATE_FORM = SOCIETY_EDU_ADMIN + "/subbanner_update_form";
	/**
	 * 서브 배너 수정 요청
	 * */
	public static final String SOCIETY_EDU_ADMIN_SUBBANNER_UPDATE = SOCIETY_EDU_ADMIN + "/subbanner_update";
	
	/**
	 * 서브 배너 순서 요청; 2018. 10. 1. 이재준
	 */
	
	public static final String SOCIETY_EDU_ADMIN_SUBBANNER_OD = SOCIETY_EDU_ADMIN + "/subbanner_od";
	
	/**
	 * 서브 배너 노출여부, 순서 초기화; 2018. 10. 1. 이재준
	 */
	public static final String SOCIETY_EDU_ADMIN_SUBBANNER_INI = SOCIETY_EDU_ADMIN + "/subbanner_ini";
	
	/**
	 * 메인 배너 관리 요청 주소; 2018. 9. 27. 김준영 
	 */
	public static final String SOCIETY_EDU_ADMIN_BANNER_MANAGER_FORM = SOCIETY_EDU_ADMIN + "/banner_manager_form";
	
	/**
	 * 메인 배너 저장 요청 주소; 2018. 9. 27. 김준영 
	 */
	public static final String SOCIETY_EDU_ADMIN_BANNER_INSERT_FORM = SOCIETY_EDU_ADMIN + "/banner_insert_form";
	
	/**
	 * 메인 배너 저장 요청; 2018. 9. 27. 김준영 
	 */
	public static final String SOCIETY_EDU_ADMIN_BANNER_INSERT = SOCIETY_EDU_ADMIN + "/banner_insert";
	
	/**
	 * 메인 배너 순서 요청; 2018. 9. 28. 김준영
	 */
	public static final String SOCIETY_EDU_ADMIN_BANNER_OD = SOCIETY_EDU_ADMIN + "/banner_od";
	
	/**
	 * 메인 배너 노출여부, 순서 초기화; 2018. 9. 28. 김준영
	 */
	public static final String SOCIETY_EDU_ADMIN_BANNER_INI = SOCIETY_EDU_ADMIN + "/banner_ini";
	
	/**
	 * 메인 배너 순서 변경; 2018. 10. 1. 김준영
	 */
	public static final String SOCIETY_EDU_ADMIN_BANNER_ORDER_UPDATE  = SOCIETY_EDU_ADMIN + "/banner_od_udt";
	
	/**
	 * 서브 배너 순서 변경; 2018. 10. 1. 김준영
	 */
	public static final String SOCIETY_EDU_ADMIN_SUBBANNER_ORDER_UPDATE  = SOCIETY_EDU_ADMIN + "/subbanner_od_udt";
	
	/**
	 * 배너 수정페이지 요청 주소; 2018. 10. 1. 이재준
	 */
	public static final String SOCIETY_EDU_ADMIN_BANNER_UPDATE_FORM = SOCIETY_EDU_ADMIN + "/banner_update_form";
	/**
	 * 배너 수정 요청; 2018. 10. 1. 이재준
	 */
	public static final String SOCIETY_EDU_ADMIN_BANNER_UPDATE = SOCIETY_EDU_ADMIN + "/banner_update";
	/**
	 * 배너 삭제 요청
	 * */
	public static final String SOCIETY_EDU_ADMIN_BANNER_DELETE = SOCIETY_EDU_ADMIN + "/banner_delete";
	/**
	 * 기수과정 설명 이미지 삭제 요청; 2018. 10. 2. 신동철
	 * */
	public static final String SOCIETY_EDU_ADMIN_CURRICULUM_GISU_IMG_DELETE = SOCIETY_EDU_ADMIN + "/curriculum_gisu_img_delete";
	
	/**
	 * 과정 중복 여부 확인; 2018. 10. 8. 김준영
	 */
	public static final String SOCIETY_EDU_ADMIN_CURRICULUM_CLASS =  SOCIETY_EDU_ADMIN + "/class";
	
	/**
	 * 링크 구분 업데이트; 2018. 10. 8. 김준영
	 */
	public static final String SOCIETY_EDU_ADMIN_CURRICULUM_GISU_DIVISION_UPDATE =  SOCIETY_EDU_ADMIN + "/division_update";
	
	/**
	 * 지원자 정보를 학사로 복사하는 요청 2018 .12 .13 이종호
	 */
	public static final String SOCIETY_EDU_ADMIN_COPY_TO_SMP = SOCIETY_EDU_ADMIN + "/copy_to_smp";
	
	//---------------------------- SMP 학사관리
	
	/**
	 * 학사관리 시스템  주소(여명환)
	 */
	public static final String SOCIETY_SMP = "/smp";
	
	/**
	 * 학사관리 시스템  관리자 주소(여명환)
	 */
	public static final String SOCIETY_SMP_ADMIN = SOCIETY_SMP + "/admin";
	
	/**
	 * 학사관리 시스템  사용자(학생) 주소(박찬주)
	 */
	public static final String SOCIETY_SMP_USER = SOCIETY_SMP + "/user";
	
	
	/**
	 * 학사관리 시스템  메인 페이지(여명환)
	 */
	public static final String SOCIETY_SMP_USERMAIN = SOCIETY_SMP_USER+"/usermain";
	
	/**
	 * 학사관리 시스템  메인 페이지(여명환)
	 */
	public static final String SOCIETY_SMP_ADMINMAIN = SOCIETY_SMP_ADMIN+"/adminmain";
	
	/**
	 * 학사관리 시스템  학생관리 페이지(여명환)
	 */
	public static final String SOCIETY_SMP_STUDENT_MANAGER = SOCIETY_SMP_ADMIN+"/student_manager";
	
	/**
	 * 학사관리 시스템  학생 정보 요청(여명환)
	 */
	public static final String SOCIETY_SMP_SEARCH_STUDENT_LIST = SOCIETY_SMP+"/search_student_list";
	
	/**
	 * 학사관리 시스템  최종 합격 페이지요청(여명환)
	 */
	public static final String SOCIETY_SMP_FINAL_PASS = SOCIETY_SMP_ADMIN+"/student_final_pass";
	
	/**
	 * 학사관리 시스템  최종 합격 요청(여명환)
	 */
	public static final String SOCIETY_SMP_FINAL_PASS_REST = SOCIETY_SMP_ADMIN+"/final_pass";
	
	/**
	 * 학사관리 시스템  관리자의 지원신청서 보기 주소(여명환
	 */
	public static final String SOCIETY_SMP_STUDENT_INFO_UPDATE_FORM = SOCIETY_SMP_ADMIN + "/student_info_update_form";
	
	/**
	 * 학사관리 시스템  지원신청 수정 요청(여명환)
	 */
	public static final String SOCIETY_SMP_STUDENT_UPDATE = SOCIETY_SMP + "/student_update";
	
	/**
	 * 학사관리 시스템  수강확인서 페이지(여명환)
	 */
	public static final String SOCIETY_SMP_USER_CONFIRMCOURSE = SOCIETY_SMP_USER + "/confirmCourse";
	
	/**
	 * 학사관리 시스템  일정 보기 주소(박찬주)
	 */
	public static final String SOCIETY_SMP_SCHEDULE = SOCIETY_SMP_USER + "/schedule";
	
	/**
	 * 학사관리 시스템  일정 페이지 불러오기 시작(박찬주)
	 */
	public static final String SOCIETY_SMP_SCHEDULE_START = SOCIETY_SMP + "/scheduleStart";
	
	/**
	 * 학사관리 시스템  일정 페이지 요청(박찬주)
	 */
	public static final String SOCIETY_SMP_SCHEDULE_REQUEST = SOCIETY_SMP_USER+ "/fullCalendar";
	
	/**
	 * 학사관리 시스템  기수별 일정 페이지 요청(박찬주)
	 */
	public static final String SOCIETY_SMP_SCHEDULE_GISUCHANGE = SOCIETY_SMP_ADMIN+ "/gisuChange";

	/**
	 * 학사관리 시스템  기수별 일정 이벤트 조회 요청(박찬주)
	 */
	public static final String SOCIETY_SMP_SCHEDULE_SELECTALL = SOCIETY_SMP + "/selectAll";
	
	/**
	 * 학사관리 시스템  일정 이벤트 삭제 요청(박찬주)
	 */
	public static final String SOCIETY_SMP_SCHEDULE_DELETE = SOCIETY_SMP_ADMIN + "/deleteSch";
	
	/**
	 * 학사관리 시스템  일정 이벤트 수정 요청(박찬주)
	 */
	public static final String SOCIETY_SMP_SCHEDULE_UPDATE = SOCIETY_SMP_ADMIN + "/updateSch";
	
	/**
	 * 학사관리 시스템  일정 이벤트 입력 요청(박찬주)
	 */
	public static final String SOCIETY_SMP_SCHEDULE_INSERT = SOCIETY_SMP_ADMIN + "/insertSch";
	
	/**
	 * 학사관리 시스템  특정 기수의 월별 이벤트 조회 요청(박찬주)
	 */
	public static final String SOCIETY_SMP_SCHEDULE_MONTHEVENT_SELECT = SOCIETY_SMP + "/monthEventSelect";
	
	/**
	 * 학사관리 시스템 로그아웃(이종호)
	 * */
	public static final String SOCIETY_SMP_LOGOUT = SOCIETY_SMP + "/logout";
	
	/**
	 * 학사관리 시스템 로그인 성공 주소
	 * */
	public static final String SOCIETY_SMP_LOGIN_SUCCESS = SOCIETY_SMP + "/login_success";
	/**
	 * 학사관리 시스템 로그인 성공 주소
	 * */
	public static final String SOCIETY_SMP_ADMINLOGIN_SUCCESS = SOCIETY_SMP_ADMIN + "/login_success";
	
	/**
	 * 학사관리 시스템 권한없음 페이지 주소
	 * */
	public static final String SOCIETY_SMP_ACCESS_DENIED = SOCIETY_SMP_USER + "/access_denied";
	
	
	/**
	 * 학사관리 관리자 로그인 주소
	 * */
	public static final String SOCIETY_SMP_ADMIN_LOGIN = SOCIETY_SMP_ADMIN + "/login";
	
	/**
	 * 공지게시판  관리자 주소(전희배)
	 */
	public static final String SOCIETY_SMP_ADMIN_BOARD = SOCIETY_SMP_ADMIN + "/board";
	
	/**
	 * 공지게시판  갱신 표시기간 설정 ajax 주소(원병호)
	 */
	public static final String SOCIETY_SMP_ADMIN_UPDATE_BOARD_PD = SOCIETY_SMP_ADMIN + "/update_board_pd";
	
	
	/**
	 * 공지게시판  상세 정보 페이지 관리자 주소(원병호)
	 */
	public static final String SOCIETY_SMP_ADMIN_BOARD_DETAIL = SOCIETY_SMP_ADMIN + "/board_detail";
	
	/**
	 * 공지게시판 게시물등록 페이지  관리자 주소(전희배)
	 */
	public static final String SOCIETY_SMP_ADMIN_BOARD_INSERT_FORM = SOCIETY_SMP_ADMIN+ "/board_insert_form";
	
	/**
	 * 공지게시판 게시물등록  관리자 주소(전희배)
	 */
	public static final String SOCIETY_SMP_ADMIN_BOARD_INSERT = SOCIETY_SMP_ADMIN_BOARD + "/insert";
	
	/**
	 * 공지게시판 게시물수정 페이지  관리자 주소(전희배)
	 */
	public static final String SOCIETY_SMP_ADMIN_BOARD_UPDATE_FORM = SOCIETY_SMP_ADMIN+ "/board_update_form";
	
	/**
	 * 공지게시판 게시물수정 관리자 주소(전희배)
	 */
	public static final String SOCIETY_SMP_ADMIN_BOARD_UPDATE = SOCIETY_SMP_ADMIN_BOARD + "/update";
	 
	/**
	 * 특정 사용자 기수 조회(김진환)
	 */
	public static final String SOCIETY_SMP_SPECIFIC_USER_GISU = SOCIETY_SMP + "/get_specific_user_gisu";
	
	/**
	 * 수강확인페이지  관리자  주소(여명환)
	 */
	public static final String SOCIETY_SMP_USER_PRINTCOURSE = SOCIETY_SMP_USER + "/printCourse"; 
	
	/**
	 * 공지게시판 사용자  주소(전희배)
	 */
	public static final String SOCIETY_SMP_USER_BOARD= SOCIETY_SMP_USER + "/board";
 
	/**
	 * 공지게시판 게시물수정 페이지  관리자  주소(전희배)
	 */
	public static final String SOCIETY_SMP_USER_BOARD_FILEDOWNLOAD = SOCIETY_SMP_USER_BOARD + "/filedownload";

	/**
	 * 공지게시판 상세 페이지  관리자  주소(전희배)
	 */
	public static final String SOCIETY_SMP_USER_BOARD_DETAIL = SOCIETY_SMP_USER + "/board_detail";
	 
	/**
	 * 로그인 페이지(여명환)
	 */
	public static final String SOCIETY_SMP_USER_USERLOGIN = SOCIETY_SMP_USER + "/userlogin";
	
	/**
	 * 로그인 페이지(여명환)
	 */
	public static final String SOCIETY_SMP_ADMIN_ADMINLOGIN = SOCIETY_SMP_ADMIN + "/adminlogin";
	
	/**
	 * 공지게시판 게시물삭제 페이지  관리자 주소(여명환)
	 */
	public static final String SOCIETY_SMP_ADMIN_BOARD_DELETE_FORM = SOCIETY_SMP_ADMIN+ "/board_delete_form";
	
	/**
	 * 메인페이지 게시물 조회 주소(여명환)
	 */
	public static final String SOCIETY_SMP_USER_BOARD_MAINPAGE_FORM = SOCIETY_SMP_USER+ "/get_mainpage_board";
	
	/**
	 * 학사관리 학적부 메모 삽입(여명환)
	 */
	public static final String SOCIETY_SMP_ADMIN_INSERT_MEMO = SOCIETY_SMP_ADMIN+"/insertMemo";
	
	/**
	 * 학사관리 학적부 메모 삽입(여명환)
	 */
	public static final String SOCIETY_SMP_ADMIN_SELECT_MEMO = SOCIETY_SMP_ADMIN+"/selectMemo";
	
	/**
	 * 학사관리 종합평가 페이지(여명환)
	 */
	public static final String SOCIETY_SMP_ADMIN_APS_TOTAL = SOCIETY_SMP_ADMIN+"/aps_total";
	
	/**
	 * 학사관리 종합평가 페이지(여명환)
	 */
	public static final String SOCIETY_SMP_ADMIN_APS_GROUP = SOCIETY_SMP_ADMIN+"/aps_group";
	
	/**
	 * 학사관리 종합평가 페이지(여명환)
	 */
	public static final String SOCIETY_SMP_ADMIN_APS_DETAIL = SOCIETY_SMP_ADMIN+"/aps_detail";
	
	/**
	 * 학사관리 종합평가 페이지(김홍일)
	 */
	public static final String SOCIETY_SMP_ADMIN_APS_SETEVAL = SOCIETY_SMP_ADMIN+"/aps_seteval";
	
	/**
	 * 종합평가검색(여명환)
	 */
	public static final String SOCIETY_SMP_SEARCH_TOTAL = SOCIETY_SMP+"/search_total";
	/**
	 * 종합평가 기수별 정보 요청(여명환)
	 */
	public static final String SOCIETY_SMP_TOTAL_SEARCH_GISU = SOCIETY_SMP+"/total_search_gisu";
	
	/**
	 * 그룹평가 기수별 정보 요청(여명환)
	 */
	public static final String SOCIETY_SMP_GROUP_SEARCH_GISU = SOCIETY_SMP+"/group_search_gisu";
	
	/**
	 * 상세평가 기수별 정보 요청(여명환)
	 */
	public static final String SOCIETY_SMP_DETAIL_SEARCH_GISU = SOCIETY_SMP+"/detail_search_gisu";
	
	/**
	 * 종합평가 정보 삭제 요청(여명환)
	 */
	public static final String SOCIETY_SMP_DELETE_TOTAL = SOCIETY_SMP+"/deleteTotal";
	
	/**
	 * 그룹평가 정보 삭제 요청(여명환)
	 */
	public static final String SOCIETY_SMP_DELETE_GROUP = SOCIETY_SMP+"/deleteGroup";
	
	/**
	 * 상세평가 정보 삭제 요청(여명환)
	 */
	public static final String SOCIETY_SMP_DELETE_DETAIL = SOCIETY_SMP+"/deleteDetail";

	/**
	 * 학사관리 종합평가 등록 페이지(전희배)
	 */
	public static final String SOCIETY_SMP_ADMIN_APS_TOTAL_INSERT_FORM = SOCIETY_SMP_ADMIN+"/aps_total_insert_form";
	
	/**
	 * 학사관리 종합그룹 등록 페이지(전희배)
	 */
	public static final String SOCIETY_SMP_ADMIN_APS_GROUP_INSERT_FORM = SOCIETY_SMP_ADMIN+"/aps_group_insert_form";
	
	/**
	 * 학사관리 종합상세 등록 페이지(전희배)
	 */
	public static final String SOCIETY_SMP_ADMIN_APS_DETAIL_INSERT_FORM = SOCIETY_SMP_ADMIN+"/aps_detail_insert_form";
	
	/**
	 * 학사관리 평가종합 등록 페이지(전희배)
	 */
	public static final String SOCIETY_SMP_ADMIN_APS_TOTAL_INSERT = SOCIETY_SMP_ADMIN+"/aps_total_insert";
	
	/**
	 * 학사관리 평가그룹 등록 페이지(전희배)
	 */
	public static final String SOCIETY_SMP_ADMIN_APS_GROUP_INSERT = SOCIETY_SMP_ADMIN+"/aps_group_insert";
	
	/**
	 * 학사관리 평가상세 등록 페이지(전희배)
	 */
	public static final String SOCIETY_SMP_ADMIN_APS_DETAIL_INSERT = SOCIETY_SMP_ADMIN+"/aps_detail_insert";
	
	/**
	 * 학사관리 종합평가 수정 페이지(전희배)
	 */
	public static final String SOCIETY_SMP_ADMIN_APS_TOTAL_UPDATE_FORM = SOCIETY_SMP_ADMIN+"/aps_total_update_form";
	
	/**
	 * 학사관리 종합그룹 수정 페이지(전희배)
	 */
	public static final String SOCIETY_SMP_ADMIN_APS_GROUP_UPDATE_FORM = SOCIETY_SMP_ADMIN+"/aps_group_update_form";
	
	/**
	 * 학사관리 종합상세 수정 페이지(전희배)
	 */
	public static final String SOCIETY_SMP_ADMIN_APS_DETAIL_UPDATE_FORM = SOCIETY_SMP_ADMIN+"/aps_detail_update_form";
	
	/**
	 * 학사관리 평가종합 수정 페이지(전희배)
	 */
	public static final String SOCIETY_SMP_ADMIN_APS_TOTAL_UPDATE = SOCIETY_SMP_ADMIN+"/aps_total_update";
	
	/**
	 * 학사관리 평가그룹 수정 페이지(전희배)
	 */
	public static final String SOCIETY_SMP_ADMIN_APS_GROUP_UPDATE = SOCIETY_SMP_ADMIN+"/aps_group_update";
	
	/**
	 * 학사관리 평가상세 수정 페이지(전희배)
	 */
	public static final String SOCIETY_SMP_ADMIN_APS_DETAIL_UPDATE = SOCIETY_SMP_ADMIN+"/aps_detail_update";
	
	/**
	 * 종합평가별 그룹평가 리스트(김홍일)
	 */
	public static final String SOCIETY_SMP_ADMIN_SELECT_APS_GROUP = SOCIETY_SMP_ADMIN+"/selectApsGroup";
	
	/**
	 * 종합평가별 상세평가 리스트(김홍일)
	 */
	public static final String SOCIETY_SMP_ADMIN_SELECT_APS_DETAIL = SOCIETY_SMP_ADMIN+"/selectApsDetail";
	
	/**
	 * 종합평가별 그룹평가 리스트(김홍일)
	 */
	public static final String SOCIETY_SMP_ADMIN_SELECT_APS_GROUP_LIST = SOCIETY_SMP_ADMIN+"/selectApsGroupList";
	
	/**
	 * 평가설정 페이지; 2018. 10. 12. 김준영
	 */
	public static final String SOCIETY_SMP_ADMIN_APS_SETLIST = SOCIETY_SMP_ADMIN + "/aps_setlist";
	
	/**
	 * ASP 연결; 2018. 10. 12. 김준영
	 */
	public static final String SOCIETY_SMP_ADMIN_APS = SOCIETY_SMP_ADMIN + "/aps";
	
	/**
	 * ; 2018. 10. 12. 김준영
	 */
	public static final String SOCIETY_SMP_ADMIN_APS_APPLYSETLIST = SOCIETY_SMP_ADMIN_APS + "/applySetList";
	
	/**
	 * ; 2018. 10. 12. 김준영
	 */
	public static final String SOCIETY_SMP_ADMIN_ADDSETLIST = SOCIETY_SMP_ADMIN + "/addSetList";
	
	/**
	 * setTotal 추가; 2018. 10. 12. 김준영
	 */
	public static final String SOCIETY_SMP_ADMIN_APS_NEWTOTAL  = SOCIETY_SMP_ADMIN_APS + "/newTotal";
	
	/**
	 * setGroup 추가; 2018. 10. 12. 김준영
	 */
	public static final String SOCIETY_SMP_ADMIN_APS_NEWGROUP = SOCIETY_SMP_ADMIN_APS + "/newGroup";
	
	/**
	 * setDetail 추가; 2018. 10. 12. 김준영
	 */
	public static final String SOCIETY_SMP_ADMIN_APS_NEWDETAIL = SOCIETY_SMP_ADMIN_APS + "/newDetail";
	
	/**
	 * ; 2018. 10. 12. 김준영 
	 */
	public static final String SOCIETY_SMP_ADMIN_APS_DELETESETLIST = SOCIETY_SMP_ADMIN_APS + "/deleteSetList";
	
	/**
	 * ; 2018. 10. 12. 김준영 
	 */
	public static final String SOCIETY_SMP_ADMIN_APS_DELETESET = SOCIETY_SMP_ADMIN_APS + "/deleteSet";
	
	/**
	 * ; 2018. 10. 12. 김준영 
	 */
	public static final String SOCIETY_SMP_ADMIN_APS_SELECTSET = SOCIETY_SMP_ADMIN_APS + "/selectSet";
	
	/**
	 * ; 2018. 10. 12. 김준영 
	 */
	public static final String SOCIETY_SMP_ADMIN_APS_SETUPDATE = SOCIETY_SMP_ADMIN_APS + "/setUpdate";

	/**
	 * ; 2018. 10. 12. 김준영
	 */
	public static final String SOCIETY_SMP_ADMIN_APS_SELECTSETTOTAL = SOCIETY_SMP_ADMIN_APS + "/selectSetTotal";
	
	/**
	 * ; 2018. 10. 12. 김준영
	 */
	public static final String SOCIETY_SMP_ADMIN_APS_APPENDGROUP = SOCIETY_SMP_ADMIN_APS + "/appendGroup";
	
	/**
	 * ; 2018. 10. 12. 김준영
	 */
	public static final String SOCIETY_SMP_ADMIN_APS_APPENDDETAIL = SOCIETY_SMP_ADMIN_APS + "/appendDetail";
	
	
	/**
	 * 
	 * 
	 * 여기서부터 통합잡페어
	 * 
	 * 
	 */
	
	/**
	 * 통합잡페어(FAP) 기본 URL
	 */
	public static final String SOCIETY_FAP = "/fap";
	
	/**
	 * 통합잡페어(FAP) 관리자용 URL
	 */
	public static final String SOCIETY_FAP_ADMIN = SOCIETY_FAP + "/admin";
	
	/**
	 * 통합잡페어(FAP) 기업용 URL
	 */
	public static final String SOCIETY_FAP_COMPANY = SOCIETY_FAP + "/company";
	
	/**
	 * 통합잡페어(FAP) 사용자용 URL
	 */
	public static final String SOCIETY_FAP_USER = SOCIETY_FAP + "/user";
	
	/**
	 * 통합잡페어(FAP) 에지전시용 URL
	 */
	public static final String SOCIETY_FAP_AGENCY = SOCIETY_FAP + "/agency";
	
	/**
	 * 통합잡페어(FAP) 관리자, 기업 공용 URL
	 */
	public static final String SOCIETY_FAP_ADMINCOMPANY = SOCIETY_FAP + "/admincompany";
	
	/**
	 * 
	 * FAP 김준영 시작
	 * 
	 */
		
	/**
	 * FAP 회사 회원가입; 2018. 12. 10. 김준영
	 */
	public static final String SOCIETY_FAP_COMPANY_INSERT_FORM = SOCIETY_FAP_COMPANY + "/company_insert_form";
	
	/*
	 * FAP 회사 유저 회원 중복체크; 2018. 12. 11. 김준영
	 */
	public static final String SOCIETY_FAP_COMPANY_USER_ID_CHECK = SOCIETY_FAP_COMPANY + "/user_id_check";
	
	/**
	 * FAP 에이전시 회원가입; 2018. 12. 11. 김준영
	 */
	public static final String SOCIETY_FAP_AGENCY_INSERT_FORM = SOCIETY_FAP_AGENCY + "/agency_insert_form";
	
	/*
	 * FAP 에이전시 유저 회원 중복체크; 2018. 12. 11. 김준영
	 */
	public static final String SOCIETY_FAP_AGENCY_USER_ID_CHECK = SOCIETY_FAP_AGENCY + "/user_id_check";
	
	/*
	 * FAP 일반 유저 회원가입; 2018. 12. 12. 김준영
	 */
	public static final String SOCIETY_FAP_USER_INSERT_FORM = SOCIETY_FAP_USER + "/user_insert_form";
	
	/*
	 * FAP 일반 유저 회원 중복체크; 2018. 12. 12. 김준영
	 */
	public static final String SOCIETY_FAP_USER_USER_ID_CHECK = SOCIETY_FAP_USER + "/user_id_check";

	/*
	 * FAP 회사 유저 회원 수정; 2018. 12. 13. 김준영 
	 */
	public static final String SOCIETY_FAP_COMPANY_USER_UDDATE_FORM = SOCIETY_FAP_COMPANY + "/user_update_form";

	/*
	 * FAP 회사 정보 수정; 2018. 12. 13. 김준영
	 */
	public static final String SOCIETY_FAP_COMPANY_COMPANY_UDDATE_FORM = SOCIETY_FAP_COMPANY + "/company_update_form";
	
	/*
	 * FAP 에이전시 로그인 주소; 2018. 12. 13. 김준영
	 */
	public static final String SOCIETY_FAP_AGENCY_LOGIN_FORM = SOCIETY_FAP_AGENCY + "/agency_login";
	
	/*
	 * FAP 에이전시 메인; 2018. 12. 13. 김준영
	 */
	public static final String SOCIETY_FAP_AGENCY_MAIN = SOCIETY_FAP_AGENCY + "/agency_main";
	
	/*
	 * FAP 회원 정보 수정; 2018. 12. 14. 김준영
	 */
	public static final String SOCIETY_FAP_USER_USER_UPDATE_FORM = SOCIETY_FAP_USER + "/user_update_form";
	
	/*
	 * FAP 회사 담당자 정보 수정; 2018. 12. 17. 김준영 
	 */
	public static final String SOCIETY_FAP_COMPANY_COMPANY_USER_UPDATE_FORM = SOCIETY_FAP_COMPANY + "/company_user_update_form";
	
	/*
	 * FAP 에이전시 담당자 정보 수정; 2018. 12. 17. 김준영 
	 */
	public static final String SOCIETY_FAP_AGENCY_AGENCY_USER_UPDATE_FORM = SOCIETY_FAP_AGENCY + "/agency_user_update_form";
	
	/*
	 * FAP 에이전시 기업 회원가입; 2018. 12. 18. 김준영
	 */
	public static final String SOCIETY_FAP_AGENCY_COMPANY_INSERT = SOCIETY_FAP_AGENCY + "/agency_company_insert";
	
	/*
	 * FAP 에이전시 기업 등록; 2018. 12. 18. 김준영
	 */
	public static final String SOCIETY_FAP_AGENCY_COMPANY_REGISTRATION = SOCIETY_FAP_AGENCY + "/agency_company_registration";
	
	/*
	 * FAP 에이전시 등록 기업 관리; 2018. 12. 18. 김준영
	 */
	public static final String SOCIETY_FAP_AGENCY_COMPANY_MANAGEMENT = SOCIETY_FAP_AGENCY + "/agency_company_management";
	
	/*
	 * FAP 에이전시 기업 정보 수정 폼; 2018. 12. 19. 김준영
	 */
	public static final String SOCIETY_FAP_AGENCY_COMPANY_UPDATE_FORM = SOCIETY_FAP_AGENCY + "/agency_company_update_form";
	
	/*
	 * FAP 에이전시 기업 정보 수정; 2018. 12. 19. 김준영
	 */
	public static final String SOCIETY_FAP_AGENCY_COMPANY_UPDATE = SOCIETY_FAP_AGENCY + "/agency_company_update";
	
	/*
	 * FAP 에이전시 기업 연결 끊기; 2018. 12. 21. 김준영
	 */
	public static final String SOCIETY_FAP_AGENCY_COMPANY_DISCONNECT = SOCIETY_FAP_AGENCY + "/agency_company_disconnect";
	
	/*
	 * FAP 에이전시 기업 정보(자기자신) 수정; 2018. 12. 24. 김준영
	 */
	public static final String SOCIETY_FAP_AGENCY_UPDATE_FORM = SOCIETY_FAP_AGENCY + "/agency_update_form";
	
	/*
	 * FAP 유저 아이디 찾기; 2018. 12. 24. 김준영
	 */
	public static final String SOCIETY_FAP_USER_FORGOT_ID = SOCIETY_FAP_USER + "/user_forgot_id";
	
	/*
	 * FAP 유저 아이디 찾기 결과; 2018. 12. 24. 김준영
	 */
	public static final String SOCIETY_FAP_USER_FORGOT_ID_RESULT = SOCIETY_FAP_USER + "/user_forgot_id_result";
	
	/*
	 * FAP 유저 아이디 찾기 승인 코드 요청; 2018. 12. 24. 김준영
	 */
	public static final String SOCIETY_FAP_USER_REQUEST_CERTIFICATION_CODE = SOCIETY_FAP_USER + "/user_request_certification_code";
	
	/*
	 * FAP 유저 아이디 찾기 승인 코드 확인; 2018. 12. 24. 김준영
	 */
	public static final String SOCIETY_FAP_USER_CHECK_CERTIFICATION_CODE = SOCIETY_FAP_USER + "/user_check_certification_code";
	
	/*
	 * FAP 유저 비밀번호 찾기; 2018. 12. 26. 김준영
	 */
	public static final String SOCIETY_FAP_USER_FORGOT_PASSWORD = SOCIETY_FAP_USER + "/user_forgot_password";
	
	/*
	 * FAP 유저 비밀번호 찾기 폼; 2018. 12. 26. 김준영
	 */
	public static final String SOCIETY_FAP_USER_FORGOT_PASSWORD_FORM = SOCIETY_FAP_USER + "/user_forgot_password_form";
	
	/*
	 * FAP 유저 비밀번호 찾기 결과; 2018. 12. 26. 김준영
	 */
	public static final String SOCIETY_FAP_USER_FORGOT_PASSWORD_RESULT = SOCIETY_FAP_USER + "/user_forgot_password_result";
	
	/*
	 * FAP 유저 비밀번호 변경; 2018. 12. 26. 김준영
	 */
	public static final String SOCIETY_FAP_USER_FORGOT_PASSWORD_CHANGE = SOCIETY_FAP_USER + "/user_forgot_password_change";
	
	/*
	 * FAP 기업 담당자 아이디 찾기; 2018. 12. 24. 김준영
	 */
	public static final String SOCIETY_FAP_COMPANY_FORGOT_ID = SOCIETY_FAP_COMPANY + "/company_forgot_id";
	
	/*
	 * FAP 기업 담당자 아이디 찾기 결과; 2018. 12. 24. 김준영
	 */
	public static final String SOCIETY_FAP_COMPANY_FORGOT_ID_RESULT = SOCIETY_FAP_COMPANY + "/company_forgot_id_result";
	
	/*
	 * FAP 기업 담당자 아이디 찾기 승인 코드 요청; 2018. 12. 24. 김준영
	 */
	public static final String SOCIETY_FAP_COMPANY_REQUEST_CERTIFICATION_CODE = SOCIETY_FAP_COMPANY + "/company_request_certification_code";
	
	/*
	 * FAP 기업 담당자 아이디 찾기 승인 코드 확인; 2018. 12. 24. 김준영
	 */
	public static final String SOCIETY_FAP_COMPANY_CHECK_CERTIFICATION_CODE = SOCIETY_FAP_COMPANY + "/company_check_certification_code";
	
	/*
	 * FAP 기업 담당자 비밀번호 찾기; 2018. 12. 26. 김준영
	 */
	public static final String SOCIETY_FAP_COMPANY_FORGOT_PASSWORD = SOCIETY_FAP_COMPANY + "/company_forgot_password";
	
	/*
	 * FAP 기업 담당자 비밀번호 찾기 폼; 2018. 12. 26. 김준영
	 */
	public static final String SOCIETY_FAP_COMPANY_FORGOT_PASSWORD_FORM = SOCIETY_FAP_COMPANY + "/company_forgot_password_form";
	
	/*
	 * FAP 기업 담당자 비밀번호 찾기 결과; 2018. 12. 26. 김준영
	 */
	public static final String SOCIETY_FAP_COMPANY_FORGOT_PASSWORD_RESULT = SOCIETY_FAP_COMPANY + "/company_forgot_password_result";
	
	/*
	 * FAP 기업 담당자 비밀번호 변경; 2018. 12. 26. 김준영
	 */
	public static final String SOCIETY_FAP_COMPANY_FORGOT_PASSWORD_CHANGE = SOCIETY_FAP_COMPANY + "/company_forgot_password_change";
	/*
	 * FAP 에이전시 담당자 아이디 찾기; 2018. 12. 24. 김준영
	 */
	public static final String SOCIETY_FAP_AGENCY_FORGOT_ID = SOCIETY_FAP_AGENCY + "/agency_forgot_id";
	
	/*
	 * FAP 에이전시 담당자 아이디 찾기 결과; 2018. 12. 24. 김준영
	 */
	public static final String SOCIETY_FAP_AGENCY_FORGOT_ID_RESULT = SOCIETY_FAP_AGENCY + "/agency_forgot_id_result";
	
	/*
	 * FAP 에이전시 담당자 아이디 찾기 승인 코드 요청; 2018. 12. 24. 김준영
	 */
	public static final String SOCIETY_FAP_AGENCY_REQUEST_CERTIFICATION_CODE = SOCIETY_FAP_AGENCY + "/agency_request_certification_code";
	
	/*
	 * FAP 에이전시 담당자 아이디 찾기 승인 코드 확인; 2018. 12. 24. 김준영
	 */
	public static final String SOCIETY_FAP_AGENCY_CHECK_CERTIFICATION_CODE = SOCIETY_FAP_AGENCY + "/agency_check_certification_code";
	
	/*
	 * FAP 에이전시 담당자 비밀번호 찾기; 2018. 12. 26. 김준영
	 */
	public static final String SOCIETY_FAP_AGENCY_FORGOT_PASSWORD = SOCIETY_FAP_AGENCY + "/agency_forgot_password";
	
	/*
	 * FAP 에이전시 담당자 비밀번호 찾기 폼; 2018. 12. 26. 김준영
	 */
	public static final String SOCIETY_FAP_AGENCY_FORGOT_PASSWORD_FORM = SOCIETY_FAP_AGENCY + "/agency_forgot_password_form";
	
	/*
	 * FAP 에이전시 담당자 비밀번호 찾기 결과; 2018. 12. 26. 김준영
	 */
	public static final String SOCIETY_FAP_AGENCY_FORGOT_PASSWORD_RESULT = SOCIETY_FAP_AGENCY + "/agency_forgot_password_result";
	
	/*
	 * FAP 에이전시 담당자 비밀번호 변경; 2018. 12. 26. 김준영
	 */
	public static final String SOCIETY_FAP_AGENCY_FORGOT_PASSWORD_CHANGE = SOCIETY_FAP_AGENCY + "/agency_forgot_password_change";
	
	/*
	 * FAP 유저 정보 삭제; 2018. 12. 26. 김준영
	 */
	public static final String SOCIETY_FAP_USER_INFO_DELETE = SOCIETY_FAP_USER + "/user_info_delete";
	
	/*
	 * FAP 기업 담당자 정보 삭제; 2018. 12. 26. 김준영
	 */
	public static final String SOCIETY_FAP_COMPANY_USER_INFO_DELETE = SOCIETY_FAP_COMPANY + "/company_user_info_delete";
	
	/*
	 * FAP 에이전시 기업 담당자 정보 삭제; 2019. 5. 30. 이종호
	 */
	public static final String SOCIETY_FAP_AGENCY_COMPANY_USER_INFO_DELETE = SOCIETY_FAP_AGENCY + "/company_user_info_delete";
	
	/*
	 * FAP 에이전시 담당자 정보 삭제; 2018. 12. 26. 김준영
	 */
	public static final String SOCIETY_FAP_AGENCY_USER_INFO_DELETE = SOCIETY_FAP_AGENCY + "/agency_user_info_delete";
	
	/*
	 * FAP 기업 유저 연결 리스트 요청; 2018. 12. 26. 김준영
	 */
	public static final String SOCIETY_FAP_COMPANY_USER_CONNECT_LIST = SOCIETY_FAP_COMPANY + "/company_user_connect_list";
	
	/*
	 * FAP 기업 - 유저 연결 삭제; 2018. 12. 27. 김준영
	 */
	public static final String SOCIETY_FAP_COMPANY_DELETE_COMPANY_USER_CONNECT = SOCIETY_FAP_COMPANY + "/delete_company_user_connect";
	
	/*
	 * FAP 기업 - 유저 연결 요청; 2018. 12. 27. 김준영
	 */
	public static final String SOCIETY_FAP_COMPANY_REQUEST_COMPANY_USER_CONNECT = SOCIETY_FAP_COMPANY + "/request_company_user_connect";
	
	/*
	 * FAP 기업 유저 연결 리스트 요청; 2018. 12. 26. 김준영
	 */
	public static final String SOCIETY_FAP_AGENCY_USER_CONNECT_LIST = SOCIETY_FAP_AGENCY + "/agency_user_connect_list";
	/*
	 * FAP 에이전시 - 유저 연결 삭제; 2018. 12. 27. 김준영
	 */
	public static final String SOCIETY_FAP_AGENCY_DELETE_COMPANY_USER_CONNECT = SOCIETY_FAP_AGENCY + "/delete_agency_user_connect";
	/*
	 * FAP 에이전시 - 유저 연결 요청; 2018. 12. 27. 김준영
	 */
	public static final String SOCIETY_FAP_AGENCY_REQUEST_COMPANY_USER_CONNECT = SOCIETY_FAP_AGENCY + "/request_agency_user_connect";
	/*
	 * FAP 에이전시 - 기업 직접 연결시 기업 여부 확인; 2018. 12. 27. 김준영
	 */
	public static final String SOCIETY_FAP_AGENCY_COMPANY_DIRECT_CONNECT = SOCIETY_FAP_AGENCY + "/company_direct_connect";
	/*
	 * FAP 에이전시 - 기업 연결 요청; 2018. 12. 31. 김준영
	 */
	public static final String SOCIETY_FAP_AGENCY_COMPANY_CONNECT_REQUEST = SOCIETY_FAP_AGENCY + "/company_connect_request";
	
	/*
	 * FAP 에이전시 - 기업 연결 요청 삭제; 2018. 12. 31. 김준영
	 */
	public static final String SOCIETY_FAP_AGENCY_DELETE_CONNECT_REQUEST = SOCIETY_FAP_AGENCY + "/delete_connect_request";
	
	/*
	 * FAP 기업 에이전시 연결 요청 확인; 2018. 12. 31. 김준영
	 */
	public static final String SOCIETY_FAP_COMPANY_MANAGEMENT_CONNECT_REQUEST = SOCIETY_FAP_COMPANY + "/management_connect_request";
	
	/* 
	 * FAP 에이전시 요청 처리; 2019. 1. 2. 김준영
	 */
	public static final String SOCIETY_FAP_COMPANY_REQUEST_HANDLING = SOCIETY_FAP_COMPANY + "/request_handling";
	
	/*
	 * FAP 관리자 회원 관리; 2019. 1. 2. 김준영
	 */
	public static final String SOCIETY_FAP_ADMIN_USER_MANAGEMENT = SOCIETY_FAP_ADMIN + "/user_management";
	
	/*
	 * FAP 관리자 기업 관리; 2019. 1. 2. 김준영
	 */
	public static final String SOCIETY_FAP_ADMIN_COMPANY_MANAGEMENT = SOCIETY_FAP_ADMIN + "/company_management";
	
	/*
	 * FAP 관리자 회원 수정 폼; 2019. 1. 3. 김준영
	 */
	public static final String SOCIETY_FAP_ADMIN_USER_UPDATE_FORM = SOCIETY_FAP_ADMIN + "/user_update_form";
	
	/*
	 * FAP 관리자 일반 회원 수정 폼; 2019. 1. 3. 김준영
	 */
	public static final String SOCIETY_FAP_ADMIN_PERSONAL_USER_UPDATE_FORM = SOCIETY_FAP_ADMIN + "/personal_user_update_form";
	
	/*
	 * FAP 관리자 기업 담당자 수정 폼; 2019. 1. 3. 김준영
	 */
	public static final String SOCIETY_FAP_ADMIN_COMPANY_USER_UPDATE_FORM = SOCIETY_FAP_ADMIN + "/company_user_update_form";
	
	/*
	 * FAP 관리자 일반 회원 수정; 2019. 1. 3. 김준영
	 */
	public static final String SOCIETY_FAP_ADMIN_PERSONAL_USER_UPDATE = SOCIETY_FAP_ADMIN + "/personal_user_update";
	
	/*
	 * FAP 관리자 기업 담당자 수정; 2019. 1. 3. 김준영
	 */
	public static final String SOCIETY_FAP_ADMIN_COMPANY_USER_UPDATE = SOCIETY_FAP_ADMIN + "/company_user_update";
	
	/*
	 * FAP 관리자 회원 탈퇴; 2019. 1. 3. 김준영
	 */
	public static final String SOCIETY_FAP_ADMIN_USER_INFO_DELETE = SOCIETY_FAP_ADMIN + "/user_info_delete";
	
	/*
	 * FAP 관리자 기업 정보 수정 폼; 2019. 1. 3. 김준영
	 */
	public static final String SOCIETY_FAP_ADMIN_COMPANY_UPDATE_FORM = SOCIETY_FAP_ADMIN + "/company_update_form";
	
	/*
	 * FAP 관리자 기업 정보 수정; 2019. 1. 3. 김준영
	 */
	public static final String SOCIETY_FAP_ADMIN_COMPANY_INFO_UPDATE = SOCIETY_FAP_ADMIN + "/company_info_update";

	/*
	 * FAP 관리자 기업 - 담당자 연결 관리; 2019. 1. 4. 김준영
	 */
	public static final String SOCIETY_FAP_ADMIN_COMPANY_USER_CONNECT_MANAGEMENT = SOCIETY_FAP_ADMIN + "/company_user_connect_management";
	
	/*
	 * FAP 관리자 기업 - 담당자 연결 수정; 2019. 1. 4. 김준영
	 */
	public static final String SOCIETY_FAP_ADMIN_COMPANY_USER_CONNECT_UPDATE = SOCIETY_FAP_ADMIN + "/company_user_connect_update";
	
	/*
	 * FAP 관리자 기업 - 담당자 연결 정보; 2019. 1. 4. 김준영
	 */
	public static final String SOCIETY_FAP_ADMIN_CONNECT_ALL_UPDATE = SOCIETY_FAP_ADMIN + "/connect_all_update";
	
	/*
	 * FAP 관리자 기업 - 담당자 연결 끊기; 2019. 1. 7. 김준영
	 */
	public static final String SOCIETY_FAP_ADMIN_COMPANY_USER_CONNECT_DELETE = SOCIETY_FAP_ADMIN + "/company_user_connect_delete";
	
	/*
	 * FAP 관리자 기업 - 담당자 연결; 2019. 1. 7. 김준영
	 */
	public static final String SOCIETY_FAP_ADMIN_COMPANY_USER_CONNECT = SOCIETY_FAP_ADMIN + "/company_user_connect";
	
	/*
	 * FAP 관리자 에이전시 - 기업 연결 관리; 2019. 1. 7. 김준영
	 */
	public static final String SOCIETY_FAP_ADMIN_AGENCY_COMPANY_CONNECT_MANAGEMENT = SOCIETY_FAP_ADMIN + "/agency_company_connect_management";
	
	/*
	 * FAP 관리자 에이전시 - 기업 연결; 2019. 1. 7. 김준영
	 */
	public static final String SOCIETY_FAP_ADMIN_AGENCY_COMPANY_CONNECT = SOCIETY_FAP_ADMIN + "/agency_company_connect";
	
	/*
	 * FAP 관리자 에이전시 - 기업 연결 끊기; 2019. 1. 8. 김준영
	 */
	public static final String SOCIETY_FAP_ADMIN_AGENCY_COMPANY_CONNECT_DELETE = SOCIETY_FAP_ADMIN + "/agency_company_connect_delete";
	
	/*
	 * FAP 관리자 에이전시 - 기업 연결 업데이트; 2019. 1. 8. 김준영
	 */
	public static final String SOCIETY_FAP_ADMIN_AGENCY_COMPANY_CONNECT_UPDATE = SOCIETY_FAP_ADMIN + "/agency_company_connect_update";
	
	/*
	 * FAP 기업 정보 추가 입력; 2019. 1. 10. 김준영
	 */
	public static final String SOCIETY_FAP_COMPANY_INFO_INSERT = SOCIETY_FAP_COMPANY + "/company_info_insert";
	
	/*
	 * FAP 에이전시 정보 추가 입력; 2019. 1. 10. 김준영
	 */
	public static final String SOCIETY_FAP_AGENCY_INFO_INSERT = SOCIETY_FAP_AGENCY + "/agency_info_insert";
	
	/*
	 * FAP 기업 잡페어 정보 수정; 2019. 1. 15. 김준영
	 */
	public static final String SOCIETY_FAP_COMPANY_JOB_AD_UPDATE = SOCIETY_FAP_COMPANY + "/company_job_ad_update";
	
	/*
	 * FAP 기업 채용전형 수정 가능 여부 확인; 2019. 1. 17. 김준영
	 */
	public static final String SOCIETY_FAP_COMPANY_JOB_PCS_EDITABLE_CHECK = SOCIETY_FAP_COMPANY + "/job_pcs_editable_check";
	
	/*
	 * FAP 기업 약관 동의; 2019. 1. 23. 김준영
	 */
	public static final String SOCIETY_FAP_COMPANY_TERMS_AND_CONDITION = SOCIETY_FAP_COMPANY + "/company_terms_and_condition";
	
	/*
	 * FAP 기업 약관 동의 업데이트; 2019. 1. 23. 김준영
	 */
	public static final String SOCIETY_FAP_COMPANY_TERMS_UPDATE = SOCIETY_FAP_COMPANY + "/company_terms_update";
	
	/*
	 * FAP 에이전시 약관 동의; 2019. 1. 23. 김준영
	 */
	public static final String SOCIETY_FAP_AGENCY_TERMS_AND_CONDITION = SOCIETY_FAP_AGENCY + "/agency_terms_and_condition";
	
	/*
	 * FAP 에이전시 약관 동의 업데이트; 2019. 1. 23. 김준영
	 */
	public static final String SOCIETY_FAP_AGENCY_TERMS_UPDATE = SOCIETY_FAP_AGENCY + "/agency_terms_update";

	/*
	 * FAP 기업 마이페이지; 2019. 1. 25. 김준영
	 */
	public static final String SOCIETY_FAP_COMPANY_MYPAGE =  SOCIETY_FAP_COMPANY + "/company_mypage";
	
	/*
	 * FAP 담당자 - 기업 연결 관리 페이지; 2019. 1. 25. 김준영
	 */
	public static final String SOCIETY_FAP_COMPANY_CONNECT_REQUEST_MANAGEMENT = SOCIETY_FAP_COMPANY + "/company_connect_request_management";	

	/*
	 * FAP 에이전시 마이페이지; 2019. 1. 25. 김준영
	 */
	public static final String SOCIETY_FAP_AGENCY_MYPAGE =  SOCIETY_FAP_AGENCY + "/agency_mypage";
	
	/*
	 * FAP 담당자 - 에이전시 연결 관리 페이지; 2019. 1. 25. 김준영
	 */
	public static final String SOCIETY_FAP_AGENCY_CONNECT_REQUEST_MANAGEMENT = SOCIETY_FAP_AGENCY + "/agency_connect_request_management";	
	
	/*
	 * FAP 기업 메뉴 체크; 2019. 1. 29. 김준영
	 */
	public static final String SOCIETY_FAP_COMPANY_MENU_CHECK = SOCIETY_FAP_COMPANY + "/company_menu_check";
	
	/*
	 * FAP 기업 메뉴 체크; 2019. 2. 11. 김홍일
	 */
	public static final String SOCIETY_FAP_AGENCY_MENU_CHECK = SOCIETY_FAP_AGENCY + "/agency_menu_check";
	
	/*
	 * FAP 기업 - 담당자 연결 요청; 2019. 2. 7. 김준영
	 */
	public static final String SOCIETY_FAP_COMPANY_CONNECT_REQUEST  = SOCIETY_FAP_COMPANY + "/connect_request";
	
	/*
	 * FAP 기업 - 담당자 연결 요청 삭제; 2019. 2. 7. 김준영
	 */
	public static final String SOCIETY_FAP_COMPANY_CONNECT_REQUEST_DELETE = SOCIETY_FAP_COMPANY + "/connect_request_delete";
	
	/*
	 * FAP 에이전시 - 담당자 연결 요청; 2019. 2. 7. 김준영
	 */
	public static final String SOCIETY_FAP_AGENCY_CONNECT_REQUEST  = SOCIETY_FAP_AGENCY + "/connect_request";
	
	/*
	 * FAP 에이전시 - 담당자 연결 요청 삭제; 2019. 2. 7. 김준영
	 */
	public static final String SOCIETY_FAP_AGENCY_CONNECT_REQUEST_DELETE = SOCIETY_FAP_AGENCY + "/connect_request_delete";
	
	/*
	 * FAP 기업, 에이전시 - 담당자 연결 요청 삭제(담당자); 2019. 2. 7. 김준영
	 */
	public static final String SOCIETY_FAP_ADMIN_CONNECT_REQUEST_DELETE = SOCIETY_FAP_ADMIN + "/connect_request_delete";
	
	/*
	 * FAP 기업 채용공고 삭제; 2019. 2. 11. 김준영
	 */
	public static final String SOCIETY_FAP_COMPANY_JOB_AD_DELETE = SOCIETY_FAP_COMPANY + "/job_ad_delete";
	
	/*
	 * FAP 에이전시 회원 탈퇴; 2019. 2. 12. 김준영
	 */
	public static final String SOCIETY_FAP_AGENCY_USER_INFO_DELETE_FORM = SOCIETY_FAP_AGENCY + "/agency_user_info_delete_form";
	
	/*
	 * FAP 잡페어 공고 가져오기 페이징; 2019. 2. 12. 김준영
	 */
	public static final String SOCIETY_FAP_AGENCY_SELECT_SELECT_JOB_AD_LOAD_LIST_PAGING = SOCIETY_FAP_AGENCY + "/select_job_ad_load_list_paging";
	
	/*
	 * FAP 에이전시 채용공고 삭제; 2019. 2. 11. 김준영
	 */
	public static final String SOCIETY_FAP_AGENCY_JOB_AD_DELETE = SOCIETY_FAP_AGENCY + "/job_ad_delete";
	
	/*
	 * FAP 공지사항 관리; 2019. 2. 14.
	 */
	public static final String SOCIETY_FAP_ADMIN_NOTICE_MANAGEMENT = SOCIETY_FAP_ADMIN + "/notice_management";
	
	/*
	 * FAP 공지사항 등록폼; 2019. 2. 14.
	 */
	public static final String SOCIETY_FAP_ADMIN_NOTICE_INSERT_FORM = SOCIETY_FAP_ADMIN + "/notice_insert_form";
	
	/*
	 * FAP 공지사항 등록; 2019. 2. 14.
	 */
	public static final String SOCIETY_FAP_ADMIN_NOTICE_INSERT = SOCIETY_FAP_ADMIN + "/notice_insert";
	
	/*
	 * FAP 공지사항 수정폼; 2019. 2. 14.
	 */
	public static final String SOCIETY_FAP_ADMIN_NOTICE_UPDATE_FORM = SOCIETY_FAP_ADMIN + "/notice_update_form";
	
	/*
	 * FAP 공지사항 수정; 2019. 2. 14.
	 */
	public static final String SOCIETY_FAP_ADMIN_NOTICE_UPDATE = SOCIETY_FAP_ADMIN + "/notice_update";
	
	/*
	 * FAP 공지사항 게시글 리스트; 2019. 2. 15. 김준영
	 */
	public static final String SOCIETY_FAP_ADMIN_FAP_NOTICE_MANAGEMENT = SOCIETY_FAP_ADMIN + "/fap_notice_management";
	
	/*
	 * FAP 공지사항 읽기; 2019. 2. 20. 김준영
	 */
	public static final String SOCIETY_FAP_ADMIN_NOTICE_CONTENTS_DETAIL = SOCIETY_FAP_ADMIN + "/notice_contents_detail";
	
	/*
	 * FAP 공지사항 삭제; 2019. 2. 20. 김준영
	 */
	public static final String SOCIETY_FAP_ADMIN_NOTICE_DELETE = SOCIETY_FAP_ADMIN + "/notice_delete";
	
	/*
	 * FAP 회원 메뉴 체크; 2019. 2. 22. 김준영
	 */
	public static final String SOCIETY_FAP_USER_USER_MENU_CHECK = SOCIETY_FAP_USER + "/user_menu_check";
	
	/*
	 * FAP 회원 학교 정보 입력; 2019. 2. 25. 김준영
	 */
	public static final String SOCIETY_FAP_USER_INSERT_SCHOOL = SOCIETY_FAP_USER + "/user_insert_school";
	
	/**
	 * 
	 * FAP 김준영 끝
	 * 
	 */
	
	/**
	 * 
	 * FAP 신동철 시작
	 * 
	 */
	
	/**
	 * FAP 잡페어 관리자 등록 폼 페이지; 2018. 12. 3. 신동철
	 */
	public static final String SOCIETY_FAP_ADMIN_JOBFAIR_INSERT_FORM = SOCIETY_FAP_ADMIN + "/jobfair_insert_form";
	
	/**
	 * FAP 잡페어 등록; 2018. 12. 3. 신동철
	 */
	public static final String SOCIETY_FAP_ADMIN_JOBFAIR_INSERT = SOCIETY_FAP_ADMIN + "/jobfair_insert";
	
	/**
	 * FAP 잡페어 관리; 2018. 12. 4. 신동철
	 */
	public static final String SOCIETY_FAP_ADMIN_JOBFAIR_MANAGEMENT = SOCIETY_FAP_ADMIN + "/jobfair_management";
	
	/**
	 * FAP 잡페어 관리 폼; 2018. 12. 4. 신동철
	 */
	public static final String SOCIETY_FAP_ADMIN_JOBFAIR_MANAGEMENT_FORM = SOCIETY_FAP_ADMIN + "/jobfair_management_form";
	
	/**
	 * FAP 잡페어 리스트 검색(잡페어 모든 항목); 2018. 12. 4. 신동철
	 */
	public static final String SOCIETY_FAP_ADMIN_JOBFAIR_LIST_SEARCH = SOCIETY_FAP_ADMIN + "/jobfair_list_search";
	
	/**
	 * FAP 잡페어 리스트 검색(기본 잡페어 정보만); 2018. 12. 4. 신동철
	 */
	public static final String SOCIETY_FAP_ADMIN_JOBFAIR_SEARCH_LIST = SOCIETY_FAP_ADMIN + "/jobfair_search_list";
	
	/**
	 * FAP 잡페어 선택 검색; 2018. 12. 4. 신동철
	 */
	public static final String SOCIETY_FAP_ADMIN_JOBFAIR_SEARCH = SOCIETY_FAP_ADMIN + "/jobfair_search";
	
	/**
	 * FAP 잡페어 세부사항 정보 검색; 2018. 12. 14. 신동철
	 */
	public static final String SOCIETY_FAP_ADMIN_JOBFAIR_DIVIDE_SEARCH = SOCIETY_FAP_ADMIN + "/jobfair_divide_search";
	
	/**
	 * FAP 잡페어 수정; 2018. 12. 14. 신동철
	 */
	public static final String SOCIETY_FAP_ADMIN_JOBFAIR_UPDATE = SOCIETY_FAP_ADMIN + "/jobfair_update";
	
	/**
	 * FAP 잡페어 수정폼; 2018. 12. 14. 신동철
	 */
	public static final String SOCIETY_FAP_ADMIN_JOBFAIR_UPDATE_FORM = SOCIETY_FAP_ADMIN + "/jobfair_update_form";
	
	/**
	 * FAP 잡페어 삭제; 2018. 12. 14. 신동철
	 */
	public static final String SOCIETY_FAP_ADMIN_JOBFAIR_DELETE = SOCIETY_FAP_ADMIN + "/jobfair_delete";
	
	/**
	 * FAP 잡페어 승인페이지 이동; 2018. 12. 20. 신동철
	 */
	public static final String SOCIETY_FAP_ADMIN_JOBFAIR_PERMISSION = SOCIETY_FAP_ADMIN + "/jobfair_permission";
	
	/**
	 * FAP 잡페어 승인 폼; 2018. 12. 30. 신동철
	 */
	public static final String SOCIETY_FAP_ADMIN_JOBFAIR_PERMISSION_FORM = SOCIETY_FAP_ADMIN + "/jobfair_permission_form";
	
	/**
	 * FAP 잡페어 지원자 등록정보  검색; 2018. 12. 4. 신동철
	 */
	public static final String SOCIETY_FAP_ADMIN_JOBFAIR_SEARCH_USER_APPLY_INFO = SOCIETY_FAP_ADMIN + "/search_jobfair_user_apply_info";
	
	/**
	 * FAP 잡페어 지원자 학력정보 검색
	 * */
	public static final String SOCIETY_FAP_ADMIN_JOBFAIR_SEARCH_USER_EDU_INFO = SOCIETY_FAP_ADMIN + "/search_jobfair_user_edu_info";
	
	/**
	 * FAP 잡페어 지원자 신청 승인; 2018. 12. 20. 신동철
	 */
	public static final String SOCIETY_FAP_ADMIN_JOBFAIR_USER_APPLY_PERMISSION = SOCIETY_FAP_ADMIN + "/jobfair_user_apply_permission";

	/**
	 * FAP 잡페어 리스트 검색; 2018. 12. 24. 신동철
	 */
	public static final String SOCIETY_FAP_COMPANY_JOBFAIR_SEARCH_LIST = SOCIETY_FAP_COMPANY + "/jobfair_search_list";
	
	/**
	 * FAP 잡페어 채용기업 참가; 2018. 12. 24. 신동철
	 */
	public static final String SOCIETY_FAP_COMPANY_JOBFAIR_PARTICIPATION = SOCIETY_FAP_COMPANY + "/company_jobfair_participation";
	
	/**
	 * FAP 잡페어 채용기업 참가 폼; 2018. 12. 24. 신동철
	 */
	public static final String SOCIETY_FAP_COMPANY_JOBFAIR_PARTICIPATION_FORM = SOCIETY_FAP_COMPANY + "/company_jobfair_participation_form";
	
	/**
	 * FAP 잡페어 채용기업 세부 참가; 2018. 12. 24. 신동철
	 */
	public static final String SOCIETY_FAP_COMPANY_JOBFAIR_DIVIDE_PARTICIPATION = SOCIETY_FAP_COMPANY + "/company_jobfair_divide_participation";
	
	/**
	 * FAP 전형일정 캘린더; 2018. 12. 27. 신동철
	 */
	public static final String SOCIETY_FAP_ADMIN_PROCESS_SCHEDULE_CALENDAR = SOCIETY_FAP_ADMIN + "/process_schedule_calendar";
	
	/**
	 * FAP 전형일정 캘린더 폼; 2018. 12. 27. 신동철
	 */
	public static final String SOCIETY_FAP_ADMIN_PROCESS_SCHEDULE_CALENDAR_FORM = SOCIETY_FAP_ADMIN + "/process_schedule_calendar_form";
	
	/**
	 * FAP 회사 내정서류 관리; 2018. 12. 31. 신동철
	 */
	public static final String SOCIETY_FAP_COMPANY_REQUIRED_DOC_MANAGEMENT = SOCIETY_FAP_COMPANY + "/company_required_doc_management";

	/**
	 * FAP 회사 내정서류 관리 폼; 2018. 12. 31. 신동철
	 */
	public static final String SOCIETY_FAP_COMPANY_REQUIRED_DOC_MANAGEMENT_FORM = SOCIETY_FAP_COMPANY + "/company_required_doc_management_form";
	
	/**
	 * FAP 회사 공통내정서류 등록; 2019. 1. 1. 신동철
	 */
	public static final String SOCIETY_FAP_COMPANY_COMMON_REQUIRED_DOC_INSERT = SOCIETY_FAP_COMPANY + "/company_common_required_doc_insert";
	
	/**
	 * FAP 회사 공통내정서류 삭제; 2019. 1. 1. 신동철
	 */
	public static final String SOCIETY_FAP_COMPANY_COMMON_REQUIRED_DOC_DELETE = SOCIETY_FAP_COMPANY + "/company_common_required_doc_delete";
	
	/**
	 * FAP 회사 공통내정서류 리스트 검색; 2019. 1. 1. 신동철
	 */
	public static final String SOCIETY_FAP_COMPANY_COMMON_REQUIRED_DOC_SEARCH_LIST = SOCIETY_FAP_COMPANY + "/company_common_required_doc_search_list";
	
	/**
	 * FAP 회사 특정 공통내정서류 검색; 2019. 1. 2. 신동철
	 */
	public static final String SOCIETY_FAP_COMPANY_COMMON_REQUIRED_DOC_SEARCH = SOCIETY_FAP_COMPANY + "/company_common_required_doc_search";

	/**
	 * FAP 회사 공통내정서류 다운로드; 2019. 1. 2. 신동철
	 */
	public static final String SOCIETY_FAP_COMPANY_COMMON_REQUIRED_DOC_DOWNLOAD = SOCIETY_FAP_COMPANY + "/company_common_required_doc_download";

	/**
	 * FAP 회사 공통내정서류 수정; 2019. 1. 2. 신동철
	 */
	public static final String SOCIETY_FAP_COMPANY_COMMON_REQUIRED_DOC_UPDATE = SOCIETY_FAP_COMPANY + "/company_common_required_doc_update";
	
	/**
	 * FAP 회사가 참가한 채용공고 리스트 검색; 2019. 1. 5. 신동철
	 */
	public static final String SOCIETY_FAP_COMPANY_JOB_AD_SEARCH_LIST = SOCIETY_FAP_COMPANY + "/company_job_ad_search_list";
	
	/**
	 * FAP 회사의 내정자 정보 리스트 검색; 2019. 1. 5. 신동철
	 */
	public static final String SOCIETY_FAP_COMPANY_NOMINEE_INFO_SEARCH_LIST = SOCIETY_FAP_COMPANY + "/company_nominee_info_search_list";

	/**
	 * FAP 회사 개인내정서류 관리; 2019. 1. 7. 신동철
	 */
	public static final String SOCIETY_FAP_COMPANY_PERSONAL_REQUIRED_DOC_MANAGEMENT = SOCIETY_FAP_COMPANY + "/company_personal_required_doc_management";
	
	/**
	 * FAP 회사 개인내정서류 관리폼; 2019. 1. 7. 신동철
	 */
	public static final String SOCIETY_FAP_COMPANY_PERSONAL_REQUIRED_DOC_MANAGEMENT_FORM = SOCIETY_FAP_COMPANY + "/company_personal_required_doc_management_form";
	
	/**
	 * FAP 개인 내정서류 등록; 2019. 1. 7. 신동철
	 */
	public static final String SOCIETY_FAP_COMPANY_PERSONAL_REQUIRED_DOC_INSERT = SOCIETY_FAP_COMPANY + "/company_personal_required_doc_insert";
	
	/**
	 * FAP 개인 내정서류 리스트 검색; 2019. 1. 7. 신동철
	 */
	public static final String SOCIETY_FAP_COMPANY_PERSONAL_REQUIRED_DOC_SEARCH_LIST = SOCIETY_FAP_COMPANY + "/company_personal_required_doc_search_list";
	
	/**
	 * FAP 개인 내정서류 수정; 2019. 1. 7. 신동철
	 */
	public static final String SOCIETY_FAP_COMPANY_PERSONAL_REQUIRED_DOC_UPDATE = SOCIETY_FAP_COMPANY + "/company_personal_required_doc_update";
	/**

	 * FAP 특정 개인 내정서류 검색; 2019. 1. 7. 신동철
	 */
	public static final String SOCIETY_FAP_COMPANY_PERSONAL_REQUIRED_DOC_SEARCH = SOCIETY_FAP_COMPANY + "/company_personal_required_doc_search";
	
	/**
	 * FAP 개인 내정서류 삭제; 2019. 1. 7. 신동철
	 */
	public static final String SOCIETY_FAP_COMPANY_PERSONAL_REQUIRED_DOC_DELETE = SOCIETY_FAP_COMPANY + "/company_personal_required_doc_delete";
	
	/**
	 * FAP 내정자 정보 검색; 2019. 1. 7. 신동철
	 */
	public static final String SOCIETY_FAP_COMPANY_NOMINEE_INFO_SEARCH = SOCIETY_FAP_COMPANY + "/company_nominee_info_search";
	
	/**
	 * FAP 개인취업자 내정서류 관리; 2019. 1. 8. 신동철
	 */
	public static final String SOCIETY_FAP_USER_REQUIRED_DOC_MANAGEMENT = SOCIETY_FAP_USER + "/user_required_doc_management";
	
	/**
	 * FAP 개인취업자 내정서류 관리; 2019. 1. 8. 신동철
	 */
	public static final String SOCIETY_FAP_USER_REQUIRED_DOC_MANAGEMENT_FORM = SOCIETY_FAP_USER + "/user_required_doc_management_form";
	
	/**
	 * FAP 개인취업자 공통 내정서류 리스트 검색; 2019. 1. 8. 신동철
	 */
	public static final String SOCIETY_FAP_USER_COMMON_REQUIRED_DOC_SEARCH_LIST = SOCIETY_FAP_USER + "/user_common_required_doc_search_list";
	
	/**
	 * FAP 개인취업자 개인 내정서류 리스트 검색; 2019. 1. 8. 신동철
	 */
	public static final String SOCIETY_FAP_USER_PERSONAL_REQUIRED_DOC_SEARCH_LIST = SOCIETY_FAP_USER + "/user_personal_required_doc_search_list";
	
	/**
	 * FAP 개인취업자 내정서류 업로드; 2019. 1. 8. 신동철
	 */
	public static final String SOCIETY_FAP_USER_REQUIRED_DOC_INSERT = SOCIETY_FAP_USER + "/user_required_doc_insert";
	
	/**
	 * FAP 개인취업자 내정서류 검색; 2019. 1. 8. 신동철
	 */
	public static final String SOCIETY_FAP_USER_PERSONAL_REQUIRED_DOC_SEARCH = SOCIETY_FAP_USER + "/user_personal_required_doc_search";
	
	/**
	 * FAP 개인취업자 내정서류 수정; 2019. 1. 8. 신동철
	 */
	public static final String SOCIETY_FAP_USER_PERSONAL_REQUIRED_DOC_UPDATE = SOCIETY_FAP_USER + "/user_personal_required_doc_update";
	
	/**
	 * FAP 개인취업자 내정서류 삭제; 2019. 1. 8. 신동철
	 */
	public static final String SOCIETY_FAP_USER_PERSONAL_REQUIRED_DOC_DELETE = SOCIETY_FAP_USER + "/user_personal_required_doc_delete";
	
	/**
	 * FAP 채용전형 일정관리; 2019. 1. 10. 신동철
	 */
	public static final String SOCIETY_FAP_ADMIN_PROCESS_SCHEDULE_MANAGEMENT = SOCIETY_FAP_ADMIN + "/process_schedule_management";
	
	/**
	 * FAP 채용전형 일정관리 폼; 2019. 1. 10. 신동철
	 */
	public static final String SOCIETY_FAP_ADMIN_PROCESS_SCHEDULE_MANAGEMENT_FORM = SOCIETY_FAP_ADMIN + "/process_schedule_management_form";
	
	/**
	 * FAP 채용전형 정보 검색; 2019. 1. 10. 신동철
	 */
	public static final String SOCIETY_FAP_ADMIN_RECRUIT_PROCESS_INFO_SEARCH = SOCIETY_FAP_ADMIN + "/recruit_process_info_search";
	
	/**
	 * FAP 채용전형 정보 첨부파일 삭제; 2019. 9. 30. 김경아
	 */
	public static final String SOCIETY_FAP_ADMIN_DELETE_JOB_EXAM_FILE_UPLOADED = SOCIETY_FAP_ADMIN + "/delete_job_exam_file_uploaded";
	/**
	 * FAP 채용전형 정보 검색; 2019. 1. 10. 신동철
	 */
	public static final String SOCIETY_FAP_ADMIN_JOB_AD_INFO_SEARCH = SOCIETY_FAP_ADMIN + "/job_ad_info_search";

	/**
	 * FAP 서류전형 정보 검색; 2019. 1. 10. 신동철
	 */
	public static final String SOCIETY_FAP_ADMIN_REVIEW_PROCESS_SELECT = SOCIETY_FAP_ADMIN + "/review_process_select";
	
	/**
	 * FAP 시험전형 정보 검색; 2019. 1. 10. 신동철
	 */
	public static final String SOCIETY_FAP_ADMIN_EXAM_PROCESS_SELECT = SOCIETY_FAP_ADMIN + "/exam_process_select";
	
	/**
	 * FAP 면접전형 정보 검색; 2019. 1. 10. 신동철
	 */
	public static final String SOCIETY_FAP_ADMIN_INTERVIEW_PROCESS_SELECT = SOCIETY_FAP_ADMIN + "/interview_process_select";
	
	/**
	 * FAP 기타전형 정보 검색; 2019. 1. 10. 신동철
	 */
	public static final String SOCIETY_FAP_ADMIN_TEST_ETC_PROCESS_SELECT = SOCIETY_FAP_ADMIN + "/test_etc_process_select";
	
	/**
	 * FAP 서류전형 스케줄 설정; 2019. 1. 13. 신동철
	 */
	public static final String SOCIETY_FAP_ADMIN_REVIEW_PROCESS_SCHEDULE_UPDATE = SOCIETY_FAP_ADMIN + "/review_process_schedule_update";
	
	/**
	 * FAP 시험전형 스케줄 설정; 2019. 1. 13. 신동철
	 */
	public static final String SOCIETY_FAP_ADMIN_EXAM_PROCESS_SCHEDULE_UPDATE = SOCIETY_FAP_ADMIN + "/exam_process_schedule_update";
	
	/**
	 * FAP 면접전형 스케줄 설정; 2019. 1. 13. 신동철
	 */
	public static final String SOCIETY_FAP_ADMIN_INTERVEIW_PROCESS_SCHEDULE_UPDATE = SOCIETY_FAP_ADMIN + "/interview_process_schedule_update";
	
	/**
	 * FAP 기타전형 스케줄 설정; 2019. 1. 13. 신동철
	 */
	public static final String SOCIETY_FAP_ADMIN_TEST_ETC_PROCESS_SCHEDULE_UPDATE = SOCIETY_FAP_ADMIN + "/test_etc_process_schedule_update";
	
	/**
	 * FAP 전형일정 스케줄 검색; 2019. 1. 14. 신동철
	 */
	public static final String SOCIETY_FAP_ADMIN_RECRUIT_PROCESS_SCHEDULE_SELECT = SOCIETY_FAP_ADMIN + "/recruit_process_schedule_select";
		
	/**
	 * FAP 서류전형 스케줄 설정; 2019. 1. 15. 신동철
	 */
	public static final String SOCIETY_FAP_ADMIN_REVIEW_PROCESS_SCHEDULE_CALENDAR_UPDATE = SOCIETY_FAP_ADMIN + "/review_process_schedule_calendar_update";
	
	/**
	 * FAP 시험전형 스케줄 설정; 2019. 1. 15. 신동철
	 */
	public static final String SOCIETY_FAP_ADMIN_EXAM_PROCESS_SCHEDULE_CALENDAR_UPDATE = SOCIETY_FAP_ADMIN + "/exam_process_schedule_calendar_update";
	
	/**
	 * FAP 면접전형 스케줄 설정; 2019. 1. 15. 신동철
	 */
	public static final String SOCIETY_FAP_ADMIN_INTERVEIW_PROCESS_SCHEDULE_CALENDAR_UPDATE = SOCIETY_FAP_ADMIN + "/interview_process_schedule_calendar_update";
	
	/**
	 * FAP 기타전형 스케줄 설정; 2019. 1. 15. 신동철
	 */
	public static final String SOCIETY_FAP_ADMIN_TEST_ETC_PROCESS_SCHEDULE_CALENDAR_UPDATE = SOCIETY_FAP_ADMIN + "/test_etc_process_schedule_calendar_update";

	/**
	 * FAP 채용기업 전형일정 캘린더; 2019. 1. 16. 신동철
	 */
	public static final String SOCIETY_FAP_COMPANY_PROCESS_SCHEDULE_CALENDAR = SOCIETY_FAP_COMPANY + "/company_process_schedule_calendar";
	
	/**
	 * FAP 채용기업 전형일정 캘린더 폼; 2019. 1. 16. 신동철
	 */
	public static final String SOCIETY_FAP_COMPANY_PROCESS_SCHEDULE_CALENDAR_FORM = SOCIETY_FAP_COMPANY + "/company_process_schedule_calendar_form";
	
	/**
	 * FAP 채용기업 채용전형 정보 검색; 2019. 1. 16. 신동철
	 */
	public static final String SOCIETY_FAP_COMPANY_RECRUIT_PROCESS_SCHEDULE_SELECT = SOCIETY_FAP_COMPANY + "/company_recruit_process_schedule_select";
	
	/**
	 * FAP 채용기업 참가한 세부잡페어 정보 검색; 2019. 1. 16. 신동철
	 */
	public static final String SOCIETY_FAP_COMPANY_JOBFAIR_DIVIDE_LIST_SEARCH = SOCIETY_FAP_COMPANY + "/company_jobfair_divide_list_search";
	
	/**
	 * FAP 채용기업 서류전형 정보 검색; 2019. 1. 16. 신동철
	 */
	public static final String SOCIETY_FAP_COMPANY_REVIEW_PROCESS_SELECT = SOCIETY_FAP_COMPANY + "/company_review_process_select";
	
	/**
	 * FAP 채용기업 서류전형 정보 검색; 2019. 1. 16. 신동철
	 */
	public static final String SOCIETY_FAP_COMPANY_EXAM_PROCESS_SELECT = SOCIETY_FAP_COMPANY + "/company_exam_process_select";
	
	/**
	 * FAP 채용기업 면접전형 정보 검색; 2019. 1. 16. 신동철
	 */
	public static final String SOCIETY_FAP_COMPANY_ITV_PROCESS_SELECT = SOCIETY_FAP_COMPANY + "/company_itv_process_select";
	
	/**
	 * FAP 채용기업 기타전형 정보 검색; 2019. 1. 16. 신동철
	 */
	public static final String SOCIETY_FAP_COMPANY_TEST_ETC_PROCESS_SELECT = SOCIETY_FAP_COMPANY + "/company_test_etc_process_select";
	
	/**
	 * FAP 지원자 전형일정 캘린더; 2019. 1. 16. 신동철
	 */
	public static final String SOCIETY_FAP_USER_PROCESS_SCHEDULE_CALENDAR = SOCIETY_FAP_USER + "/user_process_schedule_calendar";
	
	/**
	 * FAP 지원자 전형일정 캘린더 폼; 2019. 1. 16. 신동철
	 */
	public static final String SOCIETY_FAP_USER_PROCESS_SCHEDULE_CALENDAR_FORM = SOCIETY_FAP_USER + "/user_process_schedule_calendar_form";
	
	/**
	 * FAP 지원자 채용전형 정보 검색; 2019. 1. 16. 신동철
	 */
	public static final String SOCIETY_FAP_USER_RECRUIT_PROCESS_SCHEDULE_SELECT = SOCIETY_FAP_USER + "/user_recruit_process_schedule_select";
	
	/**
	 * FAP 지원자 서류전형 정보 검색; 2019. 1. 16. 신동철
	 */
	public static final String SOCIETY_FAP_USER_REVIEW_PROCESS_SELECT = SOCIETY_FAP_USER + "/user_review_process_select";
	
	/**
	 * FAP 지원자 서류전형 정보 검색; 2019. 1. 16. 신동철
	 */
	public static final String SOCIETY_FAP_USER_EXAM_PROCESS_SELECT = SOCIETY_FAP_USER + "/user_exam_process_select";
	
	/**
	 * FAP 지원자 면접전형 정보 검색; 2019. 1. 16. 신동철
	 */
	public static final String SOCIETY_FAP_USER_ITV_PROCESS_SELECT = SOCIETY_FAP_USER + "/user_itv_process_select";
	
	/**
	 * FAP 지원자 기타전형 정보 검색; 2019. 1. 16. 신동철
	 */
	public static final String SOCIETY_FAP_USER_TEST_ETC_PROCESS_SELECT = SOCIETY_FAP_USER + "/user_test_etc_process_select";
	
	/**
	 * FAP 관리자 내정서류 관리; 2019. 1. 17. 신동철
	 */
	public static final String SOCIETY_FAP_ADMIN_REQUIRED_DOC_MANAGEMENT = SOCIETY_FAP_ADMIN + "/required_doc_management";

	/**
	 * FAP 관리자 내정서류 관리 폼; 2019. 1. 17. 신동철
	 */
	public static final String SOCIETY_FAP_ADMIN_REQUIRED_DOC_MANAGEMENT_FORM = SOCIETY_FAP_ADMIN + "/required_doc_management_form";
	
	/**
	 * FAP 관리자 내정서류 관리 폼; 2019. 1. 18. 신동철
	 */
	public static final String SOCIETY_FAP_ADMIN_JOB_AD_LIST_SEARCH = SOCIETY_FAP_ADMIN + "/job_ad_list_search";
	
	/**
	 * FAP 관리자 공통내정서류 리스트 검색; 2019. 1. 18. 신동철
	 */
	public static final String SOCIETY_FAP_ADMIN_COMMON_REQUIRED_DOC_SEARCH_LIST = SOCIETY_FAP_ADMIN+ "/common_required_doc_search_list";
	
	/**
	 * FAP 관리자 회사 공통내정서류 등록; 2019. 1. 18. 신동철
	 */
	public static final String SOCIETY_FAP_ADMIN_COMMON_REQUIRED_DOC_INSERT = SOCIETY_FAP_ADMIN + "/common_required_doc_insert";
	
	/**
	 * FAP 해당잡페어의 채용공고에 승인받은 회사 목록 검색; 2019. 1. 19. 신동철
	 */
	public static final String SOCIETY_FAP_ADMIN_JOB_AD_COMP_LIST_SELECT = SOCIETY_FAP_ADMIN + "/job_ad_comp_list_select";
	
	/**
	 * FAP 관리자 개인내정서류 관리; 2019. 1. 19. 신동철
	 */
	public static final String SOCIETY_FAP_ADMIN_PERSONAL_REQUIRED_DOC_MANAGEMENT = SOCIETY_FAP_ADMIN+ "/personal_required_doc_management";
	
	/**
	 * FAP 관리자 개인내정서류 관리폼; 2019. 1. 19. 신동철
	 */
	public static final String SOCIETY_FAP_ADMIN_PERSONAL_REQUIRED_DOC_MANAGEMENT_FORM = SOCIETY_FAP_ADMIN + "/personal_required_doc_management_form";
	
	/**
	 * FAP 관리자 특정 공통내정서류 검색; 2019. 1. 19. 신동철
	 */
	public static final String SOCIETY_FAP_ADMIN_COMMON_REQUIRED_DOC_SELECT = SOCIETY_FAP_ADMIN+ "/common_required_doc_select";
	
	/**
	 * FAP 관리자 공통내정서류 수정; 2019. 1. 19. 신동철
	 */
	public static final String SOCIETY_FAP_ADMIN_COMMON_REQUIRED_DOC_UPDATE = SOCIETY_FAP_ADMIN + "/common_required_doc_update";
	
	/**
	 * FAP 관리자 공통내정서류 다운로드; 2019. 1. 19. 신동철
	 */
	public static final String SOCIETY_FAP_ADMIN_COMMON_REQUIRED_DOC_DOWNLOAD = SOCIETY_FAP_ADMIN + "/common_required_doc_download";
	
	/**
	 * FAP 관리자 공통내정서류 삭제; 2019. 1. 19. 신동철
	 */
	public static final String SOCIETY_FAP_ADMIN_COMMON_REQUIRED_DOC_DELETE = SOCIETY_FAP_ADMIN + "/common_required_doc_delete";
	
	/**
	 * FAP 관리자 개인 내정서류 리스트 검색; 2019. 1. 19. 신동철
	 */
	public static final String SOCIETY_FAP_ADMIN_PERSONAL_REQUIRED_DOC_SEARCH_LIST = SOCIETY_FAP_ADMIN + "/personal_required_doc_search_list";
	
	
	/**
	 * FAP 관리자 내정자 정보 리스트 검색: 2019. 6. 11. 김경아
	 */
	public static final String SOCIETY_FAP_ADMIN_NOMINEE_INFO_SEARCH_LIST	= SOCIETY_FAP_ADMIN + "/nominee_info_search_list";
	
	/**
	 * FAP 관리자 내정자 정보 검색; 2019. 1. 19. 신동철
	 */
	public static final String SOCIETY_FAP_ADMIN_NOMINEE_INFO_SEARCH = SOCIETY_FAP_ADMIN + "/nominee_info_search";
	
	/**
	 * FAP 관리자 개인 내정서류 등록; 2019. 1. 19. 신동철
	 */
	public static final String SOCIETY_FAP_ADMIN_PERSONAL_REQUIRED_DOC_INSERT = SOCIETY_FAP_ADMIN + "/personal_required_doc_insert";
	
	/**
	 * FAP 개인 내정서류 수정; 2019. 1. 19. 신동철
	 */
	public static final String SOCIETY_FAP_ADMIN_PERSONAL_REQUIRED_DOC_UPDATE = SOCIETY_FAP_ADMIN + "/personal_required_doc_update";
	/**
	
	/**
	 * FAP 개인 내정서류 삭제; 2019. 1. 19. 신동철
	 */
	public static final String SOCIETY_FAP_ADMIN_PERSONAL_REQUIRED_DOC_DELETE = SOCIETY_FAP_ADMIN + "/personal_required_doc_delete";
	
	/**
	 * FAP 관리자 개인취업자 내정서류 업로드; 2019. 1. 19. 신동철
	 */
	public static final String SOCIETY_FAP_ADMIN_NOMINEE_REQUIRED_DOC_INSERT = SOCIETY_FAP_ADMIN + "/nominee_required_doc_insert";
	
	/**
	 * FAP 채용기업 메인 공지사항 검색; 2019. 1. 23. 신동철
	 */
	public static final String SOCIETY_FAP_COMPANY_BOARD_CONTENTS_SEARCH = SOCIETY_FAP_COMPANY + "/company_board_contents_search";
	
	/**
	 * FAP 채용기업 메인 공지사항 세부내용 검색; 2019. 1. 23. 신동철
	 */
	public static final String SOCIETY_FAP_COMPANY_BOARD_CONTENTS_DETAIL = SOCIETY_FAP_COMPANY + "/company_board_contents_datail";
	
	/**
	 * FAP 채용기업 메인 공지사항 세부내용 검색폼; 2019. 1. 23. 신동철
	 */
	public static final String SOCIETY_FAP_COMPANY_BOARD_CONTENTS_DETAIL_FORM = SOCIETY_FAP_COMPANY + "/company_board_contents_detail_form";
	
	/**
	 * FAP 채용기업 메인 공지사항 리스트 검색; 2019. 1. 24. 신동철
	 */
	public static final String SOCIETY_FAP_COMPANY_BOARD_CONTENT_LIST_SEARCH = SOCIETY_FAP_COMPANY + "/company_board_content_list_search";
	
	/**
	 * FAP 채용기업 메인 공지사항 리스트 페이지; 2019. 1. 24. 신동철
	 */
	public static final String SOCIETY_FAP_COMPANY_BOARD_CONTENT_LIST = SOCIETY_FAP_COMPANY + "/company_board_content_list";
	
	/**
	 * FAP 채용기업 채용공고 리스트 검색; 2019. 1. 24. 신동철
	 */
	public static final String SOCIETY_FAP_COMPANY_JOB_AD_LIST_SEARCH = SOCIETY_FAP_COMPANY + "/company_job_ad_list_search";
	
	/**
	 * FAP 에이전시 메인 공지사항 검색; 2019. 1. 28. 신동철
	 */
	public static final String SOCIETY_FAP_AGENCY_BOARD_CONTENTS_SEARCH = SOCIETY_FAP_AGENCY + "/agency_board_contents_search";
	
	/**
	 * FAP 에이전시 메인 공지사항 세부내용 검색; 2019. 1. 28. 신동철
	 */
	public static final String SOCIETY_FAP_AGENCY_BOARD_CONTENTS_DETAIL = SOCIETY_FAP_AGENCY + "/agency_board_contents_datail";
	
	/**
	 * FAP 에이전시 메인 공지사항 세부내용 검색폼; 2019. 1. 28. 신동철
	 */
	public static final String SOCIETY_FAP_AGENCY_BOARD_CONTENTS_DETAIL_FORM = SOCIETY_FAP_AGENCY+ "/agency_board_contents_detail_form";
	
	/**
	 * FAP 에이전시 메인 공지사항 리스트 검색; 2019. 1. 28. 신동철
	 */
	public static final String SOCIETY_FAP_AGENCY_BOARD_CONTENT_LIST_SEARCH = SOCIETY_FAP_AGENCY + "/agency_board_content_list_search";
	
	/**
	 * FAP 에이전시 메인 공지사항 리스트 페이지; 2019. 1. 28. 신동철
	 */
	public static final String SOCIETY_FAP_AGENCY_BOARD_CONTENT_LIST = SOCIETY_FAP_AGENCY + "/agency_board_content_list";
	
	/**
	 * FAP 에이전시 전형일정 캘린더; 2019. 1. 29. 신동철
	 */
	public static final String SOCIETY_FAP_AGENCY_PROCESS_SCHEDULE_CALENDAR = SOCIETY_FAP_AGENCY + "/agency_process_schedule_calendar";
	
	/**
	 * FAP 에이전시 전형일정 캘린더 폼; 2019. 1. 29. 신동철
	 */
	public static final String SOCIETY_FAP_AGENCY_PROCESS_SCHEDULE_CALENDAR_FORM = SOCIETY_FAP_AGENCY + "/agency_process_schedule_calendar_form";
	
	/**
	 * FAP 에이전시 채용전형 정보 검색; 2019. 1. 29. 신동철
	 */
	public static final String SOCIETY_FAP_AGENCY_RECRUIT_PROCESS_SCHEDULE_SELECT = SOCIETY_FAP_AGENCY + "/agency_recruit_process_schedule_select";
	
	/**
	 * FAP 에이전시 참가한 세부잡페어 정보 검색; 2019. 1. 29. 신동철
	 */
	public static final String SOCIETY_FAP_AGENCY_JOBFAIR_DIVIDE_LIST_SEARCH = SOCIETY_FAP_AGENCY + "/agency_jobfair_divide_list_search";
	
	/**
	 * FAP 에이전시 서류전형 정보 검색; 2019. 1. 29. 신동철
	 */
	public static final String SOCIETY_FAP_AGENCY_REVIEW_PROCESS_SELECT = SOCIETY_FAP_AGENCY + "/agency_review_process_select";
	
	/**
	 * FAP 에이전시 서류전형 정보 검색; 2019. 1. 29. 신동철
	 */
	public static final String SOCIETY_FAP_AGENCY_EXAM_PROCESS_SELECT = SOCIETY_FAP_AGENCY + "/agency_exam_process_select";
	
	/**
	 * FAP 에이전시 면접전형 정보 검색; 2019. 1. 29. 신동철
	 */
	public static final String SOCIETY_FAP_AGENCY_ITV_PROCESS_SELECT = SOCIETY_FAP_AGENCY + "/agency_itv_process_select";
	
	/**
	 * FAP 에이전시 기타전형 정보 검색; 2019. 1. 29. 신동철
	 */
	public static final String SOCIETY_FAP_AGENCY_TEST_ETC_PROCESS_SELECT = SOCIETY_FAP_AGENCY + "/agency_test_etc_process_select";
	
	/**
	 * FAP 에이전시 내정서류 관리; 2019. 1. 29. 신동철
	 */
	public static final String SOCIETY_FAP_AGENCY_REQUIRED_DOC_MANAGEMENT = SOCIETY_FAP_AGENCY + "/agency_required_doc_management";

	/**
	 * FAP 에이전시 내정서류 관리 폼; 2019. 1. 29. 신동철
	 */
	public static final String SOCIETY_FAP_AGENCY_REQUIRED_DOC_MANAGEMENT_FORM = SOCIETY_FAP_AGENCY + "/agency_required_doc_management_form";
	
	/**
	 * FAP 에이전시 공통내정서류 등록; 2019. 1. 29. 신동철
	 */
	public static final String SOCIETY_FAP_AGENCY_COMMON_REQUIRED_DOC_INSERT = SOCIETY_FAP_AGENCY + "/agency_common_required_doc_insert";
	
	/**
	 * FAP 에이전시 공통내정서류 삭제; 2019. 1. 29. 신동철
	 */
	public static final String SOCIETY_FAP_AGENCY_COMMON_REQUIRED_DOC_DELETE = SOCIETY_FAP_AGENCY + "/agency_common_required_doc_delete";
	
	/**
	 * FAP 에이전시 공통내정서류 리스트 검색; 2019. 1. 29. 신동철
	 */
	public static final String SOCIETY_FAP_AGENCY_COMMON_REQUIRED_DOC_SEARCH_LIST = SOCIETY_FAP_AGENCY + "/agency_common_required_doc_search_list";
	
	/**
	 * FAP 에이전시 특정 공통내정서류 검색; 2019. 1. 29. 신동철
	 */
	public static final String SOCIETY_FAP_AGENCY_COMMON_REQUIRED_DOC_SEARCH = SOCIETY_FAP_AGENCY + "/agency_common_required_doc_search";

	/**
	 * FAP 에이전시 공통내정서류 다운로드; 2019. 1. 29. 신동철
	 */
	public static final String SOCIETY_FAP_AGENCY_COMMON_REQUIRED_DOC_DOWNLOAD = SOCIETY_FAP_AGENCY + "/agency_common_required_doc_download";

	/**
	 * FAP 에이전시 공통내정서류 수정; 2019. 1. 29. 신동철
	 */
	public static final String SOCIETY_FAP_AGENCY_COMMON_REQUIRED_DOC_UPDATE = SOCIETY_FAP_AGENCY + "/agency_common_required_doc_update";
	
	/**
	 * FAP 에이전시가 참가한 채용공고 리스트 검색; 2019. 1. 29. 신동철
	 */
	public static final String SOCIETY_FAP_AGENCY_JOB_AD_SEARCH_LIST = SOCIETY_FAP_AGENCY + "/agency_job_ad_search_list";
	
	/**
	 * FAP 에이전시의 내정자 정보 리스트 검색; 2019. 1. 29. 신동철
	 */
	public static final String SOCIETY_FAP_AGENCY_NOMINEE_INFO_SEARCH_LIST = SOCIETY_FAP_AGENCY + "/agency_nominee_info_search_list";

	/**
	 * FAP 에이전시 개인내정서류 관리; 2019. 1. 29. 신동철
	 */
	public static final String SOCIETY_FAP_AGENCY_PERSONAL_REQUIRED_DOC_MANAGEMENT = SOCIETY_FAP_AGENCY + "/agency_personal_required_doc_management";
	
	/**
	 * FAP 에이전시 개인내정서류 관리폼; 2019. 1. 29. 신동철
	 */
	public static final String SOCIETY_FAP_AGENCY_PERSONAL_REQUIRED_DOC_MANAGEMENT_FORM = SOCIETY_FAP_AGENCY + "/agency_personal_required_doc_management_form";
	
	/**
	 * FAP 에이전시 개인 내정서류 등록; 2019. 1. 29. 신동철
	 */
	public static final String SOCIETY_FAP_AGENCY_PERSONAL_REQUIRED_DOC_INSERT = SOCIETY_FAP_AGENCY + "/agency_personal_required_doc_insert";
	
	/**
	 * FAP 에이전시 개인 내정서류 리스트 검색; 2019. 1. 29. 신동철
	 */
	public static final String SOCIETY_FAP_AGENCY_PERSONAL_REQUIRED_DOC_SEARCH_LIST = SOCIETY_FAP_AGENCY + "/agency_personal_required_doc_search_list";
	
	/**
	 * FAP 에이전시 개인 내정서류 수정; 2019. 1. 29. 신동철
	 */
	public static final String SOCIETY_FAP_AGENCY_PERSONAL_REQUIRED_DOC_UPDATE = SOCIETY_FAP_AGENCY + "/agency_personal_required_doc_update";
	/**

	 * FAP 에이전시 특정 개인 내정서류 검색; 2019. 1. 29. 신동철
	 */
	public static final String SOCIETY_FAP_AGENCY_PERSONAL_REQUIRED_DOC_SEARCH = SOCIETY_FAP_AGENCY + "/agency_personal_required_doc_search";
	
	/**
	 * FAP 에이전시 개인 내정서류 삭제; 2019. 1. 29. 신동철
	 */
	public static final String SOCIETY_FAP_AGENCY_PERSONAL_REQUIRED_DOC_DELETE = SOCIETY_FAP_AGENCY + "/agency_personal_required_doc_delete";
	
	/**
	 * FAP 에이전시 내정자 정보 검색; 2019. 1. 29. 신동철
	 */
	public static final String SOCIETY_FAP_AGENCY_NOMINEE_INFO_SEARCH = SOCIETY_FAP_AGENCY + "/agency_nominee_info_search";
	
	/**
	 * FAP 에이전시 언어변경 요청; 2019. 1. 29.  신동철
	 * */
	public static final String SOCIETY_FAP_AGENCY_LANGUAGE_CHANGE = SOCIETY_FAP_AGENCY + "/language_change";
	
	/**
	 * FAP 에이전시 잡페어 리스트 검색; 2019. 1. 30.  신동철
	 * */
	public static final String SOCIETY_FAP_AGENCY_COMPANY_JOBFAIR_LIST_SEARCH = SOCIETY_FAP_AGENCY + "/agency_company_jobfair_list_search";
	
	/**
	 * FAP 에이전시 회사가 참가하여 승인받은 채용공고 리스트 검색; 2019. 1. 30.  신동철
	 * */
	public static final String SOCIETY_FAP_AGENCY_JOB_AD_LIST_SEARCH = SOCIETY_FAP_AGENCY + "/agency_job_ad_list_search";
	
	/**
	 * FAP 기업 개인정보처리방침 페이지; 2019. 1. 31.  신동철
	 * */
	public static final String SOCIETY_FAP_COMPANY_TERMS_AND_CONDITION_POLICY = SOCIETY_FAP_COMPANY + "/company_terms_and_condition_policy";
	
	/**
	 * FAP 에이전시 개인정보처리방침 페이지; 2019. 1. 31.  신동철
	 * */
	public static final String SOCIETY_FAP_AGENCY_TERMS_AND_CONDITION_POLICY = SOCIETY_FAP_AGENCY + "/agency_terms_and_condition_policy";
	
	/**
	 * FAP 채용전형 지원자 정보 검색; 2019. 2. 15.  신동철
	 * */
	public static final String SOCIETY_FAP_COMPANY_SEARCH_APPLICANT_INFO = SOCIETY_FAP_COMPANY + "/search_applicant_info";
	
	/**
	 * FAP 채용공고 지원자관리 채용전형 정보 검색; 2019. 2. 15.  신동철
	 * */
	public static final String SOCIETY_FAP_COMPANY_SELECT_JOB_AD_RECRUIT_PCS = SOCIETY_FAP_COMPANY + "/select_job_ad_recruit_pcs";
	
	/**
	 * FAP 통합잡페어 공지사항 관리폼 이동; 2019. 2. 19.  신동철
	 * */
	public static final String SOCIETY_FAP_ADMIN_FAP_NOTICE_MANAGEMENT_FORM = SOCIETY_FAP_ADMIN + "/fap_notice_management_form";
	
	/**
	 * FAP 통합잡페어 참가한 기업 리스트; 2019. 2. 21.  신동철
	 * */
	public static final String SOCIETY_FAP_ADMIN_JOBFAIR_ATTENDED_COMP_LIST = SOCIETY_FAP_ADMIN + "/jobfair_attended_comp_list";
	
	/**
	 * FAP 통합잡페어 참가한 기업 리스트폼 이동; 2019. 2. 21.  신동철
	 * */
	public static final String SOCIETY_FAP_ADMIN_JOBFAIR_ATTENDED_COMP_LIST_FORM = SOCIETY_FAP_ADMIN + "/jobfair_attended_comp_list_form";
	
	/**
	 * FAP 통합잡페어 참가한 기업 리스트 검색; 2019. 2. 21.  신동철
	 * */
	public static final String SOCIETY_FAP_ADMIN_SEARCH_JOBFAIR_ATTENDED_COMP_LIST = SOCIETY_FAP_ADMIN + "/search_jobfair_attended_comp_list";
	
	/**
	 * FAP 채용공고 지원자 전형결과 수정; 2019. 2. 21.  신동철
	 * */
	public static final String SOCIETY_FAP_COMPANY_UPDATE_FAP_JOB_APPLY_RESULT = SOCIETY_FAP_COMPANY + "/update_fap_job_apply_result";
	
	/**
	 * FAP 채용공고 지원자 전형현황 관리폼 페이지 이동; 2019. 2. 21.  신동철
	 * */
	public static final String SOCIETY_FAP_COMPANY_APPLICANT_STAT_PER_JOB_AD_FORM = SOCIETY_FAP_COMPANY + "/applicant_status_per_job_ad";
	
	/**
	 * FAP 채용공고 지원자 합격사유 등록; 2019. 2. 22.  신동철
	 * */
	public static final String SOCIETY_FAP_COMPANY_INSERT_PASS_COMMENT = SOCIETY_FAP_COMPANY + "/insert_pass_comment";
	
	/**
	 * FAP 채용공고 지원자 전형결과 수정; 2019. 2. 24.  신동철
	 * */
	public static final String SOCIETY_FAP_COMPANY_UPDATE_MISSMATCHING_FAP_JOB_APPLY_RESULT = SOCIETY_FAP_COMPANY + "/update_missmatching_fap_job_apply_result";
	
	/**
	 * FAP 통합잡페어 지원자 지능가능 갯수 설정 페이지 이동; 2019. 2. 25.  신동철
	 * */
	public static final String SOCIETY_FAP_ADMIN_USER_APPLY_NUMBERS_MANAGEMENT = SOCIETY_FAP_ADMIN + "/user_apply_numbers_management";
	
	/**
	 * FAP 통합잡페어 지원자 지능가능 갯수 검색; 2019. 2. 25.  신동철
	 * */
	public static final String SOCIETY_FAP_ADMIN_SEARCH_USER_APPLY_NUMBERS = SOCIETY_FAP_ADMIN + "/search_user_apply_numbers";
	
	/**
	 * FAP 통합잡페어 지원자 지능가능 갯수 수정; 2019. 2. 25.  신동철
	 * */
	public static final String SOCIETY_FAP_ADMIN_UPDATE_USER_APPLY_NUMBERS = SOCIETY_FAP_ADMIN + "/update_user_apply_numbers";
	
	/**
	 * 게시물 파일 삭제; 2019. 3. 5.  신동철
	 * */
	public static final String SOCIETY_FAP_ADMIN_DELETE_BOARD_FILE = SOCIETY_FAP_ADMIN + "/delete_board_file";
	
	/**
	 * 게시물 파일 리스트 삭제; 2019. 3. 5.  신동철
	 * */
	public static final String SOCIETY_FAP_ADMIN_DELETE_BOARD_FILE_LIST = SOCIETY_FAP_ADMIN + "/delete_board_file_list";
	
	/**
	 * FAP 채용기업 메인 공지사항 검색; 2019. 3. 6. 신동철
	 */
	public static final String SOCIETY_FAP_USER_BOARD_CONTENTS_SEARCH = SOCIETY_FAP_USER + "/user_board_contents_search";
	
	/**
	 * FAP 잡페어 지원자 메인 공지사항 리스트 페이지; 2019. 3. 6. 신동철
	 */
	public static final String SOCIETY_FAP_USER_BOARD_CONTENT_LIST = SOCIETY_FAP_USER + "/user_board_content_list";
	
	/**
	 * FAP 잡페어 지원자 메인 공지사항 리스트 검색; 2019. 3. 6. 신동철
	 */
	public static final String SOCIETY_FAP_USER_BOARD_CONTENT_LIST_SEARCH = SOCIETY_FAP_USER + "/user_board_content_list_search";
	
	/**
	 * FAP 잡페어 지원자 메인 공지사항 세부내용 검색; 2019. 3. 6. 신동철
	 */
	public static final String SOCIETY_FAP_USER_BOARD_CONTENTS_DETAIL = SOCIETY_FAP_USER + "/user_board_contents_datail";
	
	/**
	 * FAP 잡페어 지원자 메인 공지사항 세부내용 검색폼; 2019. 3. 6. 신동철
	 */
	public static final String SOCIETY_FAP_USER_BOARD_CONTENTS_DETAIL_FORM = SOCIETY_FAP_USER + "/user_board_contents_detail_form";
	
	/**
	 * FAP 지원자 SES 회원서비스 페이지 이동; 2019. 07. 24. 김경아
	 */
	public static final String SOCIETY_FAP_USER_SES_USER_SERVICE = SOCIETY_FAP_USER + "/user_ses_user_service";
	
	/**
	 * FAP 지원자 2020 Fair 일정 페이지 이동; 2019. 07. 24. 김경아
	 */
	public static final String SOCIETY_FAP_USER_2020_FAIR_SCHEDULE = SOCIETY_FAP_USER + "/user_2020_fair_schedule";
	
	/**
	 * FAP 지원자 전형절차 페이지 이동; 2019. 07. 24. 김경아
	 */
	public static final String SOCIETY_FAP_USER_STEP = SOCIETY_FAP_USER + "/user_step";
	
	/**
	 * FAP 지원자 채용기업&파트너사 페이지 이동; 2019. 07. 24. 김경아
	 */
	public static final String SOCIETY_FAP_USER_COMPS_AND_PARTNERS = SOCIETY_FAP_USER + "/user_comps_and_partners";
	
	
	/**
	 * FAP 기업 SES 회원서비스 페이지 이동; 2019. 07. 24. 김경아
	 */
	public static final String SOCIETY_FAP_COMPANY_SES_USER_SERVICE = SOCIETY_FAP_COMPANY + "/company_ses_user_service";
	
	/**
	 * FAP 기업 2020 Fair 일정 페이지 이동; 2019. 07. 24. 김경아
	 */
	public static final String SOCIETY_FAP_COMPANY_2020_FAIR_SCHEDULE = SOCIETY_FAP_COMPANY + "/company_2020_fair_schedule";
	
	/**
	 * FAP 기업 전형절차 페이지 이동; 2019. 07. 24. 김경아
	 */
	public static final String SOCIETY_FAP_COMPANY_STEP = SOCIETY_FAP_COMPANY + "/company_step";
	
	/**
	 * FAP 기업 채용기업&파트너사 페이지 이동; 2019. 07. 24. 김경아
	 */
	public static final String SOCIETY_FAP_COMPANY_COMPS_AND_PARTNERS = SOCIETY_FAP_COMPANY + "/company_comps_and_partners";
	
	
	/**
	 * FAP 에이전시 SES 회원서비스 페이지 이동; 2019. 07. 24. 김경아
	 */
	public static final String SOCIETY_FAP_AGENCY_SES_USER_SERVICE = SOCIETY_FAP_AGENCY + "/agency_ses_user_service";
	
	/**
	 * FAP 에이전시 2020 Fair 일정 페이지 이동; 2019. 07. 24. 김경아
	 */
	public static final String SOCIETY_FAP_AGENCY_2020_FAIR_SCHEDULE = SOCIETY_FAP_AGENCY + "/agency_2020_fair_schedule";
	
	/**
	 * FAP 에이전시 전형절차 페이지 이동; 2019. 07. 24. 김경아
	 */
	public static final String SOCIETY_FAP_AGENCY_STEP = SOCIETY_FAP_AGENCY + "/agency_step";
	
	/**
	 * FAP 에이전시 채용기업&파트너사 페이지 이동; 2019. 07. 24. 김경아
	 */
	public static final String SOCIETY_FAP_AGENCY_COMPS_AND_PARTNERS = SOCIETY_FAP_AGENCY + "/agency_comps_and_partners";
	
		
	
	/**
	 * 잡페어 지원자 채용공고 질문 승인 페이지 이동; 2019. 3. 5.  신동철
	 * */
	public static final String SOCIETY_FAP_ADMIN_JOBFAIR_QNA_PERMISSION = SOCIETY_FAP_ADMIN + "/jobfair_qna_permission";
	
	/**
	 * 잡페어 지원자가 질문한 기업의 채용공고 검색; 2019. 3. 6.  신동철
	 * */
	public static final String SOCIETY_FAP_ADMIN_SEARCH_QNA_JOB_AD = SOCIETY_FAP_ADMIN + "/search_qna_job_ad";
	
	/**
	 * 잡페어 채용공고 Q&A 질문 정보 검색; 2019. 3. 6.  신동철
	 * */
	public static final String SOCIETY_FAP_ADMIN_SEARCH_JOB_QNA_QUESTION_INFO = SOCIETY_FAP_ADMIN + "/search_job_qna_question_info";
	
	/**
	 * 잡페어 지원자 채용공고 질문 승인; 2019. 3. 7.  신동철
	 * */
	public static final String SOCIETY_FAP_ADMIN_JOBFAIR_USER_QNA_PERMISSION = SOCIETY_FAP_ADMIN + "/jobfair_user_qna_permission";
	
	/**
	 * 잡페어 지원자 채용공고 질문 미승인; 2019. 3. 7.  신동철
	 * */
	public static final String SOCIETY_FAP_ADMIN_JOBFAIR_USER_QNA_NONPERMISSION = SOCIETY_FAP_ADMIN + "/jobfair_user_qna_nonpermission";
	
	/**
	 * 잡페어 지원자 채용공고 질문 미승인사유 등록; 2019. 3. 7.  신동철
	 * */
	public static final String SOCIETY_FAP_ADMIN_INSERT_QNA_QUESTION_REFUSE_REASON = SOCIETY_FAP_ADMIN + "/insert_qna_question_refuse_reason";
	
	/**
	 * 잡페어 지원자 채용공고 질문 미승인사유 수정; 2019. 3. 7.  신동철
	 * */
	public static final String SOCIETY_FAP_ADMIN_UPDATE_QNA_QUESTION_REFUSE_REASON = SOCIETY_FAP_ADMIN + "/update_qna_question_refuse_reason";
	
	/**
	 * 잡페어 잡페어 세부정보 검색; 2019. 3. 12.  신동철
	 * */
	public static final String SOCIETY_FAP_ADMIN_SELECT_JOBFAIR_DIVIDE_INFO = SOCIETY_FAP_ADMIN + "/select_jobfair_divide_info";
	
	/**
	 * FAP 에이전시채용공고 지원자 전형현황 관리폼 페이지 이동; 2019. 3. 13.  신동철
	 * */
	public static final String SOCIETY_FAP_AGENCY_APPLICANT_STAT_PER_JOB_AD = SOCIETY_FAP_AGENCY + "/agency_applicant_status_per_job_ad";
	
	/**
	 * FAP 에이전시 채용공고별 이력서 출력  2019. 03. 13. 신동철
	 */
	public static final String SOCIETY_FAP_AGENCY_APPLIED_RESUME_LIST= SOCIETY_FAP_AGENCY +"/applied_resume_list";
	
	/**
	 * FAP 에이전시 채용공고 지원자 전형결과 수정; 2019. 03. 13.  신동철
	 * */
	public static final String SOCIETY_FAP_AGENCY_UPDATE_FAP_JOB_APPLY_RESULT = SOCIETY_FAP_AGENCY + "/update_fap_job_apply_result";
	
	/**
	 * FAP 에이전시 채용공고 지원자 전형현황 관리폼 페이지 이동; 2019. 03. 13.  신동철
	 * */
	public static final String SOCIETY_FAP_AGENCY_APPLICANT_STAT_PER_JOB_AD_FORM = SOCIETY_FAP_AGENCY + "/agency_applicant_status_per_job_ad";
	
	/**
	 * FAP 에이전시 채용공고 지원자 합격사유 등록; 2019. 03. 13.  신동철
	 * */
	public static final String SOCIETY_FAP_AGENCY_INSERT_PASS_COMMENT = SOCIETY_FAP_AGENCY + "/insert_pass_comment";
	
	/**
	 * FAP 에이전시 채용공고 지원자 전형결과 수정; 2019. 03. 13.  신동철
	 * */
	public static final String SOCIETY_FAP_AGENCY_UPDATE_MISSMATCHING_FAP_JOB_APPLY_RESULT = SOCIETY_FAP_AGENCY + "/update_missmatching_fap_job_apply_result";
	
	/**
	 * 잡페어 세부별 최종합격자 결정 시한 설정 페이지; 2019. 3. 13.  신동철
	 * */
	public static final String SOCIETY_FAP_ADMIN_JOBFAIR_DIVIDE_FINAL_SELECT = SOCIETY_FAP_ADMIN + "/jobfair_divide_final_select";
	
	/**
	 * 잡페어 세부별 최종합격자 결정 시한 설정 정보 검색; 2019. 3. 14.  신동철
	 * */
	public static final String SOCIETY_FAP_ADMIN_SEARCH_JOBFAIR_DIVIDE_FINAL_SELECT_INFO = SOCIETY_FAP_ADMIN + "/search_jobfair_divide_final_select_info";
	
	/**
	 * 잡페어 세부별 최종합격자 결정 시한 알림 등록; 2019. 3. 14.  신동철
	 * */
	public static final String SOCIETY_FAP_ADMIN_INSERT_FAP_JOBFAIR_DIVIDE_FINAL_SELECT = SOCIETY_FAP_ADMIN + "/insert_fap_jobfair_divide_final_select";
	
	
	/**
	 * 
	 * FAP 신동철 끝
	 * 
	 */
	
	/**
	 * 
	 * FAP 이종호 시작
	 * 
	 */
	
	/**
	 * FAP 관리자 로그인 주소 2018. 12. 4. 이종호
	 */
	public static final String SOCIETY_FAP_ADMIN_LOGIN = SOCIETY_FAP_ADMIN + "/login";
	
	/**
	 * FAP 관리자 로그인 폼 주소 2018. 12. 4. 이종호
	 */
	public static final String SOCIETY_FAP_ADMIN_LOGIN_FORM = SOCIETY_FAP_ADMIN + "/admin_login";
	
	/**
	 * FAP 관리자 로그인 초기화 주소 2018. 12. 4. 이종호
	 */
	public static final String SOCIETY_FAP_ADMIN_SECURITY_INVALIDATE = SOCIETY_FAP_ADMIN + "/admin_security_invalidate";
	
	/**
	 * FAP 관리자 로그인 성공 주소 2018. 12. 4. 이종호
	 */
	public static final String SOCIETY_FAP_ADMIN_LOGIN_SUCCESS = SOCIETY_FAP_ADMIN + "/admin_login_success";
	
	/**
	 * FAP 관리자 접근 거부 주소 2018. 12. 4. 이종호
	 */
	public static final String SOCIETY_FAP_ADMIN_ACCESS_DENIED = SOCIETY_FAP_ADMIN + "/admin_access_denied";
	
	/**
	 * FAP 관리자 메인 주소 2018. 12. 4. 이종호
	 */
	public static final String SOCIETY_FAP_ADMIN_MAIN = SOCIETY_FAP_ADMIN + "/admin_main";
	
	/**
	 * FAP 관리자 휴면 계정 회원 폼 주소
	 */
	public static final String SOCIETY_FAP_ADMIN_DORMANCY_FORM = SOCIETY_FAP_ADMIN + "/admin_dormancy_form";

	/**
	 * FAP 관리자 탈퇴 계정 회원 폼 주소
	 */
	public static final String SOCIETY_FAP_ADMIN_EXPIRED_FORM = SOCIETY_FAP_ADMIN + "/admin_expired_form";

	/**
	 * FAP 관리자 정지 계정 회원 폼 주소
	 */
	public static final String SOCIETY_FAP_ADMIN_LOCKED_FORM = SOCIETY_FAP_ADMIN + "/admin_locked_form";
	
	/**
	 * FAP 관리자 승인 대기 계정 회원 폼 주소
	 * */
	public static final String SOCIETY_FAP_ADMIN_PENDING_APPROVAL_FORM = SOCIETY_FAP_ADMIN + "/admin_pending_approval_form";
	
	/**
	 * FAP 관리자 권한 기간 만료 폼 주소
	 * */
	public static final String SOCIETY_FAP_ADMIN_TERMINATION_FORM = SOCIETY_FAP_ADMIN + "/admin_termination_form";
	
	/**
	 * FAP 관리자 도쿄페어 일정 관리 폼 주소
	 * */
	public static final String SOCIETY_FAP_ADMIN_TOKYOFAIR_SCHEDULE_MANAGEMENT = SOCIETY_FAP_ADMIN + "/tokyofair_schedule_management";
	
	/**
	 * FAP 관리자 도쿄페어 일정 등록 폼 주소
	 * */
	public static final String SOCIETY_FAP_ADMIN_TOKYOFAIR_SCHEDULE_INSERT_FORM = SOCIETY_FAP_ADMIN + "/tokyofair_schedule_insert_form";
	
	/**
	 * FAP 관리자 도쿄페어 일정 가능 조회
	 * */
	public static final String SOCIETY_FAP_ADMIN_TOKYOFAIR_SCREENING_SEARCH_BOOKABLE = SOCIETY_FAP_ADMIN + "/tokyofair_screening_search_bookable";
	
	/**
	 * FAP 관리자 도쿄페어 일정 확인 폼 주소
	 * */
	public static final String SOCIETY_FAP_ADMIN_TOKYOFAIR_SCHEDULE_SEARCH_FORM = SOCIETY_FAP_ADMIN + "/tokyofair_schedule_search_form";
	
	/**
	 * FAP 관리자 도쿄페어 일정 등록
	 * */
	public static final String SOCIETY_FAP_ADMIN_TOKYOFAIR_SCHEDULE_INSERT = SOCIETY_FAP_ADMIN + "/tokyofair_schedule_insert";
	
	/**
	 * FAP 관리자 도쿄페어 추가일정 등록
	 * */
	public static final String SOCIETY_FAP_ADMIN_TOKYOFAIR_SCHEDULE_ADMIN_INSERT = SOCIETY_FAP_ADMIN + "/tokyofair_schedule_admin_insert";
	
	/**
	 * FAP 관리자 도쿄페어 일정 수정 폼 주소
	 * */
	public static final String SOCIETY_FAP_ADMIN_TOKYOFAIR_SCHEDULE_UPDATE_FORM = SOCIETY_FAP_ADMIN + "/tokyofair_schedule_update_form";
	
	/**
	 * FAP 관리자 도쿄페어 일정 수정
	 * */
	public static final String SOCIETY_FAP_ADMIN_TOKYOFAIR_SCHEDULE_UPDATE = SOCIETY_FAP_ADMIN + "/tokyofair_schedule_update";
	
	/**
	 * FAP 관리자 도쿄페어 일정 삭제
	 * */
	public static final String SOCIETY_FAP_ADMIN_TOKYOFAIR_SCHEDULE_DELETE = SOCIETY_FAP_ADMIN + "/tokyofair_schedule_delete";
	
	/**
	 * FAP 관리자 도쿄페어 설정 정보 조회
	 * */
	public static final String SOCIETY_FAP_ADMIN_TOKYOFAIR_SCHEDULE_SET_SEARCH_LIST = SOCIETY_FAP_ADMIN + "/tokyofair_schedule_set_search_list";
	
	/**
	 * FAP 관리자 도쿄페어 설정 사용구분 변경
	 * */
	public static final String SOCIETY_FAP_ADMIN_TOKYOFAIR_SCHEDULE_SET_GB_UPDATE = SOCIETY_FAP_ADMIN + "/tokyofair_schedule_set_gb_update";
	
	/**
	 * FAP 관리자 도쿄페어 일정 갱신
	 * */
	public static final String SOCIETY_FAP_ADMIN_TOKYOFAIR_SCHEDULE_RELOAD = SOCIETY_FAP_ADMIN + "/tokyofair_schedule_reload";
	
	/**
	 * FAP 관리자 도쿄페어 전형 삭제
	 * */
	public static final String SOCIETY_FAP_ADMIN_TOKYOFAIR_SCREENING_DELETE = SOCIETY_FAP_ADMIN + "/tokyofair_screening_delete";
	
	/**
	 * FAP 관리자 도쿄페어 전체 일정 인쇄
	 * */
	public static final String SOCIETY_FAP_ADMIN_TOKYOFARI_SCHEDULE_PRINT_FORM = SOCIETY_FAP_ADMIN + "/tokyofair_schedule_print_form";
	
	/**
	 * FAP 관리자 잡페어별 임시 결제 그룹 관리
	 * */
	public static final String SOCIETY_FAP_ADMIN_PER_JOBFAIR_TEMP_GROUP_MANAGEMENT = SOCIETY_FAP_ADMIN +"/per_jobfair_temp_group_management";
	
	/**
	 * FAP 관리자 잡페어별 임시 결제 그룹 등록 폼
	 * */
	public static final String SOCIETY_FAP_ADMIN_PER_JOBFAIR_TEMP_GROUP_INSERT_FORM = SOCIETY_FAP_ADMIN +"/per_jobfair_temp_group_insert_form";
	
	/**
	 * FAP 관리자 잡페어별 임시 결제 그룹 등록
	 * */
	public static final String SOCIETY_FAP_ADMIN_PER_JOBFAIR_TEMP_GROUP_INSERT = SOCIETY_FAP_ADMIN +"/per_jobfair_temp_group_insert";
	
	/**
	 * FAP 관리자 잡페어별 임시 결제 그룹 검색
	 * */
	public static final String SOCIETY_FAP_ADMIN_PER_JOBFAIR_TEMP_GROUP_SEARCH = SOCIETY_FAP_ADMIN +"/per_jobfair_temp_group_search";
	
	/**
	 * FAP 관리자 잡페어별 임시 결제 그룹 삭제
	 * */
	public static final String SOCIETY_FAP_ADMIN_PER_JOBFAIR_TEMP_GROUP_DELETE = SOCIETY_FAP_ADMIN +"/per_jobfair_temp_group_delete";
	
	/**
	 * FAP 관리자 잡페어별 임시 결제 그룹 수정 폼
	 * */
	public static final String SOCIETY_FAP_ADMIN_PER_JOBFAIR_TEMP_GROUP_UPDATE_FORM = SOCIETY_FAP_ADMIN +"/per_jobfair_temp_group_update_form";
	
	/**
	 * FAP 관리자 잡페어별 임시 결제 그룹 수정
	 * */
	public static final String SOCIETY_FAP_ADMIN_PER_JOBFAIR_TEMP_GROUP_UPDATE = SOCIETY_FAP_ADMIN +"/per_jobfair_temp_group_update";
	
	/**
	 * FAP 관리자 회사별 임시 결제 관리
	 * */
	public static final String SOCIETY_FAP_ADMIN_PER_COMP_TEMP_PAYMENT_MANAGEMENT = SOCIETY_FAP_ADMIN +"/per_comp_temp_payment_management";
	
	/**
	 * FAP 관리자 회사별 임시 결제 리스트 검색
	 * */
	public static final String SOCIETY_FAP_ADMIN_PER_COMP_TEMP_PAYMENT_SEARCH = SOCIETY_FAP_ADMIN +"/per_comp_temp_payment_search";
	
	/**
	 * FAP 관리자 회사별 임시 결제 정보 수정
	 * */
	public static final String SOCIETY_FAP_ADMIN_PER_COMP_TEMP_PAYMENT_UPDATE = SOCIETY_FAP_ADMIN +"/per_comp_temp_payment_update";
	
	/**
	 * FAP 관리자 회사별 임시 결제 정보 수정
	 * */
	public static final String SOCIETY_FAP_ADMIN_PER_COMP_TEMP_PAYMENT_INSERT = SOCIETY_FAP_ADMIN +"/per_comp_temp_payment_insert";
	
	/**
	 * FAP 관리자 회사별 임시 결제 정보 삭제
	 * */
	public static final String SOCIETY_FAP_ADMIN_PER_COMP_TEMP_PAYMENT_DELETE = SOCIETY_FAP_ADMIN +"/per_comp_temp_payment_delete";
	
	/**
	 * FAP 관리자 최종확정 기간 설정 폼 이동
	 * */
	public static final String SOCIETY_FAP_ADMIN_FINAL_DECISION_TIME_FORM = SOCIETY_FAP_ADMIN +"/final_decision_time_form";
	
	/**
	 * FAP 관리자 최종확정 기간 설정 등록
	 * */
	public static final String SOCIETY_FAP_ADMIN_FINAL_DECISION_TIME_SELECT = SOCIETY_FAP_ADMIN +"/final_decision_time_select";
	
	/**
	 * FAP 관리자 최종확정 기간 설정 등록
	 * */
	public static final String SOCIETY_FAP_ADMIN_FINAL_DECISION_TIME_INSERT = SOCIETY_FAP_ADMIN +"/final_decision_time_insert";
	
	/**
	 * FAP 관리자 최종확정 기간 설정 수정
	 * */
	public static final String SOCIETY_FAP_ADMIN_FINAL_DECISION_TIME_UPDATE = SOCIETY_FAP_ADMIN +"/final_decision_time_update";
	
	/**
	 * FAP 관리자 최종확정 기간 설정 삭제
	 * */
	public static final String SOCIETY_FAP_ADMIN_FINAL_DECISION_TIME_DELETE = SOCIETY_FAP_ADMIN +"/final_decision_time_delete";
	
	/**
	 * FAP 관리자 최종확정 적용(예비선택)
	 * */
	public static final String SOCIETY_FAP_ADMIN_FINAL_DECISION_COMMIT_OP = SOCIETY_FAP_ADMIN + "/final_decision_commit_op";
	
	/**
	 * FAP 관리자 최종확정 적용(예비필수)
	 * */
	public static final String SOCIETY_FAP_ADMIN_FINAL_DECISION_COMMIT_NS = SOCIETY_FAP_ADMIN + "/final_decision_commit_ns";
	
	/**
	 * FAP 관리자 최종확정 적용(최종)
	 * */
	public static final String SOCIETY_FAP_ADMIN_FINAL_DECISION_COMMIT_LAST = SOCIETY_FAP_ADMIN + "/final_decision_commit_last";

	/**
	 * FAP 관리자 최종확정 기업에 전달
	 * */
	public static final String SOCIETY_FAP_ADMIN_FINAL_DECISION_PASS_TO_COMP = SOCIETY_FAP_ADMIN + "/final_decision_pass_to_comp";
	
	/**
	 * FAP 관리자 채용공고 대상자 공통코드 조회
	 * */
	public static final String SOCIETY_FAP_ADMIN_AD_SHOW_CODE_SELECT = SOCIETY_FAP_ADMIN +"/ad_show_code_select";
	
	/**
	 * FAP 관리자 채용공고 대상자 공통코드 등록
	 * */
	public static final String SOCIETY_FAP_ADMIN_AD_SHOW_CODE_INSERT = SOCIETY_FAP_ADMIN +"/ad_show_code_insert";
	
	/**
	 * FAP 관리자 오픈잡페어 설명회 관리 폼 이동
	 * */
	public static final String SOCIETY_FAP_ADMIN_OPEN_PT_MANAGEMENT = SOCIETY_FAP_ADMIN + "/open_pt_management";
	
	/**
	 * FAP 관리자 오픈잡페어 설명회 지원자 관리 폼 이동
	 * */
	public static final String SOCIETY_FAP_ADMIN_OPEN_PT_APPLIER_MANAGEMENT = SOCIETY_FAP_ADMIN + "/open_pt_applier_management";
	
	/**
	 * FAP 관리자 오픈잡페어 설명회 지원자 리스트 조회
	 * */
	public static final String SOCIETY_FAP_ADMIN_OPEN_PT_APPLIER_LIST = SOCIETY_FAP_ADMIN + "/fap_open_pt_applier_list";
	
	/**
	 * FAP 관리자 오픈잡페어 구직자 교육 지원자 리스트 조회
	 * */
	public static final String SOCIETY_FAP_ADMIN_OPEN_EDU_APPLIER_LIST = SOCIETY_FAP_ADMIN + "/fap_open_edu_applier_list";
	
	/**
	 * FAP 관리자 오픈잡페어 구직자 교육 지원자 이력서 조회
	 * */
	public static final String SOCIETY_FAP_ADMIN_OPEN_EDU_APPLIER_RESUME_SELECT = SOCIETY_FAP_ADMIN + "/fap_open_edu_applier_resume_select";
	
	/**
	 * FAP 관리자 오픈잡페어 구직자 교육 지원자 합/불 처리
	 * */
	public static final String SOCIETY_FAP_ADMIN_OPEN_EDU_APPLIER_RESUME_UPDATE = SOCIETY_FAP_ADMIN + "/fap_open_edu_applier_resume_update";
	
	/**
	 * FAP 관리자 오픈잡페어 설명회 지원자 리스트 엑셀출력
	 * */
	public static final String SOCIETY_FAP_ADMIN_OPEN_PT_PRINT_EXCEL = SOCIETY_FAP_ADMIN + "/fap_open_pt_print_excel";
	
	/**
	 * FAP 관리자 오픈잡페어 구직자 교육 지원자 리스트 엑셀출력
	 * */
	public static final String SOCIETY_FAP_ADMIN_OPEN_EDU_PRINT_EXCEL = SOCIETY_FAP_ADMIN + "/fap_open_edu_print_excel";
	
	/**
	 * FAP 관리자 오픈잡페어 구직자 교육 지원자 이력서 출력용 폼
	 * */
	public static final String SOCIETY_FAP_ADMIN_APPLICANT_RESUME_PRINT_FORM = SOCIETY_FAP_ADMIN + "/applicant_resume_print_form";
	
	/**
	 * FAP 관리자 오픈잡페어 구직자 교육 지원자 관리 폼 이동
	 * */
	public static final String SOCIETY_FAP_ADMIN_OPEN_PT_EDU_APPLIER_MANAGEMENT = SOCIETY_FAP_ADMIN + "/open_pt_edu_applier_management";
	
	/**
	 * FAP 관리자 오픈잡페어 설명회 등록 폼 이동
	 * */
	public static final String SOCIETY_FAP_ADMIN_OPEN_PT_INSERT_FORM = SOCIETY_FAP_ADMIN + "/open_pt_insert_form";
	
	/**
	 * FAP 관리자 오픈잡페어 설명회 등록
	 * */
	public static final String SOCIETY_FAP_ADMIN_OPEN_PT_INSERT = SOCIETY_FAP_ADMIN + "/open_pt_insert";
	
	/**
	 * FAP 관리자 오픈잡페어 설명회 조회
	 * */
	public static final String SOCIETY_FAP_ADMIN_OPEN_PT_SELECT_ONE = SOCIETY_FAP_ADMIN + "/open_pt_select_one";
	
	/**
	 * FAP 관리자 오픈잡페어 설명회 구분 수정
	 * */
	public static final String SOCIETY_FAP_ADMIN_OPEN_PT_UPDATE_GB = SOCIETY_FAP_ADMIN + "/open_pt_update_gb";
	
	/**
	 * FAP 관리자 오픈잡페어 설명회 수정 폼 이동
	 * */
	public static final String SOCIETY_FAP_ADMIN_OPEN_PT_UPDATE_FORM = SOCIETY_FAP_ADMIN + "/open_pt_update_form";
	
	/**
	 * FAP 관리자 오픈잡페어 설명회 정보 수정
	 * */
	public static final String SOCIETY_FAP_ADMIN_OPEN_PT_UPDATE = SOCIETY_FAP_ADMIN + "/open_pt_update";
	
	/**
	 * FAP 관리자 오픈잡페어 설명회 정보 삭제
	 * */
	public static final String SOCIETY_FAP_ADMIN_OPEN_PT_DELETE = SOCIETY_FAP_ADMIN + "/open_pt_delete";
	
	
	/*
	 * FAP 관리자 오픈잡페어 취업정보 & 전략 리스트 조회 : 김경아
	 */
	public static final String SOCIETY_FAP_ADMIN_OPEN_JOB_INFO_LIST =  SOCIETY_FAP_ADMIN + "/open_job_info_list";
	
	/*
	 * FAP 관리자 오픈잡페어 취업정보 & 전략 글 조회 : 김경아
	 */
	public static final String SOCIETY_FAP_ADMIN_OPEN_JOB_INFO_DETAIL =  SOCIETY_FAP_ADMIN + "/open_job_info_detail";
	
	/*
	 * FAP 관리자 오픈잡페어 취업정보 & 전략 등록 폼 이동  : 김경아
	 */
	public static final String SOCIETY_FAP_ADMIN_OPEN_JOB_INFO_INSERT_FORM =  SOCIETY_FAP_ADMIN + "/open_job_info_insert_form";
	
	/*
	 * FAP 관리자 오픈잡페어 취업정보 & 전략 등록  : 김경아
	 */
	public static final String SOCIETY_FAP_ADMIN_OPEN_JOB_INFO_INSERT =  SOCIETY_FAP_ADMIN + "/open_job_info_insert";
	
	/*
	 * FAP 관리자 오픈잡페어 취업정보 & 전략 수정 폼으로 이동 : 김경아
	 */
	public static final String SOCIETY_FAP_ADMIN_OPEN_JOB_INFO_UPDATE_FORM =  SOCIETY_FAP_ADMIN + "/open_job_info_update_form";
	
	/*
	 * FAP 관리자 오픈잡페어 취업정보 & 전략 수정 : 김경아
	 */
	public static final String SOCIETY_FAP_ADMIN_OPEN_JOB_INFO_UPDATE =  SOCIETY_FAP_ADMIN + "/open_job_info_update";
	
	/*
	 * FAP 관리자 오픈잡페어 삭제  : 김경아
	 */
	public static final String SOCIETY_FAP_ADMIN_OPEN_JOB_INFO_DELETE =  SOCIETY_FAP_ADMIN + "/open_job_info_delete";
	
	/**
	 * FAP 관리자 팝업 관리 폼 이동
	 * */
	public static final String SOCIETY_FAP_ADMIN_POPUP_MANAGEMENT = SOCIETY_FAP_ADMIN + "/popup_management";
	
	/**
	 * FAP 관리자 팝업 등록 폼 이동
	 * */
	public static final String SOCIETY_FAP_ADMIN_POPUP_INSERT_FORM = SOCIETY_FAP_ADMIN + "/popup_insert_form";
	
	/**
	 * FAP 관리자 팝업 등록
	 * */
	public static final String SOCIETY_FAP_ADMIN_POPUP_INSERT = SOCIETY_FAP_ADMIN + "/popup_insert";
	
	/**
	 * FAP 관리자 팝업 수정 폼 이동
	 * */
	public static final String SOCIETY_FAP_ADMIN_POPUP_UPDATE_FORM = SOCIETY_FAP_ADMIN + "/popup_update_form";
	
	/**
	 * FAP 관리자 팝업 수정
	 * */
	public static final String SOCIETY_FAP_ADMIN_POPUP_UPDATE = SOCIETY_FAP_ADMIN + "/popup_update";
	
	/**
	 * FAP 관리자 팝업 삭제
	 * */
	public static final String SOCIETY_FAP_ADMIN_POPUP_DELETE = SOCIETY_FAP_ADMIN + "/popup_delete";
	
	/**
	 * FAP 관리자 채용공고별 지원자 현황
	 * */
	public static final String SOCIETY_FAP_ADMIN_APPLICANT_STATUS_PER_JOB_AD = SOCIETY_FAP_ADMIN + "/applicant_status_per_job_ad";
	
	/**
	 * FAP 관리자 채용공고별 Q&A 현황
	 * */
	public static final String SOCIETY_FAP_ADMIN_JOB_QNA_MANAGEMENT = SOCIETY_FAP_ADMIN + "/admin_job_qna_management";
	
	/**
	 * FAP 관리자 채용공고별 Q&A 읽기
	 * */
	public static final String SOCIETY_FAP_ADMIN_JOB_QNA = SOCIETY_FAP_ADMIN + "/admin_job_qna";
	
	/**
	 * FAP 관리자 채용공고별 지원자 이력서 프린트
	 * */
	public static final String SOCIETY_FAP_ADMIN_JOB_APPLICANT_RESUME_PRINT_FORM =  SOCIETY_FAP_ADMIN + "/admin_job_applicant_resume_print_form";
	
	/**
	 * FAP 관리자 이력서 수정여부 관리 (임시)
	 * */
	public static final String SOCIETY_FAP_ADMIN_RESUME_UPDATE_MANAGEMENT = SOCIETY_FAP_ADMIN + "/resume_update_management";
	
	/**
	 * FAP 관리자 이력서 수정여부 변경 (임시)
	 * */
	public static final String SOCIETY_FAP_ADMIN_RESUME_UPDATE_GB = SOCIETY_FAP_ADMIN + "/resume_update_gb";
	
	/**
	 * FAP 관리자 - 지원자 메인페이지 기업컨텐츠 관리 이동
	 * */
	public static final String SOCIETY_FAP_ADMIN_MAINPAGE_CT_MANAGEMENT = SOCIETY_FAP_ADMIN + "/mainpage_ct_management";
	
	/**
	 * FAP 관리자 - 지원자 메인페이지 기업컨텐츠 관리 등록 폼 이동
	 * */
	public static final String SOCIETY_FAP_ADMIN_MAINPAGE_CT_INSERT_FORM = SOCIETY_FAP_ADMIN + "/mainpage_ct_insert_form";
	
	/**
	 * FAP 관리자 - 지원자 메인페이지 기업컨텐츠 관리 등록
	 * */
	public static final String SOCIETY_FAP_ADMIN_MAINPAGE_CT_INSERT = SOCIETY_FAP_ADMIN + "/mainpage_ct_insert";
	
	/**
	 * FAP 관리자 - 지원자 메인페이지 기업컨텐츠 관리 수정
	 * */
	public static final String SOCIETY_FAP_ADMIN_MAINPAGE_CT_UPDATE = SOCIETY_FAP_ADMIN + "/mainpage_ct_update";
	
	/**
	 * FAP 관리자 - 지원자 메인페이지 기업컨텐츠 관리 삭제
	 * */
	public static final String SOCIETY_FAP_ADMIN_MAINPAGE_CT_DELETE = SOCIETY_FAP_ADMIN + "/mainpage_ct_delete";
	
	/**
	 * FAP 회원 로그인 주소 2018. 12. 6. 이종호
	 */
	public static final String SOCIETY_FAP_USER_LOGIN = SOCIETY_FAP_USER + "/login";
	
	/**
	 * FAP 회원 로그인 폼 주소 2018. 12. 6. 이종호
	 */
	public static final String SOCIETY_FAP_USER_LOGIN_FORM = SOCIETY_FAP_USER + "/user_login";
	
	/**
	 * FAP 회원 로그인 초기화 주소 2018. 12. 6. 이종호
	 */
	public static final String SOCIETY_FAP_USER_SECURITY_INVALIDATE = SOCIETY_FAP_USER + "/user_security_invalidate";
	
	/**
	 * FAP 회원 로그인 성공 주소 2018. 12. 6. 이종호
	 */
	public static final String SOCIETY_FAP_USER_LOGIN_SUCCESS = SOCIETY_FAP_USER + "/user_login_success";
	
	/**
	 * FAP 회원 접근 거부 주소 2018. 12. 6. 이종호
	 */
	public static final String SOCIETY_FAP_USER_ACCESS_DENIED = SOCIETY_FAP_USER + "/user_access_denied";
	
	/**
	 * FAP 회원 휴면 계정 회원 폼 주소 2018. 12. 6. 이종호
	 */
	public static final String SOCIETY_FAP_USER_DORMANCY_FORM = SOCIETY_FAP_USER + "/user_dormancy_form";

	/**
	 * FAP 회원 탈퇴 계정 회원 폼 주소 2018. 12. 6. 이종호
	 */
	public static final String SOCIETY_FAP_USER_EXPIRED_FORM = SOCIETY_FAP_USER + "/user_expired_form";

	/**
	 * FAP 회원 정지 계정 회원 폼 주소 2018. 12. 6. 이종호
	 */
	public static final String SOCIETY_FAP_USER_LOCKED_FORM = SOCIETY_FAP_USER + "/user_locked_form";
	
	/**
	 * FAP 회원 잡페어 로드맵 이미지 2019. 4. 2. 이종호
	 */
	public static final String SOCIETY_FAP_USER_ROADMAP_IMAGE = SOCIETY_FAP_USER + "/user_roadmap_image";
	
	/**
	 * FAP 오픈잡페어 이력서등록화면으로 이동 2019. 4. 3. 이종호
	 */
	public static final String SOCIETY_FAP_USER_RESUME_OPEN_INSERT_FORM = SOCIETY_FAP_USER + "/resume_open_insert_form";
	
	/**
	 * FAP 오픈잡페어 이력서수정화면으로 이동 2019. 4. 3. 이종호
	 */
	public static final String SOCIETY_FAP_USER_RESUME_OPEN_UPDATE_FORM = SOCIETY_FAP_USER + "/resume_open_update_form";
	
	/**
	 * FAP 오픈잡페어 이력서읽기화면으로 이동 2019. 4. 3. 이종호
	 */
	public static final String SOCIETY_FAP_USER_RESUME_OPEN_READ_FORM = SOCIETY_FAP_USER + "/resume_open_read_form";
	
	/**
	 * FAP 취업지원자 오픈잡페어 채용공고 읽기 폼 요청주소 2019. 4. 3. 이종호
	 */
	public static final String SOCIETY_FAP_USER_JOB_OPEN_ADVERTISEMENT_READ_FORM = SOCIETY_FAP_USER + "/user_job_open_advertisement_read_form";
	
	/**
	 * FAP 취업지원자 메인 팝업 2019. 4. 5 이종호
	 * */
	public static final String SOCIETY_FAP_USER_MAIN_POPUP = SOCIETY_FAP_USER + "/user_main_popup";
	
	/**
	 * FAP 오픈잡페어 설명회 신청 정보 페이지
	 * */
	public static final String SOCIETY_FAP_USER_OPEN_PT_INFO = SOCIETY_FAP_USER + "/user_open_pt_info";
	
	/**
	 * FAP 오픈잡페어 구직자 교육 신청 정보 페이지
	 * */
	public static final String SOCIETY_FAP_USER_OPEN_PT_EDU_INFO = SOCIETY_FAP_USER + "/user_open_pt_edu_info";
	
	/**
	 * FAP 오픈잡페어 설명회 신청 정보 페이지(로그인체크 용)
	 * */
	public static final String SOCIETY_FAP_USER_OPEN_PT_INFO_LOGIN = SOCIETY_FAP_USER + "/user_open_pt_info_login";
	
	/**
	 * FAP 오픈잡페어 구직자 교육 신청 정보 페이지(로그인체크 용)
	 * */
	public static final String SOCIETY_FAP_USER_OPEN_PT_EDU_INFO_LOGIN = SOCIETY_FAP_USER + "/user_open_pt_edu_info_login";
	
	/**
	 * FAP 오픈잡페어 설명회 신청
	 * */
	public static final String SOCIETY_FAP_USER_OPEN_PT_APPLY = SOCIETY_FAP_USER + "/user_open_pt_apply";
	
	/**
	 * FAP 오픈잡페어 구직자 교육 신청
	 * */
	public static final String SOCIETY_FAP_USER_OPEN_PT_EDU_APPLY = SOCIETY_FAP_USER + "/user_open_pt_edu_apply";
	
	/**
	 * FAP 오픈잡페어 설명회 신청 취소
	 * */
	public static final String SOCIETY_FAP_USER_OPEN_PT_APPLY_CANCEL = SOCIETY_FAP_USER + "/user_open_pt_apply_cancel";
	
	/**
	 * FAP 오픈잡페어 구직자 교육 신청 취소
	 * */
	public static final String SOCIETY_FAP_USER_OPEN_PT_EDU_APPLY_CANCEL = SOCIETY_FAP_USER + "/user_open_pt_edu_apply_cancel";
	
	/**
	 * FAP 오픈잡페어 설명회 참가내역 확인 폼
	 * */
	public static final String SOCIETY_FAP_USER_OPEN_PT_APPLIED_FORM = SOCIETY_FAP_USER + "/user_open_pt_applied_form";
	
	/**
	 * FAP 오픈잡페어 설명회 개인 참가내역 리스트 조회
	 * */
	public static final String SOCIETY_FAP_USER_OPEN_PT_APPLIED_LIST = SOCIETY_FAP_USER + "/user_open_pt_applied_list";
	
	/**
	 * FAP 오픈잡페어 구직자 교육 개인 참가내역 리스트 조회
	 * */
	public static final String SOCIETY_FAP_USER_OPEN_EDU_APPLIED_LIST = SOCIETY_FAP_USER + "/user_open_edu_applied_list";
	
	/**
	 * FAP 노출 팝업 체크
	 * */
	public static final String SOCIETY_FAP_USER_POPUP_CHECK = SOCIETY_FAP_USER + "/user_popup_check";
	
	/**
	 * FAP 오픈잡페어 설명회 팝업 호출
	 * */
	public static final String SOCIETY_FAP_USER_OPEN_PT_POPUP = SOCIETY_FAP_USER + "/user_open_pt_popup";
	
	/**
	 * FAP 오픈잡페어 구직자 교육 팝업 호출
	 * */
	public static final String SOCIETY_FAP_USER_OPEN_EDU_POPUP = SOCIETY_FAP_USER + "/user_open_edu_popup";
	
	/**
	 * FAP 메인페이지 기업컨텐츠 이동
	 * */
	public static final String SOCIETY_FAP_USER_MAINPAGE_CONTENT_READ = SOCIETY_FAP_USER + "/mainpage_content_read";
	

	/*
	 * FAP 회원탈퇴
	 */
	 public static final String SOCIETY_FAP_USER_INFO_DELETE_FORM = SOCIETY_FAP_USER + "/user_info_delete_form";
	
	/**
	 * FAP 회원 지원동의(보증보험) 동의 여부 조회
	 * */
	public static final String SOCIETY_FAP_USER_APPLY_CONFIRM = SOCIETY_FAP_USER + "/user_apply_confirm";
	
	/**
	 * FAP 회원 도쿄페어 일정 확인 폼
	 * */
	public static final String SOCIETY_FAP_USER_TOKYOFAIR_SCHEDULE_FORM = SOCIETY_FAP_USER + "/user_tokyofair_schedule_form";
	
	/**
	 * FAP 회원 도쿄페어 일정 인쇄 폼
	 * */
	public static final String SOCIETY_FAP_USER_TOKYOFAIR_SCHEDULE_PRINT_FORM = SOCIETY_FAP_USER + "/user_tokyofair_schedule_print_form";
	
	/**
	 * FAP 기업 로그인 주소 2018. 12. 6. 이종호
	 */
	public static final String SOCIETY_FAP_COMPANY_LOGIN = SOCIETY_FAP_COMPANY + "/login";
	
	/**
	 * FAP 기업 노출 팝업 체크
	 * */
	public static final String SOCIETY_FAP_COMPANY_POPUP_CHECK = SOCIETY_FAP_COMPANY + "/company_popup_check";
	
	/**
	 * FAP 기업 아이디 중복 검사 2019. 5. 30. 이종호
	 * */
	public static final String SOCIETY_FAP_COMPANY_USER_DUPLICATED = SOCIETY_FAP_COMPANY + "/user_duplicated";
	
	/**
	 * FAP 기업 로그인 폼 주소 2018. 12. 6. 이종호
	 */
	public static final String SOCIETY_FAP_COMPANY_LOGIN_FORM = SOCIETY_FAP_COMPANY + "/company_login";
	
	/**
	 * FAP 기업 로그인 초기화 주소 2018. 12. 6. 이종호
	 */
	public static final String SOCIETY_FAP_COMPANY_SECURITY_INVALIDATE = SOCIETY_FAP_COMPANY + "/company_security_invalidate";
	
	/**
	 * FAP 기업 로그인 성공 주소 2018. 12. 6. 이종호
	 */
	public static final String SOCIETY_FAP_COMPANY_LOGIN_SUCCESS = SOCIETY_FAP_COMPANY + "/company_login_success";
	
	/**
	 * FAP 기업 접근 거부 주소 2018. 12. 6. 이종호
	 */
	public static final String SOCIETY_FAP_COMPANY_ACCESS_DENIED = SOCIETY_FAP_COMPANY + "/company_access_denied";
	
	/**
	 * FAP 기업 휴면 계정 회원 폼 주소 2018. 12. 6. 이종호
	 */
	public static final String SOCIETY_FAP_COMPANY_DORMANCY_FORM = SOCIETY_FAP_COMPANY + "/company_dormancy_form";

	/**
	 * FAP 기업 탈퇴 계정 회원 폼 주소 2018. 12. 6. 이종호
	 */
	public static final String SOCIETY_FAP_COMPANY_EXPIRED_FORM = SOCIETY_FAP_COMPANY + "/company_expired_form";

	/**
	 * FAP 기업 정지 계정 회원 폼 주소 2018. 12. 6. 이종호
	 */
	public static final String SOCIETY_FAP_COMPANY_LOCKED_FORM = SOCIETY_FAP_COMPANY + "/company_locked_form";

	/**
	 * FAP 기업 현지잡페어 참여 설정 폼 2019. 1. 7. 이종호
	 */
	public static final String SOCIETY_FAP_COMPANY_ALGORITHM_CALENDAR_SETTING_FORM = SOCIETY_FAP_COMPANY + "/algorithm_calendar_setting_form";

	/**
	 * FAP 기업 현지잡페어 참여 설정 수정 폼 2019. 1. 11. 이종호
	 */
	public static final String SOCIETY_FAP_COMPANY_ALGORITHM_CALENDAR_SETTING_UPDATE_FORM = SOCIETY_FAP_COMPANY + "/algorithm_calendar_setting_update_form";
	
	/**
	 * FAP 기업 현지잡페어 참여 설정 수정 2019. 1. 11. 이종호
	 */
	public static final String SOCIETY_FAP_COMPANY_ALGORITHM_CALENDAR_SETTING_UPDATE = SOCIETY_FAP_COMPANY + "/algorithm_calendar_setting_update";
	
	/**
	 * FAP 기업 현지잡페어 참여 설정 등록 2019. 1. 10. 이종호
	 */
	public static final String SOCIETY_FAP_COMPANY_ALGORITHM_CALENDAR_SETTING_INSERT = SOCIETY_FAP_COMPANY + "/algorithm_calendar_setting_insert";
	
	/**
	 * FAP 기업 언어변경 요청 이종호
	 * */
	public static final String SOCIETY_FAP_COMPANY_LANGUAGE_CHANGE = SOCIETY_FAP_COMPANY + "/language_change";
	
	/**
	 * FAP 기업 로드맵
	 * */
	public static final String SOCIETY_FAP_COMPANY_ROADMAP_IMAGE = SOCIETY_FAP_COMPANY + "/company_roadmap_image";
	
	/**
	 * FAP 기업 비용결제
	 * */
	public static final String SOCIETY_FAP_COMPANY_PAY_FOR_COST = SOCIETY_FAP_COMPANY + "/company_pay_for_cost";
	
	/**
	 * FAP 기업 비용결제 검색
	 * */
	public static final String SOCIETY_FAP_COMPANY_PAY_FOR_COST_SEARCH = SOCIETY_FAP_COMPANY + "/company_pay_for_cost_search";
	
	/**
	 * FAP 기업 회원 가입 완료 폼
	 * */
	public static final String SOCIETY_FAP_COMPANY_INSERT_COMPLETE = SOCIETY_FAP_COMPANY + "/company_insert_complete";
	
	/**
	 * FAP 기업 지원자 이력서 출력 폼
	 * */
	public static final String SOCIETY_FAP_COMPANY_APPLICANT_RESUME_PRINT_FORM = SOCIETY_FAP_COMPANY + "/applicant_resume_print_form";
	
	/**
	 * FAP 기업 현지면접 지원자 제한 체크
	 */
	public static final String SOCIETY_FAP_COMPANY_INTERVIEW_LIMIT_CHECK = SOCIETY_FAP_COMPANY + "/interview_limit_check";
	
	/**
	 * FAP 기업 도쿄페어 전형 관리 페이지
	 * */
	public static final String SOCIETY_FAP_COMPANY_TOKYOFAIR_SCREENING_MANAGEMENT = SOCIETY_FAP_COMPANY + "/company_tokyofair_screening_management";
	
	/**
	 * FAP 기업 도쿄페어 전형 등록 가능일자 확인
	 * */
	public static final String SOCIETY_FAP_COMPANY_TOKYOFAIR_SCREENING_DATE_CHECK = SOCIETY_FAP_COMPANY + "/company_tokyofair_screening_date_check";
	
	/**
	 * FAP 기업 도쿄페어 전형 등록 페이지
	 * */
	public static final String SOCIETY_FAP_COMPANY_TOKYOFAIR_SCREENING_INSERT_FORM = SOCIETY_FAP_COMPANY + "/company_tokyofair_screening_insert_form";
	
	/**
	 * FAP 기업 도쿄페어 일정 관리 페이지
	 * */
	public static final String SOCIETY_FAP_COMPANY_TOKYOFAIR_SCHEDULE_MANAGEMENT = SOCIETY_FAP_COMPANY + "/company_tokyofair_schedule_management";
	
	/**
	 * FAP 기업 도쿄페어 전형 등록
	 * */
	public static final String SOCIETY_FAP_COMPANY_TOKYOFAIR_SCREENING_INSERT = SOCIETY_FAP_COMPANY + "/company_tokyofair_screening_insert";
	
	/**
	 * FAP 기업 도쿄페어 전형 수정 페이지
	 * */
	public static final String SOCIETY_FAP_COMPANY_TOKYOFAIR_SCREENING_UPDATE_FORM = SOCIETY_FAP_COMPANY + "/company_tokyofair_screening_update_form";
	
	/**
	 * FAP 기업 도쿄페어 전형 수정
	 * */
	public static final String SOCIETY_FAP_COMPANY_TOKYOFAIR_SCREENING_UPDATE = SOCIETY_FAP_COMPANY + "/company_tokyofair_screening_update";
	
	/**
	 * FAP 기업 도쿄페어 전형 삭제
	 * */
	public static final String SOCIETY_FAP_COMPANY_TOKYOFAIR_SCREENING_DELETE	=	SOCIETY_FAP_COMPANY + "/company_tokyofair_screening_delete";
	
	/**
	 * FAP 기업 도쿄페어 전체 일정 확인 페이지
	 * */
	public static final String SOCIETY_FAP_COMPANY_TOKYOFAIR_SCREENING_SEARCH_FORM = SOCIETY_FAP_COMPANY + "/company_tokyofair_screening_search_form";
	
	/**
	 * FAP 기업 도쿄페어 전형 대상자 조회
	 * */
	public static final String SOCIETY_FAP_COMPANY_TOKYOFAIR_SCREENING_SUBJECT_SEARCH = SOCIETY_FAP_COMPANY + "/tokyofair_screening_subject_search";
	
	/**
	 * FAP 기업 도쿄페어 전형 대상자 일부 조회
	 * */
	public static final String SOCIETY_FAP_COMPANY_TOKYOFAIR_SCREENING_SUBJECT_SEARCH_TWO = SOCIETY_FAP_COMPANY + "/tokyofair_screening_subject_search_two";
	
	/**
	 * FAP 기업 도쿄페어 전형별 대상자 일부 조회
	 * */
	public static final String SOCIETY_FAP_COMPANY_TOKYOFAIR_SCREENING_SUBJECT_SEARCH_THREE = SOCIETY_FAP_COMPANY + "/tokyofair_screening_subject_search_three";
	
	/**
	 * FAP 기업 도쿄페어 전형 리스트 조회
	 * */
	public static final String SOCIETY_FAP_COMPANY_TOKYOFAIR_SCREENING_SEARCH = SOCIETY_FAP_COMPANY + "/tokyofair_screening_search";
	
	/**
	 * FAP 기업 도쿄페어 전형 중 예약가능한 리스트 조회 
	 * */
	public static final String SOCIETY_FAP_COMPANY_TOKYOFAIR_SCREENING_SEARCH_BOOKABLE = SOCIETY_FAP_COMPANY + "/tokyofair_screening_search_bookable";
	
	/**
	 * FAP 기업 도쿄페어 전형 조회
	 * */
	public static final String SOCIETY_FAP_COMPANY_TOKYOFAIR_SCREENING_SEARCH_ONE = SOCIETY_FAP_COMPANY + "/tokyofair_screening_search_one";
	
	/**
	 * FAP 기업 도쿄페어 일정 등록
	 * */
	public static final String SOCIETY_FAP_COMPANY_TOKYOFAIR_SCHEDULE_INSERT = SOCIETY_FAP_COMPANY + "/tokyofair_schedule_insert";
	
	/**
	 * FAP 기업 도쿄페어 일정 삭제
	 * */
	public static final String SOCIETY_FAP_COMPANY_TOKYOFAIR_SCHEDULE_DELETE = SOCIETY_FAP_COMPANY + "/tokyofair_schedule_delete";
	
	/**
	 * FAP 기업 도쿄페어 최초일정 확인
	 * */
	public static final String SOCIETY_FAP_COMPANY_TOKYOFAIR_SCHEDULE_FIRST_CHECK = SOCIETY_FAP_COMPANY + "/tokyofair_schedule_first_check";
	
	/**
	 * FAP 기업 도쿄페어 앞면접과 기업 준비시간 체크
	 * */
	public static final String SOCIETY_FAP_COMPANY_TOKYOFAIR_SCHEDULE_ITV_COMP_BEFORE_CHECK = SOCIETY_FAP_COMPANY + "/tokyofair_schedule_itv_comp_before_check";
	
	/**
	 * FAP 기업 도쿄페어 뒷면접과 기업 준비시간 체크
	 * */
	public static final String SOCIETY_FAP_COMPANY_TOKYOFAIR_SCHEDULE_ITV_COMP_AFTER_CHECK = SOCIETY_FAP_COMPANY + "/tokyofair_schedule_itv_comp_after_check";
	
	/**
	 * FAP 기업 도쿄페어 일정 인원 등록
	 * */
	public static final String SOCIETY_FAP_COMPANY_TOKYOFAIR_SCHEDULE_MEMBER_INSERT = SOCIETY_FAP_COMPANY + "/tokyofair_schedule_member_insert";
	
	/**
	 * FAP 기업 도쿄페어 일정 인원 수정
	 * */
	public static final String SOCIETY_FAP_COMPANY_TOKYOFAIR_SCHEDULE_MEMBER_UPDATE = SOCIETY_FAP_COMPANY + "/tokyofair_schedule_member_update";
	
	/**
	 * FAP 기업 도쿄페어 일정 인원 삭제
	 * */
	public static final String SOCIETY_FAP_COMPANY_TOKYOFAIR_SCHEDULE_MEMBER_DELETE = SOCIETY_FAP_COMPANY + "/tokyofair_schedule_member_delete";
	
	/**
	 * FAP 기업 도쿄페어 면접간 여유도 체크
	 * */
	public static final String SOCIETY_FAP_COMPANY_TOKYOFAIR_SCHEDULE_TERM_CHECK = SOCIETY_FAP_COMPANY + "/tokyofair_schedule_term_check";
	
	/**
	 * FAP 기업 도쿄페어 일정 갱신
	 * */
	public static final String SOCIETY_FAP_COMPANY_TOKYOFAIR_SCHEDULE_RELOAD = SOCIETY_FAP_COMPANY + "/tokyofair_schedule_reload";
	
	/**
	 * FAP 기업 도쿄페어 일정 및 인원 정보 조회
	 * */
	public static final String SOCIETY_FAP_COMPANY_TOKYOFAIR_SCHEDULE_SEARCH_DETAIL = SOCIETY_FAP_COMPANY + "/tokyofair_schedule_search_detail";
	
	/**
	 * FAP 기업 도쿄페어 일정 현황 인쇄
	 * */
	public static final String SOCIETY_FAP_COMPANY_TOKYOFAIR_SCREENING_SEARCH_PRINT_FORM = SOCIETY_FAP_COMPANY + "/company_tokyofair_screening_search_print_form";
	
	/**
	 * FAP 에이전시 현지면접 지원자 제한 체크
	 * */
	public static final String SOCIETY_FAP_AGENCY_INTERVIEW_LIMIT_CHECK = SOCIETY_FAP_AGENCY + "/interview_limit_check";
	
	/**
	 * FAP 에이전시 기업회원가입시 아이디 중복 검사
	 * */
	public static final String SOCIETY_FAP_AGENCY_ID_DUPLICATED = SOCIETY_FAP_AGENCY+"/id_duplicated";
	
	/**
	 * FAP 에이전시 지원자 이력서 출력 폼
	 * */
	public static final String SOCIETY_FAP_AGENCY_APPLICANT_RESUME_PRINT_FORM = SOCIETY_FAP_AGENCY + "/applicant_resume_print_form";
	
	/**
	 * FAP 에이전시 로그인 주소 2018. 12. 13. 이종호
	 */
	public static final String SOCIETY_FAP_AGENCY_LOGIN = SOCIETY_FAP_AGENCY + "/login";
	
	/**
	 * FAP 에이전시 로그인 초기화 주소 2018. 12.13. 이종호
	 */
	public static final String SOCIETY_FAP_AGENCY_SECURITY_INVALIDATE = SOCIETY_FAP_AGENCY + "/agency_security_invalidate";
	
	/**
	 * FAP 에이전시 로그인 성공 주소 2018. 12. 13. 이종호
	 */
	public static final String SOCIETY_FAP_AGENCY_LOGIN_SUCCESS = SOCIETY_FAP_AGENCY + "/agency_login_success";
	
	/**
	 * FAP 에이전시 접근 거부 주소 2018. 12. 13. 이종호
	 */
	public static final String SOCIETY_FAP_AGENCY_ACCESS_DENIED = SOCIETY_FAP_AGENCY + "/agency_access_denied";
	
	/**
	 * FAP 에이전시 휴면 계정 회원 폼 주소 2018. 12. 13. 이종호
	 */
	public static final String SOCIETY_FAP_AGENCY_DORMANCY_FORM = SOCIETY_FAP_AGENCY + "/agency_dormancy_form";

	/**
	 * FAP 에이전시 탈퇴 계정 회원 폼 주소 2018. 12. 13. 이종호
	 */
	public static final String SOCIETY_FAP_AGENCY_EXPIRED_FORM = SOCIETY_FAP_AGENCY + "/agency_expired_form";

	/**
	 * FAP 에이전시 정지 계정 회원 폼 주소 2018. 12. 13. 이종호
	 */
	public static final String SOCIETY_FAP_AGENCY_LOCKED_FORM = SOCIETY_FAP_AGENCY + "/agency_locked_form";
	
	/**
	 * FAP 에이전시 잡페어 로드맵 이미지 2019. 4. 2. 이종호
	 */
	public static final String SOCIETY_FAP_AGENCY_ROADMAP_IMAGE = SOCIETY_FAP_AGENCY + "/agency_roadmap_image";
	
	/**
	 * FAP 에이전시 오픈잡페어 채용공고 등록 화면으로 이동 2019. 4. 2. 이종호
	 */
	public static final String SOCIETY_FAP_AGENCY_OPEN_JOB_AD_INSERT_FORM = SOCIETY_FAP_AGENCY + "/agency_open_job_ad_insert_form";
	
	/**
	 * FAP 에이전시 오픈잡페어 채용공고 수정 화면으로 이동 2019. 4. 2. 이종호
	 */
	public static final String SOCIETY_FAP_AGENCY_OPEN_JOB_AD_UPDATE_FORM = SOCIETY_FAP_AGENCY + "/agency_open_job_ad_update_form";
	
	/**
	 * FAP 에이전시 오픈잡페어 채용공고 읽기 화면으로 이동 2019. 4. 2. 이종호
	 */
	public static final String SOCIETY_FAP_AGENCY_OPEN_JOB_AD_READ_FORM = SOCIETY_FAP_AGENCY + "/agency_open_job_ad_read_form";
	
	/**
	 * FAP 에이전시 오픈잡페어 채용공고 불러오기 화면으로 이동 2019. 4. 2. 이종호
	 */
	public static final String SOCIETY_FAP_AGENCY_OPEN_JOB_AD_INSERT_FORM_LOAD = SOCIETY_FAP_AGENCY + "/agency_open_job_ad_insert_form_load";
	
	/**
	 * 
	 * FAP 이종호 끝
	 * 
	 */
	
	/**
	 * 
	 * FAP 이재준 시작
	 * 
	 */
	
	/**
	 * FAP 관리자 채용공고 관리 화면으로 이동 2018. 12. 24. 이재준
	 */
	public static final String SOCIETY_FAP_ADMIN_JOB_AD_MANAGEMENT = SOCIETY_FAP_ADMIN + "/job_ad_management";
	
	/**
	 * FAP 관리자 채용공고 등록 화면으로 이동 2018. 12. 24. 이재준
	 */
	public static final String SOCIETY_FAP_ADMIN_JOB_AD_INSERT_FORM = SOCIETY_FAP_ADMIN + "/job_ad_insert_form";
	
	/**
	 * FAP 관리자 채용공고 등록  2018. 12. 24. 이재준
	 */
	public static final String SOCIETY_FAP_ADMIN_JOB_AD_INSERT = SOCIETY_FAP_ADMIN + "/job_ad_insert";
	
	/**
	 * FAP 관리자 채용공고 정보 업데이트 화면으로 이동 2019. 1. 10. 이재준
	 */
	public static final String SOCIETY_FAP_ADMIN_JOB_AD_UPDATE_FORM = SOCIETY_FAP_ADMIN + "/job_ad_update_form";
	
	/**
	 * FAP 기업 채용공고 관리 화면으로 이동 2019. 1. 10. 이재준
	 */
	public static final String SOCIETY_FAP_COMPANY_JOB_AD_MANAGEMENT = SOCIETY_FAP_COMPANY + "/company_job_ad_management";
	
	/**
	 * FAP 기업 채용공고 등록 화면으로 이동 2019. 1. 10. 이재준
	 */
	public static final String SOCIETY_FAP_COMPANY_JOB_AD_INSERT_FORM = SOCIETY_FAP_COMPANY + "/company_job_ad_insert_form";
	
	/**
	 * FAP 기업 오픈잡페어 채용공고 등록 화면 이동 2019. 3. 28. 이종호
	 * */
	public static final String SOCIETY_FAP_COMPANY_OPEN_JOB_AD_INSERT_FORM = SOCIETY_FAP_COMPANY + "/company_open_job_ad_insert_form";
	
	/**
	 * FAP 기업 채용공고 불러오기; 2019. 1. 30. 김준영
	 */
	public static final String SOCIETY_FAP_COMPANY_JOB_AD_INSERT_FORM_LOAD = SOCIETY_FAP_COMPANY_JOB_AD_INSERT_FORM + "_load";
	
	/**
	 * FAP 기업 채용공고 불러오기; 2019. 4. 1. 이종호
	 */
	public static final String SOCIETY_FAP_COMPANY_OPEN_JOB_AD_INSERT_FORM_LOAD = SOCIETY_FAP_COMPANY_OPEN_JOB_AD_INSERT_FORM + "_load";
	
	
	/**
	 * FAP 기업 채용공고 등록  2019. 1. 11. 이재준
	 */
	public static final String SOCIETY_FAP_COMPANY_JOB_AD_INSERT = SOCIETY_FAP_COMPANY + "/company_job_ad_insert";
	
	/**
	 * FAP 기업 채용공고 업데이트 화면으로 이동 2019. 1. 11. 이재준
	 */
	public static final String SOCIETY_FAP_COMPANY_JOB_AD_UPDATE_FORM = SOCIETY_FAP_COMPANY + "/company_job_ad_update_form";
	
	/**
	 * FAP 기업 오픈잡페어 채용공고 수정 화면 이동 2019. 3. 28. 이종호
	 * */
	public static final String SOCIETY_FAP_COMPANY_OPEN_JOB_AD_UPDATE_FORM = SOCIETY_FAP_COMPANY + "/company_open_job_ad_update_form";
	
	/**
	 * FAP 기업 오픈잡페어 채용공고 읽기 화면 이동 2019. 3. 28. 이종호
	 * */
	public static final String SOCIETY_FAP_COMPANY_OPEN_JOB_AD_READ_FORM = SOCIETY_FAP_COMPANY + "/company_open_job_ad_read_form";
	
	/**
	 * FAP 에이전시 잡페어 리스트 검색; 2019. 1. 21. 이재준
	 */
	public static final String SOCIETY_FAP_AGENCY_JOBFAIR_SEARCH_LIST = SOCIETY_FAP_AGENCY + "/jobfair_search_list";
	
	/**
	 * FAP 에이전시 잡페어 참가; 2019. 1. 22. 이재준
	 */
	public static final String SOCIETY_FAP_AGENCY_JOBFAIR_PARTICIPATION = SOCIETY_FAP_AGENCY + "/agency_jobfair_participation";
	
	/**
	 * FAP 에이전시 잡페어 세부참가 폼; 2019. 1. 22. 이재준
	 */
	public static final String SOCIETY_FAP_AGENCY_JOBFAIR_PARTICIPATION_FORM = SOCIETY_FAP_AGENCY + "/agency_jobfair_participation_form";
	
	/**
	 * FAP 에이전시 채용공고 관리 화면으로 이동 2019. 1. 22. 이재준
	 */
	public static final String SOCIETY_FAP_AGENCY_JOB_AD_MANAGEMENT = SOCIETY_FAP_AGENCY + "/agency_job_ad_management";
	
	/**
	 * FAP 에이전시 채용공고 등록 화면으로 이동 2019. 1. 22. 이재준
	 */
	public static final String SOCIETY_FAP_AGENCY_JOB_AD_INSERT_FORM = SOCIETY_FAP_AGENCY + "/agency_job_ad_insert_form";
	
	/*
	 * FAP 에이전시 채용공고 불러오기; 2019. 2. 12. 김준영
	 */
	public static final String SOCIETY_FAP_AGENCY_JOB_AD_INSERT_FORM_LOAD = SOCIETY_FAP_AGENCY_JOB_AD_INSERT_FORM + "_load";
	
	/**
	 * FAP 에이전시 채용공고 등록  2019. 1. 22. 이재준
	 */
	public static final String SOCIETY_FAP_AGENCY_JOB_AD_INSERT = SOCIETY_FAP_AGENCY + "/agency_job_ad_insert";
	
	/**
	 * FAP 에이전시 채용공고 업데이트 화면으로 이동 2019. 1. 22. 이재준
	 */
	public static final String SOCIETY_FAP_AGENCY_JOB_AD_UPDATE_FORM = SOCIETY_FAP_AGENCY + "/agency_job_ad_update_form";
	
	/*
	 * FAP 에이전시 채용공고 업데이트; 2019. 1. 23. 이재준
	 */
	public static final String SOCIETY_FAP_AGENCY_JOB_AD_UPDATE = SOCIETY_FAP_AGENCY + "/agency_job_ad_update";
	
	/*
	 * FAP 에이전시 채용전형 수정 가능 여부 확인; 2019. 1. 24. 이재준
	 */
	public static final String SOCIETY_FAP_AGENCY_JOB_PCS_EDITABLE_CHECK = SOCIETY_FAP_AGENCY + "/job_pcs_editable_check";
	
	/**
	 * FAP 에이전시 잡페어 신청 페이지 이동 요청 2019. 1. 26. 이재준
	 */
	public static final String SOCIETY_FAP_AGENCY_JOBFAIR_APPLY_TO_ATTEND_FORM = SOCIETY_FAP_AGENCY + "/agency_jobfair_apply_to_attend_form";
	
	/**
	 * FAP 에이전시 FAQ 페이지 이동 요청 2019. 1. 30. 이재준
	 */
	public static final String SOCIETY_FAP_AGENCY_FAQ = SOCIETY_FAP_AGENCY + "/agency_faq";
	
	/**
	 * FAP 회사 FAQ 페이지 이동 요청 2019. 1. 31. 이재준
	 */
	public static final String SOCIETY_FAP_COMPANY_FAQ = SOCIETY_FAP_COMPANY + "/company_faq";
	
	/**
	 * FAP 유저 FAQ 페이지 이동 요청 2019. 4. 10. 이종호
	 */
	public static final String SOCIETY_FAP_USER_FAQ = SOCIETY_FAP_USER + "/user_faq";
	
	/**
	 * FAP ADMIN FAQ 관리 2019. 1. 31. 이재준
	 */
	public static final String SOCIETY_FAP_ADMIN_FAQ_MANAGEMENT = SOCIETY_FAP_ADMIN + "/admin_faq_management";
	
	/**
	 * FAP ADMIN FAQ 등록폼 이동 2019. 1. 31. 이재준
	 */
	public static final String SOCIETY_FAP_ADMIN_FAQ_INSERT_FORM = SOCIETY_FAP_ADMIN + "/admin_faq_insert_form";
	
	/**
	 * FAP ADMIN FAQ 수정폼 이동 2019. 4. 9. 이종호
	 * */
	public static final String SOCIETY_FAP_ADMIN_FAQ_UPDATE_FORM = SOCIETY_FAP_ADMIN + "/admin_faq_update_form";
	
	/**
	 * FAP ADMIN FAQ 수정 2019. 4. 9. 이종호
	 * */
	public static final String SOCIETY_FAP_ADMIN_FAQ_UPDATE = SOCIETY_FAP_ADMIN + "/admin_faq_update";
	
	/**
	 * FAP ADMIN FAQ 삭제 2019. 4. 9. 이종호
	 * */
	public static final String SOCIETY_FAP_ADMIN_FAQ_DELETE = SOCIETY_FAP_ADMIN + "/admin_faq_delete";
	
	/**
	 * FAP ADMIN FAQ 등록 2019. 1. 31. 이재준
	 */
	public static final String SOCIETY_FAP_ADMIN_FAQ_INSERT = SOCIETY_FAP_ADMIN + "/admin_faq_insert";
	
	/*
	 * FAP 관리자 에이전시 - 기업 연결(기업 페이징); 2019. 2. 19. 이재준
	 */
	public static final String SOCIETY_FAP_ADMIN_AGENCY_COMPANY_CONNECT_COMPANY_PAGING = SOCIETY_FAP_ADMIN + "/agency_company_connect_company_paging";
	
	/*
	 * FAP 관리자 에이전시 - 기업 연결(에이전시 페이징); 2019. 2. 19. 이재준
	 */
	public static final String SOCIETY_FAP_ADMIN_AGENCY_COMPANY_CONNECT_AGENCY_PAGING = SOCIETY_FAP_ADMIN + "/agency_company_connect_agency_paging";
	
	/*
	 * FAP 관리자 에이전시 - 기업 연결관리(대기중인 리스트 페이징); 2019. 2. 20. 이재준
	 */
	public static final String SOCIETY_FAP_ADMIN_AGENCY_COMPANY_CONNECT_STANDBY_PAGING = SOCIETY_FAP_ADMIN + "/agency_company_connect_standby_paging";
	
	/*
	 * FAP 관리자 에이전시 - 기업 연결관리(승인한 리스트 페이징); 2019. 2. 20. 이재준
	 */
	public static final String SOCIETY_FAP_ADMIN_AGENCY_COMPANY_CONNECT_APPROVAL_PAGING = SOCIETY_FAP_ADMIN + "/agency_company_connect_approval_paging";
	
	/*
	 * FAP 관리자 에이전시 - 기업 연결관리(거절한 리스트 페이징); 2019. 2. 20. 이재준
	 */
	public static final String SOCIETY_FAP_ADMIN_AGENCY_COMPANY_CONNECT_REFUSAL_PAGING = SOCIETY_FAP_ADMIN + "/agency_company_connect_refusal_paging";
	
	/*
	 * FAP 관리자 담당자 - 기업 연결관리(대기중인 리스트 페이징); 2019. 2. 21. 이재준
	 */
	public static final String SOCIETY_FAP_ADMIN_COMP_USER_CONNECT_STANDBY_PAGING = SOCIETY_FAP_ADMIN + "/comp_user_connect_standby_paging";
	
	/*
	 * FAP 관리자 담당자 - 기업 연결관리(승인한 리스트 페이징); 2019. 2. 21. 이재준
	 */
	public static final String SOCIETY_FAP_ADMIN_COMP_USER_CONNECT_APPROVAL_PAGING = SOCIETY_FAP_ADMIN + "/comp_user_connect_approval_paging";
	
	/*
	 * FAP 관리자 담당자 - 기업 연결관리(거절한 리스트 페이징); 2019. 2. 21. 이재준
	 */
	public static final String SOCIETY_FAP_ADMIN_COMP_USER_CONNECT_REFUSAL_PAGING = SOCIETY_FAP_ADMIN + "/comp_user_connect_refusal_paging";
	
	/*
	 * 담당자 연결 요청 리스트 페이징; 2019. 2. 21. 이재준
	 */
	public static final String SOCIETY_FAP_ADMIN_CONNECT_REQUEST_PAGING = SOCIETY_FAP_ADMIN + "/connect_request_paging";
	
	/*
	 * 연결 객체가 없어 불명확한 기업 리스트 페이징; 2019. 2. 21. 이재준
	 */
	public static final String SOCIETY_FAP_ADMIN_UNCERTAIN_COMPANY_PAGING = SOCIETY_FAP_ADMIN + "/uncertain_company_paging";
	
	/*
	 * 기업과 연결 되지 않은 유저(기업) 리스트 페이징; 2019. 2. 22. 이재준
	 */
	public static final String SOCIETY_FAP_ADMIN_UNCONNECT_COMPANY_PAGING = SOCIETY_FAP_ADMIN + "/unconnect_company_paging";
	
	/*
	 * 기업과 연결 되지 않은 유저(에이전시) 리스트 페이징; 2019. 2. 22. 이재준
	 */
	public static final String SOCIETY_FAP_ADMIN_UNCONNECT_AGENCY_PAGING = SOCIETY_FAP_ADMIN + "/unconnect_agency_paging";
	
	/*
	 * 연결 할 기업 리스트 페이징; 2019. 2. 22. 이재준
	 */
	public static final String SOCIETY_FAP_ADMIN_CONNECT_COMPANY_PAGING = SOCIETY_FAP_ADMIN + "/connect_company_paging";
	
	/*
	 * 연결 할 에이전시 리스트 페이징; 2019. 2. 22. 이재준
	 */
	public static final String SOCIETY_FAP_ADMIN_CONNECT_AGENCY_PAGING = SOCIETY_FAP_ADMIN + "/connect_agency_paging";
	
	/*
	 * 불명확한 기업 선택 시, 기업과 연결 되지 않은 유저(기업) 리스트 페이징; 2019. 2. 25. 이재준
	 */
	public static final String SOCIETY_FAP_ADMIN_UNCONNECT_COMPANY_PAGING_SUB = SOCIETY_FAP_ADMIN + "/unconnect_company_paging_sub";
	
	/*
	 * 불명확한 기업 선택 시, 기업과 연결 되지 않은 유저(에이전시) 리스트 페이징; 2019. 2. 25. 이재준
	 */
	public static final String SOCIETY_FAP_ADMIN_UNCONNECT_AGENCY_PAGING_SUB = SOCIETY_FAP_ADMIN + "/unconnect_agency_paging_sub";
	
	/**
	 * FAP 관리자 채용공고 관리 미스매칭/일반지원 수정; 2019. 2. 27. 이재준
	 */
	public static final String SOCIETY_FAP_ADMIN_UPDATE_MISMATCHING = SOCIETY_FAP_ADMIN + "/admin_update_mismatching";
	
	/**
	 * 
	 * FAP 이재준 끝
	 * 
	 */
	
	/**
	 * 
	 * FAP 남유송 시작
	 * 
	 */
	
	/**
	 * FAP 이력서관리화면으로 이동 2018. 12. 11. 남유송
	 */
	public static final String SOCIETY_FAP_USER_RESUME_MANAGEMENT = SOCIETY_FAP_USER + "/resume_management";
	
	/**
	 * FAP 이력서등록화면으로 이동 2018. 12. 11. 남유송
	 */
	public static final String SOCIETY_FAP_USER_RESUME_INSERT_FORM = SOCIETY_FAP_USER + "/resume_insert_form";
	
	/**
	 * FAP 이력서 정보 등록  2018. 12. 11. 남유송
	 */
	public static final String SOCIETY_FAP_USER_RESUME_INSERT = SOCIETY_FAP_USER + "/resume_insert";
	
	/**
	 * FAP 이력서 정보 삭제  2018. 12. 11. 남유송
	 */
	public static final String SOCIETY_FAP_USER_RESUME_DELETE = SOCIETY_FAP_USER + "/delete_resume_form";
	
	/**
	 * FAP 이력서 정보 업데이트  2018. 12. 11. 남유송
	 */
	public static final String SOCIETY_FAP_USER_RESUME_UPDATE_FORM = SOCIETY_FAP_USER + "/resume_update_form";
	
	/**
	 * FAP 이력서 정보 읽기 폼  2019. 03. 15. 이종호
	 */
	public static final String SOCIETY_FAP_USER_RESUME_READ_FORM = SOCIETY_FAP_USER + "/resume_read_form";
	
	/**
	 * FAP 이력서 정보 업데이트  2018. 12. 11. 남유송
	 */
	public static final String SOCIETY_FAP_USER_RESUME_UPDATE = SOCIETY_FAP_USER + "/resume_update";
	
	/**
	 * FAP 이력서 정보 업데이트  2019. 01. 09. 남유송
	 */
	public static final String SOCIETY_FAP_USER_RESUME_DELETABLE_CHECK = SOCIETY_FAP_USER + "/resume_deletable_check";
	
	/**
	 * FAP 관리자 기업별  지원자 페이지로 이동  2019. 12. 31. 남유송
	 */
	public static final String  SOCIETY_FAP_ADMIN_APPLICANT_STATUS_PER_COMP= SOCIETY_FAP_ADMIN + "/applicant_status_per_comp";
	
	/**
	 * FAP 관리자 지원자별  지원 페이지로 이동  2019. 5. 16. 이종호
	 */
	public static final String  SOCIETY_FAP_ADMIN_APPLICANT_STATUS_PER_APPLIER= SOCIETY_FAP_ADMIN + "/applicant_status_per_applier";
	
	/**
	 * FAP 관리자 지원자별  지원현황 검색  2019. 5. 17. 이종호
	 */
	public static final String  SOCIETY_FAP_ADMIN_APPLICANT_STATUS_PER_APPLIER_SEARCH= SOCIETY_FAP_ADMIN + "/applicant_status_per_applier_search";
	
	/**
	 * FAP 관리자 지원자별  지원현황 엑셀 다운  2019. 5. 20. 이종호
	 */
	public static final String  SOCIETY_FAP_ADMIN_APPLICANT_STATUS_PER_APPLIER_EXCEL= SOCIETY_FAP_ADMIN + "/applicant_status_per_applier_excel";
	
	/**
	 * FAP 관리자 기업별  지원현황 엑셀 다운  2019. 6. 4. 이종호
	 */
	public static final String  SOCIETY_FAP_ADMIN_APPLICANT_STATUS_PER_COMP_EXCEL= SOCIETY_FAP_ADMIN + "/applicant_status_per_comp_excel";
	
	/**
	 * FAP 관리자 기업별  지원자 폼으로 이동  2019. 12. 31. 남유송
	 */
	public static final String  SOCIETY_FAP_ADMIN_APPLICANT_STATUS_PER_COMP_FORM= SOCIETY_FAP_ADMIN + "/applicant_status_per_comp_form";
	
	/**
	 * FAP 관리자 잡페어 세부정보 검색 리스트 출력  2019. 12. 31. 남유송
	 */
	public static final String SOCIETY_FAP_ADMIN_JOB_FAIR_DIVIDE_SEARCH_LIST = SOCIETY_FAP_ADMIN + "/select_all_job_fair_divide";
	
	/**
	 * FAP 관리자 잡페어별  채용공고 리스트 출력  2019. 12. 31. 남유송
	 */
	public static final String SOCIETY_FAP_ADMIN_JOB_FAIR_AD_LIST = SOCIETY_FAP_ADMIN + "/select_jobfair_job_ad";
	
	/**
	 * FAP 관리자 잡페어별  채용공고 리스트 출력  2019. 01. 03. 남유송
	 */
	public static final String SOCIETY_FAP_ADMIN_APPLICANT_LIST_PER_JOB_AD = SOCIETY_FAP_ADMIN + "/applicant_list_per_job_ad";
	
	/**
	 * FAP 관리자 잡페어별  채용공고 리스트 출력  2019. 01. 03. 남유송
	 */
	public static final String SOCIETY_FAP_ADMIN_APPLICANT_LIST_PER_JOB_AD_FORM = SOCIETY_FAP_ADMIN + "/applicant_list_per_job_ad_form";
	
	/**
	 * FAP 관리자 잡페어별  채용공고 리스트 출력  2019. 01. 04. 남유송
	 */
	public static final String SOCIETY_FAP_ADMIN_APPLIED_RESUME_LIST = SOCIETY_FAP_ADMIN + "/applied_resume_list";
	
	/**
	 * FAP 지원자별 전형 결과 리스트 출력  2019. 01. 21. 남유송
	 */
	public static final String SOCIETY_FAP_ADMIN_APPLIED_RESULT_LIST = SOCIETY_FAP_ADMIN +"/applied_result_list";
		
	/**
	 * FAP 채용전형별 기업 그룹코드 설정 리스트 출력  2019. 02. 20. 남유송
	 */
 	public static final String SOCIETY_FAP_ADMIN_COMPANY_GROUP_CODE_PER_JOB_FAIR = SOCIETY_FAP_ADMIN +"/admin_company_group_code_management_per_job_fair";
	
	/**
	 * FAP 관리자 잡페어 리스트 출력 2019. 02. 21. 남유송
	 */
	public static final String SOCIETY_FAP_ADMIN_SELECT_JOBFAIR_LIST = SOCIETY_FAP_ADMIN +"/admin_select_jobfair_list";
	
	/**
	 * FAP 관리자 잡페어 리스트 출력 2019. 02. 21. 남유송
	 */
	public static final String SOCIETY_FAP_ADMIN_COMPANY_SELECT_JOBFAIR_LIST = SOCIETY_FAP_ADMIN +"/admin_select_all_job_fair_divide";
	
	/**
	 * FAP 관리자 잡페어 리스트 출력 2019. 02. 25. 남유송
	 */
	public static final String SOCIETY_FAP_ADMIN_COMPANY_CHANGE_GROUPCODE = SOCIETY_FAP_ADMIN +"/change_groupcode";
	
	/**
	 * FAP 지원자별 전형 결과 리스트 출력  2019. 02. 15. 남유송
	 */
	public static final String SOCIETY_FAP_COMPANY_APPLICANT_STAT_PER_JOB_AD= SOCIETY_FAP_COMPANY +"/applicant_status_per_job_ad";
	/**
	 * FAP 채용공고별 이력서 출력  2019. 02. 19. 남유송
	 */
	public static final String SOCIETY_FAP_COMPANY_APPLIED_RESUME_LIST= SOCIETY_FAP_COMPANY +"/applied_resume_list";
	
	
 
	/**
	 * 
	 * FAP 남유송 끝
	 * 
	 */
	

	/**
	 * 
	 * FAP 원병호 시작
	 * 
	 */
	
	/**
	 * 통합잡페어(FAP) 기업 로드맵용 URL (/fap/company_roadmap) 2018 12 13 원병호
	 */
	public static final String SOCIETY_FAP_COMPANY_ROADMAP = SOCIETY_FAP + "/company_roadmap";
	
	/**
	 * 통합잡페어(FAP) 기업 로드맵 메인페이지 URL (/fap/company_roadmap/main) 2018 12 13 원병호
	 */
	public static final String SOCIETY_FAP_COMPANY_ROADMAP_MAIN = SOCIETY_FAP_COMPANY_ROADMAP + "/main";
	
	/**
	 * 통합잡페어(FAP) 기업 로드맵 잡페어 세부정보 가져오는 ajax URL (/fap/company_roadmap/select_jobfair_divide) 2018 12 20 원병호
	 */
	public static final String SOCIETY_FAP_COMPANY_ROADMAP_SELECT_JOBFAIR_DIVIDE = SOCIETY_FAP_COMPANY_ROADMAP + "/select_jobfair_divide";
	
	/**
	 * FAP 기업 로드맵 세부 잡페어별 진행중, 마감된 채용공고 리스트 호출 
	 * */
	public static final String SOCIETY_FAP_COMPANY_ROADMAP_SELECT_JOB_AD_TITLE_LIST = SOCIETY_FAP_COMPANY_ROADMAP + "/select_job_ad_title_list";
	
	/**
	 * 통합잡페어(FAP) 기업 로드맵 잡페어 세부정보 가져오는 ajax URL (/fap/company_roadmap/select_job_recruit_pcs) 2018 12 24 원병호
	 */
	public static final String SOCIETY_FAP_COMPANY_ROADMAP_SELECT_JOB_RECRUIT_PCS = SOCIETY_FAP_COMPANY_ROADMAP + "/select_job_recruit_pcs";
	
	/**
	 * 통합잡페어(FAP) 기업 로드맵 프로세스 진행에 필요한 정보 가져오는 ajax URL (/fap/company_roadmap/roadmap_process_map) 2018 12 27 원병호
	 */
	public static final String SOCIETY_FAP_COMPANY_ROADMAP_ROADMAP_PROCESS_MAP = SOCIETY_FAP_COMPANY_ROADMAP + "/roadmap_process_map";
	
	/*
	 * FAP 담당자 - 채용공고 상태 수정; 2019. 1. 26. 원병호
	 */
	public static final String SOCIETY_FAP_COMPANY_UPDATE_JOB_AD_STATE = SOCIETY_FAP_COMPANY + "/update_job_ad_state";
	
	/*
	 * FAP 채용기업 - 채용공고 읽기 2019. 2. 13 원병호
	 */
	public static final String SOCIETY_FAP_COMPANY_JOB_AD_READ_FORM = SOCIETY_FAP_COMPANY + "/company_job_ad_read_form";
	
	/*
	 * FAP 에이전시 - 에이전시 읽기 2019. 2. 17  원병호
	 */
	public static final String SOCIETY_FAP_AGENCY_JOB_AD_READ_FORM = SOCIETY_FAP_AGENCY + "/agency_job_ad_read_form";
	
	/*
	 * FAP 관리지 - 관리자 잡페어 지원가능시간 관리 2019. 2. 21  원병호
	 */
	public static final String SOCIETY_FAP_ADMIN_JOBFAIR_APPLICABLE_TIME_MANAGEMENT = SOCIETY_FAP_ADMIN + "/jobfair_applicable_time_management";
	
	/*
	 * FAP 관리자 - 관리자 채용공고 읽기 URL 2019. 2. 21 원병호 
	 */
	public static final String SOCIETY_FAP_ADMIN_JOB_AD_READ_FORM = SOCIETY_FAP_ADMIN + "/job_ad_read_form";
	
	/**
	 * FAP 관리자 - 관리자 오픈잡페어 채용공고 읽기 2019.6.17 이종호
	 * */
	public static final String SOCIETY_FAP_ADMIN_OPEN_JOB_AD_READ_FORM = SOCIETY_FAP_ADMIN + "/open_job_ad_read_form";
	

	/*
	 * FAP 관리지 - 관리자 잡페어 지원가능시간 관리 2019. 2. 21  원병호
	 */
	public static final String SOCIETY_FAP_ADMIN_INSERT_JOB_APPLICABLETIME = SOCIETY_FAP_ADMIN + "/insert_job_applicabletime";
	
	/*
	 * FAP 관리지 - 관리자 잡페어 지원가능시간 수정 2019. 3. 04  원병호
	 */
	public static final String SOCIETY_FAP_ADMIN_UPDATE_JOB_APPLICABLETIME = SOCIETY_FAP_ADMIN + "/update_job_applicabletime";
	
	/*
	 * FAP 관리지 - 관리자 잡페어 지원가능시간 삭제 2019. 3. 04  원병호
	 */
	public static final String SOCIETY_FAP_ADMIN_DELETE_JOB_APPLICABLETIME = SOCIETY_FAP_ADMIN + "/delete_job_applicabletime";
	
	/*
	 * FAP 담당자 - 채용공고 Q&A ; 2019. 3. 05. 원병호
	 */
	public static final String SOCIETY_FAP_COMPANY_JOB_QNA = SOCIETY_FAP_COMPANY + "/company_job_qna";
	
	/*
	 * FAP 담당자 - 채용공고 Q&A ; 2019. 3. 05. 원병호
	 */
	public static final String SOCIETY_FAP_COMPANY_JOB_QNA_MANAGEMENT = SOCIETY_FAP_COMPANY + "/company_job_qna_management";
	
	/*
	 * FAP 담당자 - 채용공고 Q&A 답변 등록 ; 2019. 3. 06. 원병호
	 */
	public static final String SOCIETY_FAP_COMPANY_JOB_QNA_ANSWER_INSERT = SOCIETY_FAP_COMPANY + "/company_job_qna_answer_insert";
	
	/*
	 * FAP 담당자 - 채용공고 Q&A 답변 등록 ; 2019. 3. 06. 원병호
	 */
	public static final String SOCIETY_FAP_COMPANY_JOB_QNA_ANSWER_UPDATE = SOCIETY_FAP_COMPANY + "/company_job_qna_answer_update";
	
	/*
	 * FAP 사용자 - 채용공고 Q&A 관리 ; 2019. 3. 08. 원병호
	 */
	public static final String SOCIETY_FAP_USER_JOB_QNA_MANAGEMENT = SOCIETY_FAP_USER + "/user_job_qna_management";
	
	/*
	 * FAP 사용자 - 채용공고 Q&A 관리 ; 2019. 3. 08. 원병호
	 */
	public static final String SOCIETY_FAP_USER_JOB_QNA_INSERT = SOCIETY_FAP_USER + "/user_job_qna_insert";
	
	/*
	 * FAP 담당자 - 채용공고 Q&A ; 2019. 3. 11. 원병호
	 */
	public static final String SOCIETY_FAP_USER_JOB_QNA = SOCIETY_FAP_USER + "/user_job_qna";
	
	/*
	 * FAP 사용자 - 채용공고 Q&A 질문 수정 ; 2019. 3. 11. 원병호
	 */
	public static final String SOCIETY_FAP_USER_JOB_QNA_UPDATE = SOCIETY_FAP_USER + "/user_job_qna_update";
	
	/*
	 * FAP 사용자 - 채용공고 Q&A 질문 삭제 ; 2019. 3. 11. 원병호
	 */
	public static final String SOCIETY_FAP_USER_JOB_QNA_DELETE = SOCIETY_FAP_USER + "/user_job_qna_delete";
	
	/*
	 * FAP 에이전시 - 채용공고 Q&A ; 2019. 3. 14. 원병호
	 */
	public static final String SOCIETY_FAP_AGENCY_JOB_QNA = SOCIETY_FAP_AGENCY + "/agency_job_qna";
	
	/*
	 * FAP 에이전시 - 채용공고 Q&A ; 2019. 3. 14. 원병호
	 */
	public static final String SOCIETY_FAP_AGENCY_JOB_QNA_MANAGEMENT = SOCIETY_FAP_AGENCY + "/agency_job_qna_management";
	
	/*
	 * FAP 에이전시 - 채용공고 Q&A 답변 등록 ; 2019. 3. 14. 원병호
	 */
	public static final String SOCIETY_FAP_AGENCY_JOB_QNA_ANSWER_INSERT = SOCIETY_FAP_AGENCY + "/agency_job_qna_answer_insert";
	
	/*
	 * FAP 에이전시 - 채용공고 Q&A 답변 등록 ; 2019. 3. 14. 원병호
	 */
	public static final String SOCIETY_FAP_AGENCY_JOB_QNA_ANSWER_UPDATE = SOCIETY_FAP_AGENCY + "/agency_job_qna_answer_update";
	
	
	/**
	 * 
	 * FAP 원병호 끝
	 * 
	 */
	
	/**
	 * 
	 * FAP 김홍일 시작
	 * 
	 */
	
	/**
	 * 
	 * FAP 김홍일 끝
	 * 
	 */
	
	/**
	 * 
	 * FAP 정대영 시작
	 * 
	 */
	
	/**
	 * FAP 개인취업지원자 메인 주소 2018. 12. 5. 정대영
	 */
	public static final String SOCIETY_FAP_USER_MAIN = SOCIETY_FAP_USER + "/user_main";
	/**
	 * FAP 기업 메인 주소 2018. 12. 5. 정대영
	 */
	public static final String SOCIETY_FAP_COMPANY_MAIN = SOCIETY_FAP_COMPANY + "/company_main";
	/**
	 * FAP 취업지원자 잡페어 신청 주소 2018. 12. 12. 정대영
	 */
	public static final String SOCIETY_FAP_USER_ENTRY_REQUEST = SOCIETY_FAP_USER + "/entry_request";
	/**
	 * FAP 취업지원자 잡페어 채용공고 폼 요청주소 2018. 12. 12. 정대영
	 */
	public static final String SOCIETY_FAP_USER_JOB_ADVERTISEMENT_LIST_FORM = SOCIETY_FAP_USER + "/user_job_advertisement_list_form";
	/**
	 * FAP 취업지원자 잡페어 채용공고 읽기 폼 요청주소 2018. 12. 13. 정대영
	 */
	public static final String SOCIETY_FAP_USER_JOB_ADVERTISEMENT_READ_FORM = SOCIETY_FAP_USER + "/user_job_advertisement_read_form";
	/**
	 * FAP 취업지원자 잡페어 지원현황관리 페이지 요청 주소   2018. 12. 14. 정대영
	 */
	public static final String SOCIETY_FAP_USER_TOTAL_APPLY_STATUS_FORM = SOCIETY_FAP_USER + "/user_total_apply_status_form";
	/**
	 * FAP 취업지원자 잡페어 내가담은기업보기에 기업담기   2018. 12. 14. 정대영
	 */
	public static final String SOCIETY_FAP_USER_INSERT_MY_FAVORITE_COMPANY = SOCIETY_FAP_USER + "/insert_my_favorite_company";
	/**
	 * FAP 취업지원자 잡페어 내가담은기업보기 리스트 출력 요청 주소   2018. 12. 14. 정대영
	 */
	public static final String SOCIETY_FAP_USER_MY_FAVORITE_COMPANY_LIST_FORM = SOCIETY_FAP_USER + "/user_my_favorite_company_list_form";
	/**
	 * FAP 취업지원자 잡페어 내가담은기업보기 리스트 삭제 요청 주소   2018. 12. 17. 정대영
	 */
	public static final String SOCIETY_FAP_USER_DELETE_MY_FAVORITE_COMPANY_LIST = SOCIETY_FAP_USER + "/delete_my_favorite_company_list";
	/**
	 * FAP 취업지원자 잡페어 채용공고 상세 검색   2018. 12. 20. 정대영
	 */
	public static final String SOCIETY_FAP_USER_SEARCH_JOB_ADVERTISEMENT_LIST = SOCIETY_FAP_USER + "/search_job_advertisement_list";
	/**
	 * FAP 취업지원자 잡페어 채용공고 상세 검색   2018. 12. 20. 정대영
	 */
	public static final String SOCIETY_FAP_ADMIN_SEARCH_JOB_ADVERTISEMENT_LIST = SOCIETY_FAP_ADMIN + "/admin_search_job_advertisement_list";	
	/**
	 * FAP 취업지원자 잡페어 채용공고 상세 검색   2018. 12. 24. 정대영
	 */
	public static final String SOCIETY_FAP_USER_COMPANY_SCALE_STATISTICS = SOCIETY_FAP_USER + "/company_scale_statistics";
	/**
	 * FAP 취업지원자 잡페어 회사 지원하기 폼 요청 주소  2018. 12. 27. 정대영
	 */
	public static final String SOCIETY_FAP_USER_APPLY_THIS_JOB_ADVERTISEMENT_FORM = SOCIETY_FAP_USER + "/apply_this_job_advertisement_form";
	/**
	 * FAP 취업지원자 잡페어 회사 지원하기  2018. 12. 28. 정대영
	 */
	public static final String SOCIETY_FAP_USER_APPLY_THIS_JOB_ADVERTISEMENT = SOCIETY_FAP_USER + "/apply_this_job_advertisement";
	/**
	 * FAP 채용공고 중복지원 여부 체크  2018. 12. 31. 정대영
	 */
	public static final String SOCIETY_FAP_USER_APPLY_THIS_JOB_ADVERTISEMENT_APPLICABLE_CHECK = SOCIETY_FAP_USER + "/apply_this_job_advertisement_applicable_check";
	/**
	 * FAP 관리자 추가지원 기업설정  2019. 1. 7. 정대영
	 */
	public static final String SOCIETY_FAP_ADMIN_ADDITIONAL_APPLY_COMPANY_CONFIGURED = SOCIETY_FAP_ADMIN + "/additional_apply_company_configured";
	/**
	 * FAP 관리자 잡페어 세부 정보 비동기 셀렉트  2019. 1. 8. 정대영
	 */
	public static final String SOCIETY_FAP_ADMIN_SELECT_JOBFAIR_DIVIDE_LIST_IN_ADDITIONAL_APPLY = SOCIETY_FAP_ADMIN + "/select_jobfair_divide_list_in_additional_apply";
	/**
	 * FAP 관리자 잡페어 세부 별 채용공고 진행상황 리스트 셀렉트  2019. 1. 8. 정대영
	 */
	public static final String SOCIETY_FAP_ADMIN_SELECT_JOBFAIR_DIVIDE_AD_APPLY_STATUS_INFO = SOCIETY_FAP_ADMIN + "/select_jobfair_divide_ad_apply_status_info";
	/**
	 * FAP 관리자 잡페어 세부 별 추가지원 가능한 채용공고 리스트 셀렉트  2019. 1. 8. 정대영
	 */
	public static final String SOCIETY_FAP_ADMIN_SELECT_JOBFAIR_DIVIDE_ADDITION_COMP_LIST = SOCIETY_FAP_ADMIN + "/select_jobfair_divide_addition_comp_list";
	/**
	 * FAP 관리자 잡페어 세부 별 추가지원 가능한 채용공고로 설정하기  2019. 1. 8. 정대영
	 */
	public static final String SOCIETY_FAP_ADMIN_INSERT_JOBFAIR_DIVIDE_ADDITION_COMP_LIST = SOCIETY_FAP_ADMIN + "/insert_jobfair_divide_addition_comp_list";
	/**
	 * FAP 관리자 잡페어 세부 별 추가지원 가능한 채용공고에서 설정 삭제 2019. 1. 8. 정대영
	 */
	public static final String SOCIETY_FAP_ADMIN_DELETE_JOBFAIR_DIVIDE_ADDITION_COMP_LIST = SOCIETY_FAP_ADMIN + "/delete_jobfair_divide_addition_comp_list";
	/**
	 * FAP 관리자 잡페어 세부 별 지원룰 적용 페이지로 이동 2019. 1. 9. 정대영
	 */
	public static final String SOCIETY_FAP_ADMIN_APPLY_BUSINESS_RULE_APPLICATION_FORM = SOCIETY_FAP_ADMIN + "/apply_business_rule_application_form";
	/**
	 * FAP 관리자 세부잡페어별 지원룰 명칭 리스트 조회 2019.08.06 이종호
	 * */
	public static final String SOCIETY_FAP_ADMIN_SELECT_JOBFAIR_APPLICABLE_TIME_NM_LIST = SOCIETY_FAP_ADMIN +"/select_jobfair_applicable_time_nm_list";
	/**
	 * FAP 관리자 세부잡페어별 지원룰 대상 채용공고 리스트 조회 2019.08.07 이종호
	 * */
	public static final String SOCIETY_FAP_ADMIN_SELECT_JOBFAIR_APPLICABLE_AD_LIST = SOCIETY_FAP_ADMIN + "/select_jobfair_applicable_ad_list";
	/**
	 * FAP 관리자 잡페어 세부별 지원가능 시간 조회 2019. 1. 9. 정대영
	 */
	public static final String SOCIETY_FAP_ADMIN_SELECT_JOBFAIR_DIVIDE_APPLICABLE_TIME = SOCIETY_FAP_ADMIN + "/select_jobfair_divide_applicable_time";
	/**
	 * FAP 관리자 잡페어 세부별 룰 적용 후 취업지원자 이력서 승인 2019. 1. 9. 정대영
	 */
	public static final String SOCIETY_FAP_ADMIN_RESUME_APPROVAL_AFTER_RULE_APPLY = SOCIETY_FAP_ADMIN + "/resume_approval_after_rule_apply";
	/**
	 * FAP 관리자 잡페어 세부별 룰 무시하고 취업지원자 이력서 승인 2019. 1. 9. 정대영
	 */
	public static final String SOCIETY_FAP_ADMIN_RESUME_IGNORE_AFTER_RULE_APPLY = SOCIETY_FAP_ADMIN + "/resume_ignore_after_rule_apply";
	/**
	 * FAP 취업지원자 개인지원현황 리스트 요청 2019. 1. 15. 정대영
	 */
	public static final String SOCIETY_FAP_USER_PERSONAL_APPLY_STATUS_FORM = SOCIETY_FAP_USER + "/user_personal_apply_status_form";
	/**
	 * FAP 취업지원자 개인지원현황 최종확정 2019. 3. 25. 이종호
	 */
	public static final String SOCIETY_FAP_USER_PERSONAL_APPLY_FINAL_DECISION = SOCIETY_FAP_USER + "/user_personal_apply_final_decision";
	/**
	 * FAP 취업지원자 진행상황 상세정보 모달창 출력 정보 요청 2019. 1. 16. 정대영
	 */
	public static final String SOCIETY_FAP_USER_SELECT_APPLY_STATUS_DETAIL_INFO_MODAL = SOCIETY_FAP_USER + "/select_apply_status_detail_info_modal";
	/**
	 * FAP 취업지원자 지원기업편집 모달창 출력 정보 요청 2019. 1. 16. 정대영
	 */
	public static final String SOCIETY_FAP_USER_SELECT_APPLIED_COMPANY_RANK_EDIT_INFO_MODAL = SOCIETY_FAP_USER + "/select_applied_company_rank_edit_info_modal";
	/**
	 * FAP 취업지원자 승인 전 지원정보 삭제 요청 2019. 1. 18. 정대영
	 */
	public static final String SOCIETY_FAP_USER_DELETE_CURRENT_APPLY_INFO = SOCIETY_FAP_USER + "/delete_current_apply_info";
	/**
	 * FAP 회사 잡페어 신청 페이지 이동 요청 2019. 1. 24. 정대영
	 */
	public static final String SOCIETY_FAP_COMPANY_JOBFAIR_APPLY_TO_ATTEND_FORM = SOCIETY_FAP_COMPANY + "/company_jobfair_apply_to_attend_form";
	/**
	 * FAP 회사 채용공고 상태별 채용공고 리스트 요청 2019. 1. 31.  정대영
	 */
	public static final String SOCIETY_FAP_COMPANY_SELECT_PER_STATE_JOB_AD_LIST = SOCIETY_FAP_COMPANY + "/company_select_per_state_job_ad_list";
	/*
	 * FAP 기업 담당자 정보 삭제 자식창으로 이동; 2019. 1. 31. 정대영
	 */
	public static final String SOCIETY_FAP_COMPANY_USER_INFO_DELETE_FORM = SOCIETY_FAP_COMPANY + "/company_user_info_delete_form";
	/**
	 * FAP 에이전시 채용공고 회사별 상태별 채용공고 리스트 요청 2019. 1. 31 정대영
	 */
	public static final String SOCIETY_FAP_AGENCY_SELECT_PER_STATE_JOB_AD_LIST = SOCIETY_FAP_AGENCY + "/agency_select_per_state_job_ad_list";
	/*
	 * FAP 에이전시 채용공고 상태 수정; 2019. 2. 7. 정대영
	 */
	public static final String SOCIETY_FAP_AGENCY_UPDATE_JOB_AD_STATE = SOCIETY_FAP_AGENCY + "/update_job_ad_state";
	/*
	 * FAP 에이전시 에이전시 관리 회사들 목록 출력 폼 요청 2019. 2. 7. 정대영
	 */
	public static final String SOCIETY_FAP_AGENCY_SELECT_ALLOWABLE_COMPANY_LIST_FORM = SOCIETY_FAP_AGENCY + "/agency_select_allowable_company_list_form";
	/*
	 * FAP 에이전시 에이전시 관리 회사 잡페어 참가 요청; 2019. 2. 7. 정대영
	 */
	public static final String SOCIETY_FAP_AGENCY_INSERT_COMPANY_JOBFAIR_JOIN_TABLE = SOCIETY_FAP_AGENCY + "/insert_company_jobfair_join_table";
	/*
	 * FAP 에이전시 참가 할 회사 목록 폼 요청 2019. 2. 8. 정대영
	 */
	public static final String SOCIETY_FAP_AGENCY_SELECT_ATTEND_COMPANY_LIST_FORM = SOCIETY_FAP_AGENCY + "/agency_select_attend_company_list_form";
	/*
	 * FAP 에이전시 선택한 회사 세션 저장 요청 2019. 2. 8. 정대영
	 */
	public static final String SOCIETY_FAP_AGENCY_CHOSEN_COMPANY_ID_SAVE_SESSION = SOCIETY_FAP_AGENCY + "/chosen_company_id_save_session";
	/*
	 * FAP 에이전시 채용공고 관리화면에서 관리회사 목록 요청 2019. 2. 8. 정대영
	 */
	public static final String SOCIETY_FAP_AGENCY_SELECT_IN_JOB_MANAGEMENT_COMPANY_LIST = SOCIETY_FAP_AGENCY + "/select_in_job_management_company_list";
	/*
	 * FAP 기업 채용공고 등록화면에서 이전 채용공고 불러오기 페이징 된 정보 요청 2019. 2. 8. 정대영
	 */
	public static final String SOCIETY_FAP_COMPANY_SELECT_SELECT_JOB_AD_LOAD_LIST_PAGING = SOCIETY_FAP_COMPANY + "/select_job_ad_load_list_paging";
	/**
	 * 통합잡페어(FAP) 관리자 잡페어 세부정보 가져오는 ajax URL (/fap/admin/select_jobfair_divide) 2019 2. 12.  정대영
	 */
	public static final String SOCIETY_FAP_ADMIN_SELECT_JOBFAIR_DIVIDE = SOCIETY_FAP_ADMIN + "/select_jobfair_divide";
	/**
	 * FAP 관리자 상태별 채용공고 리스트 요청 2019. 2. 12.  정대영
	 */
	public static final String SOCIETY_FAP_ADMIN_SELECT_PER_STATE_JOB_AD_LIST = SOCIETY_FAP_ADMIN + "/admin_select_per_state_job_ad_list";
	/**
	 * FAP 관리자 지원가능인원 수정 2019. 2. 27.  이종호
	 */
	public static final String SOCIETY_FAP_ADMIN_JOB_APP_PER_UPDATE = SOCIETY_FAP_ADMIN + "/admin_job_app_per_update";
	/**
	 * FAP 관리자 현지제한인원 수정 2019. 7. 31. 이종호
	 * */
	public static final String SOCIETY_FAP_ADMIN_JOB_ITV_PER_UPDATE = SOCIETY_FAP_ADMIN + "/admin_job_itv_per_update";
	/*
	 * FAP 관리자 - 채용공고 상태 수정 2019. 02. 12 정대영
	 */
	public static final String SOCIETY_FAP_ADMIN_UPDATE_JOB_AD_STATE = SOCIETY_FAP_ADMIN + "/update_job_ad_state";
	
	/**
	 * FAP 관리자 잡페어 채용공고 상세검색 폼 요청 주소; 2019. 7. 25. 김경아
	 */
	public static final String SOCIETY_FAP_ADMIN_JOB_ADVERTISEMENT_SEARCH_FORM = SOCIETY_FAP_ADMIN + "/admin_job_advertisement_search_form";
	/**
	/**
	 * FAP 취업지원자 잡페어 신청 페이지 이동 요청 2019. 1. 24. 정대영
	 */
	public static final String SOCIETY_FAP_USER_JOBFAIR_APPLY_TO_ATTEND_FORM = SOCIETY_FAP_USER + "/user_jobfair_apply_to_attend_form";
	/**
	 * FAP 취업지원자 잡페어 채용기업 참가 폼; 2019. 2. 14. 정대영
	 */
	public static final String SOCIETY_FAP_USER_JOBFAIR_PARTICIPATION_FORM = SOCIETY_FAP_USER + "/user_jobfair_participation_form";
	/**
	 * FAP 취업지원자 잡페어 선택 모달 눌렀을 때 해당아이디 잡페어 목록 요청; 2019. 2. 15. 정대영
	 */
	public static final String SOCIETY_FAP_USER_CURRENT_PARTICIPATION_JOBFAIR_LIST = SOCIETY_FAP_USER + "/user_current_participation_jobfair_list";
	/**
	 * FAP 취업지원자 잡페어 선택 시 세션저장 요청; 2019. 2. 15. 정대영
	 */
	public static final String SOCIETY_FAP_USER_USER_REQUEST_SAVE_JOBFAIR_INFO = SOCIETY_FAP_USER + "/user_request_save_jobfair_info";
	/**
	 * FAP 취업지원자 잡페어 채용공고 상세검색 폼 요청 주소; 2019. 2. 15. 정대영
	 */
	public static final String SOCIETY_FAP_USER_JOB_ADVERTISEMENT_SEARCH_FORM = SOCIETY_FAP_USER + "/user_job_advertisement_search_form";
	/**
	 * FAP 취업지원자 개인지원현황 지망순위 변경 요청; 2019. 2. 20. 정대영
	 */
	public static final String SOCIETY_FAP_USER_REQUEST_APPLY_INFO_RANK_CHANGE = SOCIETY_FAP_USER + "/request_apply_info_rank_change";
	/**
	 * FAP 취업지원자 전체지원현황 상세정보 모달창 출력 정보 요청 2019. 2. 22. 정대영
	 */
	public static final String SOCIETY_FAP_USER_SELECT_TOTAL_APPLY_STATUS_DETAIL_INFO_MODAL = SOCIETY_FAP_USER + "/select_total_apply_status_detail_info_modal";
	/**
	 * FAP 취업지원자 이력서 읽기 폼 요청 2019. 2. 27. 정대영
	 */
	public static final String SOCIETY_FAP_USER_SELECT_USER_RESUME_INFO_READ = SOCIETY_FAP_USER + "/select_user_resume_info_read";
	/**
	 * 
	 * FAP 정대영 끝
	 * 
	 */
	
	/**
	 * FAP 기업 관련 이메일 관리  2019. 01. 03. 전상수
	 */
	public static final String  SOCIETY_FAP_ADMIN_EMAIL_ALL = SOCIETY_FAP_ADMIN + "/email_all";
	/**
	 * FAP 기업 관련 이메일 관리  2019. 01. 03. 전상수
	 */
	public static final String  SOCIETY_FAP_ADMIN_EMAIL_MANAGEMENT = SOCIETY_FAP_ADMIN + "/email_management";
	/**
	 * FAP 기업 관련 특정 이메일 가져오기  2019. 01. 03. 전상수
	 */
	public static final String  SOCIETY_FAP_ADMIN_EMAIL_SPECIFIC = SOCIETY_FAP_ADMIN + "/email_content";
	/**
	 * FAP 기업 관련 이메일보내기  2019. 01. 03. 전상수
	 */
	public static final String  SOCIETY_FAP_ADMIN_EMAIL_SEND = SOCIETY_FAP_ADMIN + "/email_send";
	
	
	/*
	 * FAP 오픈잡페어 지원자 메인페이지 기업배너 리스트 조회 2019. 07. 18. 김경아
	 */
	public static final String SOCIETY_FAP_USER_OPEN_COMP_BANNER_LIST = SOCIETY_FAP_USER + "/user_open_comp_banner_list";
	
	/*
	 * FAP 관리자 잡페어 그룹코드 조회 2019. 07. 29. 김경아
	 */
	public static final String SOCIETY_FAP_ADMIN_SELECT_COMPANY_GROUP_CODE_LIST = SOCIETY_FAP_ADMIN + "/admin_select_company_group_code_list";
	
	/*
	 * FAP 관리자 알림 게시판 이동 2019. 08. 29. 김경아
	 */
	public static final String SOCIETY_FAP_ADMIN_NOTICE_ALIM = SOCIETY_FAP_ADMIN +"/admin_notice_alim";
	
	/*
	 * FAP 관리자 알림 게시판 리스트 출력 2019. 08. 30. 김경아
	 */
	public static final String SOCIETY_FAP_ADMIN_NOTICE_ALIM_LIST = SOCIETY_FAP_ADMIN +"/admin_notice_alim_list";
	
	/*
	 * FAP 관리자 알림 게시판 처리/취소여부 변경 2019.09.06. 김경아
	 */
	public static final String SOCIETY_FAP_ADMIN_NOTICE_UPDATE_HANDLE_FIN_GB = SOCIETY_FAP_ADMIN + "/admin_notice_update_handle_fin_gb";
	
	/*
	 * FAP 관리자 알림 게시판 처리/취소여부 단체변경  2019.09.06. 김경아
	 */
	public static final String SOCIETY_FAP_ADMIN_NOTICE_UPDATE_HANDLE_FIN_GB_ALL_SELECTED = SOCIETY_FAP_ADMIN + "/admin_notice_update_handle_fin_gb_all_selected";
	
	/*
	 * FAP 관리자처리되지 않은 건 갯수 조회  2019.09.06. 김경아
	 */
	public static final String SOCIETY_FAP_SELECT_ADMIN_NOTICE_NOT_HANDLED = SOCIETY_FAP_ADMIN + "/select_admin_notice_list_not_handled";
	
}
