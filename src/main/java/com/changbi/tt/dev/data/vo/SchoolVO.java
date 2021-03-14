package com.changbi.tt.dev.data.vo;

import forFaith.dev.vo.CodeVO;
import forFaith.dev.vo.CommonVO;

/**
 * @Class Name : BookVO.java
 * @Description : 교재정보
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
public class SchoolVO extends CommonVO {
	
	private SchoolVO search; // 검색조건
	
	private int id; // 학교 관리 ID
	private String sType; // 학교구분(1:초등, 2:중학교, 3:고등학교, 4:유치원, 5:특수학교, 6:기관)
	private String eType; // 설립구분(1:국립, 2:공립, 3:사립)
	private String name; // 학교(기관)명
	private String regionCode; // 지역 시도 교육청 분류 코드
	private String jurisdiction; // 관할
	private String tel; // 연락처
	private String fax; // 팩스
	private String postCode; // 우편번호(신:5자리, 구:6자리)
	private String addr1; // 주소1: 우편번호에 연결된 주소
	private String addr2; // 주소2: 상세주소 (사용자 입력)

	// 확장멤버
	private String sTypeName; // 학교구분명
	private String eTypeName; // 설립구분명
	
	private CodeVO region; // 지역코드
	
	public SchoolVO getSearch() {
		return search;
	}
	public void setSearch(SchoolVO search) {
		this.search = search;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getsType() {
		return sType;
	}
	public void setsType(String sType) {
		this.sType = sType;
	}
	public String geteType() {
		return eType;
	}
	public void seteType(String eType) {
		this.eType = eType;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getRegionCode() {
		return regionCode;
	}
	public void setRegionCode(String regionCode) {
		this.regionCode = regionCode;
	}
	public String getJurisdiction() {
		return jurisdiction;
	}
	public void setJurisdiction(String jurisdiction) {
		this.jurisdiction = jurisdiction;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getFax() {
		return fax;
	}
	public void setFax(String fax) {
		this.fax = fax;
	}
	public String getPostCode() {
		return postCode;
	}
	public void setPostCode(String postCode) {
		this.postCode = postCode;
	}
	public String getAddr1() {
		return addr1;
	}
	public void setAddr1(String addr1) {
		this.addr1 = addr1;
	}
	public String getAddr2() {
		return addr2;
	}
	public void setAddr2(String addr2) {
		this.addr2 = addr2;
	}
	public String getsTypeName() {
		return sTypeName;
	}
	public void setsTypeName(String sTypeName) {
		this.sTypeName = sTypeName;
	}
	public String geteTypeName() {
		return eTypeName;
	}
	public void seteTypeName(String eTypeName) {
		this.eTypeName = eTypeName;
	}
	public CodeVO getRegion() {
		return region;
	}
	public void setRegion(CodeVO region) {
		this.region = region;
	}
}
