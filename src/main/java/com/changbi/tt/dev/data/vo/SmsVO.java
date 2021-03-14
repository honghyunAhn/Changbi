package com.changbi.tt.dev.data.vo;

import java.util.HashMap;
import java.util.List;

import forFaith.dev.vo.CommonVO;

@SuppressWarnings("serial")
public class SmsVO extends CommonVO{
	
	private int sms_seq;
	private int sms_mid;
	private String admin_id;
	private String send_num;
	private String send_title;
	private String send_content;
	private String sms_ins_date;
	private String rdate;
	
	private String name;
	private String start_date;
	private String end_date;
	private List<HashMap<String, Object>> list;
	
	private String phone;
	private String callback;
	private String msg;
	
	
	public List<HashMap<String, Object>> getList() {
		return list;
	}
	public void setList(List<HashMap<String, Object>> list) {
		this.list = list;
	}
	public int getSms_seq() {
		return sms_seq;
	}
	public void setSms_seq(int sms_seq) {
		this.sms_seq = sms_seq;
	}
	public int getSms_mid() {
		return sms_mid;
	}
	public void setSms_mid(int sms_mid) {
		this.sms_mid = sms_mid;
	}
	public String getAdmin_id() {
		return admin_id;
	}
	public void setAdmin_id(String admin_id) {
		this.admin_id = admin_id;
	}
	public String getSend_num() {
		return send_num;
	}
	public void setSend_num(String send_num) {
		this.send_num = send_num;
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
	public String getSms_ins_date() {
		return sms_ins_date;
	}
	public void setSms_ins_date(String sms_ins_date) {
		this.sms_ins_date = sms_ins_date;
	}
	public String getRdate() {
		return rdate;
	}
	public void setRdate(String rdate) {
		this.rdate = rdate;
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
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getCallback() {
		return callback;
	}
	public void setCallback(String callback) {
		this.callback = callback;
	}
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	@Override
	public String toString() {
		return "SmsVO [sms_seq=" + sms_seq + ", sms_mid=" + sms_mid + ", admin_id=" + admin_id + ", send_num="
				+ send_num + ", send_title=" + send_title + ", send_content=" + send_content + ", sms_ins_date="
				+ sms_ins_date + ", rdate=" + rdate + ", name=" + name + ", start_date=" + start_date + ", end_date="
				+ end_date + ", list=" + list + ", phone=" + phone + ", callback=" + callback + ", msg=" + msg + "]";
	}
	
}
