package com.changbi.tt.dev.data.vo;

import forFaith.dev.vo.CommonVO;
import forFaith.dev.vo.MemberVO;

@SuppressWarnings("serial")
public class ToeflPayVO extends CommonVO{
	
	// 검색조건
    private ToeflPayVO search;
	
	private int pay_toefl_seq;				//시험 결제 일련번호(SEQ auto increment)
	private String pay_user_method;			//결제 방법
	private String pay_user_status;			//결제 상태
	private int real_pay_amount;			//실 결제 금액
	private int dis_point;					//사용 마일리지
	
	private String accname;
	private String bank;
	private String accnum;
	
	private ToeflVO toefl_id;				//신청 토플 정보
	private MemberVO user;					//결제자 
	
	public ToeflPayVO getSearch() {
		return search;
	}
	public void setSearch(ToeflPayVO search) {
		this.search = search;
	}
	public int getPay_toefl_seq() {
		return pay_toefl_seq;
	}
	public void setPay_toefl_seq(int pay_toefl_seq) {
		this.pay_toefl_seq = pay_toefl_seq;
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
	public int getReal_pay_amount() {
		return real_pay_amount;
	}
	public void setReal_pay_amount(int real_pay_amount) {
		this.real_pay_amount = real_pay_amount;
	}
	public int getDis_point() {
		return dis_point;
	}
	public void setDis_point(int dis_point) {
		this.dis_point = dis_point;
	}
	public ToeflVO getToefl_id() {
		return toefl_id;
	}
	public void setToefl_id(ToeflVO toefl_id) {
		this.toefl_id = toefl_id;
	}
	public MemberVO getuser() {
		return user;
	}
	public void setuser(MemberVO user) {
		this.user = user;
	}
	
	public String getAccname() {
		return accname;
	}
	public void setAccname(String accname) {
		this.accname = accname;
	}
	public String getBank() {
		return bank;
	}
	public void setBank(String bank) {
		this.bank = bank;
	}
	public String getAccnum() {
		return accnum;
	}
	public void setAccnum(String accnum) {
		this.accnum = accnum;
	}
	@Override
	public String toString() {
		return "ToeflPayVO [search=" + search + ", pay_toefl_seq=" + pay_toefl_seq + ", pay_user_method="
				+ pay_user_method + ", pay_user_status=" + pay_user_status + ", real_pay_amount=" + real_pay_amount
				+ ", dis_point=" + dis_point + ", accname=" + accname + ", bank=" + bank + ", accnum=" + accnum
				+ ", toefl_id=" + toefl_id + ", user=" + user + "]";
	}
}
