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
public class PointVO extends CommonVO {
	// 검색조건
    private PointVO search;
    
    private int id;			// 포인트ID
    private String userId;	// 수강자ID
    private int learnAppId;	// 연수신청ID
    private String name;	// 이름
    private int give;		// 적립포인트
    private int withdraw;	// 회수포인트
    private int balance;	// 잔여포인트
    private String note;	// 비고(사유)
    
	public PointVO getSearch() {
		return search;
	}
	public void setSearch(PointVO search) {
		this.search = search;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public int getLearnAppId() {
		return learnAppId;
	}
	public void setLearnAppId(int learnAppId) {
		this.learnAppId = learnAppId;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getGive() {
		return give;
	}
	public void setGive(int give) {
		this.give = give;
	}
	public int getWithdraw() {
		return withdraw;
	}
	public void setWithdraw(int withdraw) {
		this.withdraw = withdraw;
	}
	public int getBalance() {
		return balance;
	}
	public void setBalance(int balance) {
		this.balance = balance;
	}
	public String getNote() {
		return note;
	}
	public void setNote(String note) {
		this.note = note;
	}
	@Override
	public String toString() {
		return "PointVO [search=" + search + ", id=" + id + ", userId=" + userId + ", learnAppId=" + learnAppId
				+ ", name=" + name + ", give=" + give + ", withdraw=" + withdraw + ", balance=" + balance + ", note="
				+ note + "]";
	}
	
	
}
