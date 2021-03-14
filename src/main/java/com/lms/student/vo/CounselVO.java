package com.lms.student.vo;

import forFaith.dev.vo.AttachFileVO;
import forFaith.dev.vo.CommonVO;

/*
 * 기수 성적 카테고리 VO										
 */
@SuppressWarnings("serial")
public class CounselVO extends CommonVO{

	private int counsel_seq;
	private String course_id;
	private String cardinal_id;
	private String crc_id;
	private String gisu_id;
	private String crc_name;
	private String gisu_name;
	private String user_id;
	private String user_nm;
	private String user_phone;
	private String counsel_type;
	private String counsel_title;
	private String counsel_content;
	private String counsel_answer;
	private String counsel_regdate;
	private String counsel_teacher;
	private String counsel_teacher_name;
	
	private int totalCnt;
	private String stu_photo_attached;
	private AttachFileVO stu_photo_file;
	
	public CounselVO() {
		super();
	}

	public CounselVO(int counsel_seq, String course_id, String cardinal_id, String crc_id, String gisu_id,
			String crc_name, String gisu_name, String user_id, String user_nm, String user_phone, String counsel_type,
			String counsel_title, String counsel_content, String counsel_answer, String counsel_regdate,
			String counsel_teacher, String counsel_teacher_name, int totalCnt, String stu_photo_attached,
			AttachFileVO stu_photo_file) {
		super();
		this.counsel_seq = counsel_seq;
		this.course_id = course_id;
		this.cardinal_id = cardinal_id;
		this.crc_id = crc_id;
		this.gisu_id = gisu_id;
		this.crc_name = crc_name;
		this.gisu_name = gisu_name;
		this.user_id = user_id;
		this.user_nm = user_nm;
		this.user_phone = user_phone;
		this.counsel_type = counsel_type;
		this.counsel_title = counsel_title;
		this.counsel_content = counsel_content;
		this.counsel_answer = counsel_answer;
		this.counsel_regdate = counsel_regdate;
		this.counsel_teacher = counsel_teacher;
		this.counsel_teacher_name = counsel_teacher_name;
		this.totalCnt = totalCnt;
		this.stu_photo_attached = stu_photo_attached;
		this.stu_photo_file = stu_photo_file;
	}

	public int getCounsel_seq() {
		return counsel_seq;
	}

	public void setCounsel_seq(int counsel_seq) {
		this.counsel_seq = counsel_seq;
	}

	public String getCourse_id() {
		return course_id;
	}

	public void setCourse_id(String course_id) {
		this.course_id = course_id;
	}

	public String getCardinal_id() {
		return cardinal_id;
	}

	public void setCardinal_id(String cardinal_id) {
		this.cardinal_id = cardinal_id;
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

	public String getCrc_name() {
		return crc_name;
	}

	public void setCrc_name(String crc_name) {
		this.crc_name = crc_name;
	}

	public String getGisu_name() {
		return gisu_name;
	}

	public void setGisu_name(String gisu_name) {
		this.gisu_name = gisu_name;
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public String getUser_nm() {
		return user_nm;
	}

	public void setUser_nm(String user_nm) {
		this.user_nm = user_nm;
	}

	public String getUser_phone() {
		return user_phone;
	}

	public void setUser_phone(String user_phone) {
		this.user_phone = user_phone;
	}

	public String getCounsel_type() {
		return counsel_type;
	}

	public void setCounsel_type(String counsel_type) {
		this.counsel_type = counsel_type;
	}

	public String getCounsel_title() {
		return counsel_title;
	}

	public void setCounsel_title(String counsel_title) {
		this.counsel_title = counsel_title;
	}

	public String getCounsel_content() {
		return counsel_content;
	}

	public void setCounsel_content(String counsel_content) {
		this.counsel_content = counsel_content;
	}

	public String getCounsel_answer() {
		return counsel_answer;
	}

	public void setCounsel_answer(String counsel_answer) {
		this.counsel_answer = counsel_answer;
	}

	public String getCounsel_regdate() {
		return counsel_regdate;
	}

	public void setCounsel_regdate(String counsel_regdate) {
		this.counsel_regdate = counsel_regdate;
	}

	public String getCounsel_teacher() {
		return counsel_teacher;
	}

	public void setCounsel_teacher(String counsel_teacher) {
		this.counsel_teacher = counsel_teacher;
	}

	public String getCounsel_teacher_name() {
		return counsel_teacher_name;
	}

	public void setCounsel_teacher_name(String counsel_teacher_name) {
		this.counsel_teacher_name = counsel_teacher_name;
	}

	public int getTotalCnt() {
		return totalCnt;
	}

	public void setTotalCnt(int totalCnt) {
		this.totalCnt = totalCnt;
	}

	public String getStu_photo_attached() {
		return stu_photo_attached;
	}

	public void setStu_photo_attached(String stu_photo_attached) {
		this.stu_photo_attached = stu_photo_attached;
	}

	public AttachFileVO getStu_photo_file() {
		return stu_photo_file;
	}

	public void setStu_photo_file(AttachFileVO stu_photo_file) {
		this.stu_photo_file = stu_photo_file;
	}

	@Override
	public String toString() {
		return "CounselVO [counsel_seq=" + counsel_seq + ", course_id=" + course_id + ", cardinal_id=" + cardinal_id
				+ ", crc_id=" + crc_id + ", gisu_id=" + gisu_id + ", crc_name=" + crc_name + ", gisu_name=" + gisu_name
				+ ", user_id=" + user_id + ", user_nm=" + user_nm + ", user_phone=" + user_phone + ", counsel_type="
				+ counsel_type + ", counsel_title=" + counsel_title + ", counsel_content=" + counsel_content
				+ ", counsel_answer=" + counsel_answer + ", counsel_regdate=" + counsel_regdate + ", counsel_teacher="
				+ counsel_teacher + ", counsel_teacher_name=" + counsel_teacher_name + ", totalCnt=" + totalCnt
				+ ", stu_photo_attached=" + stu_photo_attached + ", stu_photo_file=" + stu_photo_file + "]";
	}
}
