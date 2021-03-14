package com.changbi.tt.dev.data.vo;

import forFaith.dev.vo.CommonVO;

/**
 * @Class Name : BookVO.java
 * @Description : 교재정보
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
public class InfoVO extends CommonVO {
	// 검색조건
    private InfoVO search;

    private int id; // 안내 ID(SEQ로 ID저장)
    private int themaType; // 테마타입 (1 : 회원약관, 2 : 개인정보보호정책, 3 : 소개, 4 : 연혁, 5 : 조직도, 6 : 찾아오시는길, 7 : 규정, 8 : 교육부 인가서)
    private int showOrderNum; // 표출우선순위
    private String showStartDate; // 노출시작기간
    private String showEndDate; // 노출종료기간
    private String approvalStatus; // 승인상태(1 : 노출보류, 2 : 서비스(게시))
    private String contents; // 컨텐츠 내용
    private String userId; // 작성자 USER ID
    
    // 확장 멤버
    private String themaTypeName; // 테마타입명
    private String approvalStatusName; // 승인상태명
    
	public InfoVO getSearch() {
		return search;
	}
	public void setSearch(InfoVO search) {
		this.search = search;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getThemaType() {
		return themaType;
	}
	public void setThemaType(int themaType) {
		this.themaType = themaType;
	}
	public int getShowOrderNum() {
		return showOrderNum;
	}
	public void setShowOrderNum(int showOrderNum) {
		this.showOrderNum = showOrderNum;
	}
	public String getShowStartDate() {
		return showStartDate;
	}
	public void setShowStartDate(String showStartDate) {
		this.showStartDate = showStartDate;
	}
	public String getShowEndDate() {
		return showEndDate;
	}
	public void setShowEndDate(String showEndDate) {
		this.showEndDate = showEndDate;
	}
	public String getApprovalStatus() {
		return approvalStatus;
	}
	public void setApprovalStatus(String approvalStatus) {
		this.approvalStatus = approvalStatus;
	}
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getThemaTypeName() {
		return themaTypeName;
	}
	public void setThemaTypeName(String themaTypeName) {
		this.themaTypeName = themaTypeName;
	}
	public String getApprovalStatusName() {
		return approvalStatusName;
	}
	public void setApprovalStatusName(String approvalStatusName) {
		this.approvalStatusName = approvalStatusName;
	}
}
