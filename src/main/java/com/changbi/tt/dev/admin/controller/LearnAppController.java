package com.changbi.tt.dev.admin.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.changbi.tt.dev.data.service.BasicService;
import com.changbi.tt.dev.data.service.CourseService;
import com.changbi.tt.dev.data.service.LearnAppService;
import com.changbi.tt.dev.data.service.MemberService;
import com.changbi.tt.dev.data.vo.EduUserPayVO;
import com.changbi.tt.dev.data.vo.EduUserRefundVO;
import com.changbi.tt.dev.data.vo.GroupLearnVO;
import com.changbi.tt.dev.data.vo.LearnAppVO;
import com.changbi.tt.dev.data.vo.LearnCancelVO;
import com.changbi.tt.dev.data.vo.LearnChangeVO;
import com.changbi.tt.dev.data.vo.LearnDelayVO;
import com.changbi.tt.dev.data.vo.PolicyPointVO;
import com.changbi.tt.dev.data.vo.StatsVO;
import com.changbi.tt.dev.data.vo.UserVO;

import forFaith.dev.service.BaseService;
import forFaith.dev.vo.CodeVO;
import forFaith.util.AESEncryptor;
import forFaith.util.StringUtil;

// Controller value는 중복되면 안된다. value 값을 지정하지 않으면 클래스명이 value가 되므로 같은 클래스명이 존재하면 중복으로 인식
@Controller(value="admin.learnAppController")
// 해당 클래스를 호출 하기 위한 Mapping 기본 값 뒤에 붙는 값에 의해 필요한 함수가 호출 된다.
@RequestMapping("/admin/learnApp")
public class LearnAppController {

	@Autowired
	private BaseService baseService;
	
	@Autowired
	private LearnAppService learnAppService;
	
	@Autowired
	private BasicService basicService;
	
	@Autowired
	private CourseService courseService;
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private AESEncryptor aesEncryptor;
	
    /**
     * log를 남기는 객체 생성
     * @author : 김준석(2018-02-17)
     */
    private static final Logger logger = LoggerFactory.getLogger(LearnAppController.class);

    /**
     * 연수 신청 관리 리스트 조회 페이지
     */
    @RequestMapping(value="/learnAppList")
    public void learnAppList(@ModelAttribute("search") LearnAppVO learnApp, ModelMap model) throws Exception {
        // 단체인 경우 단체리스트 조회
        if(!StringUtil.isEmpty(learnApp.getGroupLearnYn()) && learnApp.getGroupLearnYn().equals("Y")) {
			GroupLearnVO groupLearn = new GroupLearnVO();
			groupLearn.setUseYn("Y");
			groupLearn.setPagingYn("N");
	        
	        model.addAttribute("groupLearnList", courseService.groupLearnList(groupLearn));
        }
    }
    
    /**
     * 연수신청 상세 조회 페이지
     */
    @RequestMapping(value="/learnAppEdit")
    public void learnAppEdit(LearnAppVO learnApp, ModelMap model) throws Exception {
    	
    	logger.debug("LeanApp Edit LearnApp Check : " + learnApp.toString());
    	logger.debug("LearnApp Edit LearnApp Pay Seq Check : " + learnApp.getPay());
    	if(learnApp != null && !StringUtil.isEmpty(learnApp.getId())) {
    		 
    		LearnAppVO temp = learnAppService.learnAppInfo(learnApp);
    		boolean flag = true;
    		if(learnApp.getEdu() != null) flag = learnApp.getEdu().getPay_user_seq().equals("");

    		if(!flag) {
    			EduUserRefundVO refund = learnAppService.getRefundInfo(learnApp.getEdu().getPay_user_seq());
    			EduUserPayVO pay = learnAppService.getEduUserPayInfo(learnApp.getEdu().getPay_user_seq());
    			
    			if(refund != null) {
    				logger.debug("Refund Check : " + refund.toString());
    				refund.setPay_refund_accnum(aesEncryptor.decrypt(refund.getPay_refund_accnum()));
    				model.addAttribute("refundInfo", refund);
    			}
    			if(pay != null) {
    				logger.debug("PayInfo Check : " + pay.toString());
    				model.addAttribute("payInfo", pay);
    			}
    		} else {
    			System.out.println("Refund 내용이 없습니다.");
    		}
    		
    		
    		// 실 납입금액 가져오기    		     	    	 
    		LearnAppVO priceParam = new LearnAppVO();
    		 
    		priceParam.setUser(temp.getUser());    		 
    		priceParam.setPay(learnApp.getPay());
    		priceParam.setId(temp.getId());
    		priceParam.setPaymentDate(temp.getPaymentDate());
    		
    		 

    		// 선택 된 ID가 없으면 바로 edit 화면으로 이동하고 선택 된 ID가 있으면 해당 정보를 가지고 간다.
    		model.addAttribute("learnApp", temp);    	
    		
    		// 결제완료인 경우에만 처리
    		if(temp.getPaymentState().equals("2")) {
    			// PC용만 데이터 불러온다.
    			temp.setServiceType("P");
    			
    			// 기수별 과정별로 수강이력 토탈(총 챕터리스트로 가지고 온다.)
                model.addAttribute("attLecTotalList", learnAppService.attLecList(temp));
                
                // 기수별 과정별 사용자별 수강이력
                temp.setAttLecType("P");
                model.addAttribute("attLecList", learnAppService.attLecList(temp));
                
                ;
                
    		}
        }

        // 검색 조건 저장(리스트 페이지로 이동 시 검색 조건을 그대로 유지하기 위해)
        model.addAttribute("search", learnApp);
        
        // 시도교육청 코드테이블 가져오기
        CodeVO code = new CodeVO();
        code.setUseYn("Y");
        code.setPagingYn("N");
        code.getCodeGroup().setId("region");
        
        model.addAttribute("region", baseService.codeList(code));
        
        // 포인트 정책 가지고 오기
        PolicyPointVO policyPoint = new PolicyPointVO();
        policyPoint.setId(1);
        
        //model.addAttribute("policyPoint", basicService.policyPointInfo(policyPoint));
        model.addAttribute("policyPoint", basicService.policyPointInfo());
    }
    
    /**
     * 수강관리 리스트 조회 페이지
     */
    @RequestMapping(value="/learnManList")
    public void learnManList(@ModelAttribute("search") LearnAppVO learnApp, ModelMap model) throws Exception {
    	// 시도교육청 코드테이블 가져오기
        CodeVO code = new CodeVO();
        code.setUseYn("Y");
        code.setPagingYn("N");
        code.getCodeGroup().setId("region");
        
        model.addAttribute("region", baseService.codeList(code));
    }
    
    /**
     * 수강변경관리 리스트 조회 페이지
     */
    @RequestMapping(value="/learnChangeList")
    public void learnChangeList(@ModelAttribute("search") LearnChangeVO learnChange) throws Exception {}
    
    /**
     * 수강연기관리 리스트 조회 페이지
     */
    @RequestMapping(value="/learnDelayList")
    public void learnDelayList(@ModelAttribute("search") LearnDelayVO learnDelay) throws Exception {}
    
    /**
     * 수강취소관리 리스트 조회 페이지
     */
    @RequestMapping(value="/learnCancelList")
    public void learnCancelList(@ModelAttribute("search") LearnCancelVO learnCancel) throws Exception {}
    
    /**
     * 첨삭이력 조회 통계
     */
    @RequestMapping(value="/activeList")
    public void activeList(@ModelAttribute("search") StatsVO stats) throws Exception {}
 
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
    
    /**
     * 입과처리
     */
    @RequestMapping(value="/learnAppInsert")
    public void learnAppReg(@ModelAttribute("search") UserVO user, ModelMap model) throws Exception {}
    
}