package com.changbi.tt.dev.data.vo;

import forFaith.dev.vo.CodeVO;
import forFaith.dev.vo.CommonVO;

@SuppressWarnings("serial")
public class SurveyVO extends CommonVO {
	// 검색조건
    private SurveyVO search;
    
    private String id; // 설문 마스터 ID(YYYYMMDDHHMISS)형태
    private String title; // 설문 제목
    private String aLead; // 안내머리글

    private CodeVO surveyCode; // 설문코드
    
    // 확장멤버
    private String concatCardinalId; // 그룹 기수관리 ID

	public SurveyVO getSearch() {
		return search;
	}

	public void setSearch(SurveyVO search) {
		this.search = search;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getaLead() {
		return aLead;
	}

	public void setaLead(String aLead) {
		this.aLead = aLead;
	}

	public String getConcatCardinalId() {
		return concatCardinalId;
	}

	public void setConcatCardinalId(String concatCardinalId) {
		this.concatCardinalId = concatCardinalId;
	}

	public CodeVO getSurveyCode() {
		return surveyCode;
	}

	public void setSurveyCode(CodeVO surveyCode) {
		this.surveyCode = surveyCode;
	}
}
