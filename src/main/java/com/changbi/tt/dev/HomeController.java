/**
 * Admin 화면 호출 Controller
 * admin Home은 세션 객체 생성 때문에 HomeController에 공통으로 넣지 않았음.
 * 세션 생성이 필요한 경우에는 따로 Contoller를 만들어서 사용하면 좋겠음.
 * 같은 세션인 경우는 HomeController에 공통으로 넣어도 됨.
 * @author : 김준석(2015-06-03)
 */

package com.changbi.tt.dev;

import java.util.Locale;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;


import forFaith.util.web.WebCommon;

@Controller(value="homeController")      // Controller value는 중복되면 안된다. value 값을 지정하지 않으면 클래스명이 value가 되므로 같은 클래스명이 존재하면 중복으로 인식
public class HomeController {

    /**
     * log를 남기는 객체 생성
     * @author : 김준석(2015-06-03)
     */
    private static final Logger logger = LoggerFactory.getLogger(HomeController.class);

    @RequestMapping(value = "/")
    public String main(Locale locale, HttpServletRequest request) {
        logger.info("Welcome home! The client locale is {}.", locale);
        
        boolean isMobile = WebCommon.isMobile(request);
        
        String viewName = "/admin/base/layout";

        if(isMobile) {
            viewName = "/admin/base/layout";
        }
        
        return viewName;
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