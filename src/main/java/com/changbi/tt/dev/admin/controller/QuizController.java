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
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.changbi.tt.dev.data.service.QuizService;
import com.changbi.tt.dev.data.vo.ExamSpotVO;
import com.changbi.tt.dev.data.vo.QuizBankVO;
import com.changbi.tt.dev.data.vo.QuizPoolVO;
import com.changbi.tt.dev.data.vo.QuizVO;
import com.changbi.tt.dev.data.vo.ReportVO;

import forFaith.util.StringUtil;

@Controller(value="admin.quizController")      // Controller value는 중복되면 안된다. value 값을 지정하지 않으면 클래스명이 value가 되므로 같은 클래스명이 존재하면 중복으로 인식
@RequestMapping("/admin/quiz")       // 해당 클래스를 호출 하기 위한 Mapping 기본 값 뒤에 붙는 값에 의해 필요한 함수가 호출 된다.
public class QuizController {

	@Autowired
	private QuizService quizService;
	
    /**
     * log를 남기는 객체 생성
     * @author : 김준석(2018-02-17)
     */
    private static final Logger logger = LoggerFactory.getLogger(QuizController.class);

    /**
     * 시험지 풀 관리 리스트
     * @param
     */
    @RequestMapping(value="/quizPoolList")
    public void quizPoolList(@ModelAttribute("search") QuizPoolVO quizPool) throws Exception {}
    
    /**
     * 시험지 풀 상세 조회 리스트
     * @param book
     * @param model
     * @throws Exception
     */
    @RequestMapping(value="/quizPoolEdit")
    public void quizPoolEdit(@ModelAttribute("search")QuizPoolVO quizPool, ModelMap model) throws Exception {
        if(quizPool != null && quizPool.getId() > 0) {
            // 선택 된 ID가 없으면 바로 edit 화면으로 이동하고 선택 된 ID가 있으면 해당 정보를 가지고 간다.
            model.addAttribute("quizPool", quizService.quizPoolInfo(quizPool));
        }
    }
    
    /**
     * 시험지 풀 미리보기
     * @param
     */
    @RequestMapping(value="/quizPreview")
    public void quizPreview(@ModelAttribute("search") QuizPoolVO quizPool, ModelMap model) throws Exception {
    	if(quizPool != null && quizPool.getId() > 0) {
            // 선택 된 ID가 없으면 바로 edit 화면으로 이동하고 선택 된 ID가 있으면 해당 정보를 가지고 간다.
            model.addAttribute("quizPool", quizService.quizPoolInfo(quizPool));
        }
    }
    
    /**
	 * 시험문제 리스트 조회(시험지 풀에 저장되기 때문에 시험지 풀 정보를 입력 받음)
	 */
	@RequestMapping(value="/quizItemList", method=RequestMethod.POST)
	public void quizItemList(@ModelAttribute("search")QuizPoolVO quizPool, ModelMap model) throws Exception {
		if(quizPool != null && quizPool.getId() > 0) {
            // 선택 된 ID가 없으면 바로 edit 화면으로 이동하고 선택 된 ID가 있으면 해당 정보를 가지고 간다.
    		model.addAttribute("quizPool", quizService.quizPoolInfo(quizPool));
        }
	}
    
    /**
     * 시험 관리 리스트
     * @param
     */
    @RequestMapping(value="/quizList")
    public void quizList(@ModelAttribute("search") QuizVO quiz) throws Exception {}
    
    /**
     * 시험상세 조회 리스트
     * @param book
     * @param model
     * @throws Exception
     */
    @RequestMapping(value="/quizEdit")
    public void quizEdit(@ModelAttribute("search") QuizVO quiz, ModelMap model) throws Exception {
        if(quiz != null && !StringUtil.isEmpty(quiz.getId())) {
            // 선택 된 ID가 없으면 바로 edit 화면으로 이동하고 선택 된 ID가 있으면 해당 정보를 가지고 간다.
            model.addAttribute("quiz", quizService.quizInfo(quiz));
        }
    }
	
	/**
     * 현황리스트
     * @param
     */
    @RequestMapping(value="/quizAppList")
    public void quizAppList(@ModelAttribute("search") QuizVO quiz) throws Exception {}
    
    /**
     * Report리스트
     * @param
     */
    @RequestMapping(value="/reportList")
    public void reportList(@ModelAttribute("search") QuizVO quiz, ModelMap model) throws Exception {
    	// report 정보를 생성한다.
    	ReportVO report = new ReportVO();
    	
    	report.setCardinal(quiz.getCardinal());
    	report.setCourse(quiz.getCourse());
    	report.setQuiz(quiz);
    	report.setQuizType(quiz.getQuizType());
    	
    	model.addAttribute("reportList", quizService.reportList(report));
    }
	
	/**
     * 문제은행 관리 리스트
     * @param
     */
    @RequestMapping(value="/quizBankList")
    public void quizBankList(@ModelAttribute("search") QuizBankVO quizBank) throws Exception {}
    
    /**
     * 문제은행 상세 조회 리스트
     * @param book
     * @param model
     * @throws Exception
     */
    @RequestMapping(value="/quizBankEdit")
    public void quizBankEdit(QuizBankVO quizBank, ModelMap model) throws Exception {
        if(quizBank != null && quizBank.getId() > 0) {
            // 선택 된 ID가 없으면 바로 edit 화면으로 이동하고 선택 된 ID가 있으면 해당 정보를 가지고 간다.
            model.addAttribute("quizBank", quizService.quizBankInfo(quizBank));
        }

        // 검색 조건 저장(리스트 페이지로 이동 시 검색 조건을 그대로 유지하기 위해)
        model.addAttribute("search", quizBank);
    }
    
    /**
     * 출석평가 고사장 관리 리스트
     * @param
     */
    @RequestMapping(value="/examSpotList")
    public void examSpotList(@ModelAttribute("search") ExamSpotVO examSpot) throws Exception {}
    
    /**
     * 시험상세 조회 리스트
     * @param book
     * @param model
     * @throws Exception
     */
    @RequestMapping(value="/examSpotEdit")
    public void examSpotEdit(ExamSpotVO examSpot, ModelMap model) throws Exception {
        if(examSpot != null && !StringUtil.isEmpty(examSpot.getId())) {
            // 선택 된 ID가 없으면 바로 edit 화면으로 이동하고 선택 된 ID가 있으면 해당 정보를 가지고 간다.
            model.addAttribute("examSpot", quizService.examSpotInfo(examSpot));
        }

        // 검색 조건 저장(리스트 페이지로 이동 시 검색 조건을 그대로 유지하기 위해)
        model.addAttribute("search", examSpot);
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