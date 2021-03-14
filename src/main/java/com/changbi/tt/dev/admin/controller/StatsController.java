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

import com.changbi.tt.dev.data.service.BoardService;
import com.changbi.tt.dev.data.vo.StatsVO;

@Controller(value="admin.statsController")      // Controller value는 중복되면 안된다. value 값을 지정하지 않으면 클래스명이 value가 되므로 같은 클래스명이 존재하면 중복으로 인식
@RequestMapping("/admin/stats")       // 해당 클래스를 호출 하기 위한 Mapping 기본 값 뒤에 붙는 값에 의해 필요한 함수가 호출 된다.
public class StatsController {

	@Autowired
	private BoardService boardService;
	
    /**
     * log를 남기는 객체 생성
     * @author : 김준석(2018-02-17)
     */
    private static final Logger logger = LoggerFactory.getLogger(StatsController.class);

    /**
     * 기수 / 과정 별 통계
     * @author : 김준석(2015-06-03)
     */
    @RequestMapping(value="/courseStatsList")
    public void courseStatsList(@ModelAttribute("search") StatsVO stats) throws Exception {}

    /**
     * 회원가입현황통계
     * @author : 김준석(2015-06-03)
     */
    @RequestMapping(value="/joinStatsList")
    public void joinStatsList(@ModelAttribute("search") StatsVO stats) throws Exception {}
    
    /**
     * 회원현황 및 게시물통계
     * @author : 김준석(2015-06-03)
     */
    @RequestMapping(value="/userStatsList")
    public void userStatsList(@ModelAttribute("search") StatsVO stats) throws Exception {}
    
    /**
     * 수강현황통계(I)
     * @author : 김준석(2015-06-03)
     */
    @RequestMapping(value="/learnStatsList")
    public void learnStatsList(@ModelAttribute("search") StatsVO stats) throws Exception {}
    
    /**
     * 수강현황통계(II)
     * @author : 김준석(2015-06-03)
     */
    @RequestMapping(value="/learnStatsGraph")
    public void learnStatsGraph(@ModelAttribute("search") StatsVO stats) throws Exception {}
    
    /**
     * 연수 만족도 통계
     * @author : 김준석(2015-06-03)
     */
    @RequestMapping(value="/satisStatsGraph")
    public void satisStatsGraph(@ModelAttribute("search") StatsVO stats) throws Exception {}
    
    /**
     * 연수 설문 통계
     */
    @RequestMapping(value="/surveyStatsList")
    public void surveyStatsList(@ModelAttribute("search") StatsVO stats) throws Exception {}
    
    /**
     * 연수 설문 통계 상세
     */
    @RequestMapping(value="/surveyStatsDetail")
    public void surveyStatsDetail(@ModelAttribute("search") StatsVO stats, ModelMap model) throws Exception {
    	
    	// 통계용 VO 로 통일하게 됨에 따라 부득이하게 아래와 같이 파라미터 설정 하고 넘김.
    	stats.getSurvey().setSeq(stats.getSeq());
    	
    	model.addAttribute("survey", boardService.surveyInfo(stats.getSurvey()));
    	model.addAttribute("cardinalList", boardService.surveyCardinalList(stats.getSurvey()));
    }    
    
    /**
     * 문자 발송 통계
     * @author : 김준석(2015-06-03)
     */
    @RequestMapping(value="/smsHistoryStats")
    public void smsHistoryStats(@ModelAttribute("search") StatsVO stats) throws Exception {}

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