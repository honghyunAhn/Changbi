package com.lms.student.vo;

/*
 * 과정&기수 별 성적+출석+과제 총 배율 테이블 
 */
public class TotalPercentVO {
	
	private int 	total_per_seq;		// 총점수배율		번호
	private String 	crc_id;				// 과정			ID
	private String 	gisu_id;			// 기수			ID
	private String 	category_nm;		// 카테고리 		이름
	private Double 	category_percent;	// 항목			배율
	
	
	public TotalPercentVO() {
		super();
	}


	public TotalPercentVO(int total_per_seq, String crc_id, String gisu_id, String category_nm,
			Double category_percent) {
		super();
		this.total_per_seq = total_per_seq;
		this.crc_id = crc_id;
		this.gisu_id = gisu_id;
		this.category_nm = category_nm;
		this.category_percent = category_percent;
	}


	public int getTotal_per_seq() {
		return total_per_seq;
	}


	public void setTotal_per_seq(int total_per_seq) {
		this.total_per_seq = total_per_seq;
	}


	public String getCrc_id() {
		return crc_id;
	}


	public void setCrc_id(String crc_id) {
		this.crc_id = crc_id;
	}


	public String getGisu_id() {
		return gisu_id;
	}


	public void setGisu_id(String gisu_id) {
		this.gisu_id = gisu_id;
	}


	public String getCategory_nm() {
		return category_nm;
	}


	public void setCategory_nm(String category_nm) {
		this.category_nm = category_nm;
	}


	public Double getCategory_percent() {
		return category_percent;
	}


	public void setCategory_percent(Double category_percent) {
		this.category_percent = category_percent;
	}


	@Override
	public String toString() {
		return "TotalPercentVO [total_per_seq=" + total_per_seq + ", crc_id=" + crc_id + ", gisu_id=" + gisu_id
				+ ", category_nm=" + category_nm + ", category_percent=" + category_percent + "]";
	}
	
	

}
