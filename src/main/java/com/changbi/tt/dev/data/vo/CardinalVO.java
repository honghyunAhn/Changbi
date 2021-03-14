package com.changbi.tt.dev.data.vo;

import java.util.List;

import forFaith.dev.vo.CommonVO;

/**
 * @Class Name : CardinalVO.java
 * @Description : 기수정보
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
public class CardinalVO extends CommonVO {
	// 검색조건
    private CardinalVO search;
    // 신청제한인원
    private int limitNum;						// 단체연수에서 기수 등록 시 기수 별로 신청제한 인원을 넣을 수 있음.
    
	private String id;    						// 기수 id
	private String name;						// 기수명
	private String learnType;					// 연수타입(J : 직무, S : 자율, M : 집합, G : 단체)
	private String credits;						// 직무연수학점(다중선택 고정) 메뉴명에서 선택 시
	private String courseType;					// 과정서비스형태(S : 선택과목서비스, A : 전체과목서비스)
	private String classDay;					// 수업일
	private String classStartTime;				// 수업시작시간
	private String classEndTime;				// 수업종료시간
	private String appStartDate;				// 접수시작일
	private String appEndDate;					// 접수종료일
	private String learnStartDate;				// 연수시작일
	private String learnEndDate;				// 연수종료일
	private String issueDate;					// 이수발급일
	private String attEvalDate;					// 출석평가일자
	private String attEvalTime;					// 출석평가시간
	private String attExamType;					// 출석고사장(A : 고사장숨김/변경신청불가, B : 고사장노출/변경신청가능, C : 고사장노출/변경신청불가)
	private int cancel;							// 수강취소가능기간(신청일로부터 1~10일) - 의미 없음
	private int dupLimit;						// 기수내 다른 과정 신청 제한(1~10개)
	private int addExamPeriod;					// 추가평가기간(1~5일) 온라인평가 과제제출기간에서 설정만큼 추가로 제출 가능
	private String openResults;					// 학점별 성적 공개(1~4학점) 다중선택
	private String appPossibles;				// 신청가능학점(1~4학점) 다중선택
	private String expectExam;					// 출석평가 예상문제(A~)
	private int preview;						// 예습미리보기(1~10강)
	private String complateYn;					// 이수처리 여부
	private int recruit;
	
	private SurveyVO satisfaction;				// 만족도 설문
	private SurveyVO evaluation;				// 강의평가 설문
	private List<CourseVO> courseList;			// 과정 리스트
	
	private int compPercentQuiz;		// 수료조건 반영비율 : 과제
    private int compPercentExam;		// 수료조건 반영비율 : 시험
    private int compPercentProg;		// 수료조건 반영비율 : 진도율
    private int compScoreQuiz;		// 수료조건 배점 : 과제
    private int compScoreExam;		// 수료조건 배점 : 시험
    private int compScoreProg;		// 수료조건 배점 : 진도율
    private int completeTotal;		// 수료 조건 총점
    
    private String checkOnline;		
    private int price;							// 교육비
    private List<PaymentAdminVO> paymentList;	// 분납정보 리스트
    
	public CardinalVO getSearch() {
		return search;
	}
	public String getClassDay() {
		return classDay;
	}
	public void setClassDay(String classDay) {
		this.classDay = classDay;
	}
	public String getClassStartTime() {
		return classStartTime;
	}
	public void setClassStartTime(String classStartTime) {
		this.classStartTime = classStartTime;
	}
	public String getClassEndTime() {
		return classEndTime;
	}
	public void setClassEndTime(String classEndTime) {
		this.classEndTime = classEndTime;
	}
	public void setSearch(CardinalVO search) {
		this.search = search;
	}
	public int getLimitNum() {
		return limitNum;
	}
	public void setLimitNum(int limitNum) {
		this.limitNum = limitNum;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getLearnType() {
		return learnType;
	}
	public void setLearnType(String learnType) {
		this.learnType = learnType;
	}
	public String getCredits() {
		return credits;
	}
	public void setCredits(String credits) {
		this.credits = credits;
	}
	public String getCourseType() {
		return courseType;
	}
	public void setCourseType(String courseType) {
		this.courseType = courseType;
	}
	public String getAppStartDate() {
		return appStartDate;
	}
	public void setAppStartDate(String appStartDate) {
		this.appStartDate = appStartDate;
	}
	public String getAppEndDate() {
		return appEndDate;
	}
	public void setAppEndDate(String appEndDate) {
		this.appEndDate = appEndDate;
	}
	public String getLearnStartDate() {
		return learnStartDate;
	}
	public void setLearnStartDate(String learnStartDate) {
		this.learnStartDate = learnStartDate;
	}
	public String getLearnEndDate() {
		return learnEndDate;
	}
	public void setLearnEndDate(String learnEndDate) {
		this.learnEndDate = learnEndDate;
	}
	public String getIssueDate() {
		return issueDate;
	}
	public void setIssueDate(String issueDate) {
		this.issueDate = issueDate;
	}
	public String getAttEvalDate() {
		return attEvalDate;
	}
	public void setAttEvalDate(String attEvalDate) {
		this.attEvalDate = attEvalDate;
	}
	public String getAttEvalTime() {
		return attEvalTime;
	}
	public void setAttEvalTime(String attEvalTime) {
		this.attEvalTime = attEvalTime;
	}
	public String getAttExamType() {
		return attExamType;
	}
	public void setAttExamType(String attExamType) {
		this.attExamType = attExamType;
	}
	public int getCancel() {
		return cancel;
	}
	public void setCancel(int cancel) {
		this.cancel = cancel;
	}
	public int getDupLimit() {
		return dupLimit;
	}
	public void setDupLimit(int dupLimit) {
		this.dupLimit = dupLimit;
	}
	public int getAddExamPeriod() {
		return addExamPeriod;
	}
	public void setAddExamPeriod(int addExamPeriod) {
		this.addExamPeriod = addExamPeriod;
	}
	public String getOpenResults() {
		return openResults;
	}
	public void setOpenResults(String openResults) {
		this.openResults = openResults;
	}
	public String getAppPossibles() {
		return appPossibles;
	}
	public void setAppPossibles(String appPossibles) {
		this.appPossibles = appPossibles;
	}
	public String getExpectExam() {
		return expectExam;
	}
	public void setExpectExam(String expectExam) {
		this.expectExam = expectExam;
	}
	public int getPreview() {
		return preview;
	}
	public void setPreview(int preview) {
		this.preview = preview;
	}
	public String getComplateYn() {
		return complateYn;
	}
	public void setComplateYn(String complateYn) {
		this.complateYn = complateYn;
	}
	public int getRecruit() {
		return recruit;
	}
	public void setRecruit(int recruit) {
		this.recruit = recruit;
	}
	public SurveyVO getSatisfaction() {
		return satisfaction;
	}
	public void setSatisfaction(SurveyVO satisfaction) {
		this.satisfaction = satisfaction;
	}
	public SurveyVO getEvaluation() {
		return evaluation;
	}
	public void setEvaluation(SurveyVO evaluation) {
		this.evaluation = evaluation;
	}
	public List<CourseVO> getCourseList() {
		return courseList;
	}
	public void setCourseList(List<CourseVO> courseList) {
		this.courseList = courseList;
	}
	public int getCompPercentQuiz() {
		return compPercentQuiz;
	}
	public void setCompPercentQuiz(int compPercentQuiz) {
		this.compPercentQuiz = compPercentQuiz;
	}
	public int getCompPercentExam() {
		return compPercentExam;
	}
	public void setCompPercentExam(int compPercentExam) {
		this.compPercentExam = compPercentExam;
	}
	public int getCompPercentProg() {
		return compPercentProg;
	}
	public void setCompPercentProg(int compPercentProg) {
		this.compPercentProg = compPercentProg;
	}
	public int getCompScoreQuiz() {
		return compScoreQuiz;
	}
	public void setCompScoreQuiz(int compScoreQuiz) {
		this.compScoreQuiz = compScoreQuiz;
	}
	public int getCompScoreExam() {
		return compScoreExam;
	}
	public void setCompScoreExam(int compScoreExam) {
		this.compScoreExam = compScoreExam;
	}
	public int getCompScoreProg() {
		return compScoreProg;
	}
	public void setCompScoreProg(int compScoreProg) {
		this.compScoreProg = compScoreProg;
	}
	public int getCompleteTotal() {
		return completeTotal;
	}
	public void setCompleteTotal(int completeTotal) {
		this.completeTotal = completeTotal;
	}
	public String getCheckOnline() {
		return checkOnline;
	}
	public void setCheckOnline(String checkOnline) {
		this.checkOnline = checkOnline;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public List<PaymentAdminVO> getPaymentList() {
		return paymentList;
	}
	public void setPaymentList(List<PaymentAdminVO> paymentList) {
		this.paymentList = paymentList;
	}
}	