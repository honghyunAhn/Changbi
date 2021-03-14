package com.lms.student.vo;

import forFaith.dev.vo.CommonVO;

@SuppressWarnings("serial")
public class ApplyVO extends CommonVO{

	private int stu_app_seq;
	private String crc_id;
	private String gisu_id;
	private String crc_nm;
	private String gisu_nm;
	private String stu_app_ins_dt;
	private String user_id;
	private String stu_app_nm;
	private String stu_app_phone;
	private String stu_app_email;
	private String stu_app_rt_doc;
	private String stu_app_rt_doc_id;
	private String stu_app_rt_doc_dt;
	private String stu_app_rt_itv;
	private String stu_app_rt_itv_id;
	private String stu_app_rt_itv_dt;
	private String confirm; //연수인원으로 확정되었는지 유무	yes:확정됨	no:미확정
	
	public ApplyVO() {
		super();
	}

	public ApplyVO(int stu_app_seq, String crc_id, String gisu_id, String crc_nm, String gisu_nm,
			String stu_app_ins_dt, String user_id, String stu_app_nm, String stu_app_phone, String stu_app_email,
			String stu_app_rt_doc, String stu_app_rt_doc_id, String stu_app_rt_doc_dt, String stu_app_rt_itv,
			String stu_app_rt_itv_id, String stu_app_rt_itv_dt, String confirm) {
		super();
		this.stu_app_seq = stu_app_seq;
		this.crc_id = crc_id;
		this.gisu_id = gisu_id;
		this.crc_nm = crc_nm;
		this.gisu_nm = gisu_nm;
		this.stu_app_ins_dt = stu_app_ins_dt;
		this.user_id = user_id;
		this.stu_app_nm = stu_app_nm;
		this.stu_app_phone = stu_app_phone;
		this.stu_app_email = stu_app_email;
		this.stu_app_rt_doc = stu_app_rt_doc;
		this.stu_app_rt_doc_id = stu_app_rt_doc_id;
		this.stu_app_rt_doc_dt = stu_app_rt_doc_dt;
		this.stu_app_rt_itv = stu_app_rt_itv;
		this.stu_app_rt_itv_id = stu_app_rt_itv_id;
		this.stu_app_rt_itv_dt = stu_app_rt_itv_dt;
		this.confirm = confirm;
	}

	public int getStu_app_seq() {
		return stu_app_seq;
	}

	public void setStu_app_seq(int stu_app_seq) {
		this.stu_app_seq = stu_app_seq;
	}

	public String getCrc_id() {
		return crc_id;
	}

	public void setCrc_id(String crc_id) {
		this.crc_id = crc_id;
	}

	public String getGisu_id() {
		return gisu_id;
	}

	public void setGisu_id(String gisu_id) {
		this.gisu_id = gisu_id;
	}

	public String getCrc_nm() {
		return crc_nm;
	}

	public void setCrc_nm(String crc_nm) {
		this.crc_nm = crc_nm;
	}

	public String getGisu_nm() {
		return gisu_nm;
	}

	public void setGisu_nm(String gisu_nm) {
		this.gisu_nm = gisu_nm;
	}

	public String getStu_app_ins_dt() {
		return stu_app_ins_dt;
	}

	public void setStu_app_ins_dt(String stu_app_ins_dt) {
		this.stu_app_ins_dt = stu_app_ins_dt;
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public String getStu_app_nm() {
		return stu_app_nm;
	}

	public void setStu_app_nm(String stu_app_nm) {
		this.stu_app_nm = stu_app_nm;
	}

	public String getStu_app_phone() {
		return stu_app_phone;
	}

	public void setStu_app_phone(String stu_app_phone) {
		this.stu_app_phone = stu_app_phone;
	}

	public String getStu_app_email() {
		return stu_app_email;
	}

	public void setStu_app_email(String stu_app_email) {
		this.stu_app_email = stu_app_email;
	}

	public String getStu_app_rt_doc() {
		return stu_app_rt_doc;
	}

	public void setStu_app_rt_doc(String stu_app_rt_doc) {
		this.stu_app_rt_doc = stu_app_rt_doc;
	}

	public String getStu_app_rt_doc_id() {
		return stu_app_rt_doc_id;
	}

	public void setStu_app_rt_doc_id(String stu_app_rt_doc_id) {
		this.stu_app_rt_doc_id = stu_app_rt_doc_id;
	}

	public String getStu_app_rt_doc_dt() {
		return stu_app_rt_doc_dt;
	}

	public void setStu_app_rt_doc_dt(String stu_app_rt_doc_dt) {
		this.stu_app_rt_doc_dt = stu_app_rt_doc_dt;
	}

	public String getStu_app_rt_itv() {
		return stu_app_rt_itv;
	}

	public void setStu_app_rt_itv(String stu_app_rt_itv) {
		this.stu_app_rt_itv = stu_app_rt_itv;
	}

	public String getStu_app_rt_itv_id() {
		return stu_app_rt_itv_id;
	}

	public void setStu_app_rt_itv_id(String stu_app_rt_itv_id) {
		this.stu_app_rt_itv_id = stu_app_rt_itv_id;
	}

	public String getStu_app_rt_itv_dt() {
		return stu_app_rt_itv_dt;
	}

	public void setStu_app_rt_itv_dt(String stu_app_rt_itv_dt) {
		this.stu_app_rt_itv_dt = stu_app_rt_itv_dt;
	}

	public String getConfirm() {
		return confirm;
	}

	public void setConfirm(String confirm) {
		this.confirm = confirm;
	}

	@Override
	public String toString() {
		return "ApplyMVO [stu_app_seq=" + stu_app_seq + ", crc_id=" + crc_id + ", gisu_id=" + gisu_id + ", crc_nm="
				+ crc_nm + ", gisu_nm=" + gisu_nm + ", stu_app_ins_dt=" + stu_app_ins_dt + ", user_id=" + user_id
				+ ", stu_app_nm=" + stu_app_nm + ", stu_app_phone=" + stu_app_phone + ", stu_app_email=" + stu_app_email
				+ ", stu_app_rt_doc=" + stu_app_rt_doc + ", stu_app_rt_doc_id=" + stu_app_rt_doc_id
				+ ", stu_app_rt_doc_dt=" + stu_app_rt_doc_dt + ", stu_app_rt_itv=" + stu_app_rt_itv
				+ ", stu_app_rt_itv_id=" + stu_app_rt_itv_id + ", stu_app_rt_itv_dt=" + stu_app_rt_itv_dt + ", confirm="
				+ confirm + "]";
	}

}
