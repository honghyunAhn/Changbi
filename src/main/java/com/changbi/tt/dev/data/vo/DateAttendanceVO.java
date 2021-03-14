package com.changbi.tt.dev.data.vo;

public class DateAttendanceVO {
	
	private int     attSisuSeq;
	private int     attDtSeq;
	private String courseId;
	private String cardinalId;
	private String attDate;
	private String standInTime;
	private String standOutTime;
	private String attDtGubun;
	private int     sisu;
	private String regUser;
	private String regDate;
	private String updUser;
	private String updDate;
	
	public DateAttendanceVO(int attSisuSeq, int attDtSeq, String courseId, String cardinalId, String attDate,
			String standInTime, String standOutTime, String attDtGubun, int sisu, String regUser, String regDate,
			String updUser, String updDate) {
		super();
		this.attSisuSeq = attSisuSeq;
		this.attDtSeq = attDtSeq;
		this.courseId = courseId;
		this.cardinalId = cardinalId;
		this.attDate = attDate;
		this.standInTime = standInTime;
		this.standOutTime = standOutTime;
		this.attDtGubun = attDtGubun;
		this.sisu = sisu;
		this.regUser = regUser;
		this.regDate = regDate;
		this.updUser = updUser;
		this.updDate = updDate;
	}
	
	public int getAttDtSeq() {
		return attDtSeq;
	}

	public void setAttDtSeq(int attDtSeq) {
		this.attDtSeq = attDtSeq;
	}

	public DateAttendanceVO() {
		super();
	}

	public int getAttSisuSeq() {
		return attSisuSeq;
	}

	public void setAttSisuSeq(int attSisuSeq) {
		this.attSisuSeq = attSisuSeq;
	}

	public String getCourseId() {
		return courseId;
	}

	public void setCourseId(String courseId) {
		this.courseId = courseId;
	}

	public String getCardinalId() {
		return cardinalId;
	}

	public void setCardinalId(String cardinalId) {
		this.cardinalId = cardinalId;
	}

	public String getAttDate() {
		return attDate;
	}

	public void setAttDate(String attDate) {
		this.attDate = attDate;
	}

	public String getStandInTime() {
		return standInTime;
	}

	public void setStandInTime(String standInTime) {
		this.standInTime = standInTime;
	}

	public String getStandOutTime() {
		return standOutTime;
	}

	public void setStandOutTime(String standOutTime) {
		this.standOutTime = standOutTime;
	}

	public String getAttDtGubun() {
		return attDtGubun;
	}

	public void setAttDtGubun(String attDtGubun) {
		this.attDtGubun = attDtGubun;
	}

	public int getSisu() {
		return sisu;
	}

	public void setSisu(int sisu) {
		this.sisu = sisu;
	}

	public String getRegUser() {
		return regUser;
	}

	public void setRegUser(String regUser) {
		this.regUser = regUser;
	}

	public String getRegDate() {
		return regDate;
	}

	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}

	public String getUpdUser() {
		return updUser;
	}

	public void setUpdUser(String updUser) {
		this.updUser = updUser;
	}

	public String getUpdDate() {
		return updDate;
	}

	public void setUpdDate(String updDate) {
		this.updDate = updDate;
	}

	@Override
	public String toString() {
		return "DateAttendanceVO [attSisuSeq=" + attSisuSeq + ", attDtSeq="+ attDtSeq +", courseId=" + courseId
				+ ", cardinalId=" + cardinalId + ", attDate=" + attDate + ", standInTime=" + standInTime
				+ ", standOutTime=" + standOutTime + ", attDtGubun=" + attDtGubun + ", sisu=" + sisu + ", regUser="
				+ regUser + ", regDate=" + regDate + ", updUser=" + updUser + ", updDate=" + updDate + "]";
	}

}
