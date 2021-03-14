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

import com.changbi.tt.dev.data.vo.CalculateVO;
import com.changbi.tt.dev.data.vo.GroupLearnAppVO;
import com.changbi.tt.dev.data.vo.LearnAppVO;

import forFaith.dev.service.BaseService;
import forFaith.dev.util.LoginHelper;
import forFaith.dev.vo.MemberVO;

@Controller(value="admin.payController")      // Controller value는 중복되면 안된다. value 값을 지정하지 않으면 클래스명이 value가 되므로 같은 클래스명이 존재하면 중복으로 인식
@RequestMapping("/admin/pay")       // 해당 클래스를 호출 하기 위한 Mapping 기본 값 뒤에 붙는 값에 의해 필요한 함수가 호출 된다.
public class PayController {

	@Autowired
	private BaseService baseService;
	
    /**
     * log를 남기는 객체 생성
     * @author : 김준석(2018-02-17)
     */
    private static final Logger logger = LoggerFactory.getLogger(PayController.class);

    @RequestMapping(value="/payList")
    public void payList(@ModelAttribute("search") LearnAppVO learnApp) {

    }

    @RequestMapping(value="/individualPayList")
    public void individualPayList(@ModelAttribute("search") LearnAppVO learnApp) {

    }
    
    @RequestMapping(value="/groupPayList")
    public void groupPayList(@ModelAttribute("search") GroupLearnAppVO grouplearnApp) {
    	
    }
    
    @RequestMapping(value="/calculateList")
    public void calculateList(@ModelAttribute("search") CalculateVO calculate, ModelMap model) throws Exception {

    	String calType = calculate.getCalType();
    	
    	MemberVO member = new MemberVO();
    	
    	switch (calType) {
    	case "company" :
    		// 협력업체 리스트 가져오기
            member.setUseYn("Y");
            member.setPagingYn("N");
            member.setGrade(3);
            
            model.addAttribute("companyList", baseService.memberList(member));
            
    		break;
    	case "tutor" :
    		// 튜터 리스트 가져오기
            member.setUseYn("Y");
            member.setPagingYn("N");
            member.setGrade(1);
            
            // 로그인 정보를 저장한다.
            member.setLoginUser((MemberVO)LoginHelper.getLoginInfo());
            
            model.addAttribute("tutorList", baseService.memberList(member));
    		break;
    	case "teacher" :
    		// 강사 리스트 가져오기
            member.setUseYn("Y");
            member.setPagingYn("N");
            member.setGrade(2);
            
            model.addAttribute("teacherList", baseService.memberList(member));
    		break;
    	}
    }
    
    @RequestMapping(value="/pointEdit")
    public void pointEdit(ModelMap model) throws Exception {

    }

    /*@RequestMapping(value="/couponList")
    public void couponList(@ModelAttribute("search") BookAppVO bookApp) {
    	 
    }*/
    
    @RequestMapping(value="/couponEdit")
    public void couponEdit(ModelMap model) throws Exception {
    	
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