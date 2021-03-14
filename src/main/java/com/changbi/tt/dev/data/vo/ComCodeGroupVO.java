package com.changbi.tt.dev.data.vo;

import java.util.List;

import forFaith.dev.vo.CommonVO;

// 공통코드 VO
@SuppressWarnings("serial")
public class ComCodeGroupVO extends CommonVO {
	
    private String group_id;
    private String group_nm;
    private String group_detail;
    private String group_ins_id;
    private String group_ins_dt;
    private String group_udt_id;
    private String group_udt_dt;
    private String code_group;			// 그룹코드 첫째자리 (A, B,...)
    private String com_code;			// 공통코드 5자리 (그룹코드 + 코드)
    private int com_code_length;		// 공통코드 검색 쿼리에서 사용
    private List<ComCodeVO> codeList;	// 공통코드 조회 쿼리에서 사용
    
	public String getGroup_id() {
		return group_id;
	}
	public void setGroup_id(String group_id) {
		this.group_id = group_id;
	}
	public String getGroup_nm() {
		return group_nm;
	}
	public void setGroup_nm(String group_nm) {
		this.group_nm = group_nm;
	}
	public String getGroup_detail() {
		return group_detail;
	}
	public void setGroup_detail(String group_detail) {
		this.group_detail = group_detail;
	}
	public String getGroup_ins_id() {
		return group_ins_id;
	}
	public void setGroup_ins_id(String group_ins_id) {
		this.group_ins_id = group_ins_id;
	}
	public String getGroup_ins_dt() {
		return group_ins_dt;
	}
	public void setGroup_ins_dt(String group_ins_dt) {
		this.group_ins_dt = group_ins_dt;
	}
	public String getGroup_udt_id() {
		return group_udt_id;
	}
	public void setGroup_udt_id(String group_udt_id) {
		this.group_udt_id = group_udt_id;
	}
	public String getGroup_udt_dt() {
		return group_udt_dt;
	}
	public void setGroup_udt_dt(String group_udt_dt) {
		this.group_udt_dt = group_udt_dt;
	}
	public String getCode_group() {
		return code_group;
	}
	public void setCode_group(String code_group) {
		this.code_group = code_group;
	}
	public String getCom_code() {
		return com_code;
	}
	public void setCom_code(String com_code) {
		this.com_code = com_code;
	}
	public int getCom_code_length() {
		return com_code_length;
	}
	public void setCom_code_length(int com_code_length) {
		this.com_code_length = com_code_length;
	}
	public List<ComCodeVO> getCodeList() {
		return codeList;
	}
	public void setCodeList(List<ComCodeVO> codeList) {
		this.codeList = codeList;
	}
}
