package com.changbi.tt.dev.data.vo;

import forFaith.dev.vo.CommonVO;

/**
 * @Class Name : LoginHistoryVO.java
 * @Description : 접속이력 히스토리
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
public class LoginHistoryVO extends CommonVO {
	// 검색조건
    private LoginHistoryVO search;
    
	private int id;		    					// 접속이력 마스터 ID
	private String ipAddress;					// 접속IP
	private String loginDate;					// 로그인 일시

	private ManagerVO manager;					// 관리자

    public LoginHistoryVO getSearch() {
        return search;
    }

    public void setSearch(LoginHistoryVO search) {
        this.search = search;
    }

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getIpAddress() {
		return ipAddress;
	}

	public void setIpAddress(String ipAddress) {
		this.ipAddress = ipAddress;
	}

	public String getLoginDate() {
		return loginDate;
	}

	public void setLoginDate(String loginDate) {
		this.loginDate = loginDate;
	}

	public ManagerVO getManager() {
		return manager;
	}

	public void setManager(ManagerVO manager) {
		this.manager = manager;
	}
}
