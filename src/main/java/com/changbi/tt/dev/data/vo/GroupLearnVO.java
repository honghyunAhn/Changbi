package com.changbi.tt.dev.data.vo;

import java.util.List;

import forFaith.dev.vo.AttachFileVO;
import forFaith.dev.vo.CodeVO;
import forFaith.dev.vo.CommonVO;

/**
 * @Class Name : GroupLearnVO.java
 * @Description : 단체연수
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
public class GroupLearnVO extends CommonVO {
	// 검색조건
    private GroupLearnVO search;
    
	private int id;    							// 단체연수 id
	private String name;						// 단체연수명
	private String startDate;					// 노출시작일
	private String endDate;						// 노출종료일
	private String jurisdiction;				// 교육지원청(관할교육청??)
	private String paymentType;					// 수강료납입(G : 단체일괄납부, S : 개인개별납부)
	private String targets;						// 접수대상(유,초,중,고,특,전문,일반인)-다중
	private String contents;					// 컨텐츠 내용
	private int procCnt;						// 진행횟수

	private AttachFileVO banner;				// 배너이미지
	private CodeVO region;						// 지역시도교육청
	private List<CardinalVO> cardinalList;		// 기수 리스트 가지고 온다.
	
    public GroupLearnVO getSearch() {
        return search;
    }

    public void setSearch(GroupLearnVO search) {
        this.search = search;
    }

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getStartDate() {
		return startDate;
	}

	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}

	public String getEndDate() {
		return endDate;
	}

	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}

	public String getJurisdiction() {
		return jurisdiction;
	}

	public void setJurisdiction(String jurisdiction) {
		this.jurisdiction = jurisdiction;
	}

	public String getPaymentType() {
		return paymentType;
	}

	public void setPaymentType(String paymentType) {
		this.paymentType = paymentType;
	}

	public String getTargets() {
		return targets;
	}

	public void setTargets(String targets) {
		this.targets = targets;
	}

	public String getContents() {
		return contents;
	}

	public void setContents(String contents) {
		this.contents = contents;
	}

	public int getProcCnt() {
		return procCnt;
	}

	public void setProcCnt(int procCnt) {
		this.procCnt = procCnt;
	}

	public AttachFileVO getBanner() {
		return banner;
	}

	public void setBanner(AttachFileVO banner) {
		this.banner = banner;
	}

	public CodeVO getRegion() {
		return region;
	}

	public void setRegion(CodeVO region) {
		this.region = region;
	}

	public List<CardinalVO> getCardinalList() {
		return cardinalList;
	}

	public void setCardinalList(List<CardinalVO> cardinalList) {
		this.cardinalList = cardinalList;
	}
}
