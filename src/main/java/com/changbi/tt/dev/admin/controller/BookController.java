/**
 * 회원관리 화면 호출 Controller
 * @author : 김준석(2018-02-17)
 */

package com.changbi.tt.dev.admin.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.changbi.tt.dev.data.service.BookService;
import com.changbi.tt.dev.data.vo.BookAppVO;
import com.changbi.tt.dev.data.vo.BookInoutVO;
import com.changbi.tt.dev.data.vo.BookVO;

import forFaith.dev.service.BaseService;
import forFaith.dev.vo.CodeVO;

@Controller(value="admin.bookController")      // Controller value는 중복되면 안된다. value 값을 지정하지 않으면 클래스명이 value가 되므로 같은 클래스명이 존재하면 중복으로 인식
@RequestMapping("/admin/book")       // 해당 클래스를 호출 하기 위한 Mapping 기본 값 뒤에 붙는 값에 의해 필요한 함수가 호출 된다.
public class BookController {

	@Autowired
	private BaseService baseService;
	
	@Autowired
	private BookService bookService;
	
    /**
     * log를 남기는 객체 생성
     * @author : 김준석(2018-02-17)
     */
    private static final Logger logger = LoggerFactory.getLogger(BookController.class);

    
    @RequestMapping(value="/bookAppList")
    public void bookAppList(@ModelAttribute("search") BookAppVO bookApp) {}
    
    @RequestMapping(value="/bookAppEdit")
    public void bookAppEdit(BookAppVO bookApp, ModelMap model) throws Exception {
    	if(bookApp != null && (bookApp.getId() > 0)) {
            // 선택 된 ID가 없으면 바로 edit 화면으로 이동하고 선택 된 ID가 있으면 해당 정보를 가지고 간다.
    		model.addAttribute("bookApp", bookService.bookAppInfo(bookApp));
        }

        // 검색 조건 저장(리스트 페이지로 이동 시 검색 조건을 그대로 유지하기 위해)
        model.addAttribute("search", bookApp);
    }
    
    /**
     * 교재 관리 리스트
     * @param book
     */
    @RequestMapping(value="/bookList")
    public void bookList(@ModelAttribute("search") BookVO book, ModelMap model) throws Exception {
    	// 출판사 코드 리스트 저장
        CodeVO code = new CodeVO();
        code.getCodeGroup().setId("publish");	// 출판사 분류 그룹
        code.setUseYn("Y");						// 사용 가능 한 코드만 조회

    	// 모든 코드 분류 리스트를 가지고 오기 위해 페이징 처리 안함
        code.setPagingYn("N");

        // 출판사 코드 리스트
        model.addAttribute("publish", baseService.codeList(code));
    }
    
    @RequestMapping(value="/bookEdit")
    public void bookAppEdit(BookVO book, ModelMap model) throws Exception {
        if(book != null && book.getId() > 0) {
            // 선택 된 ID가 없으면 바로 edit 화면으로 이동하고 선택 된 ID가 있으면 해당 정보를 가지고 간다.
            model.addAttribute("book", bookService.bookInfo(book));
        }

        // 검색 조건 저장(리스트 페이지로 이동 시 검색 조건을 그대로 유지하기 위해)
        model.addAttribute("search", book);

        // 출판사 코드 리스트 저장
        CodeVO code = new CodeVO();
        code.getCodeGroup().setId("publish");	// 출판사 분류 그룹
        code.setUseYn("Y");						// 사용 가능 한 코드만 조회

        // 모든 코드 분류 리스트를 가지고 오기 위해 페이징 처리 안함
        code.setPagingYn("N");

        // 출판사 코드 리스트
        model.addAttribute("publish", baseService.codeList(code));
    }
    
    /**
     * 교재 입고 관리 리스트
     * @param book
     */
    @RequestMapping(value="/bookInputList")
    public void bookInputList(@ModelAttribute("search") BookVO book, ModelMap model) throws Exception {
    	// 출판사 코드 리스트 저장
        CodeVO code = new CodeVO();
        code.getCodeGroup().setId("publish");	// 출판사 분류 그룹
        code.setUseYn("Y");						// 사용 가능 한 코드만 조회

    	// 모든 코드 분류 리스트를 가지고 오기 위해 페이징 처리 안함
        code.setPagingYn("N");

        // 출판사 코드 리스트
        model.addAttribute("publish", baseService.codeList(code));
    }
    
    /**
     * 교재 입출고 리스트
     * @param book
     */
    @RequestMapping(value="/bookInoutList")
    public void bookInoutList(@ModelAttribute("search") BookInoutVO bookInout, ModelMap model) throws Exception {
    	// 출판사 코드 리스트 저장
        CodeVO code = new CodeVO();
        code.getCodeGroup().setId("publish");	// 출판사 분류 그룹
        code.setUseYn("Y");						// 사용 가능 한 코드만 조회

    	// 모든 코드 분류 리스트를 가지고 오기 위해 페이징 처리 안함
        code.setPagingYn("N");

        // 출판사 코드 리스트
        model.addAttribute("publish", baseService.codeList(code));
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