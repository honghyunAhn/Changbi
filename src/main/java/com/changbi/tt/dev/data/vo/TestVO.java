package com.changbi.tt.dev.data.vo;

public class TestVO {
	
	private int crc_seq; 				// 과정시퀀스번호
	private String crc_class; 			// 과정번호
	private String crc_nm;  			// 과정명
	private int gisu_seq;				// 기수 시퀀스 번호
	private String gisu_crc_nm;			// 기수명 풀네임
	private String crc_id;
	private String gisu_id;
	
	public TestVO() {
		super();
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



	public int getGisu_seq() {
		return gisu_seq;
	}

	public void setGisu_seq(int gisu_seq) {
		this.gisu_seq = gisu_seq;
	}

	public String getGisu_crc_nm() {
		return gisu_crc_nm;
	}



	public void setGisu_crc_nm(String gisu_crc_nm) {
		this.gisu_crc_nm = gisu_crc_nm;
	}



	public int getCrc_seq() {
		return crc_seq;
	}

	public void setCrc_seq(int crc_seq) {
		this.crc_seq = crc_seq;
	}

	public String getCrc_class() {
		return crc_class;
	}

	public void setCrc_class(String crc_class) {
		this.crc_class = crc_class;
	}

	public String getCrc_nm() {
		return crc_nm;
	}

	public void setCrc_nm(String crc_nm) {
		this.crc_nm = crc_nm;
	}



	public TestVO(int crc_seq, String crc_class, String crc_nm, int gisu_seq, String gisu_crc_nm, String crc_id,
			String gisu_id) {
		super();
		this.crc_seq = crc_seq;
		this.crc_class = crc_class;
		this.crc_nm = crc_nm;
		this.gisu_seq = gisu_seq;
		this.gisu_crc_nm = gisu_crc_nm;
		this.crc_id = crc_id;
		this.gisu_id = gisu_id;
	}



	@Override
	public String toString() {
		return "TestVO [crc_seq=" + crc_seq + ", crc_class=" + crc_class + ", crc_nm=" + crc_nm + ", gisu_seq="
				+ gisu_seq + ", gisu_crc_nm=" + gisu_crc_nm + ", crc_id=" + crc_id + ", gisu_id=" + gisu_id + "]";
	}



	
	
}


