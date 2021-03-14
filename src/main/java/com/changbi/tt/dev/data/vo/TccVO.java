package com.changbi.tt.dev.data.vo;

import forFaith.dev.vo.CommonVO;

/**
 * @Class Name : TccVO.java
 * @Description : TCC 정보
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
public class TccVO extends CommonVO {
	// 검색조건
    private TccVO search;
    
    private int id;			// TCC ID
    private String title;	// 영상제목
    private String url;		// 영상파일URL
    
    private ManagerVO teacher;	//
    
	public TccVO getSearch() {
		return search;
	}
	
	public void setSearch(TccVO search) {
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

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public ManagerVO getTeacher() {
		return teacher;
	}

	public void setTeacher(ManagerVO teacher) {
		this.teacher = teacher;
	}
}
