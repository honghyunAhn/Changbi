package com.changbi.tt.dev.data.vo;

import forFaith.dev.vo.AttachFileVO;

public class InfoAttendanceVO {

	private int attInfoTimeSeq;
	private int attDtSeq;
	private String userId;
	private String userNm;
	private String inTime;
	private String outTime;
	private String attFinalGubun;
	private String memo;
	private String userMemo;
	private String regOriginFile;
	private String regSavedFile;
	private String regDate;
	private String regUser;
	private String upduser;
	private String updDate;
	
	private String certiAttachedFile;
	
	private AttachFileVO certiAttachFile;

	public InfoAttendanceVO(int attInfoSeq, int attDtSeq, String userId, String userNm, String inTime, String outTime,
			String attInfoGubun, String memo, String regOriginFile, String regSavedFile, String regDate, String regUser,
			String upduser, String updDate, String certiAttachedFile, AttachFileVO certiAttachFile) {
		super();
		this.attInfoTimeSeq = attInfoSeq;
		this.attDtSeq = attDtSeq;
		this.userId = userId;
		this.userNm = userNm;
		this.inTime = inTime;
		this.outTime = outTime;
		this.attFinalGubun = attInfoGubun;
		this.memo = memo;
		this.regOriginFile = regOriginFile;
		this.regSavedFile = regSavedFile;
		this.regDate = regDate;
		this.regUser = regUser;
		this.upduser = upduser;
		this.updDate = updDate;
		this.certiAttachedFile = certiAttachedFile;
		this.certiAttachFile = certiAttachFile;
	}

	public InfoAttendanceVO() {
		super();
	}
	
	public String getUserMemo() {
		return userMemo;
	}

	public void setUserMemo(String userMemo) {
		this.userMemo = userMemo;
	}
	
	public int getAttInfoTimeSeq() {
		return attInfoTimeSeq;
	}

	public void setAttInfoTimeSeq(int attInfoSeq) {
		this.attInfoTimeSeq = attInfoSeq;
	}

	public int getAttDtSeq() {
		return attDtSeq;
	}

	public void setAttDtSeq(int attDtSeq) {
		this.attDtSeq = attDtSeq;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}
	
	public String getUserNm() {
		return userNm;
	}
	
	public void setUserNm(String userNm) {
		this.userNm = userNm;
	}

	public String getInTime() {
		return inTime;
	}

	public void setInTime(String inTime) {
		this.inTime = inTime;
	}

	public String getOutTime() {
		return outTime;
	}

	public void setOutTime(String outTime) {
		this.outTime = outTime;
	}

	public String getAttFinalGubun() {
		return attFinalGubun;
	}

	public void setAttFinalGubun(String attInfoGubun) {
		this.attFinalGubun = attInfoGubun;
	}

	public String getMemo() {
		return memo;
	}

	public void setMemo(String memo) {
		this.memo = memo;
	}

	public String getRegOriginFile() {
		return regOriginFile;
	}

	public void setRegOriginFile(String regOriginFile) {
		this.regOriginFile = regOriginFile;
	}

	public String getRegSavedFile() {
		return regSavedFile;
	}

	public void setRegSavedFile(String regSavedFile) {
		this.regSavedFile = regSavedFile;
	}

	public String getRegDate() {
		return regDate;
	}

	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}

	public String getRegUser() {
		return regUser;
	}

	public void setRegUser(String regUser) {
		this.regUser = regUser;
	}

	public String getUpduser() {
		return upduser;
	}

	public void setUpduser(String upduser) {
		this.upduser = upduser;
	}

	public String getUpdDate() {
		return updDate;
	}

	public void setUpdDate(String updDate) {
		this.updDate = updDate;
	}

	public String getCertiAttachedFile() {
		return certiAttachedFile;
	}

	public void setCertiAttachedFile(String certiAttachedFile) {
		this.certiAttachedFile = certiAttachedFile;
	}

	public AttachFileVO getCertiAttachFile() {
		return certiAttachFile;
	}

	public void setCertiAttachFile(AttachFileVO certiAttachFile) {
		this.certiAttachFile = certiAttachFile;
	}

	@Override
	public String toString() {
		return "InfoAttendanceVO [attInfoTimeSeq=" + attInfoTimeSeq + ", attDtSeq=" + attDtSeq + ", userId=" + userId + ", userNm=" + userNm
				+ ", inTime=" + inTime + ", outTime=" + outTime + ", attInfoGubun=" + attFinalGubun + ", memo=" + memo
				+ ", regOriginFile=" + regOriginFile + ", regSavedFile=" + regSavedFile + ", regDate=" + regDate
				+ ", regUser=" + regUser + ", upduser=" + upduser + ", updDate=" + updDate + ", certiAttachedFile="
				+ certiAttachedFile + ", certiAttachFile=" + certiAttachFile + "]";
	}
	
}
