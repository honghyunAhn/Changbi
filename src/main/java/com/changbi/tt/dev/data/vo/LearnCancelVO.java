package com.changbi.tt.dev.data.vo;

import forFaith.dev.vo.CommonVO;

/**
 * @Class Name : LearnCancelVO.java
 * @Description : 수강취소관리
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
public class LearnCancelVO extends CommonVO {
	// 검색조건
    private LearnCancelVO search;
    
	private int id;	    						// seq id
	private String tel;							// 연락처
	private String phone;						// 핸드폰번호
	private String email;						// 이메일
	private String bookType;					// 교제구매여부(1:구매, 2:반송)
	private String bank;						// 환불은행
	private String account;						// 환불계좌
	private String owner;						// 환불예금주
	private String memo;						// 연기신청 요청사유
	private String state;						// 연기신청상태(1:신청(접수 처리중), 2:연기완료, 3:연기불가)
	
	private UserVO user;						// 사용자
	private LearnAppVO learnApp;				// 수강신청

    public LearnCancelVO getSearch() {
        return search;
    }

    public void setSearch(LearnCancelVO search) {
        this.search = search;
    }

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getTel() {
		return tel;
	}

	public void setTel(String tel) {
		this.tel = tel;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getBookType() {
		return bookType;
	}

	public void setBookType(String bookType) {
		this.bookType = bookType;
	}

	public String getBank() {
		return bank;
	}

	public void setBank(String bank) {
		this.bank = bank;
	}

	public String getAccount() {
		return account;
	}

	public void setAccount(String account) {
		this.account = account;
	}

	public String getOwner() {
		return owner;
	}

	public void setOwner(String owner) {
		this.owner = owner;
	}

	public String getMemo() {
		return memo;
	}

	public void setMemo(String memo) {
		this.memo = memo;
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
}
