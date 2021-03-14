package com.changbi.tt.dev.data.controller;

import java.text.DecimalFormat;
import java.text.DecimalFormatSymbols;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.changbi.tt.dev.data.service.LearnAppService;
import com.changbi.tt.dev.data.vo.ChapterVO;
import com.changbi.tt.dev.data.vo.LearnAppVO;
import com.changbi.tt.dev.data.vo.LearnCancelVO;
import com.changbi.tt.dev.data.vo.LearnChangeVO;
import com.changbi.tt.dev.data.vo.LearnDelayVO;
import com.changbi.tt.dev.data.vo.StatsVO;
import com.ibm.icu.text.SimpleDateFormat;

import forFaith.dev.util.GlobalMethod;
import forFaith.dev.util.LoginHelper;
import forFaith.dev.vo.MemberVO;
import forFaith.dev.vo.SubChapVO;
import forFaith.domain.RequestList;
import forFaith.util.DataList;
import forFaith.util.StringUtil;

@Controller(value="data.learnAppController")      // Controller value는 중복되면 안된다. value 값을 지정하지 않으면 클래스명이 value가 되므로 같은 클래스명이 존재하면 중복으로 인식
@RequestMapping("/data/learnApp")       // 해당 클래스를 호출 하기 위한 Mapping 기본 값 뒤에 붙는 값에 의해 필요한 함수가 호출 된다.
public class LearnAppController {

	@Autowired
	private LearnAppService learnAppService;
	
	@Autowired
	private CommonController common;
	
    /**
     * log를 남기는 객체 생성
     * @author : 김준석(2018-02-17)
     */
    private static final Logger logger = LoggerFactory.getLogger(LearnAppController.class);

	/**
     * 연수신청 리스트 정보
     */
    @RequestMapping(value = "/learnAppList", method = RequestMethod.POST)
    public @ResponseBody DataList<LearnAppVO> learnAppList(LearnAppVO learnApp) throws Exception {
    	DataList<LearnAppVO> result = new DataList<LearnAppVO>();
    	
    	// 로그인 정보를 저장한다.
    	learnApp.setLoginUser((MemberVO)LoginHelper.getLoginInfo());
    	
    	result.setPagingYn(learnApp.getPagingYn());
    	
    	// logger.info("acceptance_yn = " +  learnApp.getAcceptance_yn().getClass().getName());
    	
    	// 페이징 처리인 경우만 페이지 번호와 토탈 갯수를 저장한다.
		if(result.getPagingYn().equals("Y")) {
			result.setNumOfNums(learnApp.getNumOfNums());
			result.setNumOfRows(learnApp.getNumOfRows());
			result.setPageNo(learnApp.getPageNo());
			result.setTotalCount(learnAppService.learnAppTotalCnt(learnApp));
			logger.info("신청 총 수 " + learnAppService.learnAppTotalCnt(learnApp));
		}

		// 결과 리스트를 저장
		result.setList(learnAppService.learnAppList(learnApp));
		
		return result;
    }
    
    /**
	 * 신청 관리 엑셀 다운로드
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/excel/download/learnAppList", method = RequestMethod.POST)
	public ModelAndView excelDownloadLearnAppList(LearnAppVO learnApp) throws Exception {
		Map<String, Object> map		= new HashMap<String, Object>();
		List<Object> hederList		= new ArrayList<Object>();
		List<Object> bodyList		= new ArrayList<Object>();
		List<Object> bodyWidthList	= new ArrayList<Object>();

		// 모든 데이터를 가져오기 위해.. paging 여부를 N으로 설정
		learnApp.setPagingYn("N");

		// 리스트 조회
		List<LearnAppVO> dataList = learnAppService.learnAppList(learnApp);

		String[] heder = new String[]{"번호","신청일자","성명","아이디","기수","연수 과정명","학점","연수 지명 번호","결제상태","결제금액"};
		int[] bodyWidth = new int[]{10, 20, 10, 30, 30, 30, 20, 30, 20, 20};

		for(int i=0; i<dataList.size(); ++i) {
			LearnAppVO temp = dataList.get(i);

			String[] body = new String[heder.length];
			
			String credit = "";
			String paymentState = "";
			String format = "#,###";		
			DecimalFormat df = new DecimalFormat(format);
			DecimalFormatSymbols dfs = new DecimalFormatSymbols();
			SimpleDateFormat before_format	= new SimpleDateFormat("yyyyMMddhhmmss");
			SimpleDateFormat after_format	= new SimpleDateFormat("yyyy-MM-dd");
			Date regDate = !StringUtil.isEmpty(temp.getRegDate()) ? before_format.parse(temp.getRegDate()) : null;

            dfs.setGroupingSeparator(',');// 구분자를 ,로 
            df.setGroupingSize(3);//3자리 단위마다 구분자처리 한다. 
            df.setDecimalFormatSymbols(dfs); 

			credit = temp.getCardinal().getLearnType().equals("J") ? "직무"+temp.getCourse().getCredit()+"학점" 
				   : (temp.getCardinal().getLearnType().equals("G") ? "단체"
				   : (temp.getCardinal().getLearnType().equals("S") ? "자율" : "집합"));

			paymentState += temp.getPaymentState().equals("1") ? "결제대기" : (temp.getPaymentState().equals("2") ? "결제완료" : "환불");
			paymentState += "/"+(temp.getPaymentType().equals("1") ? "무통" : (temp.getPaymentType().equals("2") ? "이체"
							   :(temp.getPaymentType().equals("3") ? "가상" : (temp.getPaymentType().equals("4") ? "카드"
							   :(temp.getPaymentType().equals("5") ? "연기" : (temp.getPaymentType().equals("6") ? "무료" : "단체")))))); 

			body[0] = temp.getId()+"";								// 신청번호
			body[1] = regDate != null ? after_format.format(regDate) : "";		// 신청일자
			body[2]	= temp.getUser().getName();						// 신청자명
			body[3] = temp.getUser().getId();						// 신청자ID
			body[4] = temp.getCardinal().getName();					// 기수명
			body[5] = temp.getCourse().getName();					// 과정명
			body[6] = credit;										// 학점
			body[7] = temp.getDesNum();								// 연수지명번호
			body[8] = paymentState;									// 결제상태
			body[9] = df.format(temp.getPayment());					// 금액

			bodyList.add(body);
		}

		hederList.add(heder);
		bodyWidthList.add(bodyWidth);

		map.put("fileName", "신청관리리스트_"+GlobalMethod.getNow("yyyyMMddHHmmss")+".xls");
		map.put("header", hederList);
		map.put("body", bodyList);
		map.put("bodyWidth", bodyWidthList);

		return new ModelAndView("excelDownLoad", "excelMap", map);
	}
    
    /**
     * 연수신청관리 : 연수신청 추가 or 수정
     * ajax용으로 사용 될 경우(현재사용)
     * @author 김준석(2018-02-20)
     */
    @RequestMapping(value="/learnAppReg", method=RequestMethod.POST)
    public @ResponseBody LearnAppVO learnAppReg(LearnAppVO learnApp) throws Exception {
    	
    	logger.debug("Refund Prameter LearnApp Check : " + learnApp.toString());
        if(learnApp != null) {
            // 로그인 된 관리자 정보
        	MemberVO loginUser = (MemberVO)LoginHelper.getLoginInfo();

    		// 메일 발송과 별개로 올레측 DB에 저장한다.
        	learnApp.setRegUser(loginUser);
        	learnApp.setUpdUser(loginUser);
        	
        	learnAppService.learnAppReg(learnApp);
        }
        
        if(learnApp.getEdu() != null) {
        	HashMap<String, Object> map = new HashMap<>();
        	
        	map.put("pay_user_seq", learnApp.getEdu().getPay_user_seq());
        	map.put("pay_user_status", learnApp.getEdu().getPay_user_status());
        	
        	logger.debug("Edu Pay VO Map Check : " + map.toString());
        	
        	learnAppService.payRefundReg(map);
        }

        return learnApp;
    }
    
    /**
     * 입과 처리
     */
    @RequestMapping(value="/learnAppInsert", method=RequestMethod.POST)
    public @ResponseBody List<LearnAppVO> learnAppInsert(@RequestBody RequestList<LearnAppVO> requestList) throws Exception{
    	List<LearnAppVO> regUserLearnAppList = new ArrayList<LearnAppVO>();
    	List<LearnAppVO> learnAppList = requestList.getList();
    	//System.out.println(requestList.toString());
    	//System.out.println(learnAppList.toString());
    	
    	// 로그인 된 관리자 정보
    	MemberVO loginUser = (MemberVO)LoginHelper.getLoginInfo();
    	
    	
    	if (learnAppList != null && learnAppList.size() > 0) {
			// 입과 처리
    		for (LearnAppVO learnAppVO : learnAppList) {
    			// 과정, 기수에 이미 등록된 회원 정보
    	    	List<String> regUserList = learnAppService.getLearnApp(learnAppVO);
    	    	
    	    	if (regUserList.size() == 0) {
    	    		// 등록, 수정 유저
        			learnAppVO.setRegUser(loginUser);
        			learnAppVO.setUpdUser(loginUser);
        			
        			learnAppService.learnAppReg(learnAppVO);
        			List<ChapterVO> chapList = learnAppService.getChapPage(learnAppVO);
        			if(chapList.size() == 0) {
        				chapList = learnAppService.getChapPage2(learnAppVO);
        			}
        			learnAppService.insertAttLec(chapList, learnAppVO);
				} else {
					regUserLearnAppList.add(learnAppVO);
				}
			}
		}
		
    	return regUserLearnAppList;
    }
    
    @RequestMapping(value="/learnAppSelectIn", method=RequestMethod.POST)
    public @ResponseBody int learnAppSelectIn(@RequestBody RequestList<LearnAppVO> requestList) throws Exception {
    	int result = 0;
    	List<LearnAppVO> learnAppList = requestList.getList();
    	
    	System.out.println(learnAppList);

    	if(learnAppList != null && learnAppList.size() > 0) {
			// 삭제처리
			result = learnAppService.learnAppIn(learnAppList);
    	}

        return result;
    }
    
    /**
     * 연수신청관리 : 연수신청 선택 삭제
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/learnAppSelectDel", method=RequestMethod.POST)
    public @ResponseBody int learnAppSelectDel(@RequestBody RequestList<LearnAppVO> requestList) throws Exception {
    	int result = 0;
    	List<LearnAppVO> learnAppList = requestList.getList();
    	
    	System.out.println(learnAppList);

    	if(learnAppList != null && learnAppList.size() > 0) {
			// 삭제처리
			result = learnAppService.learnAppSelectDel(learnAppList);
    	}

        return result;
    }
    
    /**
     * 수강관리 리스트 정보
     */
    @RequestMapping(value = "/learnManList", method = RequestMethod.POST)
    public @ResponseBody DataList<LearnAppVO> learnManList(LearnAppVO learnApp) throws Exception {
    	DataList<LearnAppVO> result = new DataList<LearnAppVO>();
    	
    	// 로그인 정보를 저장한다.
    	learnApp.setLoginUser((MemberVO)LoginHelper.getLoginInfo());
    	
    	result.setPagingYn(learnApp.getPagingYn());
    	
    	// 페이징 처리인 경우만 페이지 번호와 토탈 갯수를 저장한다.
		if(result.getPagingYn().equals("Y")) {
			result.setNumOfNums(learnApp.getNumOfNums());
			result.setNumOfRows(learnApp.getNumOfRows());
			result.setPageNo(learnApp.getPageNo());
			result.setTotalCount(learnAppService.learnManTotalCnt(learnApp));
		}

		// 결과 리스트를 저장
		result.setList(learnAppService.learnManList(learnApp));

		return result;
    }
    
    /**
     * 수강관리 메세지 발송 추후 추가할 사안
     */
   /* @RequestMapping(value = "/sendMessage", method = RequestMethod.POST)
    public @ResponseBody Integer sendMessage(LearnAppVO learnApp) throws Exception {
    	int result = 0;

    	// 메일 발송 또는 SMS 발송 관련 기능 파라미터
    	String sendType = learnApp.getSendType();		// 1이면 이메일 발송, 2이면 SMS 발송
    	int progType	= learnApp.getProgType();		// 진도율 발송 타입(1:10프로미만 ~ 9:90프로미만)
    	String sendTarget = learnApp.getSendTarget();	// 발송 대상(1 : 진도율, 2 : 온라인평가 미참여, 3 : 온라인 과제 미참여);
    	
    	// 발송 제목
    	String subject	= sendTarget != null ? ( sendTarget.equals("1") ? "진도율 독려" 
    										 : ( sendTarget.equals("2") ? "온라인평가 참여 독려" 
    										 : ( sendTarget.equals("3") ? "온라인과제 참여 독려" : ""))) : "";
    	String addContent = sendTarget != null ? ( sendTarget.equals("1") ? "진도율이 "+(progType*10)+"프로 미만입니다.\n90프로 미만인 경우 과락처리 됩니다." 
    										   : ( sendTarget.equals("2") ? "온라인평가에 참여해주세요." 
    										   : ( sendTarget.equals("3") ? "온라인과제에 참여해주세요." : ""))) : "";
    	
    	// 발송 제목이 있다면 처리
    	if(!StringUtil.isEmpty(subject)) {
    		// 오늘 날짜
    		SimpleDateFormat fm = new SimpleDateFormat("yyyy-MM-dd");
    		Date currentTime = new Date();
    		String now = fm.format(currentTime);
    		
	    	// 전체 발송을 위해 페이징 처리 없이 전체 데이터를 호출한다.
	    	learnApp.setPagingYn("N");
	    	
	    	// 로그인 정보를 저장한다.
	    	learnApp.setLoginUser((MemberVO)LoginHelper.getLoginInfo());
	    	
			// 결과 리스트
			List<LearnAppVO> learnAppList = learnAppService.learnManList(learnApp);
			
			for(int i=0; i<learnAppList.size(); ++i) {
				LearnAppVO temp = learnAppList.get(i);
				// 결제 완료이면서 연기 및 취소자가 아닌 경우
				boolean isApp = (temp.getPaymentState().equals("2") && (temp.getReqType() == null || !temp.getReqType().equals("3") && !temp.getReqType().equals("4"))) ? true : false;
				

				// 결제 완료이면서 연기 취소자가 아닌 경우의 대상을 상대로 처리
				if(isApp) {
					double progRate = temp.getChapterCnt() == 0 ? 0 : (temp.getProgCnt() / (double)temp.getChapterCnt())*100;	// 진도율
					int objCnt = temp.getObjCnt();		// 평가 응시 수
					int subCnt = temp.getSubCnt();		// 과제 응시 수
					String startDate = temp.getCardinal().getLearnStartDate();		// 연수시작일
					String endDate = temp.getCardinal().getLearnEndDate();			// 연수종료일
					
					 1. 진도율인 경우 진도율이 설정된 진도율 보다 낮은 경우와 오늘 날짜가 연수 시작일보다 크거나 같고 연수종료일 보다 작거나 같은 경우에만
					 * 2. 평가 미참여 인 경우 평가 응시 수 가 0인 경우
					 * 3. 과제 미첨여 인 경우 과제 응시 수 가 0인 경우
					 
					if( ( sendTarget.equals("1") && progRate < (progType*10) && fm.parse(now).compareTo(fm.parse(startDate)) >= 0 && fm.parse(now).compareTo(fm.parse(endDate)) <= 0 )
					 || ( sendTarget.equals("2") && objCnt == 0 )
					 || ( sendTarget.equals("3") && subCnt == 0 ) ) {
						String cardinalName = temp.getCardinal() != null ? temp.getCardinal().getName() : "";
						String courseName = temp.getCourse() != null ? temp.getCourse().getName() : "";
						String userName = temp.getUser() != null ? temp.getUser().getName() : "";
						
						String content = userName+"님\n"+"기수 : "+cardinalName+"\n"+"과정 : "+courseName+"\n"+addContent;
						
						// 이메일 발송
						SendData sendData = new SendData();
						
						sendData.setSubject(subject);
						sendData.setContent(content);
						sendData.setUserId(temp.getUser().getId());

						if(sendType != null && sendType.equals("1")) {
							sendData.setReceiver(temp.getEmail());
							
							result += common.sendMail(sendData);
						} else if(sendType != null && sendType.equals("2")) {
							sendData.setReceiver(temp.getPhone());
							
							result += common.sendSms(sendData);
							
							common.smsHistory(sendData);
						}
					}
				}
			}
    	}

		return result;
    }*/
    
    /**
     * 수강변경관리 리스트 정보
     */
    @RequestMapping(value = "/learnChangeList", method = RequestMethod.POST)
    public @ResponseBody DataList<LearnChangeVO> learnChangeList(LearnChangeVO learnChange) throws Exception {
    	DataList<LearnChangeVO> result = new DataList<LearnChangeVO>();
    	
    	result.setPagingYn(learnChange.getPagingYn());
    	
    	// 페이징 처리인 경우만 페이지 번호와 토탈 갯수를 저장한다.
		if(result.getPagingYn().equals("Y")) {
			result.setNumOfNums(learnChange.getNumOfNums());
			result.setNumOfRows(learnChange.getNumOfRows());
			result.setPageNo(learnChange.getPageNo());
			result.setTotalCount(learnAppService.learnChangeTotalCnt(learnChange));
		}

		// 결과 리스트를 저장
		result.setList(learnAppService.learnChangeList(learnChange));

		return result;
    }
    
    /**
     * 수강변경관리 변경 처리
     */
    @RequestMapping(value = "/learnChange", method = RequestMethod.POST)
    public @ResponseBody Integer learnChange(LearnChangeVO learnChange) throws Exception {
    	int result = 0;
    	
    	if(learnChange != null) {
            // 로그인 된 관리자 정보
        	MemberVO loginUser = (MemberVO)LoginHelper.getLoginInfo();

        	learnChange.setUpdUser(loginUser);
        	
        	result = learnAppService.learnChange(learnChange);
        }
    	
		return result;
    }
    
    /**
     * 수강연기관리 리스트 정보
     */
    @RequestMapping(value = "/learnDelayList", method = RequestMethod.POST)
    public @ResponseBody DataList<LearnDelayVO> learnDelayList(LearnDelayVO learnDelay) throws Exception {
    	DataList<LearnDelayVO> result = new DataList<LearnDelayVO>();
    	
    	// 로그인 정보를 저장한다.
    	learnDelay.setLoginUser((MemberVO)LoginHelper.getLoginInfo());
    	
    	result.setPagingYn(learnDelay.getPagingYn());
    	
    	// 페이징 처리인 경우만 페이지 번호와 토탈 갯수를 저장한다.
		if(result.getPagingYn().equals("Y")) {
			result.setNumOfNums(learnDelay.getNumOfNums());
			result.setNumOfRows(learnDelay.getNumOfRows());
			result.setPageNo(learnDelay.getPageNo());
			result.setTotalCount(learnAppService.learnDelayTotalCnt(learnDelay));
		}

		// 결과 리스트를 저장
		result.setList(learnAppService.learnDelayList(learnDelay));

		return result;
    }
    
    /**
     * 수강연기관리 연기 처리
     */
    @RequestMapping(value = "/learnDelay", method = RequestMethod.POST)
    public @ResponseBody Integer learnDelay(LearnDelayVO learnDelay) throws Exception {
    	int result = 0;
    	
    	if(learnDelay != null) {
            // 로그인 된 관리자 정보
        	MemberVO loginUser = (MemberVO)LoginHelper.getLoginInfo();

        	learnDelay.setUpdUser(loginUser);
        	
        	result = learnAppService.learnDelay(learnDelay);
        }
    	
		return result;
    }
    
    /**
     * 수강취소관리 리스트 정보
     */
    @RequestMapping(value = "/learnCancelList", method = RequestMethod.POST)
    public @ResponseBody DataList<LearnCancelVO> learnCancelList(LearnCancelVO learnCancel) throws Exception {
    	DataList<LearnCancelVO> result = new DataList<LearnCancelVO>();
    	
    	// 로그인 정보를 저장한다.
    	learnCancel.setLoginUser((MemberVO)LoginHelper.getLoginInfo());
    	
    	result.setPagingYn(learnCancel.getPagingYn());
    	
    	// 페이징 처리인 경우만 페이지 번호와 토탈 갯수를 저장한다.
		if(result.getPagingYn().equals("Y")) {
			result.setNumOfNums(learnCancel.getNumOfNums());
			result.setNumOfRows(learnCancel.getNumOfRows());
			result.setPageNo(learnCancel.getPageNo());
			result.setTotalCount(learnAppService.learnCancelTotalCnt(learnCancel));
		}

		// 결과 리스트를 저장
		result.setList(learnAppService.learnCancelList(learnCancel));

		return result;
    }
    
    /**
     * 수강취소관리 취소 처리
     */
    @RequestMapping(value = "/learnCancel", method = RequestMethod.POST)
    public @ResponseBody Integer learnCancel(LearnCancelVO learnCancel) throws Exception {
    	int result = 0;
    	
    	if(learnCancel != null) {
            // 로그인 된 관리자 정보
        	MemberVO loginUser = (MemberVO)LoginHelper.getLoginInfo();

        	learnCancel.setUpdUser(loginUser);
        	
        	result = learnAppService.learnCancel(learnCancel);
        }
    	
		return result;
    }
    
    /**
     * 첨삭이력조회 리스트 정보(튜터의 첨삭이력 조회 기능)
     */
    @RequestMapping(value = "/activeList", method = RequestMethod.POST)
    public @ResponseBody DataList<Map<String,String>> activeList(StatsVO stats) throws Exception {
    	DataList<Map<String,String>> result = new DataList<Map<String,String>>();
    	
    	// 로그인 정보를 저장한다.
    	stats.setLoginUser((MemberVO)LoginHelper.getLoginInfo());
    	
    	result.setPagingYn(stats.getPagingYn());
    	
    	// 페이징 처리인 경우만 페이지 번호와 토탈 갯수를 저장한다.
		if(result.getPagingYn().equals("Y")) {
			result.setNumOfNums(stats.getNumOfNums());
			result.setNumOfRows(stats.getNumOfRows());
			result.setPageNo(stats.getPageNo());
			result.setTotalCount(learnAppService.activeTotalCnt(stats));
		}

		// 결과 리스트를 저장
		result.setList(learnAppService.activeList(stats));

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