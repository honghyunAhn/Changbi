package com.changbi.tt.dev.admin.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.changbi.tt.dev.data.vo.StatsVO;

//@Controller(value="controller.StudentController")
//@RequestMapping("/admin/studentManagement")
public class StudentController {

	/**
	 * log를 남기는 객체 생성
	 * @author : 박종민(2020-05-25)
	 */
	private static final Logger logger = LoggerFactory.getLogger(StudentController.class);

	/**
	 * Exception 처리
	 * @param Exception
	 * @return ModelAndView
	 * @author : 박종민 - (2020-05-25)
	 */
	@ExceptionHandler(Exception.class)
	public ModelAndView exceptionHandler(Exception e) {
		logger.info(e.getMessage());

		return new ModelAndView("/error/exception").addObject("msg", e.getMessage());
	}


	/**
	 * 성적관리 리스트 조회 페이지
	 */
	@RequestMapping(value="/studentScoreManagement")
	public void studentScoreManagement(ModelMap model) throws Exception {


	}
	/**
	 * 성적입력 관리 페이지
	 */
	@RequestMapping(value="/studentScoreInsert")
	public void studentScorInsert(ModelMap model) throws Exception {


	}
	/**
	 * 성적수정 관리 페이지
	 */
	@RequestMapping(value="/studentScoreModification")
	public void studentScoreModification(ModelMap model) throws Exception {


	}

	/**
	 * 과제제출관리 리스트 조회 페이지
	 */
	@RequestMapping(value="/studentSubjectManagement")
	public void studentSubjectManagement(ModelMap model) throws Exception {


	}
	/**
	 * 과제생성 관리 페이지
	 */
	@RequestMapping(value="/studentSubjectCreate")
	public void studentSubjectCreate(ModelMap model) throws Exception {


	}
	/**
	 * 과제수정 관리 페이지
	 */
	@RequestMapping(value="/studentSubjectModification")
	public void studentSubjectModification(ModelMap model) throws Exception {


	}

	/**
	 * 출석관리 리스트 조회 페이지
	 */
	@RequestMapping(value="/studentAttendanceManagement")
	public void studentAttendanceManagement(ModelMap model) throws Exception {


	}

	/**
	 * 설문조사관리 리스트 조회 페이지
	 */
	@RequestMapping(value="/studentSurveyManagement")
	public void studentSurveyManagement(ModelMap model) throws Exception {


	}
	/**
	 * 설문조사 생성 페이지
	 */
	@RequestMapping(value="/studentSurveyCreate")
	public void studentSurveyCreate(ModelMap model) throws Exception {


	}	

	/**
	 * 상담신청내역 관리 리스트 조회 페이지
	 */
	@RequestMapping(value="/studentCounselApplication")
	public void studentCounselApplication(ModelMap model) throws Exception {


	}
	/**
	 * 상담완료내역 관리 리스트 조회 페이지
	 */
	@RequestMapping(value="/studentCounselComplete")
	public void studentCounselComplete(ModelMap model) throws Exception {


	}
	/**
	 * 상담완료내역 관리 리스트 조회 페이지
	 */
	@RequestMapping(value="/studentTestCreate")
	public void studentTestCreate(ModelMap model) throws Exception {


	}
	/**
	 * 상담완료내역 관리 리스트 조회 페이지
	 */
	@RequestMapping(value="/studentTestModification")
	public void studentTestModification(ModelMap model) throws Exception {


	}
	/**
	 * 상담완료내역 관리 리스트 조회 페이지
	 */
	@RequestMapping(value="/studentTestManagement")
	public void studentTestManagement(ModelMap model) throws Exception {


	}
	@RequestMapping(value="/studentCounselManagement")
	public void studentCounselManagement(ModelMap model) throws Exception {


	}

}
