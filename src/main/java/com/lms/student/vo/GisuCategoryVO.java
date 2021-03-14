package com.lms.student.vo;


/*
 * 기수 성적 카테고리 VO										
 */
public class GisuCategoryVO {

	private int cat_seq;					// 카테고리		번호
	private String crc_id;					// 과정 			ID
	private String gisu_id;					// 기수 			ID
	private String cat_nm;					// 카테고리 		이름
	private double cat_percent;				// 카테고리		배율
	private int big_cat_seq;
	private int mid_cat_seq;
	private int small_cat_seq;
	private int test_seq;
	
	public GisuCategoryVO() {
		super();
	}
	public GisuCategoryVO(int cat_seq, String crc_id, String gisu_id, String cat_nm, double cat_percent,
			int big_cat_seq, int mid_cat_seq) {
		super();
		this.cat_seq = cat_seq;
		this.crc_id = crc_id;
		this.gisu_id = gisu_id;
		this.cat_nm = cat_nm;
		this.cat_percent = cat_percent;
		this.big_cat_seq = big_cat_seq;
		this.mid_cat_seq = mid_cat_seq;
	}
	public GisuCategoryVO(int cat_seq, String crc_id, String gisu_id, String cat_nm, double cat_percent,
			int big_cat_seq, int mid_cat_seq, int small_cat_seq) {
		super();
		this.cat_seq = cat_seq;
		this.crc_id = crc_id;
		this.gisu_id = gisu_id;
		this.cat_nm = cat_nm;
		this.cat_percent = cat_percent;
		this.big_cat_seq = big_cat_seq;
		this.mid_cat_seq = mid_cat_seq;
		this.small_cat_seq = small_cat_seq;
	}
	public int getCat_seq() {
		return cat_seq;
	}
	public void setCat_seq(int cat_seq) {
		this.cat_seq = cat_seq;
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
	public String getCat_nm() {
		return cat_nm;
	}
	public void setCat_nm(String cat_nm) {
		this.cat_nm = cat_nm;
	}
	public double getCat_percent() {
		return cat_percent;
	}
	public void setCat_percent(double cat_percent) {
		this.cat_percent = cat_percent;
	}
	public int getBig_cat_seq() {
		return big_cat_seq;
	}
	public void setBig_cat_seq(int big_cat_seq) {
		this.big_cat_seq = big_cat_seq;
	}
	public int getMid_cat_seq() {
		return mid_cat_seq;
	}
	public void setMid_cat_seq(int mid_cat_seq) {
		this.mid_cat_seq = mid_cat_seq;
	}
	public int getSmall_cat_seq() {
		return small_cat_seq;
	}
	public void setSmall_cat_seq(int small_cat_seq) {
		this.small_cat_seq = small_cat_seq;
	}
	
	@Override
	public String toString() {
		return "GisuCategoryVO [cat_seq=" + cat_seq + ", crc_id=" + crc_id + ", gisu_id=" + gisu_id + ", cat_nm="
				+ cat_nm + ", cat_percent=" + cat_percent + ", big_cat_seq=" + big_cat_seq + ", mid_cat_seq="
				+ mid_cat_seq + ", small_cat_seq=" + small_cat_seq + ", test_seq=" + test_seq + "]";
	}
	public int getTest_seq() {
		return test_seq;
	}
	public void setTest_seq(int test_seq) {
		this.test_seq = test_seq;
	}
	
	
	
	
	
}
