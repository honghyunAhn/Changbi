package com.changbi.tt.dev.data.vo;

import forFaith.dev.vo.CommonVO;

@SuppressWarnings("serial")
public class SmtpAttendanceVO extends CommonVO {
	
	private String course_id;
	private String cardinal_id;
	private String ATT_DATE;
	private String ATT_DT_GUBUN;
	private String REG_USER;
	private String REG_DATE;
	private String UPD_USER;
	private String UPD_DATE;
	
	public SmtpAttendanceVO(String course_id, String cardinal_id, String aTT_DATE, String aTT_DT_GUBUN, String rEG_USER,
			String rEG_DATE, String uPD_USER, String uPD_DATE) {
		super();
		this.course_id = course_id;
		this.cardinal_id = cardinal_id;
		ATT_DATE = aTT_DATE;
		ATT_DT_GUBUN = aTT_DT_GUBUN;
		REG_USER = rEG_USER;
		REG_DATE = rEG_DATE;
		UPD_USER = uPD_USER;
		UPD_DATE = uPD_DATE;
	}

	public SmtpAttendanceVO(){
		super();
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

	public String getATT_DATE() {
		return ATT_DATE;
	}

	public void setATT_DATE(String aTT_DATE) {
		ATT_DATE = aTT_DATE;
	}

	public String getATT_DT_GUBUN() {
		return ATT_DT_GUBUN;
	}

	public void setATT_DT_GUBUN(String aTT_DT_GUBUN) {
		ATT_DT_GUBUN = aTT_DT_GUBUN;
	}

	public String getREG_USER() {
		return REG_USER;
	}

	public void setREG_USER(String rEG_USER) {
		REG_USER = rEG_USER;
	}

	public String getREG_DATE() {
		return REG_DATE;
	}

	public void setREG_DATE(String rEG_DATE) {
		REG_DATE = rEG_DATE;
	}

	public String getUPD_USER() {
		return UPD_USER;
	}

	public void setUPD_USER(String uPD_USER) {
		UPD_USER = uPD_USER;
	}

	public String getUPD_DATE() {
		return UPD_DATE;
	}

	public void setUPD_DATE(String uPD_DATE) {
		UPD_DATE = uPD_DATE;
	}

	@Override
	public String toString() {
		return "SmtpAttendanceVO [course_id=" + course_id + ", cardinal_id=" + cardinal_id + ", ATT_DATE=" + ATT_DATE
				+ ", ATT_DT_GUBUN=" + ATT_DT_GUBUN + ", REG_USER=" + REG_USER + ", REG_DATE=" + REG_DATE + ", UPD_USER="
				+ UPD_USER + ", UPD_DATE=" + UPD_DATE + "]";
	}
	
}
