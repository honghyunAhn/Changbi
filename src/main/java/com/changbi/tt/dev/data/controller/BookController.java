/**
 * 회원관리 화면 호출 Controller
 * @author : 김준석(2018-02-17)
 */

package com.changbi.tt.dev.data.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.changbi.tt.dev.data.service.BookService;
import com.changbi.tt.dev.data.vo.BookAppVO;
import com.changbi.tt.dev.data.vo.BookInoutVO;
import com.changbi.tt.dev.data.vo.BookVO;

import forFaith.dev.util.GlobalMethod;
import forFaith.dev.util.LoginHelper;
import forFaith.dev.vo.MemberVO;
import forFaith.domain.RequestList;
import forFaith.util.DataList;
import forFaith.util.StringUtil;

@Controller(value="data.bookController")      // Controller value는 중복되면 안된다. value 값을 지정하지 않으면 클래스명이 value가 되므로 같은 클래스명이 존재하면 중복으로 인식
@RequestMapping("/data/book")       // 해당 클래스를 호출 하기 위한 Mapping 기본 값 뒤에 붙는 값에 의해 필요한 함수가 호출 된다.
public class BookController {

	@Autowired
	private BookService bookService;
	
    /**
     * log를 남기는 객체 생성
     * @author : 김준석(2018-02-17)
     */
    private static final Logger logger = LoggerFactory.getLogger(BookController.class);

    /**
     * 교재신청 정보 리스트
     */
    @RequestMapping(value = "/bookAppList", method = RequestMethod.POST)
    public @ResponseBody DataList<BookAppVO> bookAppList(BookAppVO bookAppVO) throws Exception {
    	DataList<BookAppVO> result = new DataList<BookAppVO>();
    	
    	result.setPagingYn(bookAppVO.getPagingYn());
    	
    	// 페이징 처리인 경우만 페이지 번호와 토탈 갯수를 저장한다.
		if(result.getPagingYn().equals("Y")) {
			result.setNumOfNums(bookAppVO.getNumOfNums());
			result.setNumOfRows(bookAppVO.getNumOfRows());
			result.setPageNo(bookAppVO.getPageNo());
			result.setTotalCount(bookService.bookAppTotalCnt(bookAppVO));
		}

		// 결과 리스트를 저장
		result.setList(bookService.bookAppList(bookAppVO));

		return result;
    }
    
    /**
	 * 교재신청 관리 엑셀 다운로드
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/excel/download/bookAppList", method = RequestMethod.POST)
	public ModelAndView excelDownloadManagerList(BookAppVO bookAppVO) throws Exception {
		Map<String, Object> map		= new HashMap<String, Object>();
		List<Object> hederList		= new ArrayList<Object>();
		List<Object> bodyList		= new ArrayList<Object>();
		List<Object> bodyWidthList	= new ArrayList<Object>();
		
		// 모든 데이터를 가져오기 위해.. paging 여부를 N으로 설정
		bookAppVO.setPagingYn("N");

		// 리스트 조회
		List<BookAppVO> dataList = bookService.bookAppList(bookAppVO);

		String[] heder = new String[]{"접수일자","접수번호","성명","아이디","연락처","과정명","주문수량","배송상태","결제상태","결제방법"};
		int[] bodyWidth = new int[]{20, 10, 10, 20, 20, 30, 10, 10, 10, 10};

		for(int i=0; i<dataList.size(); ++i) {
			BookAppVO temp = dataList.get(i);
			String[] body = new String[heder.length];
			SimpleDateFormat before_format	= new SimpleDateFormat("yyyyMMddhhmmss");
			SimpleDateFormat after_format	= new SimpleDateFormat("yyyy-MM-dd");
			Date regDate = !StringUtil.isEmpty(temp.getRegDate()) ? before_format.parse(temp.getRegDate()) : null;

			body[0] = regDate != null ? after_format.format(regDate) : "";
			body[1] = temp.getId()+"";
			body[2]	= temp.getRecName();
			body[3] = temp.getUserId();
			body[4] = temp.getPhone();
			body[5] = "";
			body[6] = temp.getAmount()+"개";
			body[7] = !StringUtil.isEmpty(temp.getDelivYn()) && temp.getDelivYn().equals("Y") ? "배송완료" : "배송안됨";
			body[8] = !StringUtil.isEmpty(temp.getPaymentYn()) && temp.getPaymentYn().equals("Y") ? "결제완료" : "결제안됨";
			body[9] = !StringUtil.isEmpty(temp.getPaymentType()) && temp.getPaymentType().equals("C") ? "신용카드" : "계좌이체";

			bodyList.add(body);
		}

		hederList.add(heder);
		bodyWidthList.add(bodyWidth);

		map.put("fileName", "교재신청리스트_"+GlobalMethod.getNow("yyyyMMddHHmmss")+".xls");
		map.put("header", hederList);
		map.put("body", bodyList);
		map.put("bodyWidth", bodyWidthList);

		return new ModelAndView("excelDownLoad", "excelMap", map);
	}
    
    @RequestMapping(value="/bookAppReg", method=RequestMethod.POST)
    public @ResponseBody BookAppVO bookAppReg(BookAppVO bookApp) throws Exception {
        if(bookApp != null) {
            // 로그인 된 관리자 정보
        	MemberVO loginUser = (MemberVO)LoginHelper.getLoginInfo();

    		// 메일 발송과 별개로 올레측 DB에 저장한다.
        	bookApp.setRegUser(loginUser);
        	bookApp.setUpdUser(loginUser);

        	bookService.bookAppReg(bookApp);
        }

        return bookApp;
    }

    /**
     * 교재 신청 삭제
     * @param bookApp
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/bookAppDel", method=RequestMethod.POST)
    public @ResponseBody int bookAppDel(BookAppVO bookApp) throws Exception {
    	int result = bookService.bookAppDel(bookApp);
        
        return result;
    }
    
    /**
     * 연수신청관리 : 교재신청 선택 삭제
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/bookAppSelectDel", method=RequestMethod.POST)
    public @ResponseBody int bookAppSelectDel(@RequestBody RequestList<BookAppVO> requestList) throws Exception {
    	int result = 0;
    	List<BookAppVO> bookAppList = requestList.getList();

    	if(bookAppList != null && bookAppList.size() > 0) {
			// 삭제처리
			result = bookService.bookAppSelectDel(bookAppList);
    	}

        return result;
    }
    
    /**
     * 교재 정보 리스트
     */
    @RequestMapping(value = "/bookList", method = RequestMethod.POST)
    public @ResponseBody DataList<BookVO> bookList(BookVO book) throws Exception {
    	DataList<BookVO> result = new DataList<BookVO>();
    	
    	result.setPagingYn(book.getPagingYn());
    	
    	// 페이징 처리인 경우만 페이지 번호와 토탈 갯수를 저장한다.
		if(result.getPagingYn().equals("Y")) {
			result.setNumOfNums(book.getNumOfNums());
			result.setNumOfRows(book.getNumOfRows());
			result.setPageNo(book.getPageNo());
			result.setTotalCount(bookService.bookTotalCnt(book));
		}

		// 결과 리스트를 저장
		result.setList(bookService.bookList(book));

		return result;
    } 
    
    /**
     * 교재 정보 저장 및 수정
     */
    @RequestMapping(value="/bookReg", method=RequestMethod.POST)
    public @ResponseBody BookVO bookReg(BookVO book) throws Exception {
        if(book != null) {
            // 로그인 된 관리자 정보
        	MemberVO loginUser = (MemberVO)LoginHelper.getLoginInfo();

    		// 메일 발송과 별개로 올레측 DB에 저장한다.
        	book.setRegUser(loginUser);
        	book.setUpdUser(loginUser);

        	bookService.bookReg(book);
        }

        return book;
    }
    
    /**
     * 교재 삭제
     * @author 김준석(2018-02-20)
     */
    @RequestMapping(value="/bookDel", method=RequestMethod.POST)
    public @ResponseBody int bookDel(BookVO book) throws Exception {
    	int result = bookService.bookDel(book);
        
        return result;
    }
    
    /**
     * 교재 입고
     */
    @RequestMapping(value="/bookInput", method=RequestMethod.POST)
    public @ResponseBody BookInoutVO bookInput(BookInoutVO bookInout) throws Exception {
        if(bookInout != null) {
            // 로그인 된 관리자 정보
        	MemberVO loginUser = (MemberVO)LoginHelper.getLoginInfo();

    		// 메일 발송과 별개로 올레측 DB에 저장한다.
        	bookInout.setRegUser(loginUser);
        	bookInout.setUpdUser(loginUser);

        	bookService.bookInput(bookInout);
        }

        return bookInout;
    }
    
    /**
     * 교재 입출고 현황 리스트
     */
    @RequestMapping(value = "/bookInoutList", method = RequestMethod.POST)
    public @ResponseBody DataList<BookInoutVO> bookInoutList(BookInoutVO bookInout) throws Exception {
    	DataList<BookInoutVO> result = new DataList<BookInoutVO>();
    	
    	result.setPagingYn(bookInout.getPagingYn());
    	
    	// 페이징 처리인 경우만 페이지 번호와 토탈 갯수를 저장한다.
		if(result.getPagingYn().equals("Y")) {
			result.setNumOfNums(bookInout.getNumOfNums());
			result.setNumOfRows(bookInout.getNumOfRows());
			result.setPageNo(bookInout.getPageNo());
			result.setTotalCount(bookService.bookInoutTotalCnt(bookInout));
		}

		// 결과 리스트를 저장
		result.setList(bookService.bookInoutList(bookInout));

		return result;
    } 

    /**
     * Exception 처리
     * @param Exception
     * @return ModelAndView
     * @author : 김준석 - (2015-06-03)
     */
    @ExceptionHandler(Exception.class)
    public ModelAndView exceptionHandler(Exception e) {
        logger.info(e.getMessage());

        return new ModelAndView("/error/exception").addObject("msg", e.getMessage());
    }
}