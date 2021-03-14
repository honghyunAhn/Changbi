package com.changbi.tt.dev.data.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.changbi.tt.dev.data.dao.BookDAO;
import com.changbi.tt.dev.data.vo.BookAppVO;
import com.changbi.tt.dev.data.vo.BookInoutVO;
import com.changbi.tt.dev.data.vo.BookVO;

import forFaith.dev.dao.AttachFileDAO;
import forFaith.dev.vo.AttachFileVO;
import forFaith.util.StringUtil;

@Service(value="data.bookService")
public class BookService {

	@Autowired
	private BookDAO bookDao;
	
	@Autowired
    private AttachFileDAO fileDao;

	// 교재신청 리스트 조회
	public List<BookAppVO> bookAppList(BookAppVO bookApp) throws Exception {
		return bookDao.bookAppList(bookApp);
	}

	// 교재신청 리스트 총 갯수
	public int bookAppTotalCnt(BookAppVO bookApp) throws Exception {
		return bookDao.bookAppTotalCnt(bookApp);
	}

	// 교재신청 상세 조회
	public BookAppVO bookAppInfo(BookAppVO bookApp) throws Exception {
		return bookDao.bookAppInfo(bookApp);
	}
	
	// 교재신청 등록(수정)
	public void bookAppReg(BookAppVO bookAppVO) throws Exception {
		bookDao.bookAppReg(bookAppVO);
	}
		
	// 교재신청 삭제
	public int bookAppDel(BookAppVO bookAppVO) throws Exception {
		int result = bookDao.bookAppDel(bookAppVO);

		return result;
	}
	
	// 교재신청 선택 삭제
	public int bookAppSelectDel(List<BookAppVO> bookAppList) throws Exception {
		int result = bookDao.bookAppSelectDel(bookAppList);

		return result;
	}
	
	// 교재 리스트 조회
	public List<BookVO> bookList(BookVO book) throws Exception {
		return bookDao.bookList(book);
	}

	// 교재 리스트 총 갯수
	public int bookTotalCnt(BookVO book) throws Exception {
		return bookDao.bookTotalCnt(book);
	}

	// 교재 상세 조회
	public BookVO bookInfo(BookVO book) throws Exception {
		return bookDao.bookInfo(book);
	}
	
	// 교재 등록 및 수정
	public void bookReg(BookVO book) throws Exception {
		bookDao.bookReg(book);
		
		// ID가 생성 또는 update 라면 detail insert 또는 upadate
        if(book.getId() > 0) {
        	// 파일 사용 가능 상태로 변경 처리
            // useYn을 Y로 바꾼다.
            List<AttachFileVO> attachFileList = new ArrayList<AttachFileVO>();
            
 			if(book.getImg1() != null && !StringUtil.isEmpty(book.getImg1().getFileId())) {
 				attachFileList.add(book.getImg1());
 			}
 			
 			if(book.getImg2() != null && !StringUtil.isEmpty(book.getImg2().getFileId())) {
 				attachFileList.add(book.getImg2());
 			}
            
			// 파일 사용 가능 상태로 변경
			if(attachFileList.size() > 0) {
				fileDao.attachFileUse(attachFileList);
			}
        }
	}
	
	// 교재 삭제
	public int bookDel(BookVO book) throws Exception {
		return bookDao.bookDel(book);
	}
	
	// 교재 입고
	public void bookInput(BookInoutVO bookInout) throws Exception {
		bookDao.bookInput(bookInout);
		
		// 입고 성공 시 재고 수량 변경
		if(bookInout.getId() > 0) {
			bookDao.bookStock(bookInout);
		}
	}
	
	// 교재 입출고 현황 리스트 조회
	public List<BookInoutVO> bookInoutList(BookInoutVO bookInout) throws Exception {
		return bookDao.bookInoutList(bookInout);
	}

	// 교재 입출고 현황 리스트 총 갯수
	public int bookInoutTotalCnt(BookInoutVO bookInout) throws Exception {
		return bookDao.bookInoutTotalCnt(bookInout);
	}
}