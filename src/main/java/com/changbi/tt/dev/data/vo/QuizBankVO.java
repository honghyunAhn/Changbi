package com.changbi.tt.dev.data.vo;

import java.util.List;

import forFaith.dev.vo.CommonVO;

/**
 * @Class Name : QuizBankVO.java
 * @Description : 시험문제은행
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
public class QuizBankVO extends CommonVO {
	// 검색조건
    private QuizBankVO search;
    
    // 검색 조건 시 기수ID로 조회가 넘어오는 경우
    private String cardinalId;
    
	private int id;	    						// 시험 문제 ID
	private String quizType;					// 시험 종류(1:출석고사, 2:온라인평가, 3:온라인과제)
	private String classType;					// 문제유형(A:A형, B:B형, C:C형)
	private String title;						// 문제명
	private String osType;						// 문항종류(O:객관식, S:주관식)
	private String examType;					// 객관식 유형(1:4지선다, 2:5지선다)
	private String exam1;						// 객관식 1번 보기
	private String exam2;						// 객관식 2번 보기
	private String exam3;						// 객관식 3번 보기
	private String exam4;						// 객관식 4번 보기
	private String exam5;						// 객관식 5번 보기
	private String category;					// 문항척도분류코드
	private String cateName;					// 문항척도분류명
	private String comment;						// 보충해설
	private int quizLevel;						// 퀴즈 난이도(1:하, 2:중, 3:상)
	private int oAnswer;						// 객관식 정답
	private String sAnswer;						// 주관식 정답
	
	private CourseVO course;					// 과정ID
	private List<QuizReplyVO> quizReplyList;	// 답안지 리스트
	
    public QuizBankVO getSearch() {
        return search;
    }

    public void setSearch(QuizBankVO search) {
        this.search = search;
    }

	public String getCardinalId() {
		return cardinalId;
	}

	public void setCardinalId(String cardinalId) {
		this.cardinalId = cardinalId;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getQuizType() {
		return quizType;
	}

	public void setQuizType(String quizType) {
		this.quizType = quizType;
	}

	public String getClassType() {
		return classType;
	}

	public void setClassType(String classType) {
		this.classType = classType;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getOsType() {
		return osType;
	}

	public void setOsType(String osType) {
		this.osType = osType;
	}

	public String getExamType() {
		return examType;
	}

	public void setExamType(String examType) {
		this.examType = examType;
	}

	public String getExam1() {
		return exam1;
	}

	public void setExam1(String exam1) {
		this.exam1 = exam1;
	}

	public String getExam2() {
		return exam2;
	}

	public void setExam2(String exam2) {
		this.exam2 = exam2;
	}

	public String getExam3() {
		return exam3;
	}

	public void setExam3(String exam3) {
		this.exam3 = exam3;
	}

	public String getExam4() {
		return exam4;
	}

	public void setExam4(String exam4) {
		this.exam4 = exam4;
	}

	public String getExam5() {
		return exam5;
	}

	public void setExam5(String exam5) {
		this.exam5 = exam5;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public String getCateName() {
		return cateName;
	}

	public void setCateName(String cateName) {
		this.cateName = cateName;
	}

	public String getComment() {
		return comment;
	}

	public void setComment(String comment) {
		this.comment = comment;
	}

	public int getQuizLevel() {
		return quizLevel;
	}

	public void setQuizLevel(int quizLevel) {
		this.quizLevel = quizLevel;
	}

	public int getoAnswer() {
		return oAnswer;
	}

	public void setoAnswer(int oAnswer) {
		this.oAnswer = oAnswer;
	}

	public String getsAnswer() {
		return sAnswer;
	}

	public void setsAnswer(String sAnswer) {
		this.sAnswer = sAnswer;
	}

	public CourseVO getCourse() {
		return course;
	}

	public void setCourse(CourseVO course) {
		this.course = course;
	}

	public List<QuizReplyVO> getQuizReplyList() {
		return quizReplyList;
	}

	public void setQuizReplyList(List<QuizReplyVO> quizReplyList) {
		this.quizReplyList = quizReplyList;
	}
}
