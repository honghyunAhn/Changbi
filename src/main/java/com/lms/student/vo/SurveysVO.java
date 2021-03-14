package com.lms.student.vo;

import java.util.HashMap;
import java.util.List;

import forFaith.dev.vo.CommonVO;

@SuppressWarnings("serial")
public class SurveysVO extends CommonVO{

	private int survey_seq;
	private int survey_question_seq;
	private int survey_answer_seq;
	private int survey_number;
	private int survey_type_seq;
	private int survey_complete_seq;
	private String survey_type_name;
	private String crc_id;
	private String crc_name;
	private String gisu_id;
	private String gisu_name;
	private String user_id;
	private String user_name;
	private String survey_title;
	private String survey_content;
	private String survey_question;
	private String survey_answer;
	private int survey_answer_choice;
	private boolean survey_answer_hide;
	private String survey_start_date;
	private String survey_end_date;
	private String survey_regdate;
	private String survey_update;
	private String survey_state;
	
	private String survey_answer_sample;
	private int survey_template_seq;
	private String survey_template_title;
	private String survey_template_content;
	
	private List<SurveyAnswerVO> answerList;
	private HashMap<Integer, Object> answer_userList;
	private HashMap<Integer, Object> answer_idList;
	
	private String page; // 템플릿 팝업창 오픈할 때 사용하는 구분값 : create, course
						 // 설문상세페이지 오픈할 때 사용하는 구분값 : list, course
	private int autoSurveyStart;
	private int autoSurveyPeriod;
	private String autoSurveyType;
	private String autoSurveyGisu;
	private String autoYn;
	
	public SurveysVO() {
		super();
	}

	public SurveysVO(int survey_seq, int survey_question_seq, int survey_answer_seq, int survey_number,
			int survey_type_seq, int survey_complete_seq, String survey_type_name, String crc_id, String crc_name,
			String gisu_id, String gisu_name, String user_id, String user_name, String survey_title,
			String survey_content, String survey_question, String survey_answer, int survey_answer_choice,
			boolean survey_answer_hide, String survey_start_date, String survey_end_date, String survey_regdate,
			String survey_update, String survey_state, String survey_answer_sample, int survey_template_seq,
			String survey_template_title, String survey_template_content, List<SurveyAnswerVO> answerList,
			HashMap<Integer, Object> answer_userList, HashMap<Integer, Object> answer_idList, String page,
			int autoSurveyStart, int autoSurveyPeriod, String autoSurveyType, String autoSurveyGisu, String autoYn) {
		super();
		this.survey_seq = survey_seq;
		this.survey_question_seq = survey_question_seq;
		this.survey_answer_seq = survey_answer_seq;
		this.survey_number = survey_number;
		this.survey_type_seq = survey_type_seq;
		this.survey_complete_seq = survey_complete_seq;
		this.survey_type_name = survey_type_name;
		this.crc_id = crc_id;
		this.crc_name = crc_name;
		this.gisu_id = gisu_id;
		this.gisu_name = gisu_name;
		this.user_id = user_id;
		this.user_name = user_name;
		this.survey_title = survey_title;
		this.survey_content = survey_content;
		this.survey_question = survey_question;
		this.survey_answer = survey_answer;
		this.survey_answer_choice = survey_answer_choice;
		this.survey_answer_hide = survey_answer_hide;
		this.survey_start_date = survey_start_date;
		this.survey_end_date = survey_end_date;
		this.survey_regdate = survey_regdate;
		this.survey_update = survey_update;
		this.survey_state = survey_state;
		this.survey_answer_sample = survey_answer_sample;
		this.survey_template_seq = survey_template_seq;
		this.survey_template_title = survey_template_title;
		this.survey_template_content = survey_template_content;
		this.answerList = answerList;
		this.answer_userList = answer_userList;
		this.answer_idList = answer_idList;
		this.page = page;
		this.autoSurveyStart = autoSurveyStart;
		this.autoSurveyPeriod = autoSurveyPeriod;
		this.autoSurveyType = autoSurveyType;
		this.autoSurveyGisu = autoSurveyGisu;
		this.autoYn = autoYn;
	}

	public int getSurvey_seq() {
		return survey_seq;
	}

	public void setSurvey_seq(int survey_seq) {
		this.survey_seq = survey_seq;
	}

	public int getSurvey_question_seq() {
		return survey_question_seq;
	}

	public void setSurvey_question_seq(int survey_question_seq) {
		this.survey_question_seq = survey_question_seq;
	}

	public int getSurvey_answer_seq() {
		return survey_answer_seq;
	}

	public void setSurvey_answer_seq(int survey_answer_seq) {
		this.survey_answer_seq = survey_answer_seq;
	}

	public int getSurvey_number() {
		return survey_number;
	}

	public void setSurvey_number(int survey_number) {
		this.survey_number = survey_number;
	}

	public int getSurvey_type_seq() {
		return survey_type_seq;
	}

	public void setSurvey_type_seq(int survey_type_seq) {
		this.survey_type_seq = survey_type_seq;
	}

	public int getSurvey_complete_seq() {
		return survey_complete_seq;
	}

	public void setSurvey_complete_seq(int survey_complete_seq) {
		this.survey_complete_seq = survey_complete_seq;
	}

	public String getSurvey_type_name() {
		return survey_type_name;
	}

	public void setSurvey_type_name(String survey_type_name) {
		this.survey_type_name = survey_type_name;
	}

	public String getCrc_id() {
		return crc_id;
	}

	public void setCrc_id(String crc_id) {
		this.crc_id = crc_id;
	}

	public String getCrc_name() {
		return crc_name;
	}

	public void setCrc_name(String crc_name) {
		this.crc_name = crc_name;
	}

	public String getGisu_id() {
		return gisu_id;
	}

	public void setGisu_id(String gisu_id) {
		this.gisu_id = gisu_id;
	}

	public String getGisu_name() {
		return gisu_name;
	}

	public void setGisu_name(String gisu_name) {
		this.gisu_name = gisu_name;
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public String getUser_name() {
		return user_name;
	}

	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}

	public String getSurvey_title() {
		return survey_title;
	}

	public void setSurvey_title(String survey_title) {
		this.survey_title = survey_title;
	}

	public String getSurvey_content() {
		return survey_content;
	}

	public void setSurvey_content(String survey_content) {
		this.survey_content = survey_content;
	}

	public String getSurvey_question() {
		return survey_question;
	}

	public void setSurvey_question(String survey_question) {
		this.survey_question = survey_question;
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

	public boolean isSurvey_answer_hide() {
		return survey_answer_hide;
	}

	public void setSurvey_answer_hide(boolean survey_answer_hide) {
		this.survey_answer_hide = survey_answer_hide;
	}

	public String getSurvey_start_date() {
		return survey_start_date;
	}

	public void setSurvey_start_date(String survey_start_date) {
		this.survey_start_date = survey_start_date;
	}

	public String getSurvey_end_date() {
		return survey_end_date;
	}

	public void setSurvey_end_date(String survey_end_date) {
		this.survey_end_date = survey_end_date;
	}

	public String getSurvey_regdate() {
		return survey_regdate;
	}

	public void setSurvey_regdate(String survey_regdate) {
		this.survey_regdate = survey_regdate;
	}

	public String getSurvey_update() {
		return survey_update;
	}

	public void setSurvey_update(String survey_update) {
		this.survey_update = survey_update;
	}

	public String getSurvey_state() {
		return survey_state;
	}

	public void setSurvey_state(String survey_state) {
		this.survey_state = survey_state;
	}

	public String getSurvey_answer_sample() {
		return survey_answer_sample;
	}

	public void setSurvey_answer_sample(String survey_answer_sample) {
		this.survey_answer_sample = survey_answer_sample;
	}

	public int getSurvey_template_seq() {
		return survey_template_seq;
	}

	public void setSurvey_template_seq(int survey_template_seq) {
		this.survey_template_seq = survey_template_seq;
	}

	public String getSurvey_template_title() {
		return survey_template_title;
	}

	public void setSurvey_template_title(String survey_template_title) {
		this.survey_template_title = survey_template_title;
	}

	public String getSurvey_template_content() {
		return survey_template_content;
	}

	public void setSurvey_template_content(String survey_template_content) {
		this.survey_template_content = survey_template_content;
	}

	public List<SurveyAnswerVO> getAnswerList() {
		return answerList;
	}

	public void setAnswerList(List<SurveyAnswerVO> answerList) {
		this.answerList = answerList;
	}

	public HashMap<Integer, Object> getAnswer_userList() {
		return answer_userList;
	}

	public void setAnswer_userList(HashMap<Integer, Object> answer_userList) {
		this.answer_userList = answer_userList;
	}

	public HashMap<Integer, Object> getAnswer_idList() {
		return answer_idList;
	}

	public void setAnswer_idList(HashMap<Integer, Object> answer_idList) {
		this.answer_idList = answer_idList;
	}

	public String getPage() {
		return page;
	}

	public void setPage(String page) {
		this.page = page;
	}

	public int getAutoSurveyStart() {
		return autoSurveyStart;
	}

	public void setAutoSurveyStart(int autoSurveyStart) {
		this.autoSurveyStart = autoSurveyStart;
	}

	public int getAutoSurveyPeriod() {
		return autoSurveyPeriod;
	}

	public void setAutoSurveyPeriod(int autoSurveyPeriod) {
		this.autoSurveyPeriod = autoSurveyPeriod;
	}

	public String getAutoSurveyType() {
		return autoSurveyType;
	}

	public void setAutoSurveyType(String autoSurveyType) {
		this.autoSurveyType = autoSurveyType;
	}

	public String getAutoSurveyGisu() {
		return autoSurveyGisu;
	}

	public void setAutoSurveyGisu(String autoSurveyGisu) {
		this.autoSurveyGisu = autoSurveyGisu;
	}

	public String getAutoYn() {
		return autoYn;
	}

	public void setAutoYn(String autoYn) {
		this.autoYn = autoYn;
	}

	@Override
	public String toString() {
		return "SurveysVO [survey_seq=" + survey_seq + ", survey_question_seq=" + survey_question_seq
				+ ", survey_answer_seq=" + survey_answer_seq + ", survey_number=" + survey_number + ", survey_type_seq="
				+ survey_type_seq + ", survey_complete_seq=" + survey_complete_seq + ", survey_type_name="
				+ survey_type_name + ", crc_id=" + crc_id + ", crc_name=" + crc_name + ", gisu_id=" + gisu_id
				+ ", gisu_name=" + gisu_name + ", user_id=" + user_id + ", user_name=" + user_name + ", survey_title="
				+ survey_title + ", survey_content=" + survey_content + ", survey_question=" + survey_question
				+ ", survey_answer=" + survey_answer + ", survey_answer_choice=" + survey_answer_choice
				+ ", survey_answer_hide=" + survey_answer_hide + ", survey_start_date=" + survey_start_date
				+ ", survey_end_date=" + survey_end_date + ", survey_regdate=" + survey_regdate + ", survey_update="
				+ survey_update + ", survey_state=" + survey_state + ", survey_answer_sample=" + survey_answer_sample
				+ ", survey_template_seq=" + survey_template_seq + ", survey_template_title=" + survey_template_title
				+ ", survey_template_content=" + survey_template_content + ", answerList=" + answerList
				+ ", answer_userList=" + answer_userList + ", answer_idList=" + answer_idList + ", page=" + page
				+ ", autoSurveyStart=" + autoSurveyStart + ", autoSurveyPeriod=" + autoSurveyPeriod
				+ ", autoSurveyType=" + autoSurveyType + ", autoSurveyGisu=" + autoSurveyGisu + ", autoYn=" + autoYn
				+ "]";
	}
}
