package com.lms.student.vo;

import java.util.List;

public class StuInfoLicenseVO {
	private int stu_license_seq;
	private int stu_seq;
	private String gisu_id;
	private String user_id;
	private String stu_license_nm;
	private String stu_license_ag;
	private String stu_license_obtain_dt;
	private String stu_license_note;
	private String stu_license_ins_id;
	private String stu_license_ins_dt;
	private String stu_license_udt_id;
	private String stu_license_udt_dt;
	private List<StuInfoLicenseVO> licenseList;
	
	public StuInfoLicenseVO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public StuInfoLicenseVO(int stu_license_seq, int stu_seq, String gisu_id, String user_id, String stu_license_nm,
			String stu_license_ag, String stu_license_obtain_dt, String stu_license_note, String stu_license_ins_id,
			String stu_license_ins_dt, String stu_license_udt_id, String stu_license_udt_dt,
			List<StuInfoLicenseVO> licenseList) {
		super();
		this.stu_license_seq = stu_license_seq;
		this.stu_seq = stu_seq;
		this.gisu_id = gisu_id;
		this.user_id = user_id;
		this.stu_license_nm = stu_license_nm;
		this.stu_license_ag = stu_license_ag;
		this.stu_license_obtain_dt = stu_license_obtain_dt;
		this.stu_license_note = stu_license_note;
		this.stu_license_ins_id = stu_license_ins_id;
		this.stu_license_ins_dt = stu_license_ins_dt;
		this.stu_license_udt_id = stu_license_udt_id;
		this.stu_license_udt_dt = stu_license_udt_dt;
		this.licenseList = licenseList;
	}

	public int getStu_license_seq() {
		return stu_license_seq;
	}

	public void setStu_license_seq(int stu_license_seq) {
		this.stu_license_seq = stu_license_seq;
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

	public String getStu_license_nm() {
		return stu_license_nm;
	}

	public void setStu_license_nm(String stu_license_nm) {
		this.stu_license_nm = stu_license_nm;
	}

	public String getStu_license_ag() {
		return stu_license_ag;
	}

	public void setStu_license_ag(String stu_license_ag) {
		this.stu_license_ag = stu_license_ag;
	}

	public String getStu_license_obtain_dt() {
		return stu_license_obtain_dt;
	}

	public void setStu_license_obtain_dt(String stu_license_obtain_dt) {
		this.stu_license_obtain_dt = stu_license_obtain_dt;
	}

	public String getStu_license_note() {
		return stu_license_note;
	}

	public void setStu_license_note(String stu_license_note) {
		this.stu_license_note = stu_license_note;
	}

	public String getStu_license_ins_id() {
		return stu_license_ins_id;
	}

	public void setStu_license_ins_id(String stu_license_ins_id) {
		this.stu_license_ins_id = stu_license_ins_id;
	}

	public String getStu_license_ins_dt() {
		return stu_license_ins_dt;
	}

	public void setStu_license_ins_dt(String stu_license_ins_dt) {
		this.stu_license_ins_dt = stu_license_ins_dt;
	}

	public String getStu_license_udt_id() {
		return stu_license_udt_id;
	}

	public void setStu_license_udt_id(String stu_license_udt_id) {
		this.stu_license_udt_id = stu_license_udt_id;
	}

	public String getStu_license_udt_dt() {
		return stu_license_udt_dt;
	}

	public void setStu_license_udt_dt(String stu_license_udt_dt) {
		this.stu_license_udt_dt = stu_license_udt_dt;
	}

	public List<StuInfoLicenseVO> getLicenseList() {
		return licenseList;
	}

	public void setLicenseList(List<StuInfoLicenseVO> licenseList) {
		this.licenseList = licenseList;
	}

	@Override
	public String toString() {
		return "StuInfoLicenseVO [stu_license_seq=" + stu_license_seq + ", stu_seq=" + stu_seq + ", gisu_id=" + gisu_id
				+ ", user_id=" + user_id + ", stu_license_nm=" + stu_license_nm + ", stu_license_ag=" + stu_license_ag
				+ ", stu_license_obtain_dt=" + stu_license_obtain_dt + ", stu_license_note=" + stu_license_note
				+ ", stu_license_ins_id=" + stu_license_ins_id + ", stu_license_ins_dt=" + stu_license_ins_dt
				+ ", stu_license_udt_id=" + stu_license_udt_id + ", stu_license_udt_dt=" + stu_license_udt_dt
				+ ", licenseList=" + licenseList + "]";
	}

}
