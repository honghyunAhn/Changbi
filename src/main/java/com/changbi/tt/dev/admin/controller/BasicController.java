/**
 * Admin 화면 호출 Controller
 * admin Home은 세션 객체 생성 때문에 HomeController에 공통으로 넣지 않았음.
 * 세션 생성이 필요한 경우에는 따로 Contoller를 만들어서 사용하면 좋겠음.
 * 같은 세션인 경우는 HomeController에 공통으로 넣어도 됨.
 * @author : 김준석(2015-06-03)
 */

package com.changbi.tt.dev.admin.controller;

import java.util.ArrayList;
import java.util.HashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.changbi.tt.dev.data.service.BasicService;
import com.changbi.tt.dev.data.vo.BannerVO;
import com.changbi.tt.dev.data.vo.EventVO;
import com.changbi.tt.dev.data.vo.InfoVO;
import com.changbi.tt.dev.data.vo.IpAddressVO;
import com.changbi.tt.dev.data.vo.PolicyDelayCancelVO;
import com.changbi.tt.dev.data.vo.PolicyPointVO;
import com.changbi.tt.dev.data.vo.SchoolVO;
import com.changbi.tt.dev.data.vo.ComCodeGroupVO;

import forFaith.dev.service.BaseService;
import forFaith.dev.vo.CodeVO;

@Controller(value="admin.basicController")      // Controller value는 중복되면 안된다. value 값을 지정하지 않으면 클래스명이 value가 되므로 같은 클래스명이 존재하면 중복으로 인식
@RequestMapping("/admin/basic")       // 해당 클래스를 호출 하기 위한 Mapping 기본 값 뒤에 붙는 값에 의해 필요한 함수가 호출 된다.
public class BasicController {

    /**
     * log를 남기는 객체 생성
     * @author : 김준석(2015-06-03)
     */
    private static final Logger logger = LoggerFactory.getLogger(BasicController.class);

    @Autowired
	private BasicService basicService;
    
    @Autowired
	private BaseService baseService;
    
    /**
     * 학교정보 리스트 페이지
     * @throws Exception 
     */
    @RequestMapping(value="/schoolList")
    public void schoolList(@ModelAttribute("search") SchoolVO school, ModelMap model) throws Exception {
    	
    	// 지역코드 리스트
    	CodeVO code = new CodeVO();
    	code.getCodeGroup().setId("region");
    	code.setUseYn("Y");
    	code.setPagingYn("N");
    	model.addAttribute("region", baseService.codeList(code));
    }

    /**
     * 학교정보 편집 페이지
     * @throws Exception
     */
    @RequestMapping(value="/schoolEdit")
    public void schoolEdit(SchoolVO school, ModelMap model) throws Exception {
        if(school != null && school.getId() >  0) {
            // 선택 된 ID가 없으면 바로 edit 화면으로 이동하고 선택 된 ID가 있으면 해당 정보를 가지고 간다.
            model.addAttribute("school", basicService.schoolInfo(school));
        }

        // 지역코드 리스트
        CodeVO code = new CodeVO();
    	code.getCodeGroup().setId("region");
    	code.setUseYn("Y");
    	code.setPagingYn("N");
    	model.addAttribute("region", baseService.codeList(code));
        
        // 검색 조건 저장(리스트 페이지로 이동 시 검색 조건을 그대로 유지하기 위해)
        model.addAttribute("search", school);
        
    }
    
    /**
     * 연수자 IP 관리 페이지
     */
    @RequestMapping(value="/ipList")
    public void ipList(@ModelAttribute("search") IpAddressVO ipAddress, ModelMap model) throws Exception {}
    
    /**
     * 연수자 IP 상세 관리 페이지 
     */
    @RequestMapping(value="/ipInfoEdit")
    public void ipInfoEdit(@ModelAttribute("search") IpAddressVO ipAddress, ModelMap model) throws Exception {
        if(ipAddress != null && ipAddress.getUser().getId() != "") {
            // 선택 된 ID가 없으면 바로 edit 화면으로 이동하고 선택 된 ID가 있으면 해당 정보를 가지고 간다.
            model.addAttribute("ipInfoList", basicService.ipInfoList(ipAddress));
        }
        // 검색 조건 저장(리스트 페이지로 이동 시 검색 조건을 그대로 유지하기 위해)
        model.addAttribute("search", ipAddress);
    }
    
    /**
     * 포인트 정책 관리 페이지
     * @throws Exception 
     */
    @RequestMapping(value="/policyPointEdit")
    public void policyPointEdit(ModelMap model) throws Exception {
    	PolicyPointVO policyPoint = new PolicyPointVO();
    	policyPoint = basicService.policyPointInfo();
    	model.addAttribute("policyPoint", policyPoint);
    	
    }
    
    /**
     * 수강 연기/취소 정책 관리 페이지
     * @throws Exception 
     */
    @RequestMapping(value="/policyDelayCancelEdit")
    public void policyDelayCancelEdit(@ModelAttribute("search") PolicyDelayCancelVO policyDelayCancel, ModelMap model) throws Exception {
    	model.addAttribute("policyDelayCancel", basicService.policyDelayCancelInfo(policyDelayCancel));
    }
    
    /**
     * 이벤트 관리 페이지
     * @throws Exception 
     */
    @RequestMapping(value="/eventList")
    public void eventList(@ModelAttribute("search") EventVO event, ModelMap model) throws Exception {

    }
    
    /**
     * 이벤트 편집 페이지
     * @throws Exception
     */
    @RequestMapping(value="/eventEdit")
    public void eventEdit(EventVO event, ModelMap model) throws Exception {
        if(event != null && event.getId() > 0) {
            // 선택 된 ID가 없으면 바로 edit 화면으로 이동하고 선택 된 ID가 있으면 해당 정보를 가지고 간다.
            model.addAttribute("event", basicService.eventInfo(event));
        }
        
        // 검색 조건 저장(리스트 페이지로 이동 시 검색 조건을 그대로 유지하기 위해)
        model.addAttribute("search", event);
    }
    
    /**
     * 배너 관리 페이지
     * @throws Exception 
     */
    @RequestMapping(value="/bannerManagement")
    public void bannerList(ModelMap model) throws Exception {
    	logger.debug("배너 관리 이동 컨트롤러 시작");
    	ArrayList<String> bannerNames = basicService.bannerNames();
    	logger.debug("배너 이름" + bannerNames);
    	model.addAttribute("bannerNames", bannerNames);
		logger.debug("배너 상담 관리 이동 컨트롤러 종료");
    }    
    
    @RequestMapping(value="/bannerList")
    public void bannerList(@ModelAttribute("search") BannerVO banner, ModelMap model) throws Exception {

    }
    
    /**
     * 배너 편집 페이지
     * @throws Exception
     */
    @RequestMapping(value="/bannerEdit")
    public void bannerEdit(BannerVO banner, ModelMap model) throws Exception {
        if(banner != null && banner.getId() > 0) {
            // 선택 된 ID가 없으면 바로 edit 화면으로 이동하고 선택 된 ID가 있으면 해당 정보를 가지고 간다.
            model.addAttribute("banner", basicService.bannerInfo(banner));
        }
        
        // 검색 조건 저장(리스트 페이지로 이동 시 검색 조건을 그대로 유지하기 위해)
        model.addAttribute("search", banner);
    }
    
    /**
     * 안내페이지 관리 페이지
     * @throws Exception 
     */
    @RequestMapping(value="/infoList")
    public void infoList(@ModelAttribute("search") InfoVO info, ModelMap model) throws Exception {

    }
    
    /**
     * 안내페이지 등록(수정) 페이지
     * @throws Exception
     */
    @RequestMapping(value="/infoEdit")
    public void infoEdit(InfoVO info, ModelMap model) throws Exception {
        if(info != null && info.getId() > 0) {
            // 선택 된 ID가 없으면 바로 edit 화면으로 이동하고 선택 된 ID가 있으면 해당 정보를 가지고 간다.
            model.addAttribute("info", basicService.infoInfo(info));
        }
        
        // 검색 조건 저장(리스트 페이지로 이동 시 검색 조건을 그대로 유지하기 위해)
        model.addAttribute("search", info);
    }
    
    /**
     * 공통코드 관리 페이지
     * @throws Exception 
     */
    @RequestMapping(value="/comCode")
    public void comCode(ComCodeGroupVO code, ModelMap model) throws Exception {
    	model.addAttribute("search", code);
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