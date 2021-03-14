package com.changbi.tt.dev.data.vo;

public class EduUserPayVO {
	
	private String pay_user_seq;
	
	private String course_id;
	
	private String cardinal_id;
	
	private String pay_crc_seq;
	
	private String pay_user_method;
	
	private String pay_user_status;
	
	private String pay_user_id;
	
	private String pay_accnum;
	
	private String pay_bankname;
	
	private String pay_tid;
	
	private String pay_product_name;
	
	private String pay_rtn_data;
	
	private String pay_ins_dt;
	
	private String pay_gb;
	
	private String real_pay_amount;
	
	private String dis_point;
	
	private String pay_crc_amount;
	
	private String course_name;
	
	private String cardinal_name;
	
	private UserVO user;
	
	public EduUserPayVO() {
		super();
	}

	public EduUserPayVO(String pay_user_seq, String course_id, String cardinal_id, String pay_crc_seq,
			String pay_user_method, String pay_user_status, String pay_user_id, String pay_accnum, String pay_bankname,
			String pay_tid, String pay_product_name, String pay_rtn_data, String pay_ins_dt, String pay_gb,
			String real_pay_amount, String dis_point, String pay_crc_amount, String course_name, String cardinal_name,
			UserVO user) {
		super();
		this.pay_user_seq = pay_user_seq;
		this.course_id = course_id;
		this.cardinal_id = cardinal_id;
		this.pay_crc_seq = pay_crc_seq;
		this.pay_user_method = pay_user_method;
		this.pay_user_status = pay_user_status;
		this.pay_user_id = pay_user_id;
		this.pay_accnum = pay_accnum;
		this.pay_bankname = pay_bankname;
		this.pay_tid = pay_tid;
		this.pay_product_name = pay_product_name;
		this.pay_rtn_data = pay_rtn_data;
		this.pay_ins_dt = pay_ins_dt;
		this.pay_gb = pay_gb;
		this.real_pay_amount = real_pay_amount;
		this.dis_point = dis_point;
		this.pay_crc_amount = pay_crc_amount;
		this.course_name = course_name;
		this.cardinal_name = cardinal_name;
		this.user = user;
	}

	public String getPay_user_seq() {
		return pay_user_seq;
	}

	public void setPay_user_seq(String pay_user_seq) {
		this.pay_user_seq = pay_user_seq;
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

	public String getPay_crc_seq() {
		return pay_crc_seq;
	}

	public void setPay_crc_seq(String pay_crc_seq) {
		this.pay_crc_seq = pay_crc_seq;
	}

	public String getPay_user_method() {
		return pay_user_method;
	}

	public void setPay_user_method(String pay_user_method) {
		this.pay_user_method = pay_user_method;
	}

	public String getPay_user_status() {
		return pay_user_status;
	}

	public void setPay_user_status(String pay_user_status) {
		this.pay_user_status = pay_user_status;
	}

	public String getPay_user_id() {
		return pay_user_id;
	}

	public void setPay_user_id(String pay_user_id) {
		this.pay_user_id = pay_user_id;
	}

	public String getPay_accnum() {
		return pay_accnum;
	}

	public void setPay_accnum(String pay_accnum) {
		this.pay_accnum = pay_accnum;
	}

	public String getPay_bankname() {
		return pay_bankname;
	}

	public void setPay_bankname(String pay_bankname) {
		this.pay_bankname = pay_bankname;
	}

	public String getPay_tid() {
		return pay_tid;
	}

	public void setPay_tid(String pay_tid) {
		this.pay_tid = pay_tid;
	}

	public String getPay_product_name() {
		return pay_product_name;
	}

	public void setPay_product_name(String pay_product_name) {
		this.pay_product_name = pay_product_name;
	}

	public String getPay_rtn_data() {
		return pay_rtn_data;
	}

	public void setPay_rtn_data(String pay_rtn_data) {
		this.pay_rtn_data = pay_rtn_data;
	}

	public String getPay_ins_dt() {
		return pay_ins_dt;
	}

	public void setPay_ins_dt(String pay_ins_dt) {
		this.pay_ins_dt = pay_ins_dt;
	}

	public String getPay_gb() {
		return pay_gb;
	}

	public void setPay_gb(String pay_gb) {
		this.pay_gb = pay_gb;
	}

	public String getReal_pay_amount() {
		return real_pay_amount;
	}

	public void setReal_pay_amount(String real_pay_amount) {
		this.real_pay_amount = real_pay_amount;
	}

	public String getDis_point() {
		return dis_point;
	}

	public void setDis_point(String dis_point) {
		this.dis_point = dis_point;
	}

	public String getPay_crc_amount() {
		return pay_crc_amount;
	}

	public void setPay_crc_amount(String pay_crc_amount) {
		this.pay_crc_amount = pay_crc_amount;
	}

	public String getCourse_name() {
		return course_name;
	}

	public void setCourse_name(String course_name) {
		this.course_name = course_name;
	}

	public String getCardinal_name() {
		return cardinal_name;
	}

	public void setCardinal_name(String cardinal_name) {
		this.cardinal_name = cardinal_name;
	}

	public UserVO getUser() {
		return user;
	}

	public void setUser(UserVO user) {
		this.user = user;
	}

	@Override
	public String toString() {
		return "EduUserPayVO [pay_user_seq=" + pay_user_seq + ", course_id=" + course_id + ", cardinal_id="
				+ cardinal_id + ", pay_crc_seq=" + pay_crc_seq + ", pay_user_method=" + pay_user_method
				+ ", pay_user_status=" + pay_user_status + ", pay_user_id=" + pay_user_id + ", pay_accnum=" + pay_accnum
				+ ", pay_bankname=" + pay_bankname + ", pay_tid=" + pay_tid + ", pay_product_name=" + pay_product_name
				+ ", pay_rtn_data=" + pay_rtn_data + ", pay_ins_dt=" + pay_ins_dt + ", pay_gb=" + pay_gb
				+ ", real_pay_amount=" + real_pay_amount + ", dis_point=" + dis_point + ", pay_crc_amount="
				+ pay_crc_amount + ", course_name=" + course_name + ", cardinal_name=" + cardinal_name + ", user="
				+ user + "]";
	}
	
}
