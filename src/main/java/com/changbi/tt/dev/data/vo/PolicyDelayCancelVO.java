package com.changbi.tt.dev.data.vo;

import forFaith.dev.vo.CommonVO;

@SuppressWarnings("serial")
public class PolicyDelayCancelVO extends CommonVO {
	
	private PolicyDelayCancelVO search; // 검색조건
	
	private int id; // 수강연기/취소 정책 ID
	private int delayCourseDay; // 연기정책_과정신청일로부터 (~이내)
	private int delayTrainDay; // 연기정책_연수시작일로부터 (~이내)
	private int cancelCourseDay; // 취소정책_과정신청일로부터 (~이내)
	private int cancelTrainDay; // 취소정책_연수시작일로부터 (~이내)
	
	public PolicyDelayCancelVO getSearch() {
		return search;
	}
	public void setSearch(PolicyDelayCancelVO search) {
		this.search = search;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getDelayCourseDay() {
		return delayCourseDay;
	}
	public void setDelayCourseDay(int delayCourseDay) {
		this.delayCourseDay = delayCourseDay;
	}
	public int getDelayTrainDay() {
		return delayTrainDay;
	}
	public void setDelayTrainDay(int delayTrainDay) {
		this.delayTrainDay = delayTrainDay;
	}
	public int getCancelCourseDay() {
		return cancelCourseDay;
	}
	public void setCancelCourseDay(int cancelCourseDay) {
		this.cancelCourseDay = cancelCourseDay;
	}
	public int getCancelTrainDay() {
		return cancelTrainDay;
	}
	public void setCancelTrainDay(int cancelTrainDay) {
		this.cancelTrainDay = cancelTrainDay;
	}
}
