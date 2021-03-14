package com.lms.student.vo;

/*
 * 과정 기수별 등급(?) 계급(?) 테이블 
 */

public class GradeVO {
	private String grade_seq;
	private String course_id;
	private String cardinal_id;
	private int start_score;
	private int end_score;
	private String grade;
	
	public String getGrade_seq() {
		return grade_seq;
	}
	public void setGrade_seq(String grade_seq) {
		this.grade_seq = grade_seq;
	}
	public String getCourse_id() {
		return course_id;
	}
	public void setCourse_id(String course_id) {
		this.course_id = course_id;
	}
	public String getCardinal_id() {
		return cardinal_id;
	}
	public void setCardinal_id(String cardinal_id) {
		this.cardinal_id = cardinal_id;
	}
	public int getStart_score() {
		return start_score;
	}
	public void setStart_score(int start_score) {
		this.start_score = start_score;
	}
	public int getEnd_score() {
		return end_score;
	}
	public void setEnd_score(int end_score) {
		this.end_score = end_score;
	}
	public String getGrade() {
		return grade;
	}
	public void setGrade(String grade) {
		this.grade = grade;
	}
	@Override
	public String toString() {
		return "GradeVO [course_id=" + course_id + ", cardinal_id=" + cardinal_id + ", start_score=" + start_score
				+ ", end_score=" + end_score + ", grade=" + grade + "]";
	}
	
}
