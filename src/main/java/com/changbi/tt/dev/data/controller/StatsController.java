/**
 * 회원관리 화면 호출 Controller
 * @author : 김준석(2018-02-17)
 */

package com.changbi.tt.dev.data.controller;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.changbi.tt.dev.data.service.BoardService;
import com.changbi.tt.dev.data.service.StatsService;
import com.changbi.tt.dev.data.vo.StatsVO;
import com.changbi.tt.dev.data.vo.SurveyVO;

import forFaith.dev.util.LoginHelper;
import forFaith.dev.vo.MemberVO;
import forFaith.util.DataList;

@Controller(value="data.statsController")      // Controller value는 중복되면 안된다. value 값을 지정하지 않으면 클래스명이 value가 되므로 같은 클래스명이 존재하면 중복으로 인식
@RequestMapping("/data/stats")       // 해당 클래스를 호출 하기 위한 Mapping 기본 값 뒤에 붙는 값에 의해 필요한 함수가 호출 된다.
public class StatsController {

	@Autowired
	private StatsService statsService;
	
	@Autowired
	private BoardService boardService;
	
    /**
     * log를 남기는 객체 생성
     * @author : 김준석(2018-02-17)
     */
    private static final Logger logger = LoggerFactory.getLogger(StatsController.class);

    /**
     * 기수 / 과정 별 통계
     * @author : 김준석(2017-07-06)
     */
    @RequestMapping(value = "/courseStatsList", method = RequestMethod.POST)
    public @ResponseBody DataList<Map<String,String>> courseStatsList(StatsVO stats) throws Exception {
    	DataList<Map<String,String>> result = new DataList<Map<String,String>>();
    	
    	// 로그인 정보를 저장한다.
    	stats.setLoginUser((MemberVO)LoginHelper.getLoginInfo());

		// 결과 리스트를 저장
		result.setList(statsService.courseStatsList(stats));

		return result;
    }
    
    /**
     * 회원가입현황통계
     * @author : 김준석(2017-07-06)
     */
    @RequestMapping(value = "/joinStatsList", method = RequestMethod.POST)
    public @ResponseBody DataList<Map<String,String>> joinStatsList(StatsVO stats) throws Exception {
    	DataList<Map<String,String>> result = new DataList<Map<String,String>>();
    	
    	// 로그인 정보를 저장한다.
    	stats.setLoginUser((MemberVO)LoginHelper.getLoginInfo());

		// 결과 리스트를 저장
		result.setList(statsService.joinStatsList(stats));

		return result;
    }
    
    /**
     * 회원현황 및 게시물통계
     * @author : 김준석(2017-07-06)
     */
    @RequestMapping(value = "/userStatsList", method = RequestMethod.POST)
    public @ResponseBody Map<String,String> userStatsList(StatsVO stats) throws Exception {
    	// 로그인 정보를 저장한다.
    	stats.setLoginUser((MemberVO)LoginHelper.getLoginInfo());
    	
		// 결과 리스트를 저장
		return statsService.userStatsList(stats);
    }
    
    /**
     * 수강현황통계(I)
     * @author : 김준석(2017-07-06)
     */
    @RequestMapping(value = "/learnStatsList", method = RequestMethod.POST)
    public @ResponseBody Map<String,String> learnStatsList(StatsVO stats) throws Exception {
    	// 로그인 정보를 저장한다.
    	stats.setLoginUser((MemberVO)LoginHelper.getLoginInfo());
    	
		// 결과 리스트를 저장
		return statsService.learnStatsList(stats);
    }
    
    /**
     * 수강현황통계(II) - 월단위 별 추이분석(25개월)
     * @author : 김준석(2017-07-06)
     */
    @RequestMapping(value = "/learnStatsGraph1", method = RequestMethod.POST)
    public @ResponseBody List<Map<String,String>> learnStatsGraph1(StatsVO stats) throws Exception {
    	// 로그인 정보를 저장한다.
    	stats.setLoginUser((MemberVO)LoginHelper.getLoginInfo());
    	
		// 결과 리스트를 저장
		return statsService.learnStatsGraph1(stats);
    }
    
    /**
     * 수강현황통계(II) - 연수형태별 분석 (접수유형별)
     * @author : 김준석(2017-07-06)
     */
    @RequestMapping(value = "/learnStatsGraph2_1", method = RequestMethod.POST)
    public @ResponseBody List<Map<String,String>> learnStatsGraph2_1(StatsVO stats) throws Exception {
    	// 로그인 정보를 저장한다.
    	stats.setLoginUser((MemberVO)LoginHelper.getLoginInfo());
    	
		// 결과 리스트를 저장
		return statsService.learnStatsGraph2_1(stats);
    }
    
    /**
     * 수강현황통계(II) - 연수형태별 분석 (직무연수 학점별)
     * @author : 김준석(2017-07-06)
     */
    @RequestMapping(value = "/learnStatsGraph2_2", method = RequestMethod.POST)
    public @ResponseBody List<Map<String,String>> learnStatsGraph2_2(StatsVO stats) throws Exception {
    	// 로그인 정보를 저장한다.
    	stats.setLoginUser((MemberVO)LoginHelper.getLoginInfo());
    	
		// 결과 리스트를 저장
		return statsService.learnStatsGraph2_2(stats);
    }
    
    /**
     * 수강현황통계(II) - 최다접수과정 TOP5
     * @author : 김준석(2017-07-06)
     */
    @RequestMapping(value = "/learnStatsGraph3_1", method = RequestMethod.POST)
    public @ResponseBody List<Map<String,String>> learnStatsGraph3_1(StatsVO stats) throws Exception {
    	// 로그인 정보를 저장한다.
    	stats.setLoginUser((MemberVO)LoginHelper.getLoginInfo());
    	
		// 결과 리스트를 저장
		return statsService.learnStatsGraph3_1(stats);
    }
    
    /**
     * 수강현황통계(II) - 교원선호과정 TOP5
     * @author : 김준석(2017-07-06)
     */
    @RequestMapping(value = "/learnStatsGraph3_2", method = RequestMethod.POST)
    public @ResponseBody List<Map<String,String>> learnStatsGraph3_2(StatsVO stats) throws Exception {
    	// 로그인 정보를 저장한다.
    	stats.setLoginUser((MemberVO)LoginHelper.getLoginInfo());
    	
		// 결과 리스트를 저장
		return statsService.learnStatsGraph3_2(stats);
    }

    /**
     * 수강현황통계(II) - 이수현황(인증건/무료연수제외)
     * @author : 김준석(2017-07-06)
     */
    @RequestMapping(value = "/learnStatsGraph4_1", method = RequestMethod.POST)
    public @ResponseBody Map<String,String> learnStatsGraph4_1(StatsVO stats) throws Exception {
    	// 로그인 정보를 저장한다.
    	stats.setLoginUser((MemberVO)LoginHelper.getLoginInfo());
    	
		// 결과 리스트를 저장
		return statsService.learnStatsGraph4_1(stats);
    }
    
    /**
     * 수강현황통계(II) - 결제형태(결제완료건)
     * @author : 김준석(2017-07-06)
     */
    @RequestMapping(value = "/learnStatsGraph4_2", method = RequestMethod.POST)
    public @ResponseBody Map<String,String> learnStatsGraph4_2(StatsVO stats) throws Exception {
    	// 로그인 정보를 저장한다.
    	stats.setLoginUser((MemberVO)LoginHelper.getLoginInfo());
    	
		// 결과 리스트를 저장
		return statsService.learnStatsGraph4_2(stats);
    }
    
    /**
     * 수강현황통계(II) - 학점 별 이수율 분석
     * @author : 김준석(2017-07-06)
     */
    @RequestMapping(value = "/learnStatsGraph5", method = RequestMethod.POST)
    public @ResponseBody List<Map<String,String>> learnStatsGraph5(StatsVO stats) throws Exception {
    	// 로그인 정보를 저장한다.
    	stats.setLoginUser((MemberVO)LoginHelper.getLoginInfo());
    	
		// 결과 리스트를 저장
		return statsService.learnStatsGraph5(stats);
    }
    
    /**
     * 연수설문통계
     */
    @RequestMapping(value = "/surveyStatsList", method = RequestMethod.POST)
    public @ResponseBody DataList<SurveyVO> surveyStatsList(SurveyVO survey) throws Exception {
    	DataList<SurveyVO> result = new DataList<SurveyVO>();
    	
    	result.setPagingYn(survey.getPagingYn());
    	
    	// 페이징 처리인 경우만 페이지 번호와 토탈 갯수를 저장한다.
		if(result.getPagingYn().equals("Y")) {
			result.setNumOfNums(survey.getNumOfNums());
			result.setNumOfRows(survey.getNumOfRows());
			result.setPageNo(survey.getPageNo());
			result.setTotalCount(boardService.surveyTotalCnt(survey));
		}

		// 결과 리스트를 저장
		result.setList(boardService.surveyList(survey));

		return result;
    }
    
    /**
     * 연수설문통계 상세 
     */
    @RequestMapping(value="/surveyStatsDetail", method = RequestMethod.POST)
    public @ResponseBody DataList<Map<String,String>> surveyStatsDetail(@ModelAttribute("search") StatsVO stats) throws Exception {
    	DataList<Map<String,String>> result = new DataList<Map<String,String>>();
    	
    	// 로그인 정보를 저장한다. 
    	//stats.setLoginUser((MemberVO)LoginHelper.getLoginInfo());

		// 결과 리스트를 저장
		result.setList(statsService.surveyStatsDetailList(stats));

		return result;
    }
    
    /**
     * 연수만족도통계 > 기수의 과정 만족도 상위Top5
     */
    @RequestMapping(value="/satisByCourseTop5", method = RequestMethod.POST)
    public @ResponseBody List<Map<String,String>> satisByCourseTop5(@ModelAttribute("search") StatsVO stats) throws Exception {
		return statsService.satisByCourseTop5(stats);
    } 
    
    /**
     * 연수만족도통계 > 기수 만족도분포
     */
    @RequestMapping(value="/satisByCardinal", method = RequestMethod.POST)
    public @ResponseBody List<Map<String,String>> satisByCardinal(@ModelAttribute("search") StatsVO stats) throws Exception {
		return statsService.satisByCardinal(stats);
    }
    
    /**
     * 연수만족도통계 > 설문자 연령분포 
     */
    @RequestMapping(value="/satisByAgeGroup", method = RequestMethod.POST)
    public @ResponseBody Map<String,String> satisByAgeGroup(@ModelAttribute("search") StatsVO stats) throws Exception {
		return statsService.satisByAgeGroup(stats);
    }
    
    /**
     * 연수만족도통계 > 학교구분에 따른 만족도 통계
     */
    @RequestMapping(value="/satisByClassType", method = RequestMethod.POST)
    public @ResponseBody List<Map<String,String>> satisByClassType(@ModelAttribute("search") StatsVO stats) throws Exception {
		return statsService.satisByClassType(stats);
    }
    
    /**
     * 문자발송통계
     */
    @RequestMapping(value = "/smsHistoryStats", method = RequestMethod.POST)
    public @ResponseBody DataList<Map<String,String>> smsHistoryStats(@ModelAttribute("search") StatsVO stats) throws Exception {
    	DataList<Map<String,String>> result = new DataList<Map<String,String>>();
    	
    	result.setPagingYn(stats.getPagingYn());
    	
    	// 페이징 처리인 경우만 페이지 번호와 토탈 갯수를 저장한다.
		if(result.getPagingYn().equals("Y")) {
			result.setNumOfNums(stats.getNumOfNums());
			result.setNumOfRows(stats.getNumOfRows());
			result.setPageNo(stats.getPageNo());
			result.setTotalCount(statsService.smsHistoryTotalCnt(stats));
		}

		// 결과 리스트를 저장
		result.setList(statsService.smsHistoryStats(stats));

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