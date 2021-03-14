package com.changbi.tt.dev.data.vo;

import java.util.List;

import forFaith.dev.vo.CommonVO;

/**
 * @Class Name : QuizVO.java
 * @Description : 시험정보
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
public class QuizVO extends CommonVO {
	// 검색조건
    private QuizVO search;
    
    // 제출자현황과 미채점자 현황을 저장한다.(현황에서 사용 - 실제 테이블엔 없는 데이터라 Report와 조인해서 결과 가지고 와야함)
    private int submit;							// 제출자
    private int beforeApp;						// 미채점자
    
	private String id;	    					// 시험 마스터 ID
	private String title;						// 시험명
	private String quizType;					// 시험 종류(1:출석고사, 2:온라인평가, 3:온라인과제)
	private String startDate;					// 시험기간 시작 일자
	private String endDate;						// 시험기간 종료 일자
	private int examTime;						// 시험시간(분)
	private int score;							// 만점 점수(총문제수로 나누면 문제당 점수가 나옴)
	private String guide;						// 시험안내글
	private int retry;							// 재응시 횟수
	private String limits;						// 제한기능 복수선택(1:시간제한사용, 2:재응시허용, 3:타PC작업제한)
	private String limitKeys;					// 제한 키 복수선택(1:CTRL+C, 2:CTRL+P, 3:CTRL-V, 4:우마우스클릭)
	private String openYn;						// 답안공개여부(Y/N)
	
	private CardinalVO cardinal;				// 기수ID
	private CourseVO course;					// 과정ID
	private QuizPoolVO quizPool;				// 시험지풀 ID
	
	private List<ReportVO> reportList;			// 레포트 리스트 저장

    public QuizVO getSearch() {
        return search;
    }

    public void setSearch(QuizVO search) {
        this.search = search;
    }

	public int getSubmit() {
		return submit;
	}

	public void setSubmit(int submit) {
		this.submit = submit;
	}

	public int getBeforeApp() {
		return beforeApp;
	}

	public void setBeforeApp(int beforeApp) {
		this.beforeApp = beforeApp;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getQuizType() {
		return quizType;
	}

	public void setQuizType(String quizType) {
		this.quizType = quizType;
	}

	public String getStartDate() {
		return startDate;
	}

	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}

	public String getEndDate() {
		return endDate;
	}

	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}

	public int getExamTime() {
		return examTime;
	}

	public void setExamTime(int examTime) {
		this.examTime = examTime;
	}

	public int getScore() {
		return score;
	}

	public void setScore(int score) {
		this.score = score;
	}

	public String getGuide() {
		return guide;
	}

	public void setGuide(String guide) {
		this.guide = guide;
	}

	public int getRetry() {
		return retry;
	}

	public void setRetry(int retry) {
		this.retry = retry;
	}

	public String getLimits() {
		return limits;
	}

	public void setLimits(String limits) {
		this.limits = limits;
	}

	public String getLimitKeys() {
		return limitKeys;
	}

	public void setLimitKeys(String limitKeys) {
		this.limitKeys = limitKeys;
	}

	public String getOpenYn() {
		return openYn;
	}

	public void setOpenYn(String openYn) {
		this.openYn = openYn;
	}

	public CardinalVO getCardinal() {
		return cardinal;
	}

	public void setCardinal(CardinalVO cardinal) {
		this.cardinal = cardinal;
	}

	public CourseVO getCourse() {
		return course;
	}

	public void setCourse(CourseVO course) {
		this.course = course;
	}

	public QuizPoolVO getQuizPool() {
		return quizPool;
	}

	public void setQuizPool(QuizPoolVO quizPool) {
		this.quizPool = quizPool;
	}

	public List<ReportVO> getReportList() {
		return reportList;
	}

	public void setReportList(List<ReportVO> reportList) {
		this.reportList = reportList;
	}
}
