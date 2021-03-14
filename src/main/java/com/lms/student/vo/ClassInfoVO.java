package com.lms.student.vo;

import java.util.HashMap;

public class ClassInfoVO {

	private int class_seq;
	private int class_upper_seq;
	private String crc_id;
	private String gisu_id;
	private String crc_name = "";
	private String gisu_name = "";
	private String class_name = "";
	private String class_upper_name = "";
	private String user_id;
	private String user_name;
	private String birth_day;
	private String user_phone;
	private HashMap<String,String> class_list;
	private String state;
	
	
	public ClassInfoVO() {
		super();
	}
	public ClassInfoVO(int class_seq, int class_upper_seq, String crc_id, String gisu_id, String crc_name,
			String gisu_name, String class_name, String class_upper_name, String user_id, String user_name,
			String birth_day, String user_phone, HashMap<String, String> class_list, String state) {
		super();
		this.class_seq = class_seq;
		this.class_upper_seq = class_upper_seq;
		this.crc_id = crc_id;
		this.gisu_id = gisu_id;
		this.crc_name = crc_name;
		this.gisu_name = gisu_name;
		this.class_name = class_name;
		this.class_upper_name = class_upper_name;
		this.user_id = user_id;
		this.user_name = user_name;
		this.birth_day = birth_day;
		this.user_phone = user_phone;
		this.class_list = class_list;
		this.state = state;
	}
	public int getClass_seq() {
		return class_seq;
	}
	public void setClass_seq(int class_seq) {
		this.class_seq = class_seq;
	}
	public int getClass_upper_seq() {
		return class_upper_seq;
	}
	public void setClass_upper_seq(int class_upper_seq) {
		this.class_upper_seq = class_upper_seq;
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
	public String getClass_name() {
		return class_name;
	}
	public void setClass_name(String class_name) {
		this.class_name = class_name;
	}
	public String getClass_upper_name() {
		return class_upper_name;
	}
	public void setClass_upper_name(String class_upper_name) {
		this.class_upper_name = class_upper_name;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getUser_name() {
		return user_name;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	public String getBirth_day() {
		return birth_day;
	}
	public void setBirth_day(String birth_day) {
		this.birth_day = birth_day;
	}
	public String getUser_phone() {
		return user_phone;
	}
	public void setUser_phone(String user_phone) {
		this.user_phone = user_phone;
	}
	public HashMap<String, String> getClass_list() {
		return class_list;
	}
	public void setClass_list(HashMap<String, String> class_list) {
		this.class_list = class_list;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	@Override
	public String toString() {
		return "ClassInfoVO [class_seq=" + class_seq + ", class_upper_seq=" + class_upper_seq + ", crc_id=" + crc_id
				+ ", gisu_id=" + gisu_id + ", crc_name=" + crc_name + ", gisu_name=" + gisu_name + ", class_name="
				+ class_name + ", class_upper_name=" + class_upper_name + ", user_id=" + user_id + ", user_name="
				+ user_name + ", birth_day=" + birth_day + ", user_phone=" + user_phone + ", class_list=" + class_list
				+ ", state="+ state +"]";
	}
}
