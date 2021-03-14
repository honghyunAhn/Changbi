package com.changbi.tt.dev.data.vo;

import forFaith.dev.vo.CommonVO;

@SuppressWarnings("serial")
public class PaymentVO  extends CommonVO{

    
	    private PaymentVO search;     //검색조건

		private String pay_product_name;// 결제명

		private String pay_user_seq; // 결제 시퀀스

		private String pay_crc_seq;// 결제 정보 시퀀스

		private String paymentType; // 결제 타입

		private String paymentState; // 결제 상태

		private String pay_user_id; // 결제자 id

		private String pay_user_accname;// 결제 졔좌 예금주

		private String pay_user_accnum; // 결제 계좌번호 (무통장입금 신청시)

		private String pay_user_bankno;// 결제 은행 코드

		private String pay_user_method; // 결제방법

		private String pay_user_tid; // 거래번호

		private String pay_user_moid; // 상점주문번호

		private String pay_sell_name; // 이니시스 결제 제품명

		private String pay_rtn_data; // 이니시스 리턴데이터

		private String pay_ins_dt;// 결제일
	
		private String real_price; //실 결제금액 
		
		private String pay_gb; //결제관리 구분(모집홍보/LMS)

		private CardinalVO cardinal;				// 기수
		private CourseVO course;					// 과정
		private UserVO user;                // 사용자
		
		private String pay_user_status;

		public UserVO getUser() {
			return user;
		}

		public void setUser(UserVO user) {
			this.user = user;
		}

		public CardinalVO getCardinal() {
			return cardinal;
		}

		public void setCardinal(CardinalVO cardinal) {
			this.cardinal = cardinal;
		}

		public CourseVO getCourse() {
			return course;
		}

		public void setCourse(CourseVO course) {
			this.course = course;
		}

		public String getReal_price() {
			return real_price;
		}

		public void setReal_price(String real_price) {
			this.real_price = real_price;
		}
		
		public String getPay_gb() {
			return pay_gb;
		}

		public void setPay_gb(String pay_gb) {
			this.pay_gb = pay_gb;
		}


		public PaymentVO() {
			super();
		}

		public String getPay_user_status() {
			return pay_user_status;
		}
		
		public void setPay_user_status(String pay_user_status) {
			this.pay_user_status = pay_user_status;
		}


		

 

		 

	
		

		public PaymentVO(PaymentVO search, String pay_product_name, String pay_user_seq, String pay_crc_seq,
				String paymentType, String paymentState, String pay_user_id, String pay_user_accname,
				String pay_user_accnum, String pay_user_bankno, String pay_user_method, String pay_user_tid,
				String pay_user_moid, String pay_sell_name, String pay_rtn_data, String pay_ins_dt, String real_price,
				String pay_gb, String pay_user_status, CardinalVO cardinal, CourseVO course, UserVO user) {
			super();
			this.search = search;
			this.pay_product_name = pay_product_name;
			this.pay_user_seq = pay_user_seq;
			this.pay_crc_seq = pay_crc_seq;
			this.paymentType = paymentType;
			this.paymentState = paymentState;
			this.pay_user_id = pay_user_id;
			this.pay_user_accname = pay_user_accname;
			this.pay_user_accnum = pay_user_accnum;
			this.pay_user_bankno = pay_user_bankno;
			this.pay_user_method = pay_user_method;
			this.pay_user_tid = pay_user_tid;
			this.pay_user_moid = pay_user_moid;
			this.pay_sell_name = pay_sell_name;
			this.pay_rtn_data = pay_rtn_data;
			this.pay_ins_dt = pay_ins_dt;
			this.real_price = real_price;
			this.pay_gb = pay_gb;
			this.pay_user_status = pay_user_status;
			this.cardinal = cardinal;
			this.course = course;
			this.user = user;
		}

		public PaymentVO getSearch() {
			return search;
		}

		public void setSearch(PaymentVO search) {
			this.search = search;
		}

		public String getPay_product_name() {
			return pay_product_name;
		}

		public void setPay_product_name(String pay_product_name) {
			this.pay_product_name = pay_product_name;
		}

		public String getPay_user_seq() {
			return pay_user_seq;
		}

		public void setPay_user_seq(String pay_user_seq) {
			this.pay_user_seq = pay_user_seq;
		}

		public String getPay_crc_seq() {
			return pay_crc_seq;
		}

		public void setPay_crc_seq(String pay_crc_seq) {
			this.pay_crc_seq = pay_crc_seq;
		}

		public String getPaymentType() {
			return paymentType;
		}


		public void setPaymentType(String paymentType) {
			this.paymentType = paymentType;
		}

		public String getPaymentState() {
			return paymentState;
		}

		public void setPaymentState(String paymentState) {
			this.paymentState = paymentState;
		}

		public String getPay_user_id() {
			return pay_user_id;
		}

		public void setPay_user_id(String pay_user_id) {
			this.pay_user_id = pay_user_id;
		}

		public String getPay_user_accname() {
			return pay_user_accname;
		}

		public void setPay_user_accname(String pay_user_accname) {
			this.pay_user_accname = pay_user_accname;
		}

		public String getPay_user_accnum() {
			return pay_user_accnum;
		}

		public void setPay_user_accnum(String pay_user_accnum) {
			this.pay_user_accnum = pay_user_accnum;
		}

		public String getPay_user_bankno() {
			return pay_user_bankno;
		}

		public void setPay_user_bankno(String pay_user_bankno) {
			this.pay_user_bankno = pay_user_bankno;
		}

		public String getPay_user_method() {
			return pay_user_method;
		}

		public void setPay_user_method(String pay_user_method) {
			this.pay_user_method = pay_user_method;
		}

		public String getPay_user_tid() {
			return pay_user_tid;
		}

		public void setPay_user_tid(String pay_user_tid) {
			this.pay_user_tid = pay_user_tid;
		}

		public String getPay_user_moid() {
			return pay_user_moid;
		}

		public void setPay_user_moid(String pay_user_moid) {
			this.pay_user_moid = pay_user_moid;
		}

		public String getPay_sell_name() {
			return pay_sell_name;
		}

		public void setPay_sell_name(String pay_sell_name) {
			this.pay_sell_name = pay_sell_name;
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


		@Override
		public String toString() {
			return "PaymentVO [search=" + search + ", pay_product_name=" + pay_product_name + ", pay_user_seq="
					+ pay_user_seq + ", pay_crc_seq=" + pay_crc_seq + ", paymentType=" + paymentType + ", paymentState="
					+ paymentState + ", pay_user_id=" + pay_user_id + ", pay_user_accname=" + pay_user_accname
					+ ", pay_user_accnum=" + pay_user_accnum + ", pay_user_bankno=" + pay_user_bankno
					+ ", pay_user_method=" + pay_user_method + ", pay_user_tid=" + pay_user_tid + ", pay_user_moid="
					+ pay_user_moid + ", pay_sell_name=" + pay_sell_name + ", pay_rtn_data=" + pay_rtn_data
					+ ", pay_ins_dt=" + pay_ins_dt + ", real_price=" + real_price + ", pay_gb=" + pay_gb + ", cardinal="
					+ cardinal + ", course=" + course + ", user=" + user + ", pay_user_status=" + pay_user_status + "]";
		}

 

		 
		
		
	}

 
