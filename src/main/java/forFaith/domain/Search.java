package forFaith.domain;

import javax.xml.bind.annotation.XmlTransient;

/**
 * @Class Name : Search.java
 * @Description : 기본 검색조건 정보
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
public class Search extends Paging {

    /** 검색조건 */
    private String searchCondition = "";

    /** 검색Keyword */
    private String searchKeyword = "";

    /** 검색 시 사용여부 */
    private String searchUseYn = "";
    
    /** 날짜조건 */
    private String searchDateCondition = "";
    
    /** 날짜 시작일 */
    private String searchStartDate = "";
    
    /** 날짜 종료일 */
    private String searchEndDate = "";

    public String getSearchCondition() {
        return searchCondition;
    }

    public void setSearchCondition(String searchCondition) {
        this.searchCondition = searchCondition;
    }

    @XmlTransient
    public String getSearchKeyword() {
        return searchKeyword;
    }

    public void setSearchKeyword(String searchKeyword) {
        this.searchKeyword = searchKeyword;
    }

    @XmlTransient
    public String getSearchUseYn() {
        return searchUseYn;
    }

    public void setSearchUseYn(String searchUseYn) {
        this.searchUseYn = searchUseYn;
    }

	public String getSearchDateCondition() {
		return searchDateCondition;
	}

	public void setSearchDateCondition(String searchDateCondition) {
		this.searchDateCondition = searchDateCondition;
	}

	public String getSearchStartDate() {
		return searchStartDate;
	}

	public void setSearchStartDate(String searchStartDate) {
		this.searchStartDate = searchStartDate;
	}

	public String getSearchEndDate() {
		return searchEndDate;
	}

	public void setSearchEndDate(String searchEndDate) {
		this.searchEndDate = searchEndDate;
	}
}
