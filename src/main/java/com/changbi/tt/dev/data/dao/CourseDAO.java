package com.changbi.tt.dev.data.dao;

import java.util.HashMap;
import java.util.List;

import com.changbi.tt.dev.data.vo.CardinalVO;
import com.changbi.tt.dev.data.vo.ChapterVO;
import com.changbi.tt.dev.data.vo.CourseVO;
import com.changbi.tt.dev.data.vo.GroupLearnVO;
import com.changbi.tt.dev.data.vo.PaymentAdminVO;

import forFaith.dev.vo.CodeVO;
import forFaith.dev.vo.SubChapVO;

public interface CourseDAO {
	
	// 연수영역 리스트 조회 
	List<CodeVO> studyRangeList(CodeVO code) throws Exception;

	// 연수과정관리 리스트 조회
	List<CourseVO> trainProcessList(CourseVO course) throws Exception;

	// 연수과정관리 리스트 총 갯수
	int trainProcessTotalCnt(CourseVO course) throws Exception;

	// 연수과정관리 상세 조회
	CourseVO trainProcessInfo(CourseVO course) throws Exception;

	// 연수과정 등록
	void trainProcessReg(CourseVO course) throws Exception;
	
	// 연수과정 수정
	int trainProcessUpd(CourseVO course) throws Exception;

	// 연수과정 삭제
	int trainProcessDel(CourseVO course) throws Exception;
	
	// 연수과정 선택삭제
	int trainProcessSelectDel(List<CourseVO> courseList) throws Exception;
	
	// 챕터 리스트 조회
	List<ChapterVO> chapterList(ChapterVO chapter) throws Exception;

	// 챕터 등록
	void chapterReg(ChapterVO chapter) throws Exception;
	
	// 챕터 등록
	void newChapterReg(ChapterVO chapter) throws Exception;
	
	//목차 일괄등록
	void insertChap(SubChapVO vo) throws Exception;
	
	//페이지 일괄등록
	void insertPage(SubChapVO vo) throws Exception;
	
	//목차 리스트 조회
	List<SubChapVO> subChapterList(SubChapVO vo) throws Exception;
	
	//페이지 리스트 조회
	List<SubChapVO> subPageList(SubChapVO vo) throws Exception;
	
	//페이지 삭제
	void delSubPage(SubChapVO vo) throws Exception;
	
	//목차 삭제
	void delSubChap(SubChapVO vo) throws Exception;
	
	// 챕터 삭제
	int chapterDel(ChapterVO chapter) throws Exception;
	
	// 챕터 삭제
	int delChap(SubChapVO vo) throws Exception;
	
	// 기수 리스트 조회
	List<CardinalVO> cardinalList(CardinalVO cardinal) throws Exception;

	// 기수 리스트 총 갯수
	int cardinalTotalCnt(CardinalVO cardinal) throws Exception;

	// 기수 상세 조회
	CardinalVO cardinalInfo(CardinalVO cardinal) throws Exception;
	
	// 기수 등록
	void cardinalReg(CardinalVO cardinal) throws Exception;
	
	// 기수 수정
	int cardinalUpd(CardinalVO cardinal) throws Exception;

	// 기수 삭제
	int cardinalDel(CardinalVO cardinal) throws Exception;
	
	// 기수 선택 삭제
	int cardinalSelectDel(List<CardinalVO> cardinalList) throws Exception;

	// 단체연수 리스트 조회
	List<GroupLearnVO> groupLearnList(GroupLearnVO groupLearn) throws Exception;

	// 단체연수 리스트 총 갯수
	int groupLearnTotalCnt(GroupLearnVO groupLearn) throws Exception;

	// 단체연수 상세 조회
	GroupLearnVO groupLearnInfo(GroupLearnVO groupLearn) throws Exception;
	
	// 단체연수 등록
	void groupLearnReg(GroupLearnVO groupLearn) throws Exception;

	// 단체연수 삭제
	int groupLearnDel(GroupLearnVO groupLearn) throws Exception;
	
	// 과정에 의한 기수 연동 삭제
	int courseCardinalDel(CourseVO course) throws Exception;
	
	// 과정에 의한 기수 연동 등록
	int courseCardinalReg(CourseVO course) throws Exception;

	// 기수에 의한 과정 연동 삭제
	int cardinalCourseDel(CardinalVO cardinal) throws Exception;
	
	// 기수에 의한 과정 연동 등록
	int cardinalCourseReg(CardinalVO cardinal) throws Exception;
	
	// 단체연수에 의한 기수 연동 삭제
	int groupCardinalDel(GroupLearnVO groupLearn) throws Exception;
	
	// 단체연수에 의한 기수 연동 등록
	int groupCardinalReg(GroupLearnVO groupLearn) throws Exception;
	
	// 기수에 의한 설문 연동 삭제
	int cardinalSurveyDel(CardinalVO cardinal) throws Exception;
	
	// 기수에 의한 만족도 설문 연동 저장
	int cardinalSatisfactionReg(CardinalVO cardinal) throws Exception;
	
	// 기수에 의한 강의평가 설문 연동 저장
	int cardinalEvaluationReg(CardinalVO cardinal) throws Exception;

	// code에 따른 name 출력 
	List<CodeVO> getCodeNameList(CodeVO code) throws Exception;

	//대분류 코드 삭제1- 과정테이블의 학습영역 코드 삭제
	int subCourseDeleteRelatedCode(CodeVO code) throws Exception;
	
	//대분류 코드 삭제2- 코드테이블의 대분류,학습영역 코드 삭제 
	int subCourseDelete(CodeVO code) throws Exception;

	//대분류 selectbox 선택시 해당 학습영역리스트 출력
	List<CodeVO> selectCourseList(CodeVO code) throws Exception;

	//학습영역 코드 삭제1- 과정테이블의 학습영역 코드 삭제
	int studyRangeDeleteRelatedCode(CodeVO code) throws Exception;

	//LMS 기수 검색 팝업
	List<CardinalVO> selectCourseCardinalList2(HashMap<String, Object> param) throws Exception;
	
	//LMS 총 기수 개수
	int selectCourseCardinalList2TotCnt(HashMap<String,Object> param)throws Exception;

	//LMS 연수정보의 실수강 종료기간 변경(복습기간 변경)
	int realEndDateUpd(CourseVO course);
	
	//과정에 매핑된 기수의 분납 정보 조회
	List<PaymentAdminVO> selectPaymentAdminInfo(CourseVO course);

	//과정에 매핑된 기수의 분납 정보 등록
	void coursePaymentReg(CardinalVO cardinal);

	//과정과 기수를 매핑한 시퀀스 조회
	List<HashMap<String, Object>> selectCnCourseSeq(CourseVO course);
	
	//과정에 매핑된 기수의 납입 정보 등록
	void gisuPaymentReg(CardinalVO cardinal);
	
	//과정에 매핑된 기수의 납입 정보 수정
	void gisuPaymentUpdate(PaymentAdminVO payment);
	
	//과정에 매핑된 기수읜 납입 정보 삭제
	void deleteGisuPayment(int pay);
	
	void deleteGisuPaymentList(HashMap<String,Object> param);
}