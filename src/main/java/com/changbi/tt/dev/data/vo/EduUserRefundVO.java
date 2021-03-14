package com.changbi.tt.dev.data.vo;

public class EduUserRefundVO {
	
	private String pay_refund_seq;
	
	private String pay_refund_status;
	
	private String pay_refund_reqdt;
	
	private String pay_refund_comdt;
	
	private String pay_refund_accname;
	
	private String pay_refund_accnum;
	
	private String pay_refund_reason;
	
	private String pay_refund_memo;
	
	private String pay_refund_bank;
	
	private String pay_user_seq;
	
	private String real_pay_amount;

	public EduUserRefundVO() {
		super();
	}

	public EduUserRefundVO(String pay_refund_seq, String pay_refund_status, String pay_refund_reqdt,
			String pay_refund_comdt, String pay_refund_accname, String pay_refund_accnum, String pay_refund_reason,
			String pay_refund_memo, String pay_refund_bank, String pay_user_seq, String real_pay_amount) {
		super();
		this.pay_refund_seq = pay_refund_seq;
		this.pay_refund_status = pay_refund_status;
		this.pay_refund_reqdt = pay_refund_reqdt;
		this.pay_refund_comdt = pay_refund_comdt;
		this.pay_refund_accname = pay_refund_accname;
		this.pay_refund_accnum = pay_refund_accnum;
		this.pay_refund_reason = pay_refund_reason;
		this.pay_refund_memo = pay_refund_memo;
		this.pay_refund_bank = pay_refund_bank;
		this.pay_user_seq = pay_user_seq;
		this.real_pay_amount = real_pay_amount;
	}

	public String getPay_refund_seq() {
		return pay_refund_seq;
	}

	public void setPay_refund_seq(String pay_refund_seq) {
		this.pay_refund_seq = pay_refund_seq;
	}

	public String getPay_refund_status() {
		return pay_refund_status;
	}

	public void setPay_refund_status(String pay_refund_status) {
		this.pay_refund_status = pay_refund_status;
	}

	public String getPay_refund_reqdt() {
		return pay_refund_reqdt;
	}

	public void setPay_refund_reqdt(String pay_refund_reqdt) {
		this.pay_refund_reqdt = pay_refund_reqdt;
	}

	public String getPay_refund_comdt() {
		return pay_refund_comdt;
	}

	public void setPay_refund_comdt(String pay_refund_comdt) {
		this.pay_refund_comdt = pay_refund_comdt;
	}

	public String getPay_refund_accname() {
		return pay_refund_accname;
	}

	public void setPay_refund_accname(String pay_refund_accname) {
		this.pay_refund_accname = pay_refund_accname;
	}

	public String getPay_refund_accnum() {
		return pay_refund_accnum;
	}

	public void setPay_refund_accnum(String pay_refund_accnum) {
		this.pay_refund_accnum = pay_refund_accnum;
	}

	public String getPay_refund_reason() {
		return pay_refund_reason;
	}

	public void setPay_refund_reason(String pay_refund_reason) {
		this.pay_refund_reason = pay_refund_reason;
	}

	public String getPay_refund_memo() {
		return pay_refund_memo;
	}

	public void setPay_refund_memo(String pay_refund_memo) {
		this.pay_refund_memo = pay_refund_memo;
	}

	public String getPay_refund_bank() {
		return pay_refund_bank;
	}

	public void setPay_refund_bank(String pay_refund_bank) {
		this.pay_refund_bank = pay_refund_bank;
	}

	public String getPay_user_seq() {
		return pay_user_seq;
	}

	public void setPay_user_seq(String pay_user_seq) {
		this.pay_user_seq = pay_user_seq;
	}
	
	public String getReal_pay_amount() {
		return real_pay_amount;
	}
	
	public void setReal_pay_amount(String real_pay_amount) {
		this.real_pay_amount = real_pay_amount;
	}

	@Override
	public String toString() {
		return "EduUserRefundVO [pay_refund_seq=" + pay_refund_seq + ", pay_refund_status=" + pay_refund_status
				+ ", pay_refund_reqdt=" + pay_refund_reqdt + ", pay_refund_comdt=" + pay_refund_comdt
				+ ", pay_refund_accname=" + pay_refund_accname + ", pay_refund_accnum=" + pay_refund_accnum
				+ ", pay_refund_reason=" + pay_refund_reason + ", pay_refund_memo=" + pay_refund_memo
				+ ", pay_refund_bank=" + pay_refund_bank + ", pay_user_seq=" + pay_user_seq + ", real_pay_amount=" + real_pay_amount + "]";
	}
	
}
