package com.lms.student.vo;

/*
 * 기수 카테고리별 시험 배율 테이블
 * ** 카테고리 아래에 있는 요소들의 배율 총합이 99.999 ~ 100 되도록 세팅 
 * ex) It, 일본어 이면 50% + 50% 이런식..
 */
public class CatInnerFactorPercentVO {

	private int test_per_seq;		// 배율 		번호
	private int cat_seq;			// 카테고리 	번호
	private int test_seq;			// 시험		번호
	private double test_percent;	// 시험점수 	배율 ( 소숫점 2자리 까지 )
	
	
	public CatInnerFactorPercentVO() {
		super();
	}
	public CatInnerFactorPercentVO(int test_per_seq, int cat_seq, int test_seq, double test_percent) {
		super();
		this.test_per_seq = test_per_seq;
		this.cat_seq = cat_seq;
		this.test_seq = test_seq;
		this.test_percent = test_percent;
	}
	public int getTest_per_seq() {
		return test_per_seq;
	}
	public void setTest_per_seq(int test_per_seq) {
		this.test_per_seq = test_per_seq;
	}
	public int getCat_seq() {
		return cat_seq;
	}
	public void setCat_seq(int cat_seq) {
		this.cat_seq = cat_seq;
	}
	public int getTest_seq() {
		return test_seq;
	}
	public void setTest_seq(int test_seq) {
		this.test_seq = test_seq;
	}
	public double getTest_percent() {
		return test_percent;
	}
	public void setTest_percent(double test_percent) {
		this.test_percent = test_percent;
	}
	@Override
	public String toString() {
		return "CatInnerFactorPercentVO [test_per_seq=" + test_per_seq + ", cat_seq=" + cat_seq + ", test_seq="
				+ test_seq + ", test_percent=" + test_percent + "]";
	}
	
	
	
}
