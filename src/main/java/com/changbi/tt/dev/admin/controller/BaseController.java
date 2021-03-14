/**
 * Admin 화면 호출 Controller
 * admin Home은 세션 객체 생성 때문에 HomeController에 공통으로 넣지 않았음.
 * 세션 생성이 필요한 경우에는 따로 Contoller를 만들어서 사용하면 좋겠음.
 * 같은 세션인 경우는 HomeController에 공통으로 넣어도 됨.
 * @author : 김준석(2015-06-03)
 */

package com.changbi.tt.dev.admin.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller(value="admin.baseController")      // Controller value는 중복되면 안된다. value 값을 지정하지 않으면 클래스명이 value가 되므로 같은 클래스명이 존재하면 중복으로 인식
@RequestMapping("/admin/base")       // 해당 클래스를 호출 하기 위한 Mapping 기본 값 뒤에 붙는 값에 의해 필요한 함수가 호출 된다.
public class BaseController {

    /**
     * log를 남기는 객체 생성
     * @author : 김준석(2015-06-03)
     */
    private static final Logger logger = LoggerFactory.getLogger(BaseController.class);

    /**
     * 관리자 즐겨찾기 페이지
     * @author : 김준석(2015-06-03)
     */
    @RequestMapping(value="/bookmark")
    public void bookmark() {}

    /**
     * 관리자 공통 헤더
     * 공통 처리를 목적으로 헤더를 둔다.
     * @author : 김준석(2015-06-03)
     */
    @RequestMapping(value="/header")
    public void header() {}
    
    /**
     * 왁구페이지(내용은 ajax로 호출)
     * @author : 김준석(2015-06-03)
     */
    @RequestMapping(value="/layout")
    public void layout() {}
    
    /**
     * 마이페이지
     * @author : 김준석(2015-06-03)
     */
    @RequestMapping(value="/myPage")
    public void myPage() {}
    
    /**
     * 메인페이지
     * @author : 김준석(2015-06-03)
     */
    @RequestMapping(value="/main")
    public void main() {}

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