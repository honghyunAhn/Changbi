package com.lms.student.vo;

public class UserScoreVO {

	private String user_id;
	private String crc_id;
	private String gisu_id;
	private int cat_seq;
	private int test_seq;
	private int score_seq;
	private int total_per_seq;
	private int retest_time;
	private int retest_count;
	private double score;
	private double score_plus;
	private double total_score;
	private double test_percent;
	private double cat_percent;
	
	
	
	public UserScoreVO() {
		super();
	}


	public UserScoreVO(String user_id, String crc_id, String gisu_id, int cat_seq, int test_seq, int score_seq,
			int total_per_seq, int retest_time, int retest_count, double score, double score_plus, double total_score,
			double test_percent, double cat_percent) {
		super();
		this.user_id = user_id;
		this.crc_id = crc_id;
		this.gisu_id = gisu_id;
		this.cat_seq = cat_seq;
		this.test_seq = test_seq;
		this.score_seq = score_seq;
		this.total_per_seq = total_per_seq;
		this.retest_time = retest_time;
		this.retest_count = retest_count;
		this.score = score;
		this.score_plus = score_plus;
		this.total_score = total_score;
		this.test_percent = test_percent;
		this.cat_percent = cat_percent;
	}


	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
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
	public int getScore_seq() {
		return score_seq;
	}
	public void setScore_seq(int score_seq) {
		this.score_seq = score_seq;
	}
	public int getTotal_per_seq() {
		return total_per_seq;
	}
	public void setTotal_per_seq(int total_per_seq) {
		this.total_per_seq = total_per_seq;
	}
	public String getCrc_id() {
		return crc_id;
	}
	public void setCrc_id(String crc_id) {
		this.crc_id = crc_id;
	}
	public String getGisu_id() {
		return gisu_id;
	}
	public void setGisu_id(String gisu_id) {
		this.gisu_id = gisu_id;
	}
	public double getScore() {
		return score;
	}
	public void setScore(double score) {
		this.score = score;
	}
	public double getScore_plus() {
		return score_plus;
	}
	public void setScore_plus(double score_plus) {
		this.score_plus = score_plus;
	}
	public double getTotal_score() {
		return total_score;
	}
	public void setTotal_score(double total_score) {
		this.total_score = total_score;
	}
	public double getTest_percent() {
		return test_percent;
	}
	public void setTest_percent(double test_percent) {
		this.test_percent = test_percent;
	}
	public double getCat_percent() {
		return cat_percent;
	}
	public void setCat_percent(double cat_percent) {
		this.cat_percent = cat_percent;
	}

	public int getRetest_time() {
		return retest_time;
	}

	public void setRetest_time(int retest_time) {
		this.retest_time = retest_time;
	}

	public int getRetest_count() {
		return retest_count;
	}

	public void setRetest_count(int retest_count) {
		this.retest_count = retest_count;
	}

	@Override
	public String toString() {
		return "UserScoreVO [user_id=" + user_id + ", crc_id=" + crc_id + ", gisu_id=" + gisu_id + ", cat_seq="
				+ cat_seq + ", test_seq=" + test_seq + ", score_seq=" + score_seq + ", total_per_seq=" + total_per_seq
				+ ", retest_time=" + retest_time + ", retest_count=" + retest_count + ", score=" + score
				+ ", score_plus=" + score_plus + ", total_score=" + total_score + ", test_percent=" + test_percent
				+ ", cat_percent=" + cat_percent + "]";
	}


	
}
