package com.changbi.tt.dev.data.vo;

import forFaith.dev.vo.CommonVO;

/**
 * @Class Name : WithdrawalVO.java
 * @Description : 탈퇴회원정보
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
public class WithdrawalVO extends CommonVO {
	// 검색조건
    private WithdrawalVO search;
    
	private int id;	    						// seq id
	private String note;						// 탈퇴사유

	private UserVO user;						// 사용자 정보
	
    public WithdrawalVO getSearch() {
        return search;
    }

    public void setSearch(WithdrawalVO search) {
        this.search = search;
    }

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getNote() {
		return note;
	}

	public void setNote(String note) {
		this.note = note;
	}

	public UserVO getUser() {
		return user;
	}

	public void setUser(UserVO user) {
		this.user = user;
	}
}
