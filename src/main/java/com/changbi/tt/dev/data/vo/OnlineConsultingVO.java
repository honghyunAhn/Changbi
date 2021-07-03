package com.changbi.tt.dev.data.vo;

public class OnlineConsultingVO {
	/**
	 * 온라인상담 게시판 게시물 시퀀스
	 */
	private int consulting_seq;
	
	/**
	 * 온라인상담 게시판 시퀀스
	 */
	private int consulting_tp;
	
	/**
	 * 온라인상담 게시판 게시물 제목
	 */
	private String consulting_title;
	
	/**
	 * 온라인상담 게시판 게시물 내용
	 */
	private String consulting_ct;

	/**
	 * 온라인상담 게시판 게시물 등록인 
	 */
	private String consulting_ins_id;
	
	/**
	 * 온라인상담 게시판 게시물 등록 일자 
	 */
	private String consulting_ins_dt;
	
	/**
	 * 온라인상담 게시판 게시물 수정 일자
	 */
	private String consulting_udt_dt;
	
	/**
	 * 온라인상담 게시판 게시물 수정인 
	 */
	private String consulting_udt_id;
	
	/**
	 * 온라인상담 게시판 게시물 조회수
	 */
	private int consulting_hit;

	/**
	 * 온라인상담 공개설정
	 */
	private int consulting_open;	
	
	/**
	 * 온라인상담 답변상황
	 */
	private int consulting_check;
	
	/**
	 * 온라인상담 답변내용
	 */
	private String re_ct;
	
	/**
	 * 온라인상담 삭제플러그
	 */
	private int del_flg = 0;
	
	/**
	 * 온라인상담 답변 작성일
	 */
	private String re_ins_dt;
	
	/**
	 * 온라인상담 답변자
	 */
	private String re_ins_id;
	
	/**
	 * 온라인상담 답변수정일
	 */
	private String re_udt_dt;
	
	/**
	 * 온라인상담 답변수정자
	 */
	private String re_udt_id;	

	public OnlineConsultingVO() {
		super();
	}

	public OnlineConsultingVO(int consulting_seq, int consulting_tp, String consulting_title, String consulting_ct, String consulting_ins_id, String consulting_ins_dt, String consulting_udt_dt,
			String consulting_udt_id, int consulting_hit, int consulting_open, int consulting_check, String re_ct, int del_flg, String re_ins_dt, String re_ins_id, String re_udt_dt,
			String re_udt_id) {
		super();
		this.consulting_seq = consulting_seq;
		this.consulting_tp = consulting_tp;
		this.consulting_title = consulting_title;
		this.consulting_ct = consulting_ct;
		this.consulting_ins_id = consulting_ins_id;
		this.consulting_ins_dt = consulting_ins_dt;
		this.consulting_udt_dt = consulting_udt_dt;
		this.consulting_udt_id = consulting_udt_id;
		this.consulting_hit = consulting_hit;
		this.consulting_open = consulting_open;
		this.consulting_check = consulting_check;
		this.re_ct = re_ct;
		this.del_flg = del_flg;
		this.re_ins_dt = re_ins_dt;
		this.re_ins_id = re_ins_id;
		this.re_udt_dt = re_udt_dt;
		this.re_udt_id = re_udt_id;
	}

	public int getConsulting_seq() {
		return consulting_seq;
	}

	public void setConsulting_seq(int consulting_seq) {
		this.consulting_seq = consulting_seq;
	}

	public int getConsulting_tp() {
		return consulting_tp;
	}

	public void setConsulting_tp(int consulting_tp) {
		this.consulting_tp = consulting_tp;
	}

	public String getConsulting_title() {
		return consulting_title;
	}

	public void setConsulting_title(String consulting_title) {
		this.consulting_title = consulting_title;
	}

	public String getConsulting_ct() {
		return consulting_ct;
	}

	public void setConsulting_ct(String consulting_ct) {
		this.consulting_ct = consulting_ct;
	}

	public String getConsulting_ins_id() {
		return consulting_ins_id;
	}

	public void setConsulting_ins_id(String consulting_ins_id) {
		this.consulting_ins_id = consulting_ins_id;
	}

	public String getConsulting_ins_dt() {
		return consulting_ins_dt;
	}

	public void setConsulting_ins_dt(String consulting_ins_dt) {
		this.consulting_ins_dt = consulting_ins_dt;
	}

	public String getConsulting_udt_dt() {
		return consulting_udt_dt;
	}

	public void setConsulting_udt_dt(String consulting_udt_dt) {
		this.consulting_udt_dt = consulting_udt_dt;
	}

	public String getConsulting_udt_id() {
		return consulting_udt_id;
	}

	public void setConsulting_udt_id(String consulting_udt_id) {
		this.consulting_udt_id = consulting_udt_id;
	}

	public int getConsulting_hit() {
		return consulting_hit;
	}

	public void setConsulting_hit(int consulting_hit) {
		this.consulting_hit = consulting_hit;
	}

	public int getConsulting_open() {
		return consulting_open;
	}

	public void setConsulting_open(int consulting_open) {
		this.consulting_open = consulting_open;
	}

	public int getConsulting_check() {
		return consulting_check;
	}

	public void setConsulting_check(int consulting_check) {
		this.consulting_check = consulting_check;
	}

	public String getRe_ct() {
		return re_ct;
	}

	public void setRe_ct(String re_ct) {
		this.re_ct = re_ct;
	}

	public int getDel_flg() {
		return del_flg;
	}

	public void setDel_flg(int del_flg) {
		this.del_flg = del_flg;
	}

	public String getRe_ins_dt() {
		return re_ins_dt;
	}

	public void setRe_ins_dt(String re_ins_dt) {
		this.re_ins_dt = re_ins_dt;
	}

	public String getRe_ins_id() {
		return re_ins_id;
	}

	public void setRe_ins_id(String re_ins_id) {
		this.re_ins_id = re_ins_id;
	}

	public String getRe_udt_dt() {
		return re_udt_dt;
	}

	public void setRe_udt_dt(String re_udt_dt) {
		this.re_udt_dt = re_udt_dt;
	}

	public String getRe_udt_id() {
		return re_udt_id;
	}

	public void setRe_udt_id(String re_udt_id) {
		this.re_udt_id = re_udt_id;
	}

	@Override
	public String toString() {
		return "OnlineConsultingContents [consulting_seq=" + consulting_seq + ", consulting_tp=" + consulting_tp + ", consulting_title=" + consulting_title + ", consulting_ct=" + consulting_ct
				+ ", consulting_ins_id=" + consulting_ins_id + ", consulting_ins_dt=" + consulting_ins_dt + ", consulting_udt_dt=" + consulting_udt_dt + ", consulting_udt_id=" + consulting_udt_id
				+ ", consulting_hit=" + consulting_hit + ", consulting_open=" + consulting_open + ", consulting_check=" + consulting_check + ", re_ct=" + re_ct + ", del_flg=" + del_flg
				+ ", re_ins_dt=" + re_ins_dt + ", re_ins_id=" + re_ins_id + ", re_udt_dt=" + re_udt_dt + ", re_udt_id=" + re_udt_id + "]";
	}
}
