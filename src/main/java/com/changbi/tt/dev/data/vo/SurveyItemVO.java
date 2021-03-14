package com.changbi.tt.dev.data.vo;

import forFaith.dev.vo.CodeVO;
import forFaith.dev.vo.CommonVO;

@SuppressWarnings("serial")
public class SurveyItemVO extends CommonVO {
	// 검색조건
    private SurveyItemVO search;
    
    private int id; // 설문 문항 ID
    private String surveyId; // 설문 마스터 ID
    private String itemType; // 문항유형(1:객관식, 2:주관식, 3:객관+주관식)
    private String surveyCode; // 문항분류코드(기초관리>설문분류)
    private String title; // 설문문항질문명
    private String exam1; // 객관식 1번 보기
    private String exam2; // 객관식 2번 보기
    private String exam3; // 객관식 3번 보기
    private String exam4; // 객관식 4번 보기
    private String exam5; // 객관식 5번 보기
    private String exam6; // 객관식 6번 보기
    private String exam7; // 객관식 7번 보기
    private String exam1Yn = "N"; // 객관식 1번 주관식 처리
    private String exam2Yn = "N"; // 객관식 2번 주관식 처리
    private String exam3Yn = "N"; // 객관식 3번 주관식 처리
    private String exam4Yn = "N"; // 객관식 4번 주관식 처리
    private String exam5Yn = "N"; // 객관식 5번 주관식 처리
    private String exam6Yn = "N"; // 객관식 6번 주관식 처리
    private String exam7Yn = "N"; // 객관식 7번 주관식 처리

    // 확장멤버
    private String itemTypeName; // 문항유형
    private CodeVO survey; // 문항분류코드
    
	public SurveyItemVO getSearch() {
		return search;
	}
	public void setSearch(SurveyItemVO search) {
		this.search = search;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getSurveyId() {
		return surveyId;
	}
	public void setSurveyId(String surveyId) {
		this.surveyId = surveyId;
	}
	public String getItemType() {
		return itemType;
	}
	public void setItemType(String itemType) {
		this.itemType = itemType;
	}
	public String getSurveyCode() {
		return surveyCode;
	}
	public void setSurveyCode(String surveyCode) {
		this.surveyCode = surveyCode;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getExam1() {
		return exam1;
	}
	public void setExam1(String exam1) {
		this.exam1 = exam1;
	}
	public String getExam2() {
		return exam2;
	}
	public void setExam2(String exam2) {
		this.exam2 = exam2;
	}
	public String getExam3() {
		return exam3;
	}
	public void setExam3(String exam3) {
		this.exam3 = exam3;
	}
	public String getExam4() {
		return exam4;
	}
	public void setExam4(String exam4) {
		this.exam4 = exam4;
	}
	public String getExam5() {
		return exam5;
	}
	public void setExam5(String exam5) {
		this.exam5 = exam5;
	}
	public String getExam6() {
		return exam6;
	}
	public void setExam6(String exam6) {
		this.exam6 = exam6;
	}
	public String getExam7() {
		return exam7;
	}
	public void setExam7(String exam7) {
		this.exam7 = exam7;
	}
	public String getExam1Yn() {
		return exam1Yn;
	}
	public void setExam1Yn(String exam1Yn) {
		this.exam1Yn = exam1Yn;
	}
	public String getExam2Yn() {
		return exam2Yn;
	}
	public void setExam2Yn(String exam2Yn) {
		this.exam2Yn = exam2Yn;
	}
	public String getExam3Yn() {
		return exam3Yn;
	}
	public void setExam3Yn(String exam3Yn) {
		this.exam3Yn = exam3Yn;
	}
	public String getExam4Yn() {
		return exam4Yn;
	}
	public void setExam4Yn(String exam4Yn) {
		this.exam4Yn = exam4Yn;
	}
	public String getExam5Yn() {
		return exam5Yn;
	}
	public void setExam5Yn(String exam5Yn) {
		this.exam5Yn = exam5Yn;
	}
	public String getExam6Yn() {
		return exam6Yn;
	}
	public void setExam6Yn(String exam6Yn) {
		this.exam6Yn = exam6Yn;
	}
	public String getExam7Yn() {
		return exam7Yn;
	}
	public void setExam7Yn(String exam7Yn) {
		this.exam7Yn = exam7Yn;
	}
	public String getItemTypeName() {
		return itemTypeName;
	}
	public void setItemTypeName(String itemTypeName) {
		this.itemTypeName = itemTypeName;
	}
	public CodeVO getSurvey() {
		return survey;
	}
	public void setSurvey(CodeVO survey) {
		this.survey = survey;
	}
}
