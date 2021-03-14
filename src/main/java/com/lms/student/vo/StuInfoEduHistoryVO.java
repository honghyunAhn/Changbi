package com.lms.student.vo;

import java.util.List;

public class StuInfoEduHistoryVO {
	private int stu_edu_seq;
	private int stu_seq;
	private String gisu_id;
	private String user_id;
	private String stu_edu_sc_nm;
	private String stu_edu_field;
	private String stu_edu_major;
	private String stu_edu_gd_ck;
	private String stu_edu_gd_dt;
	private String stu_edu_sc_lo;
	private String stu_edu_gd_rq;
	private String stu_edu_ins_id;
	private String stu_edu_ind_dt;
	private String stu_edu_udt_id;
	private String stu_edu_udt_dt;
	private List<StuInfoEduHistoryVO> eduHistoryList;
	
	public StuInfoEduHistoryVO() {
		super();
	}

	public StuInfoEduHistoryVO(int stu_edu_seq, int stu_seq, String gisu_id, String user_id, String stu_edu_sc_nm,
			String stu_edu_field, String stu_edu_major, String stu_edu_gd_ck, String stu_edu_gd_dt,
			String stu_edu_sc_lo, String stu_edu_gd_rq, String stu_edu_ins_id, String stu_edu_ind_dt,
			String stu_edu_udt_id, String stu_edu_udt_dt, List<StuInfoEduHistoryVO> eduHistoryList) {
		super();
		this.stu_edu_seq = stu_edu_seq;
		this.stu_seq = stu_seq;
		this.gisu_id = gisu_id;
		this.user_id = user_id;
		this.stu_edu_sc_nm = stu_edu_sc_nm;
		this.stu_edu_field = stu_edu_field;
		this.stu_edu_major = stu_edu_major;
		this.stu_edu_gd_ck = stu_edu_gd_ck;
		this.stu_edu_gd_dt = stu_edu_gd_dt;
		this.stu_edu_sc_lo = stu_edu_sc_lo;
		this.stu_edu_gd_rq = stu_edu_gd_rq;
		this.stu_edu_ins_id = stu_edu_ins_id;
		this.stu_edu_ind_dt = stu_edu_ind_dt;
		this.stu_edu_udt_id = stu_edu_udt_id;
		this.stu_edu_udt_dt = stu_edu_udt_dt;
		this.eduHistoryList = eduHistoryList;
	}

	public int getStu_edu_seq() {
		return stu_edu_seq;
	}

	public void setStu_edu_seq(int stu_edu_seq) {
		this.stu_edu_seq = stu_edu_seq;
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

	public String getStu_edu_sc_nm() {
		return stu_edu_sc_nm;
	}

	public void setStu_edu_sc_nm(String stu_edu_sc_nm) {
		this.stu_edu_sc_nm = stu_edu_sc_nm;
	}

	public String getStu_edu_field() {
		return stu_edu_field;
	}

	public void setStu_edu_field(String stu_edu_field) {
		this.stu_edu_field = stu_edu_field;
	}

	public String getStu_edu_major() {
		return stu_edu_major;
	}

	public void setStu_edu_major(String stu_edu_major) {
		this.stu_edu_major = stu_edu_major;
	}

	public String getStu_edu_gd_ck() {
		return stu_edu_gd_ck;
	}

	public void setStu_edu_gd_ck(String stu_edu_gd_ck) {
		this.stu_edu_gd_ck = stu_edu_gd_ck;
	}

	public String getStu_edu_gd_dt() {
		return stu_edu_gd_dt;
	}

	public void setStu_edu_gd_dt(String stu_edu_gd_dt) {
		this.stu_edu_gd_dt = stu_edu_gd_dt;
	}

	public String getStu_edu_sc_lo() {
		return stu_edu_sc_lo;
	}

	public void setStu_edu_sc_lo(String stu_edu_sc_lo) {
		this.stu_edu_sc_lo = stu_edu_sc_lo;
	}

	public String getStu_edu_gd_rq() {
		return stu_edu_gd_rq;
	}

	public void setStu_edu_gd_rq(String stu_edu_gd_rq) {
		this.stu_edu_gd_rq = stu_edu_gd_rq;
	}

	public String getStu_edu_ins_id() {
		return stu_edu_ins_id;
	}

	public void setStu_edu_ins_id(String stu_edu_ins_id) {
		this.stu_edu_ins_id = stu_edu_ins_id;
	}

	public String getStu_edu_ind_dt() {
		return stu_edu_ind_dt;
	}

	public void setStu_edu_ind_dt(String stu_edu_ind_dt) {
		this.stu_edu_ind_dt = stu_edu_ind_dt;
	}

	public String getStu_edu_udt_id() {
		return stu_edu_udt_id;
	}

	public void setStu_edu_udt_id(String stu_edu_udt_id) {
		this.stu_edu_udt_id = stu_edu_udt_id;
	}

	public String getStu_edu_udt_dt() {
		return stu_edu_udt_dt;
	}

	public void setStu_edu_udt_dt(String stu_edu_udt_dt) {
		this.stu_edu_udt_dt = stu_edu_udt_dt;
	}

	public List<StuInfoEduHistoryVO> getEduHistoryList() {
		return eduHistoryList;
	}

	public void setEduHistoryList(List<StuInfoEduHistoryVO> eduHistoryList) {
		this.eduHistoryList = eduHistoryList;
	}

	@Override
	public String toString() {
		return "StuInfoEduHistoryVO [stu_edu_seq=" + stu_edu_seq + ", stu_seq=" + stu_seq + ", gisu_id=" + gisu_id
				+ ", user_id=" + user_id + ", stu_edu_sc_nm=" + stu_edu_sc_nm + ", stu_edu_field=" + stu_edu_field
				+ ", stu_edu_major=" + stu_edu_major + ", stu_edu_gd_ck=" + stu_edu_gd_ck + ", stu_edu_gd_dt="
				+ stu_edu_gd_dt + ", stu_edu_sc_lo=" + stu_edu_sc_lo + ", stu_edu_gd_rq=" + stu_edu_gd_rq
				+ ", stu_edu_ins_id=" + stu_edu_ins_id + ", stu_edu_ind_dt=" + stu_edu_ind_dt + ", stu_edu_udt_id="
				+ stu_edu_udt_id + ", stu_edu_udt_dt=" + stu_edu_udt_dt + ", eduHistoryList=" + eduHistoryList + "]";
	}


}
