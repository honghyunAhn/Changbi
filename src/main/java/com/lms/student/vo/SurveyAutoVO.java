package com.lms.student.vo;

import java.util.List;

public class SurveyAutoVO {

	private int survey_seq;
	private String crc_id;
	private String autoSurveyGisu;
	private List<SurveyAutoVO> autoList;
	
	public SurveyAutoVO() {
		super();
	}

	public SurveyAutoVO(int survey_seq, String crc_id, String autoSurveyGisu, List<SurveyAutoVO> autoList) {
		super();
		this.survey_seq = survey_seq;
		this.crc_id = crc_id;
		this.autoSurveyGisu = autoSurveyGisu;
		this.autoList = autoList;
	}

	public int getSurvey_seq() {
		return survey_seq;
	}

	public void setSurvey_seq(int survey_seq) {
		this.survey_seq = survey_seq;
	}

	public String getCrc_id() {
		return crc_id;
	}

	public void setCrc_id(String crc_id) {
		this.crc_id = crc_id;
	}

	public String getAutoSurveyGisu() {
		return autoSurveyGisu;
	}

	public void setAutoSurveyGisu(String autoSurveyGisu) {
		this.autoSurveyGisu = autoSurveyGisu;
	}

	public List<SurveyAutoVO> getAutoList() {
		return autoList;
	}

	public void setAutoList(List<SurveyAutoVO> autoList) {
		this.autoList = autoList;
	}

	@Override
	public String toString() {
		return "SurveyAutoVO [survey_seq=" + survey_seq + ", crc_id=" + crc_id + ", autoSurveyGisu=" + autoSurveyGisu
				+ ", autoList=" + autoList + "]";
	}
}
