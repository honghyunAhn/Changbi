package com.changbi.tt.dev.data.vo;

import forFaith.dev.vo.CodeVO;
import forFaith.dev.vo.CommonVO;

@SuppressWarnings("serial")
public class StatsVO extends CommonVO {
	// 검색조건
    private StatsVO search;
    
    private String learnType;					// 연수타입(J : 직무, S : 자율, M : 집합, G : 단체)
    private String year;						// 년도 검색 시
    private String month;						// 월 검색 시
    private String date;						// 일 검색 시
    
    private CardinalVO cardinal;				// 기수
    private CourseVO course;					// 과정
    private CodeVO region;						// 지역코드
    private SurveyVO survey;					// 설문
    
	public StatsVO getSearch() {
		return search;
	}

	public void setSearch(StatsVO search) {
		this.search = search;
	}

	public String getLearnType() {
		return learnType;
	}

	public void setLearnType(String learnType) {
		this.learnType = learnType;
	}

	public String getYear() {
		return year;
	}

	public void setYear(String year) {
		this.year = year;
	}

	public String getMonth() {
		return month;
	}

	public void setMonth(String month) {
		this.month = month;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public CardinalVO getCardinal() {
		return cardinal;
	}

	public void setCardinal(CardinalVO cardinal) {
		this.cardinal = cardinal;
	}

	public CourseVO getCourse() {
		return course;
	}

	public void setCourse(CourseVO course) {
		this.course = course;
	}

	public CodeVO getRegion() {
		return region;
	}

	public void setRegion(CodeVO region) {
		this.region = region;
	}

	public SurveyVO getSurvey() {
		return survey;
	}

	public void setSurvey(SurveyVO survey) {
		this.survey = survey;
	}
}
