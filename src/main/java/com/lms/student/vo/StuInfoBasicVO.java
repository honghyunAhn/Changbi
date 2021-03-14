package com.lms.student.vo;

import java.util.Date;

import forFaith.dev.vo.AttachFileVO;
import forFaith.dev.vo.CommonVO;

@SuppressWarnings("serial")
public class StuInfoBasicVO extends CommonVO {
	private int stu_seq;
	private String gisu_id;
	private String user_id;
	private String stu_user_nm;
	private String stu_user_nm_en; 
	private String stu_user_nm_jp;
	private Date stu_user_birth;
	private String stu_user_gender;
	private String stu_class_ict;
	private String stu_class_jp;
	private String stu_mt_ck;
	private String stu_mt_etc;
	private String stu_zipcode;
	private String stu_addr;
	private String stu_addr_detail;
	private String stu_phone;
	private String stu_em_phone;
	private String stu_email;
	
	
	private String stu_photo_attached; 
	private String stu_edu_attached; 
	private String stu_isr_attached;
	private String stu_imm_attached;
	private String stu_worknet_attached;
	private String stu_quit_attached;
	
	private String stu_benefit_ck;
	private String stu_mou_ck;
	private String stu_mou_sc;
	private String stu_mou_sc_nm;
	private String stu_state_ck;
	private String stu_quit_dt;
	private String stu_quit_reason;
	private String stu_memo;
	
	private AttachFileVO stu_photo_file; 
	private AttachFileVO stu_edu_file; 
	private AttachFileVO stu_isr_file;
	private AttachFileVO stu_imm_file;
	private AttachFileVO stu_worknet_file;
	private AttachFileVO stu_quit_file;
	
	public StuInfoBasicVO() {
		super();
	}

	public StuInfoBasicVO(int stu_seq, String gisu_id, String user_id, String stu_user_nm, String stu_user_nm_en,
			String stu_user_nm_jp, Date stu_user_birth, String stu_user_gender, String stu_class_ict,
			String stu_class_jp, String stu_mt_ck, String stu_mt_etc, String stu_zipcode, String stu_addr,
			String stu_addr_detail, String stu_phone, String stu_em_phone, String stu_email, String stu_photo_attached,
			String stu_edu_attached, String stu_isr_attached, String stu_imm_attached, String stu_worknet_attached,
			String stu_quit_attached, String stu_benefit_ck, String stu_mou_ck, String stu_mou_sc, String stu_mou_sc_nm,
			String stu_state_ck, String stu_quit_dt, String stu_quit_reason, String stu_memo,
			AttachFileVO stu_photo_file, AttachFileVO stu_edu_file, AttachFileVO stu_isr_file,
			AttachFileVO stu_imm_file, AttachFileVO stu_worknet_file, AttachFileVO stu_quit_file) {
		super();
		this.stu_seq = stu_seq;
		this.gisu_id = gisu_id;
		this.user_id = user_id;
		this.stu_user_nm = stu_user_nm;
		this.stu_user_nm_en = stu_user_nm_en;
		this.stu_user_nm_jp = stu_user_nm_jp;
		this.stu_user_birth = stu_user_birth;
		this.stu_user_gender = stu_user_gender;
		this.stu_class_ict = stu_class_ict;
		this.stu_class_jp = stu_class_jp;
		this.stu_mt_ck = stu_mt_ck;
		this.stu_mt_etc = stu_mt_etc;
		this.stu_zipcode = stu_zipcode;
		this.stu_addr = stu_addr;
		this.stu_addr_detail = stu_addr_detail;
		this.stu_phone = stu_phone;
		this.stu_em_phone = stu_em_phone;
		this.stu_email = stu_email;
		this.stu_photo_attached = stu_photo_attached;
		this.stu_edu_attached = stu_edu_attached;
		this.stu_isr_attached = stu_isr_attached;
		this.stu_imm_attached = stu_imm_attached;
		this.stu_worknet_attached = stu_worknet_attached;
		this.stu_quit_attached = stu_quit_attached;
		this.stu_benefit_ck = stu_benefit_ck;
		this.stu_mou_ck = stu_mou_ck;
		this.stu_mou_sc = stu_mou_sc;
		this.stu_mou_sc_nm = stu_mou_sc_nm;
		this.stu_state_ck = stu_state_ck;
		this.stu_quit_dt = stu_quit_dt;
		this.stu_quit_reason = stu_quit_reason;
		this.stu_memo = stu_memo;
		this.stu_photo_file = stu_photo_file;
		this.stu_edu_file = stu_edu_file;
		this.stu_isr_file = stu_isr_file;
		this.stu_imm_file = stu_imm_file;
		this.stu_worknet_file = stu_worknet_file;
		this.stu_quit_file = stu_quit_file;
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

	public String getStu_user_nm() {
		return stu_user_nm;
	}

	public void setStu_user_nm(String stu_user_nm) {
		this.stu_user_nm = stu_user_nm;
	}

	public String getStu_user_nm_en() {
		return stu_user_nm_en;
	}

	public void setStu_user_nm_en(String stu_user_nm_en) {
		this.stu_user_nm_en = stu_user_nm_en;
	}

	public String getStu_user_nm_jp() {
		return stu_user_nm_jp;
	}

	public void setStu_user_nm_jp(String stu_user_nm_jp) {
		this.stu_user_nm_jp = stu_user_nm_jp;
	}

	public Date getStu_user_birth() {
		return stu_user_birth;
	}

	public void setStu_user_birth(Date stu_user_birth) {
		this.stu_user_birth = stu_user_birth;
	}

	public String getStu_user_gender() {
		return stu_user_gender;
	}

	public void setStu_user_gender(String stu_user_gender) {
		this.stu_user_gender = stu_user_gender;
	}

	public String getStu_class_ict() {
		return stu_class_ict;
	}

	public void setStu_class_ict(String stu_class_ict) {
		this.stu_class_ict = stu_class_ict;
	}

	public String getStu_class_jp() {
		return stu_class_jp;
	}

	public void setStu_class_jp(String stu_class_jp) {
		this.stu_class_jp = stu_class_jp;
	}

	public String getStu_mt_ck() {
		return stu_mt_ck;
	}

	public void setStu_mt_ck(String stu_mt_ck) {
		this.stu_mt_ck = stu_mt_ck;
	}

	public String getStu_mt_etc() {
		return stu_mt_etc;
	}

	public void setStu_mt_etc(String stu_mt_etc) {
		this.stu_mt_etc = stu_mt_etc;
	}

	public String getStu_zipcode() {
		return stu_zipcode;
	}

	public void setStu_zipcode(String stu_zipcode) {
		this.stu_zipcode = stu_zipcode;
	}

	public String getStu_addr() {
		return stu_addr;
	}

	public void setStu_addr(String stu_addr) {
		this.stu_addr = stu_addr;
	}

	public String getStu_addr_detail() {
		return stu_addr_detail;
	}

	public void setStu_addr_detail(String stu_addr_detail) {
		this.stu_addr_detail = stu_addr_detail;
	}

	public String getStu_phone() {
		return stu_phone;
	}

	public void setStu_phone(String stu_phone) {
		this.stu_phone = stu_phone;
	}

	public String getStu_em_phone() {
		return stu_em_phone;
	}

	public void setStu_em_phone(String stu_em_phone) {
		this.stu_em_phone = stu_em_phone;
	}

	public String getStu_email() {
		return stu_email;
	}

	public void setStu_email(String stu_email) {
		this.stu_email = stu_email;
	}

	public String getStu_photo_attached() {
		return stu_photo_attached;
	}

	public void setStu_photo_attached(String stu_photo_attached) {
		this.stu_photo_attached = stu_photo_attached;
	}

	public String getStu_edu_attached() {
		return stu_edu_attached;
	}

	public void setStu_edu_attached(String stu_edu_attached) {
		this.stu_edu_attached = stu_edu_attached;
	}

	public String getStu_isr_attached() {
		return stu_isr_attached;
	}

	public void setStu_isr_attached(String stu_isr_attached) {
		this.stu_isr_attached = stu_isr_attached;
	}

	public String getStu_imm_attached() {
		return stu_imm_attached;
	}

	public void setStu_imm_attached(String stu_imm_attached) {
		this.stu_imm_attached = stu_imm_attached;
	}

	public String getStu_worknet_attached() {
		return stu_worknet_attached;
	}

	public void setStu_worknet_attached(String stu_worknet_attached) {
		this.stu_worknet_attached = stu_worknet_attached;
	}

	public String getStu_quit_attached() {
		return stu_quit_attached;
	}

	public void setStu_quit_attached(String stu_quit_attached) {
		this.stu_quit_attached = stu_quit_attached;
	}

	public String getStu_benefit_ck() {
		return stu_benefit_ck;
	}

	public void setStu_benefit_ck(String stu_benefit_ck) {
		this.stu_benefit_ck = stu_benefit_ck;
	}

	public String getStu_mou_ck() {
		return stu_mou_ck;
	}

	public void setStu_mou_ck(String stu_mou_ck) {
		this.stu_mou_ck = stu_mou_ck;
	}

	public String getStu_mou_sc() {
		return stu_mou_sc;
	}

	public void setStu_mou_sc(String stu_mou_sc) {
		this.stu_mou_sc = stu_mou_sc;
	}

	public String getStu_mou_sc_nm() {
		return stu_mou_sc_nm;
	}

	public void setStu_mou_sc_nm(String stu_mou_sc_nm) {
		this.stu_mou_sc_nm = stu_mou_sc_nm;
	}

	public String getStu_state_ck() {
		return stu_state_ck;
	}

	public void setStu_state_ck(String stu_state_ck) {
		this.stu_state_ck = stu_state_ck;
	}

	public String getStu_quit_dt() {
		return stu_quit_dt;
	}

	public void setStu_quit_dt(String stu_quit_dt) {
		this.stu_quit_dt = stu_quit_dt;
	}

	public String getStu_quit_reason() {
		return stu_quit_reason;
	}

	public void setStu_quit_reason(String stu_quit_reason) {
		this.stu_quit_reason = stu_quit_reason;
	}

	public String getStu_memo() {
		return stu_memo;
	}

	public void setStu_memo(String stu_memo) {
		this.stu_memo = stu_memo;
	}

	public AttachFileVO getStu_photo_file() {
		return stu_photo_file;
	}

	public void setStu_photo_file(AttachFileVO stu_photo_file) {
		this.stu_photo_file = stu_photo_file;
	}

	public AttachFileVO getStu_edu_file() {
		return stu_edu_file;
	}

	public void setStu_edu_file(AttachFileVO stu_edu_file) {
		this.stu_edu_file = stu_edu_file;
	}

	public AttachFileVO getStu_isr_file() {
		return stu_isr_file;
	}

	public void setStu_isr_file(AttachFileVO stu_isr_file) {
		this.stu_isr_file = stu_isr_file;
	}

	public AttachFileVO getStu_imm_file() {
		return stu_imm_file;
	}

	public void setStu_imm_file(AttachFileVO stu_imm_file) {
		this.stu_imm_file = stu_imm_file;
	}

	public AttachFileVO getStu_worknet_file() {
		return stu_worknet_file;
	}

	public void setStu_worknet_file(AttachFileVO stu_worknet_file) {
		this.stu_worknet_file = stu_worknet_file;
	}

	public AttachFileVO getStu_quit_file() {
		return stu_quit_file;
	}

	public void setStu_quit_file(AttachFileVO stu_quit_file) {
		this.stu_quit_file = stu_quit_file;
	}

	@Override
	public String toString() {
		return "StuInfoBasicVO [stu_seq=" + stu_seq + ", gisu_id=" + gisu_id + ", user_id=" + user_id + ", stu_user_nm="
				+ stu_user_nm + ", stu_user_nm_en=" + stu_user_nm_en + ", stu_user_nm_jp=" + stu_user_nm_jp
				+ ", stu_user_birth=" + stu_user_birth + ", stu_user_gender=" + stu_user_gender + ", stu_class_ict="
				+ stu_class_ict + ", stu_class_jp=" + stu_class_jp + ", stu_mt_ck=" + stu_mt_ck + ", stu_mt_etc="
				+ stu_mt_etc + ", stu_zipcode=" + stu_zipcode + ", stu_addr=" + stu_addr + ", stu_addr_detail="
				+ stu_addr_detail + ", stu_phone=" + stu_phone + ", stu_em_phone=" + stu_em_phone + ", stu_email="
				+ stu_email + ", stu_photo_attached=" + stu_photo_attached + ", stu_edu_attached=" + stu_edu_attached
				+ ", stu_isr_attached=" + stu_isr_attached + ", stu_imm_attached=" + stu_imm_attached
				+ ", stu_worknet_attached=" + stu_worknet_attached + ", stu_quit_attached=" + stu_quit_attached
				+ ", stu_benefit_ck=" + stu_benefit_ck + ", stu_mou_ck=" + stu_mou_ck + ", stu_mou_sc=" + stu_mou_sc
				+ ", stu_mou_sc_nm=" + stu_mou_sc_nm + ", stu_state_ck=" + stu_state_ck + ", stu_quit_dt=" + stu_quit_dt
				+ ", stu_quit_reason=" + stu_quit_reason + ", stu_memo=" + stu_memo + ", stu_photo_file="
				+ stu_photo_file + ", stu_edu_file=" + stu_edu_file + ", stu_isr_file=" + stu_isr_file
				+ ", stu_imm_file=" + stu_imm_file + ", stu_worknet_file=" + stu_worknet_file + ", stu_quit_file="
				+ stu_quit_file + "]";
	}
	
}
