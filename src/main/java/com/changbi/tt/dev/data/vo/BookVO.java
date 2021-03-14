package com.changbi.tt.dev.data.vo;

import forFaith.dev.vo.AttachFileVO;
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
public class BookVO extends CommonVO {
	// 검색조건
    private BookVO search;
    
	private int id;	    						// seq id
	private String name;						// 교재명
	private String mainYn;						// 주교재 여부
	private int price;							// 교재 가격
	private String author;						// 저장
	private String memo;						// 교재 설명
	private int stock;							// 재고수량
	
	private CodeVO supply;						// 공급업체 코드
	private AttachFileVO img1;					// 이미지 파일1
	private AttachFileVO img2;					// 이미지 파일2
	
    public BookVO getSearch() {
        return search;
    }

    public void setSearch(BookVO search) {
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

	public String getMainYn() {
		return mainYn;
	}

	public void setMainYn(String mainYn) {
		this.mainYn = mainYn;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public String getAuthor() {
		return author;
	}

	public void setAuthor(String author) {
		this.author = author;
	}

	public String getMemo() {
		return memo;
	}

	public void setMemo(String memo) {
		this.memo = memo;
	}

	public int getStock() {
		return stock;
	}

	public void setStock(int stock) {
		this.stock = stock;
	}

	public CodeVO getSupply() {
		return supply;
	}

	public void setSupply(CodeVO supply) {
		this.supply = supply;
	}

	public AttachFileVO getImg1() {
		return img1;
	}

	public void setImg1(AttachFileVO img1) {
		this.img1 = img1;
	}

	public AttachFileVO getImg2() {
		return img2;
	}

	public void setImg2(AttachFileVO img2) {
		this.img2 = img2;
	}
}
