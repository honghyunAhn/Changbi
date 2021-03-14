package com.lms.student.vo;

import java.util.List;


public class StuInfoLanguageVO {
	private int stu_lang_seq;
	private int stu_seq;
	private String gisu_id;
	private String user_id;
	private String stu_lang_test_nm;
	private String stu_lang_grade;
	private String stu_lang_ag;
	private String stu_lang_obtain_dt;
	private String stu_lang_note;
	private String stu_lang_ins_id;
	private String stu_lang_ins_dt;
	private String stu_lang_udt_id;
	private String stu_lang_udt_dt;
	private List<StuInfoLanguageVO> languageList;
	
	public StuInfoLanguageVO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public StuInfoLanguageVO(int stu_lang_seq, int stu_seq, String gisu_id, String user_id, String stu_lang_test_nm,
			String stu_lang_grade, String stu_lang_ag, String stu_lang_obtain_dt, String stu_lang_note,
			String stu_lang_ins_id, String stu_lang_ins_dt, String stu_lang_udt_id, String stu_lang_udt_dt,
			List<StuInfoLanguageVO> languageList) {
		super();
		this.stu_lang_seq = stu_lang_seq;
		this.stu_seq = stu_seq;
		this.gisu_id = gisu_id;
		this.user_id = user_id;
		this.stu_lang_test_nm = stu_lang_test_nm;
		this.stu_lang_grade = stu_lang_grade;
		this.stu_lang_ag = stu_lang_ag;
		this.stu_lang_obtain_dt = stu_lang_obtain_dt;
		this.stu_lang_note = stu_lang_note;
		this.stu_lang_ins_id = stu_lang_ins_id;
		this.stu_lang_ins_dt = stu_lang_ins_dt;
		this.stu_lang_udt_id = stu_lang_udt_id;
		this.stu_lang_udt_dt = stu_lang_udt_dt;
		this.languageList = languageList;
	}

	public int getStu_lang_seq() {
		return stu_lang_seq;
	}

	public void setStu_lang_seq(int stu_lang_seq) {
		this.stu_lang_seq = stu_lang_seq;
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

	public String getStu_lang_test_nm() {
		return stu_lang_test_nm;
	}

	public void setStu_lang_test_nm(String stu_lang_test_nm) {
		this.stu_lang_test_nm = stu_lang_test_nm;
	}

	public String getStu_lang_grade() {
		return stu_lang_grade;
	}

	public void setStu_lang_grade(String stu_lang_grade) {
		this.stu_lang_grade = stu_lang_grade;
	}

	public String getStu_lang_ag() {
		return stu_lang_ag;
	}

	public void setStu_lang_ag(String stu_lang_ag) {
		this.stu_lang_ag = stu_lang_ag;
	}

	public String getStu_lang_obtain_dt() {
		return stu_lang_obtain_dt;
	}

	public void setStu_lang_obtain_dt(String stu_lang_obtain_dt) {
		this.stu_lang_obtain_dt = stu_lang_obtain_dt;
	}

	public String getStu_lang_note() {
		return stu_lang_note;
	}

	public void setStu_lang_note(String stu_lang_note) {
		this.stu_lang_note = stu_lang_note;
	}

	public String getStu_lang_ins_id() {
		return stu_lang_ins_id;
	}

	public void setStu_lang_ins_id(String stu_lang_ins_id) {
		this.stu_lang_ins_id = stu_lang_ins_id;
	}

	public String getStu_lang_ins_dt() {
		return stu_lang_ins_dt;
	}

	public void setStu_lang_ins_dt(String stu_lang_ins_dt) {
		this.stu_lang_ins_dt = stu_lang_ins_dt;
	}

	public String getStu_lang_udt_id() {
		return stu_lang_udt_id;
	}

	public void setStu_lang_udt_id(String stu_lang_udt_id) {
		this.stu_lang_udt_id = stu_lang_udt_id;
	}

	public String getStu_lang_udt_dt() {
		return stu_lang_udt_dt;
	}

	public void setStu_lang_udt_dt(String stu_lang_udt_dt) {
		this.stu_lang_udt_dt = stu_lang_udt_dt;
	}

	public List<StuInfoLanguageVO> getLanguageList() {
		return languageList;
	}

	public void setLanguageList(List<StuInfoLanguageVO> languageList) {
		this.languageList = languageList;
	}

	@Override
	public String toString() {
		return "StuInfoLanguageVO [stu_lang_seq=" + stu_lang_seq + ", stu_seq=" + stu_seq + ", gisu_id=" + gisu_id
				+ ", user_id=" + user_id + ", stu_lang_test_nm=" + stu_lang_test_nm + ", stu_lang_grade="
				+ stu_lang_grade + ", stu_lang_ag=" + stu_lang_ag + ", stu_lang_obtain_dt=" + stu_lang_obtain_dt
				+ ", stu_lang_note=" + stu_lang_note + ", stu_lang_ins_id=" + stu_lang_ins_id + ", stu_lang_ins_dt="
				+ stu_lang_ins_dt + ", stu_lang_udt_id=" + stu_lang_udt_id + ", stu_lang_udt_dt=" + stu_lang_udt_dt
				+ ", languageList=" + languageList + "]";
	}

	
}
