package com.changbi.tt.dev.data.vo;

import forFaith.dev.vo.AttachFileVO;
import forFaith.dev.vo.CommonVO;

@SuppressWarnings("serial")
public class ToeflVO extends CommonVO{
	
	// 검색조건
    private ToeflVO search;
	
	private int id;					//시험 ID(SEQ auto increment)
	private int type;				//시험 타입(1:COMPLETE, 2:HALF(R/L), 3:HALF(S/W)
	private String title;			//시험 제목
	private int volum;				//시험 볼륨값
	private int price;				//시험 가격
	private AttachFileVO imgFile;	//시험 이미지 파일
	public ToeflVO getSearch() {
		return search;
	}
	public void setSearch(ToeflVO search) {
		this.search = search;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getType() {
		return type;
	}
	public void setType(int type) {
		this.type = type;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public int getVolum() {
		return volum;
	}
	public void setVolum(int volum) {
		this.volum = volum;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public AttachFileVO getImgFile() {
		return imgFile;
	}
	public void setImgFile(AttachFileVO imgFile) {
		this.imgFile = imgFile;
	}
	
	@Override
	public String toString() {
		return "ToeflVO [search=" + search + ", id=" + id + ", type=" + type + ", title=" + title + ", volum=" + volum
				+ ", price=" + price + ", imgFile=" + imgFile + "]";
	}
	
}
