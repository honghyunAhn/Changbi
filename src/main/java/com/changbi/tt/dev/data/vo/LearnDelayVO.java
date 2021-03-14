package com.changbi.tt.dev.data.vo;

import forFaith.dev.vo.CommonVO;

/**
 * @Class Name : LearnDelayVO.java
 * @Description : 수강연기관리
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
public class LearnDelayVO extends CommonVO {
	// 검색조건
    private LearnDelayVO search;
    
	private int id;	    						// seq id
	private String tel;							// 연락처
	private String phone;						// 핸드폰번호
	private String email;						// 이메일
	private String memo;						// 연기신청 요청사유
	private String state;						// 연기신청상태(1:신청(접수 처리중), 2:연기완료, 3:연기불가)
	
	private UserVO user;						// 사용자
	private LearnAppVO learnApp;				// 수강신청
	private CardinalVO oldCardinal;				// 기존 기수
	private CardinalVO newCardinal;				// 변경 기수

    public LearnDelayVO getSearch() {
        return search;
    }

    public void setSearch(LearnDelayVO search) {
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

	public CardinalVO getOldCardinal() {
		return oldCardinal;
	}

	public void setOldCardinal(CardinalVO oldCardinal) {
		this.oldCardinal = oldCardinal;
	}

	public CardinalVO getNewCardinal() {
		return newCardinal;
	}

	public void setNewCardinal(CardinalVO newCardinal) {
		this.newCardinal = newCardinal;
	}
}
