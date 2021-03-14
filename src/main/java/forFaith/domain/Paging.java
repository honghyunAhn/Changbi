package forFaith.domain;

import java.io.Serializable;

/**
 * @Class Name : Paging.java
 * @Description : 페이징 처리
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

public class Paging implements Serializable {

    private static final long serialVersionUID = 1L;

    public final static int DEFAULT_PAGE_NO = 1;
    public final static int DEFAULT_NUM_OF_ROWS = 10;
    public final static int DEFAULT_NUM_OF_NUMS = 10;
    public final static String DEFAULT_PAGING_YN = "Y";

    /** 현재페이지 번호 */
	private int pageNo;

	/** 한 페이지 당 데이터 갯수 */
	private int numOfRows;

	/** 화면에 보여줄 페이지 갯수(1~10) */
    private int numOfNums;

    /** 총 데이터 갯수 */
	private int totalCount;

	/** 페이징 처리 여부 */
	private String pagingYn;
	
	/** 첫번째 index(mysql에서 사용함 */
	private int firstIndex;

	public Paging() {
		this(Paging.DEFAULT_PAGE_NO, Paging.DEFAULT_NUM_OF_ROWS, Paging.DEFAULT_NUM_OF_NUMS, Paging.DEFAULT_PAGING_YN);
	}

	public Paging(int pageNo) {
		this(pageNo, Paging.DEFAULT_NUM_OF_ROWS, Paging.DEFAULT_NUM_OF_NUMS, Paging.DEFAULT_PAGING_YN);
	}

	public Paging(String pagingYn) {
		this(Paging.DEFAULT_PAGE_NO, Paging.DEFAULT_NUM_OF_ROWS, Paging.DEFAULT_NUM_OF_NUMS, pagingYn);
	}

	public Paging(int pageNo, int numOfRows) {
		this(pageNo, numOfRows, Paging.DEFAULT_NUM_OF_NUMS, Paging.DEFAULT_PAGING_YN);
	}

	public Paging(int pageNo, String pagingYn) {
		this(pageNo, Paging.DEFAULT_NUM_OF_ROWS, Paging.DEFAULT_NUM_OF_NUMS, pagingYn);
	}

	public Paging(int pageNo, int numOfRows, int numOfNums, String pagingYn) {
		this.pageNo = pageNo;
		this.numOfRows = numOfRows;
		this.numOfNums = numOfNums;
		this.pagingYn = pagingYn;
	}

    public int getPageNo() {
		return pageNo;
	}

	public void setPageNo(int pageNo) {
		this.pageNo = pageNo;
	}

	public int getNumOfRows() {
		return numOfRows;
	}

	public void setNumOfRows(int numOfRows) {
		this.numOfRows = numOfRows;
	}

	public int getNumOfNums() {
		return numOfNums;
	}

	public void setNumOfNums(int numOfNums) {
		this.numOfNums = numOfNums;
	}

	public int getTotalCount() {
        return totalCount;
    }

    public void setTotalCount(int totalCount) {
        this.totalCount = totalCount;
    }

	public String getPagingYn() {
		return pagingYn;
	}

	public void setPagingYn(String pagingYn) {
		this.pagingYn = pagingYn;
	}

	public int getFirstIndex() {
		this.firstIndex = (getPageNo() - 1) * getNumOfRows();
		return this.firstIndex;
	}

	public void setFirstIndex(int firstIndex) {
		this.firstIndex = firstIndex;
	}

	@Override
	public String toString() {
		return "Paging [pageNo=" + pageNo + ", numOfRows=" + numOfRows + ", numOfNums=" + numOfNums + ", totalCount="
				+ totalCount + ", pagingYn=" + pagingYn + ", firstIndex=" + firstIndex + "]";
	}
	
	
}
