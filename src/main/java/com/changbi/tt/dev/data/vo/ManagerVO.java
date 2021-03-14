package com.changbi.tt.dev.data.vo;

import java.util.List;

import forFaith.dev.vo.MemberVO;

/**
 * @Class Name : ManagerVO.java
 * @Description : 관리자정보
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
public class ManagerVO extends MemberVO {
	
	private List<CourseVO> courseList;			// 관리자 지정 과정리스트 추가
	private List<TccVO> tccList;				// tcc 영상 리스트

	public List<CourseVO> getCourseList() {
		return courseList;
	}

	public void setCourseList(List<CourseVO> courseList) {
		this.courseList = courseList;
	}

	public List<TccVO> getTccList() {
		return tccList;
	}

	public void setTccList(List<TccVO> tccList) {
		this.tccList = tccList;
	}
}
