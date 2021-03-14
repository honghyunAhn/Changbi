package com.lms.student.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.changbi.tt.dev.data.service.LearnAppService;
import com.changbi.tt.dev.data.service.MemberService;
import com.changbi.tt.dev.data.vo.CardinalVO;
import com.changbi.tt.dev.data.vo.LearnAppVO;
import com.changbi.tt.dev.data.vo.UserVO;
import com.google.gson.Gson;
import com.lms.student.service.ApplyService;
import com.lms.student.service.StudentTbService;
import com.lms.student.service.surveyService;
import com.lms.student.vo.ApplyVO;
import com.lms.student.vo.CounselVO;
import com.lms.student.vo.StudentTbVO;
import com.lms.student.vo.SurveysVO;

@Controller(value="controller.StudentController")
@RequestMapping("/admin/studentManagement")
public class StudentController {

	@Autowired
	surveyService ss;
	
	@Autowired
	StudentTbService stuTbService;
	
	@Autowired
	private LearnAppService learnAppService;
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	ApplyService applyService;
	
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
	public void studentSurveyManagement(SurveysVO vo, ModelMap model) throws Exception {
		model.addAttribute("search", vo);
	}
	/**
	 * 설문조사 생성 페이지
	 */
	@RequestMapping(value="/studentSurveyCreate")
	public void studentSurveyCreate(SurveysVO vo, ModelMap model) throws Exception {
		model.addAttribute("search", vo);
	}
	/**
	 * 자동배포 설문 리스트 조회 페이지
	 */
	@RequestMapping(value="/studentSurveyAuto")
	public void studentSurveyAuto(SurveysVO vo, ModelMap model) throws Exception {
		model.addAttribute("search", vo);
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
	 * 상담작성 페이지
	 */
	@RequestMapping(value="/studentCounselCreate")
	public void studentCounselCreate(CounselVO counsel, ModelMap model) throws Exception {
		model.addAttribute("search", counsel);
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
	public void studentCounselManagement(CounselVO vo, ModelMap model) throws Exception {
		model.addAttribute("search", vo);
	}
	
	@RequestMapping(value="/studentSurveyDetail")
	public void studentSurveyDetail(@RequestParam HashMap<String, Object> obj, ModelMap model) throws Exception {
		Gson gson = new Gson();
		SurveysVO search = gson.fromJson((String)obj.get("search"), SurveysVO.class);
		SurveysVO vo = gson.fromJson((String)obj.get("data"), SurveysVO.class);
		String page = vo.getPage();
		
		switch(page){
		case "survey" : //일반설문 통계 : 일반설문조사 리스트 페이지에서 이동해 온 경우
			model.addAttribute("info", ss.selectSurveyInfo(vo));
			break;
		case "course" : //자동설문 과정별 통계 : 과정상세 페이지에서 이동해 온 경우
		case "auto" : 	//자동설문 과정별 통계 : 자동배포 설문목록 페이지에서 이동해 온 경우
		case "gisu" : 	//자동설문 기수별 통계 : 자동배포 설문목록 페이지에서 이동해 온 경우
			model.addAttribute("info", ss.selectAutoSurveyInfo(vo));
		}
		model.addAttribute("detail", gson.toJson(ss.selectSurveyResult(vo)));
		model.addAttribute("page", page);
		model.addAttribute("search", search);
	}
	
	@RequestMapping(value="/studentSurveyModify")
	public void studentSurveyModify(@RequestParam HashMap<String, Object> obj, ModelMap model) throws Exception {
		Gson gson = new Gson();
		SurveysVO search = gson.fromJson((String)obj.get("search"), SurveysVO.class);
		SurveysVO vo = gson.fromJson((String)obj.get("data"), SurveysVO.class);
		
		model.addAttribute("survey", gson.toJson(ss.selectSurveyDetail(vo.getSurvey_seq())));
		model.addAttribute("search", search);
	}
	
	/**
	 * 학적부 관리 리스트 조회 페이지
	 */
	@RequestMapping(value="/studentTableManagement")
	public void studentTableManagement(@ModelAttribute("search") StudentTbVO stuTb, ModelMap model) throws Exception {
		List<StudentTbVO> result = stuTbService.selectStuTable_List(stuTb);
		model.addAttribute("stuTableList", result);
	}
	
	@ResponseBody
	@RequestMapping(value="/studentTableList", method = RequestMethod.POST)
	public Object studentTableManagementAjax(@ModelAttribute("search") StudentTbVO stuTb, ModelMap model) throws Exception {
		stuTb.setPagingYn("N");
		List<StudentTbVO> result = stuTbService.selectStuTable_List(stuTb);
		return result;
	}
	
	@RequestMapping(value="/studentTableDetail")
	public void studentTableDetail(StudentTbVO stuTb, ModelMap model) throws Exception {
		
		//자기자신의 검색조건 저장
		model.addAttribute("search", stuTb);
		
		List<StudentTbVO> list = stuTbService.selectStuTable_List(stuTb);
		HashMap<String, Object> detail = stuTbService.selectStudentTb_detail(stuTb);
		List<HashMap<String, Object>> benefit = stuTbService.selectBenefitCode();
		
		Gson gson = new Gson();
		model.addAttribute("basic", gson.toJson(list.get(0)));
		model.addAttribute("detail", gson.toJson(detail));
		model.addAttribute("benefit", gson.toJson(benefit));
	}
	
	@RequestMapping(value="/studentTableModify")
	public void studentTableModify(StudentTbVO stuTb, ModelMap model) throws Exception {
		
		//자기자신의 검색조건 저장
		model.addAttribute("search", stuTb);
		
		List<StudentTbVO> list = stuTbService.selectStuTable_List(stuTb);
		HashMap<String, Object> detail = stuTbService.selectStudentTb_detail(stuTb);
		List<HashMap<String, Object>> benefit = stuTbService.selectBenefitCode();
		
		Gson gson = new Gson();
		model.addAttribute("basic", gson.toJson(list.get(0)));
		model.addAttribute("detail", gson.toJson(detail));
		model.addAttribute("benefit", gson.toJson(benefit));
	}
	
	@RequestMapping(value="/studentTableUpdate")
	public void studentTableUpdate(String stu_seq, ModelMap model) throws Exception {
		model.addAttribute("stu_seq", stu_seq);
	}
	
	@RequestMapping(value = "/print_stuInfo", method = RequestMethod.POST)
	public String printStuInfo(String[] stu_seq, StudentTbVO stuTb, Model model) throws Exception {
		ArrayList<StudentTbVO> stuFormBasicList = new ArrayList<>();
		ArrayList<HashMap<String, Object>> stuFormDetailList = new ArrayList<HashMap<String,Object>>();
		
		for(int i = 0; i < stu_seq.length; i++) {
			StudentTbVO stu = new StudentTbVO();
			stu.setStu_seq(Integer.parseInt(stu_seq[i]));
			
			List<StudentTbVO> list = stuTbService.selectStuTable_List(stu);
			HashMap<String, Object> stuForm = stuTbService.selectStudentTb_detail(stu);
			stuFormBasicList.add(list.get(0));
			stuFormDetailList.add(stuForm);
		}
		
		List<StudentTbVO> list = stuTbService.selectStuTable_List(stuTb);
		HashMap<String, Object> detail = stuTbService.selectStudentTb_detail(stuTb);
		
		Gson gson = new Gson();
		model.addAttribute("basic", gson.toJson(list.get(0)));
		model.addAttribute("detail", gson.toJson(detail));
		model.addAttribute("stuFormBasicList", gson.toJson(stuFormBasicList));
		model.addAttribute("stuFormDetailList", gson.toJson(stuFormDetailList));
		return "/admin/studentManagement/studentTablePrint";
	}
	
	@RequestMapping(value = "/print_trainingCertificate", method = RequestMethod.POST)
	public String printTrainingCertificate (String[] cardinal_id,String[] user_id, Model model) {
		ArrayList<HashMap<String, Object>> learnAppList = new ArrayList<>();
		ArrayList<UserVO> userList = new ArrayList<>();
		
		
		for(int i=0; i < user_id.length; i++) {
			LearnAppVO info = new LearnAppVO();
			
			CardinalVO cardinal = new CardinalVO();
			cardinal.setId(cardinal_id[i]);
			info.setCardinal(cardinal);;
			
			UserVO user = new UserVO();
			user.setId(user_id[i]);
			info.setUser(user);
			
			HashMap<String, Object> appResult = new HashMap<String, Object>();
			UserVO userResult = new UserVO();
			try {
				appResult = learnAppService.learnAppInfoForCertificate(info);
				userResult = memberService.memberInfo(info.getUser());
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			learnAppList.add(appResult);
			userList.add(userResult);
		}
		
		Gson gson = new Gson();
		model.addAttribute("certificateInfo", gson.toJson(learnAppList));
		model.addAttribute("userInfo", gson.toJson(userList));
		return "/admin/studentManagement/trainingCertificate";
	}
	/**
	 * 지원자 리스트 조회 페이지
	 */
	@RequestMapping(value="/applyManagement")
	public void applyManagement(ApplyVO apply, Model model) throws Exception {
		model.addAttribute("search", apply);
	}
}
