package com.changbi.tt.dev.data.vo;

import java.util.List;

import forFaith.dev.vo.CommonVO;

/**
 * @Class Name : QuizPoolVO.java
 * @Description : 시험지풀관리정보
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
public class QuizPoolVO extends CommonVO {
	// 검색조건
    private QuizPoolVO search;
    
	private int id;	    						// 시험지 풀 마스터 ID
	private String title;						// 시험지 풀 명
	private String quizType;					// 시험 종류(1:출석고사, 2:온라인평가, 3:온라인과제)
	
	private CourseVO course;					// 과정ID
	
	private List<QuizItemVO> quizItemList;		// 퀴즈 문항 리스트

    public QuizPoolVO getSearch() {
        return search;
    }

    public void setSearch(QuizPoolVO search) {
        this.search = search;
    }

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getQuizType() {
		return quizType;
	}

	public void setQuizType(String quizType) {
		this.quizType = quizType;
	}

	public CourseVO getCourse() {
		return course;
	}

	public void setCourse(CourseVO course) {
		this.course = course;
	}

	public List<QuizItemVO> getQuizItemList() {
		return quizItemList;
	}

	public void setQuizItemList(List<QuizItemVO> quizItemList) {
		this.quizItemList = quizItemList;
	}
}
