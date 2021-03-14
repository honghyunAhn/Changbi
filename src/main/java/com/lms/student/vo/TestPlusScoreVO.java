package com.lms.student.vo;

import java.util.Date;

/*
 * 성적 가산점 테이블
 */
public class TestPlusScoreVO {

	private int 	score_plus_seq;				// 가산점		번호
	private int 	score_seq;					// 성적		번호
	private int 	score_plus_cat;				// 가산점		카테고리 		(가산점 방식) ex> 1 = 시험자체에 기입, 2 = 총합점수에 +시켜버림 등등
	private double 	score_plus;					// 가산점
	private String 	score_plus_content;			// 가산점		사유
	private Date 	score_plus_regdate;			// 가산점		등록날짜
	private Date 	score_plus_update;			// 가산점		수정날짜
	
	
	public TestPlusScoreVO() {
		super();
	}


	public TestPlusScoreVO(int score_plus_seq, int score_seq, int score_plus_cat, double score_plus,
			String score_plus_content, Date score_plus_regdate, Date score_plus_update) {
		super();
		this.score_plus_seq = score_plus_seq;
		this.score_seq = score_seq;
		this.score_plus_cat = score_plus_cat;
		this.score_plus = score_plus;
		this.score_plus_content = score_plus_content;
		this.score_plus_regdate = score_plus_regdate;
		this.score_plus_update = score_plus_update;
	}


	public int getScore_plus_seq() {
		return score_plus_seq;
	}


	public void setScore_plus_seq(int score_plus_seq) {
		this.score_plus_seq = score_plus_seq;
	}


	public int getScore_seq() {
		return score_seq;
	}


	public void setScore_seq(int score_seq) {
		this.score_seq = score_seq;
	}


	public int getScore_plus_cat() {
		return score_plus_cat;
	}


	public void setScore_plus_cat(int score_plus_cat) {
		this.score_plus_cat = score_plus_cat;
	}


	public double getScore_plus() {
		return score_plus;
	}


	public void setScore_plus(double score_plus) {
		this.score_plus = score_plus;
	}


	public String getScore_plus_content() {
		return score_plus_content;
	}


	public void setScore_plus_content(String score_plus_content) {
		this.score_plus_content = score_plus_content;
	}


	public Date getScore_plus_regdate() {
		return score_plus_regdate;
	}


	public void setScore_plus_regdate(Date score_plus_regdate) {
		this.score_plus_regdate = score_plus_regdate;
	}


	public Date getScore_plus_update() {
		return score_plus_update;
	}


	public void setScore_plus_update(Date score_plus_update) {
		this.score_plus_update = score_plus_update;
	}


	@Override
	public String toString() {
		return "TestPlusScore [score_plus_seq=" + score_plus_seq + ", score_seq=" + score_seq + ", score_plus_cat="
				+ score_plus_cat + ", score_plus=" + score_plus + ", score_plus_content=" + score_plus_content
				+ ", score_plus_regdate=" + score_plus_regdate + ", score_plus_update=" + score_plus_update + "]";
	}
	
	
	
}
