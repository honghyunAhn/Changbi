package com.changbi.tt.dev.admin.controller;

import java.util.ArrayList;
import java.util.List;

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

import com.changbi.tt.dev.data.service.BoardService;
import com.changbi.tt.dev.data.service.CourseService;
import com.changbi.tt.dev.data.vo.CardinalVO;
import com.changbi.tt.dev.data.vo.CourseVO;
import com.changbi.tt.dev.data.vo.GroupLearnVO;
import com.changbi.tt.dev.data.vo.PaymentAdminVO;
import com.changbi.tt.dev.data.vo.SurveyVO;

import forFaith.dev.service.BaseService;
import forFaith.dev.vo.CodeVO;
import forFaith.dev.vo.MemberVO;
import forFaith.util.StringUtil;

@Controller(value="admin.courseController")      // Controller value는 중복되면 안된다. value 값을 지정하지 않으면 클래스명이 value가 되므로 같은 클래스명이 존재하면 중복으로 인식
@RequestMapping("/admin/course")       // 해당 클래스를 호출 하기 위한 Mapping 기본 값 뒤에 붙는 값에 의해 필요한 함수가 호출 된다.
public class CourseController {

	@Autowired
	private BaseService baseService;
	
	@Autowired
	private CourseService courseService;
	
	@Autowired
	private BoardService boardService;
	
    /**
     * log를 남기는 객체 생성
     * @author : 김준석(2018-02-17)
     */
    private static final Logger logger = LoggerFactory.getLogger(CourseController.class);

    
    /**
   	 * 대분류 등록 페이지 호출
   	 */
   	@RequestMapping(value="/subCourse", method=RequestMethod.POST)
   	public void subCourse(CodeVO code, ModelMap model) throws Exception {
           // 코드분류그룹 조회
   		
   		   /*상수*/	
   		
           //model.addAttribute("codeGroup", baseService.codeGroupInfo(code.getCodeGroup()));               
   	}
    
    /**
	 * 학습영역 등록 페이지 호출
	 */
	@RequestMapping(value="/studyRange", method=RequestMethod.POST)
	public void studyRange(CodeVO code, ModelMap model) throws Exception {
        // 코드분류그룹 조회
        model.addAttribute("codeGroup", baseService.codeGroupInfo(code.getCodeGroup()));
        //대분류코드 리스트 가져오기 
        code.getCodeGroup().setId("sub_course");
        model.addAttribute("subCourseList", baseService.codeList(code));
	}
    
    @RequestMapping(value="/trainProcessList")
    public void trainProcessList(@ModelAttribute("search") CourseVO course, ModelMap model) throws Exception {
    	
    	//대분류코드 리스트 가져오기
        CodeVO code = new CodeVO();
        code.setUseYn("Y");
        code.setPagingYn("N");
        code.getCodeGroup().setId("categorysequence");
        List<CodeVO> subCourseList = baseService.codeList(code);
        model.addAttribute("subCourseList", subCourseList);
        
               
        //학습영역 리스트 가져오기
        CodeVO code2 = new CodeVO();
        code2.setUseYn("Y");
        code2.setPagingYn("N");
        code2.getCodeGroup().setId("categorysequence");
        List<CodeVO> courseList = baseService.codeList(code2);
        model.addAttribute("courseList", courseList);
       
                       
    	// 결과 리스트를 저장
        List<CourseVO> trainProcessList = courseService.trainProcessList(course);
		model.addAttribute("trainProcessList", trainProcessList);        
        
        // 협력업체 리스트 가져오기
        MemberVO member = new MemberVO();
        member.setUseYn("Y");
        member.setPagingYn("N");
        member.setGrade(3);       
        model.addAttribute("companyList", baseService.memberList(member));
        
        // 강사 리스트 가져오기
        member.setGrade(2);
        model.addAttribute("teacherList", baseService.memberList(member));
    }
    
    @RequestMapping(value="/trainProcessEdit")
    public void trainProcessEdit(CourseVO course, ModelMap model) throws Exception {
    	CourseVO result = courseService.trainProcessInfo(course);
    	if(course != null && !StringUtil.isEmpty(course.getId()) && result != null) {
            // 선택 된 ID가 없으면 바로 edit 화면으로 이동하고 선택 된 ID가 있으면 해당 정보를 가지고 간다.
//    		model.addAttribute("course", courseService.trainProcessInfo(course));
//    		model.addAttribute("course", result);
    		//순서대로 2뎁스, 3뎁스 정보 가져오기
    		String cSearchCode ="";
    		String pSearchCode ="";
    		if(result.getSubCourseCode() != null) cSearchCode = result.getSubCourseCode().getCode();
    		if(result.getCourseCode() != null) pSearchCode = result.getCourseCode().getCode();
            //result값에 추가, model로 전송
            result.setCourseCode(baseService.codeInfoByString(pSearchCode));
            result.setSubCourseCode(baseService.codeInfoByString(cSearchCode));
            
            //분납 정보 가져오기
            List<CardinalVO> cardinalList = result.getCardinalList(); // 해당 과정에 매핑되어 있는 기수 리스트
            List<PaymentAdminVO> paymentList = courseService.selectPaymentAdminInfo(course);
            
            if(cardinalList != null && paymentList != null){
            	for(CardinalVO cardinal : cardinalList){
                	List<PaymentAdminVO> list = new ArrayList<>();
                	
                	for(PaymentAdminVO pmt : paymentList){
                		if(cardinal.getId().equals(pmt.getGisuId()))
                			list.add(pmt);
                	}
                	
                	if(list.isEmpty()){
                		PaymentAdminVO pmt = null;
                		list.add(pmt);
                	}
                	cardinal.setPaymentList(list);
                }
            }
            model.addAttribute("course", result);
        // 검색 조건 저장(리스트 페이지로 이동 시 검색 조건을 그대로 유지하기 위해)
    	}
        model.addAttribute("search", course);

        // 협력업체 리스트 가져오기
        MemberVO member = new MemberVO();
        member.setUseYn("Y");
        member.setPagingYn("N");
        member.setGrade(3);
        model.addAttribute("companyList", baseService.memberList(member));
        
        // 강사 리스트 가져오기
        member.setGrade(2);
        model.addAttribute("teacherList", baseService.memberList(member));
        
        // 교재업체 리스트 가져오기
        CodeVO code = new CodeVO();
        code.setUseYn("Y");
        code.setPagingYn("N");
        code.getCodeGroup().setId("categorysequence");
        model.addAttribute("publishList", baseService.codeList(code));
		
		
		 //대분류코드 리스트 가져오기  
        CodeVO code2 = new CodeVO();
        code2.setUseYn("Y");
        code2.setPagingYn("N");
        code2.getCodeGroup().setId("categorysequence");
        
        // 과정분류 리스트 가져오기
        CodeVO code3 = new CodeVO();
        code3.setUseYn("Y");
        code3.setPagingYn("N");
        code3.getCodeGroup().setId("categorysequence");
        model.addAttribute("courseList", baseService.codeList(code3));
        
    }
    
    /**
	 * 과정별 세부챕터 리스트 조회
	 */
	@RequestMapping(value="/chapterList", method=RequestMethod.POST)
	public void chapterList(@ModelAttribute("search") CourseVO course, ModelMap model) throws Exception {
		if(course != null && !StringUtil.isEmpty(course.getId())) {
            // 선택 된 ID가 없으면 바로 edit 화면으로 이동하고 선택 된 ID가 있으면 해당 정보를 가지고 간다.
    		model.addAttribute("course", courseService.trainProcessInfo(course));
        }
		
		// 교재업체 리스트 가져오기
        CodeVO code = new CodeVO();
        code.setUseYn("Y");
        code.setPagingYn("N");

        // 과정분류 리스트 가져오기
        code.getCodeGroup().setId("categorysequence");
        model.addAttribute("courseList", baseService.codeList(code));
	}
	
	@RequestMapping(value="/chapterListPort", method=RequestMethod.POST)
	public void chapterListPort(@ModelAttribute("search") CourseVO course, ModelMap model) throws Exception {
		if(course != null && !StringUtil.isEmpty(course.getId())) {
            // 선택 된 ID가 없으면 바로 edit 화면으로 이동하고 선택 된 ID가 있으면 해당 정보를 가지고 간다.
    		model.addAttribute("course", courseService.trainProcessInfo(course));
        }
		
		// 교재업체 리스트 가져오기
        CodeVO code = new CodeVO();
        code.setUseYn("Y");
        code.setPagingYn("N");

        // 과정분류 리스트 가져오기
        code.getCodeGroup().setId("categorysequence");
        model.addAttribute("courseList", baseService.codeList(code));
	}
    
    /**
     * 기수 리스트 조회 페이지
     * @param course
     */
    @RequestMapping(value="/cardinalList")
    public void cardinalList(@ModelAttribute("search") CardinalVO cardinal) {}
    
    /**
     * 기수 상세 조회 페이지
     * @param course
     * @param model
     * @throws Exception
     */
    @RequestMapping(value="/cardinalEdit")
    public void cardinalEdit(CardinalVO cardinal, ModelMap model) throws Exception {
    	if(cardinal != null && !StringUtil.isEmpty(cardinal.getId())) {
            // 선택 된 ID가 없으면 바로 edit 화면으로 이동하고 선택 된 ID가 있으면 해당 정보를 가지고 간다.
    		model.addAttribute("cardinal", courseService.cardinalInfo(cardinal));
        }

        // 검색 조건 저장(리스트 페이지로 이동 시 검색 조건을 그대로 유지하기 위해)
        model.addAttribute("search", cardinal);
        
        // 설문리스트 조회
        SurveyVO survey = new SurveyVO();
        CodeVO surveyCode = new CodeVO();
        
        survey.setUseYn("Y");
        survey.setPagingYn("N");
        survey.setSurveyCode(surveyCode);
        
        // 만족도 코드
        surveyCode.setCode("survey999");
        
        // 만족도 설문 리스트
        model.addAttribute("satisfactionList", boardService.surveyList(survey));
        
        // 강의평가 코드
        surveyCode.setCode("survey001");
        
        // 강의평가 설문 리스트
        model.addAttribute("evaluationList", boardService.surveyList(survey));
    }
    
    /**
     * 단체연수 리스트 조회 페이지
     * @param course
     */
    @RequestMapping(value="/groupLearnList")
    public void groupLearnList(@ModelAttribute("search") GroupLearnVO groupLearn, ModelMap model) throws Exception {
    	// 시도교육청 코드테이블 가져오기
        CodeVO code = new CodeVO();
        code.setUseYn("Y");
        code.setPagingYn("N");
        code.getCodeGroup().setId("region");
        
        model.addAttribute("region", baseService.codeList(code));
    }
    
    /**
     * 단체연수 상세 조회 페이지
     * @param course
     * @param model
     * @throws Exception
     */
    @RequestMapping(value="/groupLearnEdit")
    public void groupLearnEdit(GroupLearnVO groupLearn, ModelMap model) throws Exception {
    	if(groupLearn != null && !StringUtil.isEmpty(groupLearn.getId())) {
            // 선택 된 ID가 없으면 바로 edit 화면으로 이동하고 선택 된 ID가 있으면 해당 정보를 가지고 간다.
    		model.addAttribute("groupLearn", courseService.groupLearnInfo(groupLearn));
        }

        // 검색 조건 저장(리스트 페이지로 이동 시 검색 조건을 그대로 유지하기 위해)
        model.addAttribute("search", groupLearn);
        
        // 시도교육청 코드테이블 가져오기
        CodeVO code = new CodeVO();
        code.setUseYn("Y");
        code.setPagingYn("N");
        code.getCodeGroup().setId("region");
        
        model.addAttribute("region", baseService.codeList(code));
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