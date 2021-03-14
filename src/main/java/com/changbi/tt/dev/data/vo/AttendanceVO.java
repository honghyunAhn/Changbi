package com.changbi.tt.dev.data.vo;

import forFaith.dev.vo.CommonVO;

@SuppressWarnings("serial")
public class AttendanceVO extends CommonVO {

	private String userId;
	private String courseId;
	private String cardinalId;
	private String start;
	private String end;
	private String status;
	private String presentDate;
	private String isGone;
	private String memo;

	public AttendanceVO(String userId, String courseId, String cardinalId, String start, String end, String status,
			String presentDate, String isGone, String memo) {
		super();
		this.userId = userId;
		this.courseId = courseId;
		this.cardinalId = cardinalId;
		this.start = start;
		this.end = end;
		this.status = status;
		this.presentDate = presentDate;
		this.isGone = isGone;
		this.memo = memo;
	}

	public AttendanceVO() {
		super();
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
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

	public String getStart() {
		return start;
	}

	public void setStart(String start) {
		this.start = start;
	}

	public String getEnd() {
		return end;
	}

	public void setEnd(String end) {
		this.end = end;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getPresentDate() {
		return presentDate;
	}

	public void setPresentDate(String presentDate) {
		this.presentDate = presentDate;
	}

	public String getIsGone() {
		return isGone;
	}

	public void setIsGone(String isGone) {
		this.isGone = isGone;
	}

	public String getMemo() {
		return memo;
	}

	public void setMemo(String memo) {
		this.memo = memo;
	}

	@Override
	public String toString() {
		return "AttendanceVO [userId=" + userId + ", courseId=" + courseId + ", cardinalId=" + cardinalId + ", start="
				+ start + ", end=" + end + ", status=" + status + ", presentDate=" + presentDate + ", isGone=" + isGone
				+ ", memo=" + memo + "]";
	}

}
