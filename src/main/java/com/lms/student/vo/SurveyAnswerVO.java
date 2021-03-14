package com.lms.student.vo;

import forFaith.dev.vo.CommonVO;

@SuppressWarnings("serial")
public class SurveyAnswerVO extends CommonVO{

	private int survey_answer_seq;
	private int survey_question_seq;
	private String user_id;
	private String user_nm;
	private String survey_answer;
	private int survey_answer_choice;
	
	public int getSurvey_answer_seq() {
		return survey_answer_seq;
	}
	public void setSurvey_answer_seq(int survey_answer_seq) {
		this.survey_answer_seq = survey_answer_seq;
	}
	public int getSurvey_question_seq() {
		return survey_question_seq;
	}
	public void setSurvey_question_seq(int survey_question_seq) {
		this.survey_question_seq = survey_question_seq;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getUser_nm() {
		return user_nm;
	}
	public void setUser_nm(String user_nm) {
		this.user_nm = user_nm;
	}
	public String getSurvey_answer() {
		return survey_answer;
	}
	public void setSurvey_answer(String survey_answer) {
		this.survey_answer = survey_answer;
	}
	public int getSurvey_answer_choice() {
		return survey_answer_choice;
	}
	public void setSurvey_answer_choice(int survey_answer_choice) {
		this.survey_answer_choice = survey_answer_choice;
	}
}
