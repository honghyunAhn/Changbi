package com.changbi.tt.dev.data.vo;

import forFaith.dev.vo.AttachFileVO;
import forFaith.dev.vo.CommonVO;

/**
 * @Class Name : ExamSpotVO.java
 * @Description : 출석평가 고사장관리
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
public class ExamSpotVO extends CommonVO {
	// 검색조건
    private ExamSpotVO search;
    
	private String id;   						// 고사장 ID(무조건 3자리 숫자로만듬)
	private String name;						// 고사장명
	private String spot;						// 장소명
	private String postCode;					// 우편번호(신:5자리, 구:6자리)
	private String addr1;						// 주소1: 우편번호에 연결된 주소
	private String addr2;						// 주소2: 상세주소 (사용자 입력)
	private String tel;							// 연락처
	private int limitNum;						// 신청제한인원(0이면 제한없음)
	private String appArea;						// 해당지역(인근 응시가능지역을 참조로 적는 항목일 뿐 어떠한 제한기능도 포함되어 있지 않음)
	private String traffic;						// 교통안내

	private AttachFileVO map;					// 약도이미지 파일

    public ExamSpotVO getSearch() {
        return search;
    }

    public void setSearch(ExamSpotVO search) {
        this.search = search;
    }

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getSpot() {
		return spot;
	}

	public void setSpot(String spot) {
		this.spot = spot;
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

	public String getTel() {
		return tel;
	}

	public void setTel(String tel) {
		this.tel = tel;
	}

	public int getLimitNum() {
		return limitNum;
	}

	public void setLimitNum(int limitNum) {
		this.limitNum = limitNum;
	}

	public String getAppArea() {
		return appArea;
	}

	public void setAppArea(String appArea) {
		this.appArea = appArea;
	}

	public String getTraffic() {
		return traffic;
	}

	public void setTraffic(String traffic) {
		this.traffic = traffic;
	}

	public AttachFileVO getMap() {
		return map;
	}

	public void setMap(AttachFileVO map) {
		this.map = map;
	}
}
