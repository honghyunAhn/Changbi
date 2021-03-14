package com.lms.student.vo;

import forFaith.dev.vo.CommonVO;

@SuppressWarnings("serial")
public class MouVO extends CommonVO{

	private String mou_code;
	private String code_nm;
	
	public String getMou_code() {
		return mou_code;
	}
	public void setMou_code(String mou_code) {
		this.mou_code = mou_code;
	}
	public String getCode_nm() {
		return code_nm;
	}
	public void setCode_nm(String code_nm) {
		this.code_nm = code_nm;
	}
}
