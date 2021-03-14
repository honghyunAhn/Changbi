package com.changbi.tt.dev.data.vo;

import java.util.List;

import forFaith.dev.vo.CommonVO;
import forFaith.dev.vo.SubChapVO;

/**
 * @Class Name : ChapterVO.java
 * @Description : 세부챕터
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
public class ChapterVO extends CommonVO {
	// 검색조건
    private ChapterVO search;
    
	private int id;	    						// 챕터 id
	private String name;						// 챕터 명
	private int study;							// 교육시간(분)
	private int chk;							// 체크(분)
	private String mainUrl;						// PC URL
	private String mobileUrl;					// 모바일 URL
	private String teacher;						// 강사명
	private String fileInfo;					// 강사파일
	private String serviceType;					// PC 모바일 구분(P : PC, M : MOBILE)
	
	private CourseVO course;					// 과정
	private List<AttLecVO> attLecList;			// 유저별 수강이력
	private List<SubChapVO> subChapList; 		// 세부차시 정보
	
    public ChapterVO getSearch() {
        return search;
    }

    public void setSearch(ChapterVO search) {
        this.search = search;
    }

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getStudy() {
		return study;
	}

	public void setStudy(int study) {
		this.study = study;
	}

	public int getChk() {
		return chk;
	}

	public void setChk(int chk) {
		this.chk = chk;
	}

	public String getMainUrl() {
		return mainUrl;
	}

	public void setMainUrl(String mainUrl) {
		this.mainUrl = mainUrl;
	}
	
	public String getMobileUrl() {
		return mobileUrl;
	}

	public void setMobileUrl(String mobileUrl) {
		this.mobileUrl = mobileUrl;
	}

	public String getTeacher() {
		return teacher;
	}

	public void setTeacher(String teacher) {
		this.teacher = teacher;
	}

	public String getFileInfo() {
		return fileInfo;
	}

	public void setFileInfo(String fileInfo) {
		this.fileInfo = fileInfo;
	}

	public String getServiceType() {
		return serviceType;
	}

	public void setServiceType(String serviceType) {
		this.serviceType = serviceType;
	}

	public CourseVO getCourse() {
		return course;
	}

	public void setCourse(CourseVO course) {
		this.course = course;
	}

	public List<AttLecVO> getAttLecList() {
		return attLecList;
	}

	public void setAttLecList(List<AttLecVO> attLecList) {
		this.attLecList = attLecList;
	}

	public List<SubChapVO> getSubChapList() {
		return subChapList;
	}

	public void setSubChapList(List<SubChapVO> subChapList) {
		this.subChapList = subChapList;
	}
	
}
