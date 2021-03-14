package com.changbi.tt.dev.data.vo;

import forFaith.dev.vo.CommonVO;

@SuppressWarnings("serial")
public class PaymentAdminVO extends CommonVO{
	private int payCrcSeq; // 분납 정보 시퀀스
	private String gisuId;
	private String course_id;
	private int pmtCnt;
	private String pmtStartDate;
	private String pmtEndDate;
	private int pmtAmount;
	private String id;
	
	public String getGisuId() {
		return gisuId;
	}
	public void setGisuId(String gisuId) {
		this.gisuId = gisuId;
	}
	public int getPmtCnt() {
		return pmtCnt;
	}
	public void setPmtCnt(int pmtCnt) {
		this.pmtCnt = pmtCnt;
	}
	public String getPmtStartDate() {
		return pmtStartDate;
	}
	public void setPmtStartDate(String pmtStartDate) {
		this.pmtStartDate = pmtStartDate;
	}
	public String getPmtEndDate() {
		return pmtEndDate;
	}
	public void setPmtEndDate(String pmtEndDate) {
		this.pmtEndDate = pmtEndDate;
	}
	public int getPmtAmount() {
		return pmtAmount;
	}
	public void setPmtAmount(int pmtAmount) {
		this.pmtAmount = pmtAmount;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getCourse_id() {
		return course_id;
	}
	public void setCourse_id(String course_id) {
		this.course_id = course_id;
	}
	public int getPayCrcSeq() {
		return payCrcSeq;
	}
	public void setPayCrcSeq(int payCrcSeq) {
		this.payCrcSeq = payCrcSeq;
	}
}
