package com.changbi.tt.dev.data.vo;

import forFaith.dev.vo.CommonVO;

/**
 * @Class Name : LearnChangeVO.java
 * @Description : 수강변경관리
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
public class LearnChangeVO extends CommonVO {
	// 검색조건
    private LearnChangeVO search;
    
	private int id;	    						// seq id
	private String state;						// 변경신청 상태(1:신청(접수 처리중), 2:변경완료, 3:변경불가)
	
	private UserVO user;						// 사용자
	private LearnAppVO learnApp;				// 수강신청
	private CardinalVO cardinal;				// 기수
	private CourseVO oldCourse;					// 이전 과정
	private CourseVO newCourse;					// 변경할 과정

    public LearnChangeVO getSearch() {
        return search;
    }

    public void setSearch(LearnChangeVO search) {
        this.search = search;
    }

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public UserVO getUser() {
		return user;
	}

	public void setUser(UserVO user) {
		this.user = user;
	}

	public LearnAppVO getLearnApp() {
		return learnApp;
	}

	public void setLearnApp(LearnAppVO learnApp) {
		this.learnApp = learnApp;
	}

	public CardinalVO getCardinal() {
		return cardinal;
	}

	public void setCardinal(CardinalVO cardinal) {
		this.cardinal = cardinal;
	}

	public CourseVO getOldCourse() {
		return oldCourse;
	}

	public void setOldCourse(CourseVO oldCourse) {
		this.oldCourse = oldCourse;
	}

	public CourseVO getNewCourse() {
		return newCourse;
	}

	public void setNewCourse(CourseVO newCourse) {
		this.newCourse = newCourse;
	}
}
