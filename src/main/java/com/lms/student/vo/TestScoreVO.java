package com.lms.student.vo;

import java.util.Date;

/*
 * 시험 성적 테이블 ( 점수 기입 ) 
 */
public class TestScoreVO {

	private int 	score_seq;				// 성적		번호
	private int		test_seq;				// 시험 		번호
	private String 	user_id;				// 학생 		ID
	private int 	plus_score;				// 가산점		번호
	private double	score;					// 점수			(소숫점 2자리수까지)
	private String 	score_regdate;			// 성적		등록날짜
	private String 	score_update;			// 성적		수정날짜
	private int		retest;					// 재응시한	횟수
	private String  content;
	
	
	
	public TestScoreVO() {
		super();
	}


	public TestScoreVO(int score_seq, int test_seq, String user_id, int plus_score, double score, String score_regdate,
			String score_update, int retest) {
		super();
		this.score_seq = score_seq;
		this.test_seq = test_seq;
		this.user_id = user_id;
		this.plus_score = plus_score;
		this.score = score;
		this.score_regdate = score_regdate;
		this.score_update = score_update;
		this.retest = retest;
	}




	public int getScore_seq() {
		return score_seq;
	}


	public void setScore_seq(int score_seq) {
		this.score_seq = score_seq;
	}


	public int getTest_seq() {
		return test_seq;
	}


	public void setTest_seq(int test_seq) {
		this.test_seq = test_seq;
	}


	public String getUser_id() {
		return user_id;
	}


	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}


	public int getPlus_score() {
		return plus_score;
	}


	public void setPlus_score(int plus_score) {
		this.plus_score = plus_score;
	}


	public double getScore() {
		return score;
	}


	public void setScore(double score) {
		this.score = score;
	}


	public String getScore_regdate() {
		return score_regdate;
	}


	public void setScore_regdate(String score_regdate) {
		this.score_regdate = score_regdate;
	}


	public String getScore_update() {
		return score_update;
	}


	public void setScore_update(String score_update) {
		this.score_update = score_update;
	}


	public int getRetest() {
		return retest;
	}


	public void setRetest(int retest) {
		this.retest = retest;
	}


	@Override
	public String toString() {
		return "TestScoreVO [score_seq=" + score_seq + ", test_seq=" + test_seq + ", user_id=" + user_id
				+ ", plus_score=" + plus_score + ", score=" + score + ", score_regdate=" + score_regdate
				+ ", score_update=" + score_update + ", retest=" + retest + "]";
	}


	public String getContent() {
		return content;
	}


	public void setContent(String content) {
		this.content = content;
	}

	
	


	
	
}
