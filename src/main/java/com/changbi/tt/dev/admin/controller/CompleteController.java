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

import com.changbi.tt.dev.data.vo.LearnAppVO;

import forFaith.dev.service.BaseService;
import forFaith.dev.vo.CodeVO;

// Controller value는 중복되면 안된다. value 값을 지정하지 않으면 클래스명이 value가 되므로 같은 클래스명이 존재하면 중복으로 인식
@Controller(value="admin.completeController")
// 해당 클래스를 호출 하기 위한 Mapping 기본 값 뒤에 붙는 값에 의해 필요한 함수가 호출 된다.
@RequestMapping("/admin/complete")
public class CompleteController {

	@Autowired
	private BaseService baseService;
	
    /**
     * log를 남기는 객체 생성
     * @author : 김준석(2018-02-17)
     */
    private static final Logger logger = LoggerFactory.getLogger(CompleteController.class);

    /**
     * 이수 관리 처리 페이지
     */
    @RequestMapping(value="/completeProc")
    public void completeProc(@ModelAttribute("search") LearnAppVO learnApp) throws Exception {}
 
    /**
     * 이수자 현황보고 페이지
     */
    @RequestMapping(value="/completeList")
    public void completeList(@ModelAttribute("search") LearnAppVO learnApp, ModelMap model) throws Exception {
    	// 시도교육청 코드테이블 가져오기
        CodeVO code = new CodeVO();
        code.setUseYn("Y");
        code.setPagingYn("N");
        code.getCodeGroup().setId("region");
        
        model.addAttribute("region", baseService.codeList(code));
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