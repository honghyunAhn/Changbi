package com.changbi.tt.dev.data.vo;

import forFaith.dev.vo.CommonVO;

/**
 * @Class Name : AttLecHistoryVO.java
 * @Description : 수강이력 히스토리
 * @Modification Information
 * @
 * @  수정일                 수정자                       수정내용
 * @ -------    --------    ---------------------------
 * @ 2017.03.21   김준석                      최초 생성
 *
 *  @author kjs
 *  @since 2017.03.21
 *  @version 1.0
 *  @see
 *
 */

@SuppressWarnings("serial")
public class AttLecHistoryVO extends CommonVO {
	// 검색조건
    private AttLecHistoryVO search;
    
	private int id;		    					// 수강이력 마스터 ID
	private int chasi;							// 차시
	private String startDate;					// 시작일시
	private String endDate;						// 종료일시

	private UserVO user;						// 사용자
	private CardinalVO cardinal;				// 기수ID
	private CourseVO course;					// 과정ID
	private ChapterVO chapter;					// 챕터ID
	
    public AttLecHistoryVO getSearch() {
        return search;
    }

    public void setSearch(AttLecHistoryVO search) {
        this.search = search;
    }

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getChasi() {
		return chasi;
	}

	public void setChasi(int chasi) {
		this.chasi = chasi;
	}

	public String getStartDate() {
		return startDate;
	}

	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}

	public String getEndDate() {
		return endDate;
	}

	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}

	public UserVO getUser() {
		return user;
	}

	public void setUser(UserVO user) {
		this.user = user;
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

	public ChapterVO getChapter() {
		return chapter;
	}

	public void setChapter(ChapterVO chapter) {
		this.chapter = chapter;
	}
}
