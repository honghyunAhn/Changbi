package com.changbi.tt.dev.data.vo;

import forFaith.dev.vo.CommonVO;

/**
 * @Class Name : QuizReplyVO.java
 * @Description : 시험문제답안
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
public class QuizReplyVO extends CommonVO {
	// 검색조건
    private QuizReplyVO search;
    
	private int id;	    						// 시험 문제 ID
	private String osType;						// 문항종류(O:객관식, S:주관식)
	private String title;						// 문제명
	private String comment;						// 보충해설
	private int oAnswer;						// 객관식 정답
	private String sAnswer;						// 주관식 정답
	private int oReply;							// 객관식 본인 정답
	private String sReply;						// 주관식 본인 정답
	private int pScore;							// 문제당 점수
	private int tScore;							// 문제당 본인 획득 점수

	private ReportVO report;					// 평가 ID
	private QuizBankVO quizBank;				// 문제 은행 ID
	private QuizItemVO quizItem;				// 시험 문제 ID
	
    public QuizReplyVO getSearch() {
        return search;
    }

    public void setSearch(QuizReplyVO search) {
        this.search = search;
    }

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getOsType() {
		return osType;
	}

	public void setOsType(String osType) {
		this.osType = osType;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getComment() {
		return comment;
	}

	public void setComment(String comment) {
		this.comment = comment;
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

	public int getoReply() {
		return oReply;
	}

	public void setoReply(int oReply) {
		this.oReply = oReply;
	}

	public String getsReply() {
		return sReply;
	}

	public void setsReply(String sReply) {
		this.sReply = sReply;
	}

	public int getpScore() {
		return pScore;
	}

	public void setpScore(int pScore) {
		this.pScore = pScore;
	}

	public int gettScore() {
		return tScore;
	}

	public void settScore(int tScore) {
		this.tScore = tScore;
	}

	public ReportVO getReport() {
		return report;
	}

	public void setReport(ReportVO report) {
		this.report = report;
	}

	public QuizBankVO getQuizBank() {
		return quizBank;
	}

	public void setQuizBank(QuizBankVO quizBank) {
		this.quizBank = quizBank;
	}

	public QuizItemVO getQuizItem() {
		return quizItem;
	}

	public void setQuizItem(QuizItemVO quizItem) {
		this.quizItem = quizItem;
	}
}
