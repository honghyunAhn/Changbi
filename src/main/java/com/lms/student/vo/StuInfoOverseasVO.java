package com.lms.student.vo;

import java.util.List;

public class StuInfoOverseasVO {
	private int stu_overseas_seq;
	private int stu_seq;
	private String gisu_id;
	private String user_id;
	private String stu_overseas_nm;
	private String stu_overseas_st;
	private String stu_overseas_et; 
	private String stu_overseas_ck;
	private String stu_overseas_purpose;
	private String stu_overseas_ins_id;
	private String stu_overseas_ins_dt;
	private String stu_overseas_udt_id;
	private String stu_overseas_udt_dt;
	private List<StuInfoOverseasVO> overseasList;
	
	public StuInfoOverseasVO() {
		super();
	}

	public StuInfoOverseasVO(int stu_overseas_seq, int stu_seq, String gisu_id, String user_id,
			String stu_overseas_nm, String stu_overseas_st, String stu_overseas_et, String stu_overseas_ck,
			String stu_overseas_purpose, String stu_overseas_ins_id, String stu_overseas_ins_dt,
			String stu_overseas_udt_id, String stu_overseas_udt_dt, List<StuInfoOverseasVO> overseasList) {
		super();
		this.stu_overseas_seq = stu_overseas_seq;
		this.stu_seq = stu_seq;
		this.gisu_id = gisu_id;
		this.user_id = user_id;
		this.stu_overseas_nm = stu_overseas_nm;
		this.stu_overseas_st = stu_overseas_st;
		this.stu_overseas_et = stu_overseas_et;
		this.stu_overseas_ck = stu_overseas_ck;
		this.stu_overseas_purpose = stu_overseas_purpose;
		this.stu_overseas_ins_id = stu_overseas_ins_id;
		this.stu_overseas_ins_dt = stu_overseas_ins_dt;
		this.stu_overseas_udt_id = stu_overseas_udt_id;
		this.stu_overseas_udt_dt = stu_overseas_udt_dt;
		this.overseasList = overseasList;
	}

	public int getStu_overseas_seq() {
		return stu_overseas_seq;
	}

	public void setStu_overseas_seq(int stu_overseas_seq) {
		this.stu_overseas_seq = stu_overseas_seq;
	}

	public int getStu_seq() {
		return stu_seq;
	}

	public void setStu_seq(int stu_seq) {
		this.stu_seq = stu_seq;
	}

	public String getGisu_id() {
		return gisu_id;
	}

	public void setGisu_id(String gisu_id) {
		this.gisu_id = gisu_id;
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public String getStu_overseas_nm() {
		return stu_overseas_nm;
	}

	public void setStu_overseas_nm(String stu_overseas_nm) {
		this.stu_overseas_nm = stu_overseas_nm;
	}

	public String getStu_overseas_st() {
		return stu_overseas_st;
	}

	public void setStu_overseas_st(String stu_overseas_st) {
		this.stu_overseas_st = stu_overseas_st;
	}

	public String getStu_overseas_et() {
		return stu_overseas_et;
	}

	public void setStu_overseas_et(String stu_overseas_et) {
		this.stu_overseas_et = stu_overseas_et;
	}

	public String getStu_overseas_ck() {
		return stu_overseas_ck;
	}

	public void setStu_overseas_ck(String stu_overseas_ck) {
		this.stu_overseas_ck = stu_overseas_ck;
	}

	public String getStu_overseas_purpose() {
		return stu_overseas_purpose;
	}

	public void setStu_overseas_purpose(String stu_overseas_purpose) {
		this.stu_overseas_purpose = stu_overseas_purpose;
	}

	public String getStu_overseas_ins_id() {
		return stu_overseas_ins_id;
	}

	public void setStu_overseas_ins_id(String stu_overseas_ins_id) {
		this.stu_overseas_ins_id = stu_overseas_ins_id;
	}

	public String getStu_overseas_ins_dt() {
		return stu_overseas_ins_dt;
	}

	public void setStu_overseas_ins_dt(String stu_overseas_ins_dt) {
		this.stu_overseas_ins_dt = stu_overseas_ins_dt;
	}

	public String getStu_overseas_udt_id() {
		return stu_overseas_udt_id;
	}

	public void setStu_overseas_udt_id(String stu_overseas_udt_id) {
		this.stu_overseas_udt_id = stu_overseas_udt_id;
	}

	public String getStu_overseas_udt_dt() {
		return stu_overseas_udt_dt;
	}

	public void setStu_overseas_udt_dt(String stu_overseas_udt_dt) {
		this.stu_overseas_udt_dt = stu_overseas_udt_dt;
	}

	public List<StuInfoOverseasVO> getOverseasList() {
		return overseasList;
	}

	public void setOverseasList(List<StuInfoOverseasVO> overseasList) {
		this.overseasList = overseasList;
	}

	@Override
	public String toString() {
		return "StudentInfoOverseas [stu_overseas_seq=" + stu_overseas_seq + ", stu_seq=" + stu_seq + ", gisu_id="
				+ gisu_id + ", user_id=" + user_id + ", stu_overseas_nm=" + stu_overseas_nm + ", stu_overseas_st="
				+ stu_overseas_st + ", stu_overseas_et=" + stu_overseas_et + ", stu_overseas_ck=" + stu_overseas_ck
				+ ", stu_overseas_purpose=" + stu_overseas_purpose + ", stu_overseas_ins_id=" + stu_overseas_ins_id
				+ ", stu_overseas_ins_dt=" + stu_overseas_ins_dt + ", stu_overseas_udt_id=" + stu_overseas_udt_id
				+ ", stu_overseas_udt_dt=" + stu_overseas_udt_dt + ", overseasList=" + overseasList + "]";
	}

}

