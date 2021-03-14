package com.changbi.tt.dev.data.vo;

import forFaith.dev.vo.CommonVO;

@SuppressWarnings("serial")
public class IpAddressVO extends CommonVO {
	// 검색조건
    private IpAddressVO search;
    
    private UserVO user;	// 사용자정보
    private String ip;			// 아이피
	
    public IpAddressVO getSearch() {
		return search;
	}
	public void setSearch(IpAddressVO search) {
		this.search = search;
	}
	public UserVO getUser() {
		return user;
	}
	public void setUser(UserVO user) {
		this.user = user;
	}
	public String getIp() {
		return ip;
	}
	public void setIp(String ip) {
		this.ip = ip;
	}
}
