package com.changbi.tt.dev.data.vo;

import forFaith.dev.vo.AttachFileVO;
import forFaith.dev.vo.CommonVO;

@SuppressWarnings("serial")
public class BannerVO extends CommonVO {
	// 검색조건
    private BannerVO search;
    
    private int id; // 배너 ID(SEQ로 ID저장)
    private String position; // 위치 (1 : 메인탑, 2 : 메인우측)
    private String title; // 링크(배너)명
    private String url; // 링크
    private String target; // 링크 열림 유형(1 : _BLANK, 2 : _SELF, 3 : _PARENT, 4 : _TOP)
    private String attach1File; // 첨부 #1 파일
    private String attach2File; // 첨부 #2 파일
    private String userId; // 작성자 USER ID
    
    private AttachFileVO img1; // 파일1
	private AttachFileVO img2; // 파일2
	
	private int od; // 메인배너노출순서
   
	public BannerVO getSearch() {
		return search;
	}
	public void setSearch(BannerVO search) {
		this.search = search;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getPosition() {
		return position;
	}
	public void setPosition(String position) {
		this.position = position;
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
	public String getTarget() {
		return target;
	}
	public void setTarget(String target) {
		this.target = target;
	}
	public String getAttach1File() {
		return attach1File;
	}
	public void setAttach1File(String attach1File) {
		this.attach1File = attach1File;
	}
	public String getAttach2File() {
		return attach2File;
	}
	public void setAttach2File(String attach2File) {
		this.attach2File = attach2File;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public AttachFileVO getImg1() {
		return img1;
	}
	public void setImg1(AttachFileVO img1) {
		this.img1 = img1;
	}
	public AttachFileVO getImg2() {
		return img2;
	}
	public void setImg2(AttachFileVO img2) {
		this.img2 = img2;
	}
	public int getOd() {
		return od;
	}
	public void setOd(int od) {
		this.od = od;
	}	
}
