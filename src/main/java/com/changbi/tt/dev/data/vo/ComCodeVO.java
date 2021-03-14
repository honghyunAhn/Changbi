package com.changbi.tt.dev.data.vo;

import forFaith.dev.vo.CommonVO;

// 공통코드 VO
@SuppressWarnings("serial")
public class ComCodeVO extends CommonVO {
	
    private int code_seq;
    private String group_id;
    private String code;
    private String code_nm;
    private String code_nm_ja;
    private String code_nm_en;
    private String code_detail;
    private String code_ins_id;
    private String code_ins_dt;
    private String code_udt_id;
    private String code_udt_dt;
	
	public ComCodeVO() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	
	public ComCodeVO(int code_seq, String group_id, String code, String code_nm, String code_nm_ja, String code_nm_en,
			String code_detail, String code_ins_id, String code_ins_dt, String code_udt_id, String code_udt_dt) {
		super();
		this.code_seq = code_seq;
		this.group_id = group_id;
		this.code = code;
		this.code_nm = code_nm;
		this.code_nm_ja = code_nm_ja;
		this.code_nm_en = code_nm_en;
		this.code_detail = code_detail;
		this.code_ins_id = code_ins_id;
		this.code_ins_dt = code_ins_dt;
		this.code_udt_id = code_udt_id;
		this.code_udt_dt = code_udt_dt;
	}

	public int getCode_seq() {
		return code_seq;
	}
	public void setCode_seq(int code_seq) {
		this.code_seq = code_seq;
	}
	public String getGroup_id() {
		return group_id;
	}
	public void setGroup_id(String group_id) {
		this.group_id = group_id;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getCode_nm() {
		return code_nm;
	}
	public void setCode_nm(String code_nm) {
		this.code_nm = code_nm;
	}
	public String getCode_nm_ja() {
		return code_nm_ja;
	}
	public void setCode_nm_ja(String code_nm_ja) {
		this.code_nm_ja = code_nm_ja;
	}
	public String getCode_nm_en() {
		return code_nm_en;
	}
	public void setCode_nm_en(String code_nm_en) {
		this.code_nm_en = code_nm_en;
	}
	public String getCode_detail() {
		return code_detail;
	}
	public void setCode_detail(String code_detail) {
		this.code_detail = code_detail;
	}
	public String getCode_ins_id() {
		return code_ins_id;
	}
	public void setCode_ins_id(String code_ins_id) {
		this.code_ins_id = code_ins_id;
	}
	public String getCode_ins_dt() {
		return code_ins_dt;
	}
	public void setCode_ins_dt(String code_ins_dt) {
		this.code_ins_dt = code_ins_dt;
	}
	public String getCode_udt_id() {
		return code_udt_id;
	}
	public void setCode_udt_id(String code_udt_id) {
		this.code_udt_id = code_udt_id;
	}
	public String getCode_udt_dt() {
		return code_udt_dt;
	}
	public void setCode_udt_dt(String code_udt_dt) {
		this.code_udt_dt = code_udt_dt;
	}

	@Override
	public String toString() {
		return "ComCodeVO [code_seq=" + code_seq + ", group_id=" + group_id + ", code=" + code + ", code_nm=" + code_nm
				+ ", code_nm_ja=" + code_nm_ja + ", code_nm_en=" + code_nm_en + ", code_detail=" + code_detail
				+ ", code_ins_id=" + code_ins_id + ", code_ins_dt=" + code_ins_dt + ", code_udt_id=" + code_udt_id
				+ ", code_udt_dt=" + code_udt_dt + "]";
	}
}
