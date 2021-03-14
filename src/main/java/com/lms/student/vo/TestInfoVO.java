package com.lms.student.vo;

import java.util.Date;

/*
 * 시험 테이블
 */
public class TestInfoVO {

	private int test_seq;						// 시험 		번호
	private int cat_seq;						// 카테고리	번호
	private String test_nm;						// 시험		이름
	private double total_score;					// 총합 		점수
	private String test_content;				// 시험 		내용
	private int retest_time;					// 재응시 	횟수
	private String test_start_date;				// 시험 		시작날짜
	private String test_end_date;				// 시험 		종료날짜
	private String test_regDate;				// 시험 		등록날짜
	private String test_update;					// 시험 		수정날짜
	
	
	
	public TestInfoVO() {
		super();
	}
	public TestInfoVO(int test_seq, int cat_seq, String test_nm, double total_score, String test_content,
			int retest_time, String test_start_date, String test_end_date, String test_regDate, String test_update) {
		super();
		this.test_seq = test_seq;
		this.cat_seq = cat_seq;
		this.test_nm = test_nm;
		this.total_score = total_score;
		this.test_content = test_content;
		this.retest_time = retest_time;
		this.test_start_date = test_start_date;
		this.test_end_date = test_end_date;
		this.test_regDate = test_regDate;
		this.test_update = test_update;
	}
	public int getTest_seq() {
		return test_seq;
	}
	public void setTest_seq(int test_seq) {
		this.test_seq = test_seq;
	}
	public int getCat_seq() {
		return cat_seq;
	}
	public void setCat_seq(int cat_seq) {
		this.cat_seq = cat_seq;
	}
	public String getTest_nm() {
		return test_nm;
	}
	public void setTest_nm(String test_nm) {
		this.test_nm = test_nm;
	}
	public double getTotal_score() {
		return total_score;
	}
	public void setTotal_score(double total_score) {
		this.total_score = total_score;
	}
	public String getTest_content() {
		return test_content;
	}
	public void setTest_content(String test_content) {
		this.test_content = test_content;
	}
	public int getRetest_time() {
		return retest_time;
	}
	public void setRetest_time(int retest_time) {
		this.retest_time = retest_time;
	}
	public String getTest_start_date() {
		return test_start_date;
	}
	public void setTest_start_date(String test_start_date) {
		this.test_start_date = test_start_date;
	}
	public String getTest_end_date() {
		return test_end_date;
	}
	public void setTest_end_date(String test_end_date) {
		this.test_end_date = test_end_date;
	}
	public String getTest_regDate() {
		return test_regDate;
	}
	public void setTest_regDate(String test_regDate) {
		this.test_regDate = test_regDate;
	}
	public String getTest_update() {
		return test_update;
	}
	public void setTest_update(String test_update) {
		this.test_update = test_update;
	}
	@Override
	public String toString() {
		return "TestInfoVO [test_seq=" + test_seq + ", cat_seq=" + cat_seq + ", test_nm=" + test_nm + ", total_score="
				+ total_score + ", test_content=" + test_content + ", retest_time=" + retest_time + ", test_start_date="
				+ test_start_date + ", test_end_date=" + test_end_date + ", test_regDate=" + test_regDate
				+ ", test_update=" + test_update + "]";
	}
	
	
	
	
	
}
