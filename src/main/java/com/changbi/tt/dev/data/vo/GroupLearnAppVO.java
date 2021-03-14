package com.changbi.tt.dev.data.vo;

import forFaith.dev.vo.CommonVO;

/**
 * @Class Name : LearnAppVO.java
 * @Description : 수강신청관리
 * @Modification Information
 * @
 * @  수정일                 수정자                       수정내용
 * @ -------    --------    ---------------------------
 * @ 2017.03.21   김준석                      최초 생성
 *
 *  @author kjs
 *  @since 2017.03.21
 *  @version 1.0
 *  @see
 *
 */

@SuppressWarnings("serial")
public class GroupLearnAppVO extends CommonVO {
	// 검색조건
    private GroupLearnAppVO search;
    
    private String groupId;			// 단체연수ID
    private String cardinalId;		// 기수ID
    private String courseId;		// 과정ID
    private String schoolName;		// 단체명
    private String courseName;		// 과정명
    private int totalAppUser;		// 총 신청자
    private int totalPayment;		// 총 연수금액
    private int validAppUser;		// 수강 유효자
    private int totalValidPayment;	// 실결제금액
    private String paymentState;	// 결제상태
    private String learnStartDate;	// 연수시작일자
    private String learnEndDate;	// 연수종료일자
    private String paymentStateName;// 결제상태명
    
	public GroupLearnAppVO getSearch() {
		return search;
	}
	public void setSearch(GroupLearnAppVO search) {
		this.search = search;
	}
	public String getGroupId() {
		return groupId;
	}
	public void setGroupId(String groupId) {
		this.groupId = groupId;
	}
	public String getCardinalId() {
		return cardinalId;
	}
	public void setCardinalId(String cardinalId) {
		this.cardinalId = cardinalId;
	}
	public String getCourseId() {
		return courseId;
	}
	public void setCourseId(String courseId) {
		this.courseId = courseId;
	}
	public String getSchoolName() {
		return schoolName;
	}
	public void setSchoolName(String schoolName) {
		this.schoolName = schoolName;
	}
	public String getCourseName() {
		return courseName;
	}
	public void setCourseName(String courseName) {
		this.courseName = courseName;
	}
	public int getTotalAppUser() {
		return totalAppUser;
	}
	public void setTotalAppUser(int totalAppUser) {
		this.totalAppUser = totalAppUser;
	}
	public int getTotalPayment() {
		return totalPayment;
	}
	public void setTotalPayment(int totalPayment) {
		this.totalPayment = totalPayment;
	}
	public int getValidAppUser() {
		return validAppUser;
	}
	public void setValidAppUser(int validAppUser) {
		this.validAppUser = validAppUser;
	}
	public int getTotalValidPayment() {
		return totalValidPayment;
	}
	public void setTotalValidPayment(int totalValidPayment) {
		this.totalValidPayment = totalValidPayment;
	}
	public String getPaymentState() {
		return paymentState;
	}
	public void setPaymentState(String paymentState) {
		this.paymentState = paymentState;
	}
	public String getLearnStartDate() {
		return learnStartDate;
	}
	public void setLearnStartDate(String learnStartDate) {
		this.learnStartDate = learnStartDate;
	}
	public String getLearnEndDate() {
		return learnEndDate;
	}
	public void setLearnEndDate(String learnEndDate) {
		this.learnEndDate = learnEndDate;
	}
	public String getPaymentStateName() {
		return paymentStateName;
	}
	public void setPaymentStateName(String paymentStateName) {
		this.paymentStateName = paymentStateName;
	}
}
