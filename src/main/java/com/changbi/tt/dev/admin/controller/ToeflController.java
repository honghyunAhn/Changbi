package com.changbi.tt.dev.admin.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.changbi.tt.dev.data.service.ToeflService;
import com.changbi.tt.dev.data.vo.ToeflPayVO;
import com.changbi.tt.dev.data.vo.ToeflVO;

@Controller(value="admin.toeflController")
@RequestMapping("/admin/toefl")
public class ToeflController {
	
	//로그 객체
	private static final Logger logger = LoggerFactory.getLogger(ToeflController.class);
	
	@Autowired
	private ToeflService toeflService;
	
	@RequestMapping(value="/toeflList", method=RequestMethod.POST)
   	public void toeflList(@ModelAttribute(value = "search") ToeflVO vo, ModelMap model) throws Exception {
		logger.debug("모의토플 서비스 리스트 이동 컨트롤러 시작");
		
		logger.debug("모의토플 서비스 리스트 이동 컨트롤러 종료");
   	}
	@RequestMapping(value="/toeflEdit", method=RequestMethod.POST)
   	public void toeflEdit(ToeflVO vo, ModelMap model) throws Exception {
		logger.debug("모의토플 서비스 상세페이지 이동 컨트롤러 시작");
		
		model.addAttribute("search", vo);
		if(vo.getId() != 0) {
			model.addAttribute("toeflDetail", toeflService.selectToeflList(vo).get(0));
		}
		
		logger.debug("모의토플 서비스 상세페이지 이동 컨트롤러 종료");
   	}
	@RequestMapping(value="/toeflPayList", method=RequestMethod.POST)
   	public void toeflPayList(ToeflPayVO vo, ModelMap model) throws Exception {
		logger.debug("모의토플 서비스 결제 페이지 이동 컨트롤러 시작");
		
		model.addAttribute("search", vo);
		if(vo.getPay_toefl_seq() != 0) {
			model.addAttribute("toeflPayDetail", toeflService.selectToeflPayList(vo).get(0));
		}
		
		logger.debug("모의토플 서비스 결제 페이지 이동 컨트롤러 종료");
   	}
}
