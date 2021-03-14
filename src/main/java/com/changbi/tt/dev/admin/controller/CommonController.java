/**
 * Common Controller
 * @author : kjs(2016-10-10)
 */

package com.changbi.tt.dev.admin.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.aspectj.internal.lang.annotation.ajcDeclareAnnotation;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.openqa.selenium.json.Json;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.changbi.tt.dev.data.service.AttendanceService;
import com.changbi.tt.dev.data.service.BasicService;
import com.changbi.tt.dev.data.service.BoardService;
import com.changbi.tt.dev.data.service.LearnAppService;
import com.changbi.tt.dev.data.service.MailService;
import com.changbi.tt.dev.data.service.QuizService;
import com.changbi.tt.dev.data.service.SmsSendService;
import com.changbi.tt.dev.data.service.ToeflService;
import com.changbi.tt.dev.data.vo.AttendanceVO;
import com.changbi.tt.dev.data.vo.BoardVO;
import com.changbi.tt.dev.data.vo.ComCodeGroupVO;
import com.changbi.tt.dev.data.vo.CouponVO;
import com.changbi.tt.dev.data.vo.CourseVO;
import com.changbi.tt.dev.data.vo.DateAttendanceVO;
import com.changbi.tt.dev.data.vo.InfoAttendanceVO;
import com.changbi.tt.dev.data.vo.LearnAppVO;
import com.changbi.tt.dev.data.vo.MailVO;
import com.changbi.tt.dev.data.vo.PointVO;
import com.changbi.tt.dev.data.vo.QuizItemVO;
import com.changbi.tt.dev.data.vo.QuizPoolVO;
import com.changbi.tt.dev.data.vo.QuizVO;
import com.changbi.tt.dev.data.vo.ReportVO;
import com.changbi.tt.dev.data.vo.SchoolVO;
import com.changbi.tt.dev.data.vo.SmsVO;
import com.changbi.tt.dev.data.vo.SurveyItemVO;
import com.changbi.tt.dev.data.vo.TccVO;
import com.changbi.tt.dev.data.vo.ToeflPayVO;
import com.changbi.tt.dev.data.vo.UserVO;
import com.google.gson.Gson;
import com.lms.student.service.counselService;
import com.lms.student.service.surveyService;
import com.lms.student.vo.CounselVO;
import com.lms.student.vo.SurveysVO;

import forFaith.dev.service.BaseService;
import forFaith.dev.vo.CodeVO;
import forFaith.dev.vo.MemberVO;
import forFaith.dev.vo.SubChapVO;
import forFaith.util.DataList;

@Controller(value="admin.commonController")		// Controller value는 중복되면 안된다. value 값을 지정하지 않으면 클래스명이 value가 되므로 같은 클래스명이 존재하면 중복으로 인식
@RequestMapping("/admin/common")		// 해당 클래스를 호출 하기 위한 Mapping 기본 값 뒤에 붙는 값에 의해 필요한 함수가 호출 된다.
public class CommonController {

	@Autowired
	private BaseService baseService;
	
	@Autowired
	private QuizService quizService;

	@Autowired
	private BoardService boardService;
	
	@Autowired
	private LearnAppService learnAppService;
	
	@Autowired
	AttendanceService attendanceService;
	
	@Autowired
	private counselService counselService;
	
	@Autowired
	private surveyService surveyService;

	@Autowired
	private SmsSendService smsService;
	
	@Autowired
	private MailService mailService;
	
	@Autowired
	private BasicService basicService;
	
	@Autowired
	private ToeflService toeflService;
	
	/**
	 * log를 남기는 객체 생성
	 * @author : 김준석(2016-10-10)
	 */
	private static final Logger logger = LoggerFactory.getLogger(CommonController.class);

	/**
	 * 사용자 팝업 관리
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/popup/userList")
	public void popupUserList(@ModelAttribute("search") UserVO user, ModelMap model) throws Exception {
		logger.info("111");
		// 지역 코드 리스트 저장
        CodeVO code = new CodeVO();
        code.getCodeGroup().setId("region");		// 지역 분류 그룹
        code.setUseYn("Y");							// 사용 가능 한 코드만 조회

        // 모든 코드 분류 리스트를 가지고 오기 위해 페이징 처리 안함
        code.setPagingYn("N");

        // 지역 코드 리스트
        model.addAttribute("region", baseService.codeList(code));
	}
	
	/**
	 * 기수 팝업 관리
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/popup/cardinalList")
	public void popupCardinalList(@ModelAttribute("search") CourseVO course, ModelMap model) throws Exception {
		//과정id를 가지고 기수 팝업 창으로 이동
	}

	/**
	 * 기수 팝업 관리
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/popup/cardinalList2")
	public void popupCardinalList3(@ModelAttribute("search") CourseVO course, ModelMap model) throws Exception {
		//과정it없이 기수 팝업창으로 이동
	}
		
	/**
	 * 과정 팝업 관리
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/popup/courseList")
	public void popupCourseList(@ModelAttribute("search") CourseVO course, ModelMap model) throws Exception {
		// 과정분류코드 리스트 가져오기
        CodeVO code = new CodeVO();
        code.setUseYn("Y");
        code.setPagingYn("N");
        code.getCodeGroup().setId("course");

        // 과정분류 리스트 가져오기
        model.addAttribute("courseList", baseService.codeList(code));
        
        // 협력업체 리스트 가져오기
        MemberVO member = new MemberVO();
        member.setUseYn("Y");
        member.setPagingYn("N");
        member.setGrade(3);
        
        model.addAttribute("companyList", baseService.memberList(member));
        
        member.setGrade(2);
        model.addAttribute("teacherList", baseService.memberList(member));
	}
	
	/**
	 * 시험지 풀 팝업 관리
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/popup/quizPoolList")
	public void popupQuizPoolList(@ModelAttribute("search") QuizPoolVO quizPool) throws Exception {}
	
	/**
	 * 문제출제 팝업 관리
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/popup/quizItemEdit")
	public void popupQuizItemEdit(@ModelAttribute("search") QuizItemVO quizItem, ModelMap model) throws Exception {
		if(quizItem != null && quizItem.getId() > 0) {
            // 선택 된 ID가 없으면 바로 edit 화면으로 이동하고 선택 된 ID가 있으면 해당 정보를 가지고 간다.
            model.addAttribute("quizItem", quizService.quizItemInfo(quizItem));
        }
	}
	
	/**
	 * 문제은행 팝업 관리
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/popup/quizBankList")
	public void popupQuizBankList(@ModelAttribute("search") QuizItemVO quizItem) throws Exception {
	}
	
	/**
	 * 포인트 관리 
	 */
	@RequestMapping(value="/view/pointList")
    public void pointList(@ModelAttribute("search") PointVO point) throws Exception {}
	
	/**
	 * 포인트 등록 
	 */
	@RequestMapping(value="/popup/pointReg")
    public void pointReg(@ModelAttribute("search") PointVO point) throws Exception {}
	
	/**
	 * 쿠폰 관리 
	 */
	@RequestMapping(value="/view/couponList")
    public void couponList(@ModelAttribute("search") CouponVO coupon) throws Exception {}
	
	/**
	 * 쿠폰 등록 
	 */
	@RequestMapping(value="/popup/couponReg")
    public void couponReg(@ModelAttribute("search") CouponVO coupon) throws Exception {}
	
	/**
	 * 연수설문 문항추가 팝업
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/popup/surveyItemEdit")
	public void popupSurveyItemEdit(@ModelAttribute("search") SurveyItemVO surveyItem, ModelMap model) throws Exception {
		
		if(surveyItem != null && surveyItem.getId() > 0) {
			model.addAttribute("surveyItem", boardService.surveyItemInfo(surveyItem));
		}
		
		CodeVO code = new CodeVO();
    	code.getCodeGroup().setId("survey"); 
    	code.setUseYn("Y");
    	code.setPagingYn("N");
    	model.addAttribute("surveyCodeList", baseService.codeList(code));
		
	}
	
	/**
	 * 학교 리스트 팝업 관리
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/popup/schoolList")
	public void popupSchoolList(@ModelAttribute("search") SchoolVO school) throws Exception {}
	
	/**
	 * 게시판 레이어 팝업으로 처리하기
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/popup/boardList")
    public void boardList(@ModelAttribute("search") BoardVO board) throws Exception {}
	
	/**
	 * 게시판 레이어 팝업으로 처리하기
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/popup/boardEdit")
    public void boardEdit(@ModelAttribute("search") BoardVO board, ModelMap model) throws Exception {
		if(board != null && board.getId() > 0) {
            // 선택 된 ID가 없으면 바로 edit 화면으로 이동하고 선택 된 ID가 있으면 해당 정보를 가지고 간다.
            model.addAttribute("board", boardService.popupBoardInfo(board));
        }
	}
	
	/**
	 * TCC 영상 추가 팝업 관리
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/popup/tccReg")
    public void tccReg(@ModelAttribute("search") TccVO tcc) throws Exception {}
	
	/**
	 * 수강이력조회관리
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/popup/attLecHistory")
    public void attLecHistory(@ModelAttribute("search") LearnAppVO learnApp, ModelMap model) throws Exception {
		if(learnApp != null && learnApp.getId() > 0) {
            // 선택 된 ID가 없으면 바로 edit 화면으로 이동하고 선택 된 ID가 있으면 해당 정보를 가지고 간다.
            model.addAttribute("attLecList", learnAppService.attLecHistory(learnApp));
        }
	}
	
	//sms 결과조회 페이지 이동
	@RequestMapping(value="/smsHistory")
	public void smsHistory(SmsVO sms, Model model) {
		model.addAttribute("search", sms);
	}
	@ResponseBody
	@RequestMapping(value = "/smsList")
	public DataList<SmsVO> smsList(@ModelAttribute("search") SmsVO sms, ModelMap model) {
		DataList<SmsVO> result = new DataList<SmsVO>();
		
		result.setPagingYn(sms.getPagingYn());
		// 페이징 처리인 경우만 페이지 번호와 토탈 갯수를 저장한다.
		if(result.getPagingYn().equals("Y")) {
			result.setNumOfNums(sms.getNumOfNums());
			result.setNumOfRows(sms.getNumOfRows());
			result.setPageNo(sms.getPageNo());
			result.setTotalCount(smsService.smsListTotalCnt(sms));
		}
		// 결과 리스트를 저장
		result.setList(smsService.selectSmsList(sms));
		return result;
	}
	/**
	 * mailHistory 페이지
	 * @param mail
	 * @param model
	 */
	@RequestMapping(value="/emailHistory")
	public void emailHistory(MailVO mail, Model model) {
		model.addAttribute("search", mail);
	}
	/**
	 * mail 리스트
	 * @param mail
	 * @param model
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/emailList")
	public DataList<MailVO> emailList(@ModelAttribute("search") MailVO mail, ModelMap model) {
		DataList<MailVO> result = new DataList<MailVO>();
		
		result.setPagingYn(mail.getPagingYn());
		// 페이징 처리인 경우만 페이지 번호와 토탈 갯수를 저장한다.
		if(result.getPagingYn().equals("Y")) {
			result.setNumOfNums(mail.getNumOfNums());
			result.setNumOfRows(mail.getNumOfRows());
			result.setPageNo(mail.getPageNo());
			result.setTotalCount(mailService.mailListTotalCnt(mail));
		}
		// 결과 리스트를 저장
		result.setList(mailService.selectMailList(mail));
		return result;
	}
	/**
	 * 메일 전송 내역 조회
	 * @param param
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/mailDetail", method = RequestMethod.POST)
	public MailVO mailDetail(@RequestParam HashMap<String, Object> param) {
		
		logger.debug("메일 전송내역 조회 컨트롤러 시작");
		
		MailVO list = mailService.mailDetail(Integer.parseInt(String.valueOf(param.get("mail_seq"))));
		
		logger.debug("메일 전송내역 조회 컨트롤러 종료");
		
		return list;
	}
	/**
	 * mail 명단 팝업
	 * @param data
	 * @param model
	 */
	@RequestMapping(value="/popup/mailDetail")
	public void popupMailDetail(@RequestParam HashMap<String, Object> data, ModelMap model) {
		model.addAttribute("list", data.get("list"));
	}
	/**
	 * mail 상세정보 페이지
	 * @param mail
	 * @param model
	 */
	@RequestMapping(value="/mailHistoryDetail")
	public void mailHistoryDetail(MailVO mail, Model model) {
		List<MailVO> list = mailService.selectMailList(mail);
		model.addAttribute("mailInfo", list);
		model.addAttribute("search", mail);
 	}
	
	/**
	 * SMS EMAIL 발송 기능 팝업
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/popup/smsMail")
    public void smsMail(@RequestParam HashMap<String, Object> data, ModelMap model) throws Exception {
		model.addAttribute("list", data.get("list"));
	}
	
	@ResponseBody
	@RequestMapping(value="/send_mail", method = RequestMethod.POST)
	public Object send_mail(@RequestParam HashMap<String, Object> param) {
		
		logger.debug("메일발송 컨트롤러 시작");
		
		String result = "";
		
		param.put("from", "sesoc@gmail.com");
		
		result = mailService.sendMail(param);
		mailService.insertMail(param);	// 메일 내역 저장
		
		logger.debug("메일발송 컨트롤러 종료");
		
		return result;
	}
	
	@ResponseBody
	@RequestMapping(value="/send_sms", method = RequestMethod.POST)
	public String send_sms(@RequestParam HashMap<String, Object> param) {
		
		logger.debug("문자발송 컨트롤러 시작");
		
		//문자 발송
//		테스트 내역 너무 남기면 안되니까 작업중엔 주석처리하고 responseStr 임의로 적어서 사용
		String responseStr = smsService.send_sms(param);
//		String responseStr = "{\"result_code\":\"1\",\"message\":\"success\",\"msg_id\":\"161376540\",\"success_cnt\":1,\"error_cnt\":0,\"msg_type\":\"SMS\"}";
		//내용 저장(전송 성공일 경우)
		try {
			int sms_mid = 0;
			int send_cnt = 0;
			JSONParser parser = new JSONParser();
			Object obj = parser.parse(responseStr);
			JSONObject jobj = (JSONObject) obj;
			
			if(Integer.parseInt((String)jobj.get("result_code")) == 1) {
				sms_mid = Integer.parseInt((String)jobj.get("msg_id"));
				param.put("sms_mid", sms_mid);
				send_cnt = Integer.parseInt(String.valueOf(jobj.get("success_cnt")));
				param.put("send_cnt", send_cnt);
				smsService.insertSms(param);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		logger.debug("문자발송 컨트롤러 종료");
		
		return responseStr;
	}
	
	@ResponseBody
	@RequestMapping(value="/getSmsHistory", method = RequestMethod.POST)
	public String smsHistory(@RequestParam HashMap<String, Object> param) {
		
		logger.debug("전송내역 조회 컨트롤러 시작");
		
		String responseStr = smsService.smsHistory(param);
		
		logger.debug("전송내역 조회 컨트롤러 종료");
		
		return responseStr;
	}
	
	@ResponseBody
	@RequestMapping(value="/smsDetail", method = RequestMethod.POST)
	public String smsDetail(@RequestParam HashMap<String, Object> param) {
		
		logger.debug("전송내역 조회 컨트롤러 시작");
		
		String responseStr = smsService.smsDetail(param);
		
		logger.debug("전송내역 조회 컨트롤러 종료");
		
		return responseStr;
	}
	
	@RequestMapping(value="/smsHistoryDetail")
	public void smsDetailPage(SmsVO sms, Model model) {
		List<SmsVO> list = smsService.selectSmsList(sms);
		model.addAttribute("smsInfo", list);
		model.addAttribute("search", sms);
 	}
	
	@RequestMapping(value="/popup/smsDetail")
	public void popupSmsDetail(@RequestParam HashMap<String, Object> data, ModelMap model) {
		model.addAttribute("list", data.get("list"));
	}
	 @RequestMapping(value="/popup/addSubChapOcc")
	    public void addSubChapOcc(ModelMap model, @RequestParam(value="occ_num") int occ_num, SubChapVO data) {
	    	logger.debug("목차 페이지 팝업 컨트롤러");
	    	model.addAttribute("curOcc_num", occ_num);
	    	model.addAttribute("subchapVO", data);
    }
	 @RequestMapping(value="/popup/addSubChapPage")
	    public void addSubChapPage(ModelMap model,@RequestParam(value="order") int order ,SubChapVO data) {
	    	logger.debug("페이지 페이지 팝업 컨트롤러");
	    	model.addAttribute("curOrder_num", order);
	    	model.addAttribute("subchapVO", data);
	 }
	/**
	 * 첨삭
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/popup/correctEdit")
	public void correctEdit(@ModelAttribute("search") ReportVO report, ModelMap model) throws Exception {
		if(report != null && report.getId() > 0) {
            // 선택 된 ID가 없으면 바로 edit 화면으로 이동하고 선택 된 ID가 있으면 해당 정보를 가지고 간다.
            model.addAttribute("report", quizService.reportInfo(report));
        }
	}
	/**
	 * 출결관리팝업
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/popup/attendList")
	public void attendList(@ModelAttribute("search") AttendanceVO attend, ModelMap model) throws Exception {
		
		System.out.println("ATTEND CHECK : " + attend.toString());
		
		model.addAttribute("attend", attend);
	}
	
	/**
	 * 과제 확인 팝업
	 * @param report
	 * @param quiz
	 * @param score
	 * @param idx
	 * @param model
	 * @throws Exception
	 */
	@RequestMapping(value="/popup/reportReply")
	public void report(@ModelAttribute("search") ReportVO report, @ModelAttribute("quiz") QuizVO quiz, @RequestParam(value="score", defaultValue="0") int score, String idx, ModelMap model) throws Exception {
		if(report != null && report.getId() > 0) {
            // 선택 된 ID가 없으면 바로 edit 화면으로 이동하고 선택 된 ID가 있으면 해당 정보를 가지고 간다.
			HashMap<String, Object> params = new HashMap<>();
			logger.info("type = " + quiz.getQuizType());
			logger.info("id = " + report.getId());
			logger.info("score = " + score);
			logger.info("idx = " + idx);
			params.put("report_id", report.getId());
			
			model.addAttribute("idx", idx);
			model.addAttribute("score", score);
			model.addAttribute("reply", quizService.selectExamReplyList(params));
			model.addAttribute("correct", quizService.reportInfo(report));
        }
	}
	/**
	 * 출결 관리 팝업
	 * @param auth
	 * @param date
	 * @param info
	 * @param cardinal
	 * @param model
	 */
	@RequestMapping(value="/popup/attendanceUpdate")
	public void attendanceUpdate(Authentication auth, DateAttendanceVO date, InfoAttendanceVO info, String cardinal, ModelMap model) {
		HashMap<String, Object> map = new HashMap<>();
		List<HashMap<String, Object>> list = new ArrayList<>();
//		String admin_id = auth.getName(); null뜸 이유 모름
		
		map.put("ATT_INFO_TIME_SEQ", info.getAttInfoTimeSeq());
		map.put("USER_ID", info.getUserId());
		map.put("ATT_DT_SEQ", date.getAttDtSeq());
		
		list = attendanceService.selectUserSisu(map);
		InfoAttendanceVO stuInfo = attendanceService.stuAttendanceUpdate(map);
		String userName = attendanceService.stuName(info.getUserId());
		
//		System.out.println("stuInfo = " +stuInfo.toString());
		
//		model.addAttribute("admin_id", admin_id);
		model.addAttribute("userId", info.getUserId());
		model.addAttribute("cardinal", cardinal);
		model.addAttribute("info", stuInfo);
		model.addAttribute("userName", userName);
		model.addAttribute("usersisu", list);
		model.addAttribute("link", "user/attendance/cert");
	}
	/**
	 * 상담 상세 보기 팝업
	 * @param counsel
	 * @param model
	 */
	@RequestMapping(value="/popup/counselDetail")
	public void counselDetail(CounselVO counsel, ModelMap model) {
		//logger.info("seq = " + ;
		String seq = String.valueOf(counsel.getCounsel_seq());
		HashMap<String, String> counselDetail = counselService.selectCounsel(seq);
		
		logger.info("counsel = " + counselDetail.toString());
		
		model.addAttribute("counsel", counselDetail);
		model.addAttribute("counselvo", counsel);
	}
	
	/**
	 * 설문조사 템플릿 팝업
	 * @param SurveysVO
	 * @param model
	 * @throws Exception 
	 */
	@RequestMapping(value="/popup/surveyTemplate")
	public void surveyTemplateList(SurveysVO vo, ModelMap model) throws Exception{
		model.addAttribute("templateList", surveyService.selectSurveyTemplateList());
		model.addAttribute("page", vo.getPage());
		model.addAttribute("crc_id", vo.getCrc_id());
	}
	
	/**
	 * 설문조사 응답자/미응답자 리스트 팝업
	 * @param SurveysVO
	 * @param model
	 */
	@RequestMapping(value="/popup/surveyCompleteList")
	public void surveyCompleteList(SurveysVO vo, ModelMap model) {
		Gson gson = new Gson();
		model.addAttribute("completeList", gson.toJson(surveyService.selectSurveyCompleteList(vo)));
		model.addAttribute("noAnswerList", gson.toJson(surveyService.selectSurveyNoAnswerList(vo)));
	}
	
	/**
	 * 자동설문 기수통계 리스트 팝업
	 * @param model
	 */
	@RequestMapping(value="/popup/surveyAutoGisuList")
	public void surveyAutoGisuList(SurveysVO vo, ModelMap model) {
		model.addAttribute("search", vo);
	}
	
	/**
	 * 학적부 MOU해당학교 팝업
	 * @param model
	 */
	@RequestMapping(value="/popup/studentTableMOU")
	public void studentTableMOU(ModelMap model) {
	}
	
	/**
	 * 공통코드 수정 팝업
	 * @param SurveysVO
	 * @param model
	 * @throws Exception 
	 */
	@RequestMapping(value="/popup/comCodeEdit")
	public void comCodeEdit(@RequestParam HashMap<String, Object> obj, ModelMap model) throws Exception {
		Gson gson = new Gson();
		ComCodeGroupVO search = gson.fromJson((String)obj.get("search"), ComCodeGroupVO.class);
		ComCodeGroupVO vo = gson.fromJson((String)obj.get("data"), ComCodeGroupVO.class);

		List<ComCodeGroupVO> codeInfo = basicService.comCodeList(vo);
		model.addAttribute("codeInfo", codeInfo.get(0));
		model.addAttribute("search", search);
	}
	
	@RequestMapping(value="/popup/toeflRefundInfo")
	public void toeflRefundInfo(@RequestParam HashMap<String, Object> obj, ModelMap model) {
		Gson gson = new Gson();
		
		ToeflPayVO search = gson.fromJson((String)obj.get("search"), ToeflPayVO.class);
		ToeflPayVO vo =	gson.fromJson((String)obj.get("data"), ToeflPayVO.class);

		ToeflPayVO refund = toeflService.selectToeflRefund(vo);
		logger.info(refund.toString());
		model.addAttribute("refund", refund);
		model.addAttribute("search", search);
	}
}
