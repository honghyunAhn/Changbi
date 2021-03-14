package com.changbi.tt.dev.data.vo;

import forFaith.dev.vo.CommonVO;

/**
 * @Class Name : CopyRatioVO.java
 * @Description : 모사율
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
public class CopyRatioVO extends CommonVO {
	// 검색조건
    private CopyRatioVO search;

	private String uri;	   						// 모사율 uri
	private String checkType;					// 모사율 타입
	private String totalCopyRatio;				// 전체모사율
	private String dispTotalCopyRatio;			// 퍼센트 모사율
	private String completeStatus;				// 완료여부
	private String completeDate;				// 완료일
	
    public CopyRatioVO getSearch() {
        return search;
    }

    public void setSearch(CopyRatioVO search) {
        this.search = search;
    }

	public String getUri() {
		return uri;
	}

	public void setUri(String uri) {
		this.uri = uri;
	}

	public String getCheckType() {
		return checkType;
	}

	public void setCheckType(String checkType) {
		this.checkType = checkType;
	}

	public String getTotalCopyRatio() {
		return totalCopyRatio;
	}

	public void setTotalCopyRatio(String totalCopyRatio) {
		this.totalCopyRatio = totalCopyRatio;
	}

	public String getDispTotalCopyRatio() {
		return dispTotalCopyRatio;
	}

	public void setDispTotalCopyRatio(String dispTotalCopyRatio) {
		this.dispTotalCopyRatio = dispTotalCopyRatio;
	}

	public String getCompleteStatus() {
		return completeStatus;
	}

	public void setCompleteStatus(String completeStatus) {
		this.completeStatus = completeStatus;
	}

	public String getCompleteDate() {
		return completeDate;
	}

	public void setCompleteDate(String completeDate) {
		this.completeDate = completeDate;
	}
}
