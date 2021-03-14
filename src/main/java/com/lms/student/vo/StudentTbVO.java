package com.lms.student.vo;


import forFaith.dev.vo.AttachFileVO;
import forFaith.dev.vo.CommonVO;

@SuppressWarnings("serial")
public class StudentTbVO extends CommonVO{

	private int stu_seq;
	private String crc_id;
	private String gisu_id;
	private String user_id;
	private String stu_user_nm;
	private String stu_user_nm_en;
	private String stu_user_nm_jp;
	private String stu_user_birth;
	private int stu_user_age;
	
	private String stu_addr;
	private String stu_phone;
	private String stu_email;
	private String stu_user_gender;
	private String stu_class;
	private String stu_edu_sc_nm;
	private String stu_edu_major;
	private String stu_edu_sc_lo;
	private String stu_edu_gd_ck;
	private String stu_license;
	private String stu_language;
	private String infoProcessing;
	private String stu_overseas;
	
	private String stu_mou_ck;
	private String stu_mou_sc;
	private String stu_mou_sc_nm;
	private String stu_benefit_ck;
	private String stu_state_ck;
	private String stu_quit_dt; 
	private String stu_quit_reason;
	private String stu_memo;
	
	private String stu_photo_attached;
	private String stu_edu_attached;
	private String stu_isr_attached;
	private String stu_imm_attached;
	private String stu_worknet_attached;
	private String stu_quit_attached;
	private String gisu_nm;
	
	private AttachFileVO stu_photo_file; 
	private AttachFileVO stu_edu_file; 
	private AttachFileVO stu_isr_file;
	private AttachFileVO stu_imm_file;
	private AttachFileVO stu_worknet_file;
	private AttachFileVO stu_quit_file;
	
	public StudentTbVO() {
		super();
	}

	public StudentTbVO(int stu_seq, String crc_id, String gisu_id, String user_id, String stu_user_nm,
			String stu_user_nm_en, String stu_user_nm_jp, String stu_user_birth, int stu_user_age, String stu_addr,
			String stu_phone, String stu_email, String stu_user_gender, String stu_class, String stu_edu_sc_nm,
			String stu_edu_major, String stu_edu_sc_lo, String stu_edu_gd_ck, String stu_license, String stu_language,
			String infoProcessing, String stu_overseas, String stu_mou_ck, String stu_mou_sc, String stu_mou_sc_nm,
			String stu_benefit_ck, String stu_state_ck, String stu_quit_dt, String stu_quit_reason, String stu_memo,
			String stu_photo_attached, String stu_edu_attached, String stu_isr_attached, String stu_imm_attached,
			String stu_worknet_attached, String stu_quit_attached, String gisu_nm, AttachFileVO stu_photo_file,
			AttachFileVO stu_edu_file, AttachFileVO stu_isr_file, AttachFileVO stu_imm_file,
			AttachFileVO stu_worknet_file, AttachFileVO stu_quit_file) {
		super();
		this.stu_seq = stu_seq;
		this.crc_id = crc_id;
		this.gisu_id = gisu_id;
		this.user_id = user_id;
		this.stu_user_nm = stu_user_nm;
		this.stu_user_nm_en = stu_user_nm_en;
		this.stu_user_nm_jp = stu_user_nm_jp;
		this.stu_user_birth = stu_user_birth;
		this.stu_user_age = stu_user_age;
		this.stu_addr = stu_addr;
		this.stu_phone = stu_phone;
		this.stu_email = stu_email;
		this.stu_user_gender = stu_user_gender;
		this.stu_class = stu_class;
		this.stu_edu_sc_nm = stu_edu_sc_nm;
		this.stu_edu_major = stu_edu_major;
		this.stu_edu_sc_lo = stu_edu_sc_lo;
		this.stu_edu_gd_ck = stu_edu_gd_ck;
		this.stu_license = stu_license;
		this.stu_language = stu_language;
		this.infoProcessing = infoProcessing;
		this.stu_overseas = stu_overseas;
		this.stu_mou_ck = stu_mou_ck;
		this.stu_mou_sc = stu_mou_sc;
		this.stu_mou_sc_nm = stu_mou_sc_nm;
		this.stu_benefit_ck = stu_benefit_ck;
		this.stu_state_ck = stu_state_ck;
		this.stu_quit_dt = stu_quit_dt;
		this.stu_quit_reason = stu_quit_reason;
		this.stu_memo = stu_memo;
		this.stu_photo_attached = stu_photo_attached;
		this.stu_edu_attached = stu_edu_attached;
		this.stu_isr_attached = stu_isr_attached;
		this.stu_imm_attached = stu_imm_attached;
		this.stu_worknet_attached = stu_worknet_attached;
		this.stu_quit_attached = stu_quit_attached;
		this.gisu_nm = gisu_nm;
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

	public String getStu_user_birth() {
		return stu_user_birth;
	}

	public void setStu_user_birth(String stu_user_birth) {
		this.stu_user_birth = stu_user_birth;
	}

	public int getStu_user_age() {
		return stu_user_age;
	}

	public void setStu_user_age(int stu_user_age) {
		this.stu_user_age = stu_user_age;
	}

	public String getStu_addr() {
		return stu_addr;
	}

	public void setStu_addr(String stu_addr) {
		this.stu_addr = stu_addr;
	}

	public String getStu_phone() {
		return stu_phone;
	}

	public void setStu_phone(String stu_phone) {
		this.stu_phone = stu_phone;
	}

	public String getStu_email() {
		return stu_email;
	}

	public void setStu_email(String stu_email) {
		this.stu_email = stu_email;
	}

	public String getStu_user_gender() {
		return stu_user_gender;
	}

	public void setStu_user_gender(String stu_user_gender) {
		this.stu_user_gender = stu_user_gender;
	}

	public String getStu_class() {
		return stu_class;
	}

	public void setStu_class(String stu_class) {
		this.stu_class = stu_class;
	}

	public String getStu_edu_sc_nm() {
		return stu_edu_sc_nm;
	}

	public void setStu_edu_sc_nm(String stu_edu_sc_nm) {
		this.stu_edu_sc_nm = stu_edu_sc_nm;
	}

	public String getStu_edu_major() {
		return stu_edu_major;
	}

	public void setStu_edu_major(String stu_edu_major) {
		this.stu_edu_major = stu_edu_major;
	}

	public String getStu_edu_sc_lo() {
		return stu_edu_sc_lo;
	}

	public void setStu_edu_sc_lo(String stu_edu_sc_lo) {
		this.stu_edu_sc_lo = stu_edu_sc_lo;
	}

	public String getStu_edu_gd_ck() {
		return stu_edu_gd_ck;
	}

	public void setStu_edu_gd_ck(String stu_edu_gd_ck) {
		this.stu_edu_gd_ck = stu_edu_gd_ck;
	}

	public String getStu_license() {
		return stu_license;
	}

	public void setStu_license(String stu_license) {
		this.stu_license = stu_license;
	}

	public String getStu_language() {
		return stu_language;
	}

	public void setStu_language(String stu_language) {
		this.stu_language = stu_language;
	}

	public String getInfoProcessing() {
		return infoProcessing;
	}

	public void setInfoProcessing(String infoProcessing) {
		this.infoProcessing = infoProcessing;
	}

	public String getStu_overseas() {
		return stu_overseas;
	}

	public void setStu_overseas(String stu_overseas) {
		this.stu_overseas = stu_overseas;
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

	public String getStu_benefit_ck() {
		return stu_benefit_ck;
	}

	public void setStu_benefit_ck(String stu_benefit_ck) {
		this.stu_benefit_ck = stu_benefit_ck;
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

	public String getGisu_nm() {
		return gisu_nm;
	}

	public void setGisu_nm(String gisu_nm) {
		this.gisu_nm = gisu_nm;
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
		return "StudentTbVO [stu_seq=" + stu_seq + ", crc_id=" + crc_id + ", gisu_id=" + gisu_id + ", user_id="
				+ user_id + ", stu_user_nm=" + stu_user_nm + ", stu_user_nm_en=" + stu_user_nm_en + ", stu_user_nm_jp="
				+ stu_user_nm_jp + ", stu_user_birth=" + stu_user_birth + ", stu_user_age=" + stu_user_age
				+ ", stu_addr=" + stu_addr + ", stu_phone=" + stu_phone + ", stu_email=" + stu_email
				+ ", stu_user_gender=" + stu_user_gender + ", stu_class=" + stu_class + ", stu_edu_sc_nm="
				+ stu_edu_sc_nm + ", stu_edu_major=" + stu_edu_major + ", stu_edu_sc_lo=" + stu_edu_sc_lo
				+ ", stu_edu_gd_ck=" + stu_edu_gd_ck + ", stu_license=" + stu_license + ", stu_language=" + stu_language
				+ ", infoProcessing=" + infoProcessing + ", stu_overseas=" + stu_overseas + ", stu_mou_ck=" + stu_mou_ck
				+ ", stu_mou_sc=" + stu_mou_sc + ", stu_mou_sc_nm=" + stu_mou_sc_nm + ", stu_benefit_ck="
				+ stu_benefit_ck + ", stu_state_ck=" + stu_state_ck + ", stu_quit_dt=" + stu_quit_dt
				+ ", stu_quit_reason=" + stu_quit_reason + ", stu_memo=" + stu_memo + ", stu_photo_attached="
				+ stu_photo_attached + ", stu_edu_attached=" + stu_edu_attached + ", stu_isr_attached="
				+ stu_isr_attached + ", stu_imm_attached=" + stu_imm_attached + ", stu_worknet_attached="
				+ stu_worknet_attached + ", stu_quit_attached=" + stu_quit_attached + ", gisu_nm=" + gisu_nm
				+ ", stu_photo_file=" + stu_photo_file + ", stu_edu_file=" + stu_edu_file + ", stu_isr_file="
				+ stu_isr_file + ", stu_imm_file=" + stu_imm_file + ", stu_worknet_file=" + stu_worknet_file
				+ ", stu_quit_file=" + stu_quit_file + "]";
	}
	
}
