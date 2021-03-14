package com.changbi.tt.dev.data.vo;

import forFaith.dev.vo.AttachFileVO;
import forFaith.dev.vo.CommonVO;

@SuppressWarnings("serial")
public class EventVO extends CommonVO {
	// 검색조건
    private EventVO search;
    
    private int id; // 이벤트 ID(SEQ로 ID저장)
    private String title; // 이벤트 제목
    private String comment; // 이벤트 내용
    private String userId; // 작성자 USER ID
    private String startDate; // 이벤트 시작 기간
    private String endDate; // 이벤트 종료 기간
    private String attach1File; // 첨부 #1 파일 (인덱스 배너)
    private String attach2File; // 첨부 #2 파일
    private String approvalStatus; // 승인상태(1 : 노출보류, 2 : 서비스(게시))

    private String approvalStatusName; // 승인상태명
    
    private AttachFileVO img1; // 파일1
	private AttachFileVO img2; // 파일2
    
    public EventVO getSearch() {
		return search;
	}
	public void setSearch(EventVO search) {
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
	public String getComment() {
		return comment;
	}
	public void setComment(String comment) {
		this.comment = comment;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
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
	public String getApprovalStatus() {
		return approvalStatus;
	}
	public void setApprovalStatus(String approvalStatus) {
		this.approvalStatus = approvalStatus;
	}
	public String getApprovalStatusName() {
		return approvalStatusName;
	}
	public void setApprovalStatusName(String approvalStatusName) {
		this.approvalStatusName = approvalStatusName;
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
}
