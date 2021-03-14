package com.changbi.tt.dev.data.vo;

import forFaith.dev.vo.CommonVO;

@SuppressWarnings("serial")
public class PolicyPointVO extends CommonVO {
	
	private PolicyPointVO search; // 검색조건
	
	private int id; // 포인트 정책 ID
	private int saveJoinPoint; // 신규회원가입시 적립 포인트
	private String saveJoinUse = "N"; // 신규회원가입시 적립 사용유무
	private int saveLecturePoint; // 수강신청시 적립 포인트
	private String saveLectureType; // (1:점, 2:퍼센트)
	private String saveLectureUse = "N"; // 수강신청시 적립 사용유무
	private int saveTrainPoint; // 연수후기작성시 적립 포인트
	private String saveTrainUse = "N"; // 연수후기작성시 적립 사용유무
	private int useLecturePoint; // 수강신청시 사용시 포인트(부터)
	private int useLectureUnit; // 수강신청시 사용시 단위(로 사용)
	private String useLectureUse = "N"; // 수강신청시 사용시 사용유무
	
	public PolicyPointVO getSearch() {
		return search;
	}
	public void setSearch(PolicyPointVO search) {
		this.search = search;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getSaveJoinPoint() {
		return saveJoinPoint;
	}
	public void setSaveJoinPoint(int saveJoinPoint) {
		this.saveJoinPoint = saveJoinPoint;
	}
	public String getSaveJoinUse() {
		return saveJoinUse;
	}
	public void setSaveJoinUse(String saveJoinUse) {
		this.saveJoinUse = saveJoinUse;
	}
	public int getSaveLecturePoint() {
		return saveLecturePoint;
	}
	public void setSaveLecturePoint(int saveLecturePoint) {
		this.saveLecturePoint = saveLecturePoint;
	}
	public String getSaveLectureType() {
		return saveLectureType;
	}
	public void setSaveLectureType(String saveLectureType) {
		this.saveLectureType = saveLectureType;
	}
	public String getSaveLectureUse() {
		return saveLectureUse;
	}
	public void setSaveLectureUse(String saveLectureUse) {
		this.saveLectureUse = saveLectureUse;
	}
	public int getSaveTrainPoint() {
		return saveTrainPoint;
	}
	public void setSaveTrainPoint(int saveTrainPoint) {
		this.saveTrainPoint = saveTrainPoint;
	}
	public String getSaveTrainUse() {
		return saveTrainUse;
	}
	public void setSaveTrainUse(String saveTrainUse) {
		this.saveTrainUse = saveTrainUse;
	}
	public int getUseLecturePoint() {
		return useLecturePoint;
	}
	public void setUseLecturePoint(int useLecturePoint) {
		this.useLecturePoint = useLecturePoint;
	}
	public int getUseLectureUnit() {
		return useLectureUnit;
	}
	public void setUseLectureUnit(int useLectureUnit) {
		this.useLectureUnit = useLectureUnit;
	}
	public String getUseLectureUse() {
		return useLectureUse;
	}
	public void setUseLectureUse(String useLectureUse) {
		this.useLectureUse = useLectureUse;
	}
}
