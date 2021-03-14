package com.changbi.tt.dev.data.vo;

import java.util.List;

import forFaith.dev.vo.AttachFileVO;
import forFaith.dev.vo.CommonVO;

/**
 * @Class Name : ReportVO.java
 * @Description : 시험문제평가
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
public class ReportVO extends CommonVO {
	// 검색조건
    private ReportVO search;
    
	private int id;	    						// 시험 평가 ID
	private String quizType;					// 시험 종류(1:출석고사, 2:온라인평가, 3:온라인과제)
	private String examNum;						// 수험번호(출석고사에서 사용)
	private String answer;						// 출석평가문제답안(답안OX : OOOXOOOOXOXXXXOOOOOOXXXOXOO 또는 1O2X3O4O5X6X7X8O)
	private String correct;						// 과제인 경우 첨삭
	private int score;							// 시험 종류별 성적
	private String markYn;						// 채점여부(Y/N)

	private LearnAppVO learnApp;				// 수강신청ID
	private CardinalVO cardinal;				// 기수ID
	private CourseVO course;					// 과정ID
	private QuizVO quiz;						// 시험 ID
	private UserVO user;						// 시험본 유저ID
	private ExamSpotVO examSpot;				// 출석평가 시 고사장ID(3자리로 고정)
	private AttachFileVO file;					// 문제 답안 파일ID(과제의 정답을 파일로 제출한 경우 저장)
	private AttachFileVO userFile;				// 출석시험 증명사진
	
	private List<QuizReplyVO> quizReplyList;	// 문제 답안 리스트
	private List<CopyRatioVO> copyRatioList;	// 모사율 리스트
	
    public ReportVO getSearch() {
        return search;
    }

    public void setSearch(ReportVO search) {
        this.search = search;
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

	public String getExamNum() {
		return examNum;
	}

	public void setExamNum(String examNum) {
		this.examNum = examNum;
	}

	public int getScore() {
		return score;
	}

	public void setScore(int score) {
		this.score = score;
	}

	public String getAnswer() {
		return answer;
	}

	public void setAnswer(String answer) {
		this.answer = answer;
	}

	public String getCorrect() {
		return correct;
	}

	public void setCorrect(String correct) {
		this.correct = correct;
	}

	public String getMarkYn() {
		return markYn;
	}

	public void setMarkYn(String markYn) {
		this.markYn = markYn;
	}

	public LearnAppVO getLearnApp() {
		return learnApp;
	}

	public void setLearnApp(LearnAppVO learnApp) {
		this.learnApp = learnApp;
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

	public QuizVO getQuiz() {
		return quiz;
	}

	public void setQuiz(QuizVO quiz) {
		this.quiz = quiz;
	}

	public UserVO getUser() {
		return user;
	}

	public void setUser(UserVO user) {
		this.user = user;
	}

	public ExamSpotVO getExamSpot() {
		return examSpot;
	}

	public void setExamSpot(ExamSpotVO examSpot) {
		this.examSpot = examSpot;
	}

	public AttachFileVO getFile() {
		return file;
	}

	public void setFile(AttachFileVO file) {
		this.file = file;
	}

	public AttachFileVO getUserFile() {
		return userFile;
	}

	public void setUserFile(AttachFileVO userFile) {
		this.userFile = userFile;
	}

	public List<QuizReplyVO> getQuizReplyList() {
		return quizReplyList;
	}

	public void setQuizReplyList(List<QuizReplyVO> quizReplyList) {
		this.quizReplyList = quizReplyList;
	}

	public List<CopyRatioVO> getCopyRatioList() {
		return copyRatioList;
	}

	public void setCopyRatioList(List<CopyRatioVO> copyRatioList) {
		this.copyRatioList = copyRatioList;
	}
}
