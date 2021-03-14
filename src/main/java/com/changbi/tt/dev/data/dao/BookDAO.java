package com.changbi.tt.dev.data.dao;

import java.util.List;

import com.changbi.tt.dev.data.vo.BookAppVO;
import com.changbi.tt.dev.data.vo.BookInoutVO;
import com.changbi.tt.dev.data.vo.BookVO;

public interface BookDAO {

	// 교재신청 리스트 조회
	List<BookAppVO> bookAppList(BookAppVO bookAppVO) throws Exception;

	// 교재신청 리스트 총 갯수
	int bookAppTotalCnt(BookAppVO bookAppVO) throws Exception;

	// 교재신청 상세 조회
	BookAppVO bookAppInfo(BookAppVO bookAppVO) throws Exception;

	// 교재신청 등록(수정)
	void bookAppReg(BookAppVO bookAppVO) throws Exception;
	
	// 교재신청 삭제
	int bookAppDel(BookAppVO bookAppVO) throws Exception;
	
	// 교재신청 선택 삭제
	int bookAppSelectDel(List<BookAppVO> bookAppList) throws Exception;
	
	// 교재 리스트 조회
	List<BookVO> bookList(BookVO book) throws Exception;

	// 교재 리스트 총 갯수
	int bookTotalCnt(BookVO book) throws Exception;

	// 교재 상세 조회
	BookVO bookInfo(BookVO book) throws Exception;
	
	// 교재 등록 및 수정
	void bookReg(BookVO book) throws Exception;
	
	// 교재 삭제
	int bookDel(BookVO book) throws Exception;

	// 교재 입고
	void bookInput(BookInoutVO bookInout) throws Exception;
	
	// 교재 재고수량 변경
	int bookStock(BookInoutVO bookInout) throws Exception;
	
	// 교재 입출고 현황 리스트 조회
	List<BookInoutVO> bookInoutList(BookInoutVO bookInout) throws Exception;

	// 교재 입출고 현황 리스트 총 갯수
	int bookInoutTotalCnt(BookInoutVO bookInout) throws Exception;
}