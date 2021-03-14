package com.changbi.tt.dev.data.vo;

import java.util.HashMap;
import java.util.List;

import forFaith.dev.vo.CommonVO;

@SuppressWarnings("serial")
public class MailVO extends CommonVO{
	
	private int mail_seq;
	private String admin_id;
	private String send_title;
	private String send_content;
	private String mail_ins_date;
	
	private String name;
	private String start_date;
	private String end_date;
	private List<HashMap<String, Object>> list;
	
	
	public List<HashMap<String, Object>> getList() {
		return list;
	}
	public void setList(List<HashMap<String, Object>> list) {
		this.list = list;
	}
	public int getMail_seq() {
		return mail_seq;
	}
	public void setMail_seq(int mail_seq) {
		this.mail_seq = mail_seq;
	}
	public String getAdmin_id() {
		return admin_id;
	}
	public void setAdmin_id(String admin_id) {
		this.admin_id = admin_id;
	}
	public String getSend_title() {
		return send_title;
	}
	public void setSend_title(String send_title) {
		this.send_title = send_title;
	}
	public String getSend_content() {
		return send_content;
	}
	public void setSend_content(String send_content) {
		this.send_content = send_content;
	}
	public String getMail_ins_date() {
		return mail_ins_date;
	}
	public void setMail_ins_date(String mail_ins_date) {
		this.mail_ins_date = mail_ins_date;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getStart_date() {
		return start_date;
	}
	public void setStart_date(String start_date) {
		this.start_date = start_date;
	}
	public String getEnd_date() {
		return end_date;
	}
	public void setEnd_date(String end_date) {
		this.end_date = end_date;
	}
	@Override
	public String toString() {
		return "MailVO [mail_seq=" + mail_seq + ", admin_id=" + admin_id + ", send_title=" + send_title
				+ ", send_content=" + send_content + ", mail_ins_date=" + mail_ins_date + ", name=" + name
				+ ", start_date=" + start_date + ", end_date=" + end_date + ", list=" + list + "]";
	}
	
}
