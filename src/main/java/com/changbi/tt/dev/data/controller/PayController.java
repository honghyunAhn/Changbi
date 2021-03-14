/**
 * 회원관리 화면 호출 Controller
 * @author : 김준석(2018-02-17)
 */

package com.changbi.tt.dev.data.controller;

import java.util.ArrayList;
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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.changbi.tt.dev.data.service.PayService;
import com.changbi.tt.dev.data.vo.CalculateVO;
import com.changbi.tt.dev.data.vo.CouponVO;
import com.changbi.tt.dev.data.vo.EduUserPayVO;
import com.changbi.tt.dev.data.vo.GroupLearnAppVO;
import com.changbi.tt.dev.data.vo.LearnAppVO;
import com.changbi.tt.dev.data.vo.PaymentVO;
import com.changbi.tt.dev.data.vo.PointVO;
import com.gargoylesoftware.htmlunit.javascript.host.file.DataTransferItemList;

import forFaith.dev.util.GlobalMethod;
import forFaith.dev.util.LoginHelper;
import forFaith.dev.vo.MemberVO;
import forFaith.util.DataList;

@Controller(value="data.payController")      // Controller value는 중복되면 안된다. value 값을 지정하지 않으면 클래스명이 value가 되므로 같은 클래스명이 존재하면 중복으로 인식
@RequestMapping("/data/pay")       // 해당 클래스를 호출 하기 위한 Mapping 기본 값 뒤에 붙는 값에 의해 필요한 함수가 호출 된다.
public class PayController {

	@Autowired
	private PayService payService;
	
    /**
     * log를 남기는 객체 생성
     * @author : 김준석(2018-02-17)
     */
    private static final Logger logger = LoggerFactory.getLogger(PayController.class);

    
    /**
     * 결제관리 리스트
     */
    @RequestMapping(value = "/payList", method = RequestMethod.POST)
    public @ResponseBody DataList<LearnAppVO> payList(LearnAppVO learnApp) throws Exception {
    	
    	System.out.println("PayList LearnApp Parameters Check : " + learnApp.toString());
    	
    	DataList<LearnAppVO> result = new DataList<LearnAppVO>();
    	
    	
    	//xml 조건절을 위한 VO값 설정
//    	if(learnApp.getCardinal().getId() != "") {
//	    	learnApp.getPay().setCardinal(learnApp.getCardinal());
//	    	learnApp.getPay().setCourse(learnApp.getCourse());
//    	}
    	result.setPagingYn(learnApp.getPagingYn());
    	
    	// 페이징 처리인 경우만 페이지 번호와 토탈 갯수를 저장한다.
		if(result.getPagingYn().equals("Y")) {
			result.setNumOfNums(learnApp.getNumOfNums());
			result.setNumOfRows(learnApp.getNumOfRows());
			result.setPageNo(learnApp.getPageNo());
			
			
			result.setTotalCount(payService.payTotalCnt(learnApp));
		}
     
		List<LearnAppVO> list = payService.payList(learnApp);
		
		for(int i=0; i<list.size(); i++) {
			System.out.println("Learn App Vo : " + list.get(i).toString());
		}
		// 결과 리스트를 저장
		result.setList(list);

		return result;
    }    
    
    @RequestMapping(value = "/payListTest", method = RequestMethod.POST)
    public @ResponseBody DataList<LearnAppVO> payListTest(LearnAppVO learnApp) throws Exception {
    	
    	DataList<LearnAppVO> result = new DataList<LearnAppVO>();
    	
    	//xml 조건절을 위한 VO값 설정
    	if(learnApp.getCardinal().getId() != "" || learnApp.getCardinal().getId() != null) {
    		learnApp.setPay(new PaymentVO());
	    	learnApp.getPay().setCardinal(learnApp.getCardinal());
	    	learnApp.getPay().setCourse(learnApp.getCourse());
    	}
    	result.setPagingYn(learnApp.getPagingYn());
    	
    	// 페이징 처리인 경우만 페이지 번호와 토탈 갯수를 저장한다.
		if(result.getPagingYn().equals("Y")) {
			result.setNumOfNums(learnApp.getNumOfNums());
			result.setNumOfRows(learnApp.getNumOfRows());
			result.setPageNo(learnApp.getPageNo());
			
			result.setTotalCount(payService.payTotalCnt(learnApp));
		}
		
		List<LearnAppVO> list = payService.payListTest(learnApp);
		
		for(int i=0; i<list.size(); i++) {
			System.out.println("Learn App Vo : " + list.get(i).toString());
		}
    	
    	result.setList(list);
    	
    	return result;
    }
    
    /**
     * 개별결제리스트 엑셀 다운로드
     */
    @RequestMapping(value="/payList/excelDownLoad")
	public ModelAndView payListExcelDownLoad(LearnAppVO learnApp) throws Exception {
    	
    	Map<String, Object> map = new HashMap<String, Object>();
    	
    	List<Object> headerList		= new ArrayList<Object>();
		List<Object> bodyList		= new ArrayList<Object>();
		List<Object> bodyWidthList	= new ArrayList<Object>();
		
		learnApp.setPagingYn("N");
    	
		List<LearnAppVO> dataList = payService.payList(learnApp);
		
		String[] header = new String[]{"순번","결제일시","아이디","성명","기수","연수 과정","결제 금액","실 결제금액","사용포인트","비고"};
		int[] bodyWidth = new int[]{10,20,10,10,20,20,10,10,10,10};
		
		for(int i=0; i<dataList.size(); ++i) {
			
			LearnAppVO data = dataList.get(i);
			
			String[] body = new String[header.length];
			
			body[0] = String.valueOf(i+1);								// 순번
			body[1] = data.getRegDate().substring(0,19);		// 결제일시
			body[2] = data.getUser().getId();							// 아이디
			body[3] = data.getUser().getName();							// 성명
			body[4] = data.getCardinal().getName();						// 기수
			body[5] = data.getCourse().getName();						// 연수 과정		 
			/*
			switch(data.getPaymentType()) {
			case "1" :
				data.setPaymentState("무통장입금");
				break;
			case "2" :
				data.setPaymentState("계쫘이체");
				break;
			case "3" :
				data.setPaymentState("가상계좌");
				break;
			case "4" :
				data.setPaymentState("신용카드");
				break;
			case "5" :
				data.setPaymentState("지난연기결제");
				break;
			case "6" :
				data.setPaymentState("무료");
				break;
			case "7" :
				data.setPaymentState("단체연수결제");
				break;
			}
			
			body[6] = data.getPaymentType();							// 결제 구분
			*/
			body[6] = String.valueOf(data.getCourse().getPrice());	  // 결제금액  		 
			body[7] = String.valueOf(data.getCourse().getPrice()-data.getDisPoint());  //실결제금액 			
			body[8] =  String.valueOf(data.getDisPoint()); // 사용포인트 		 
			body[9] = data.getPaymentState();		// 비고
			
			bodyList.add(body);
		}
		
		headerList.add(header);
		bodyWidthList.add(bodyWidth);
		
		StringBuffer fileName = new StringBuffer();
		fileName.append("개별결제관리");
		fileName.append("_");
		fileName.append(GlobalMethod.getNow("yyyyMMddHHmmss"));
		fileName.append(".xls");
		
		map.put("fileName", fileName.toString());
		map.put("header", headerList);
		map.put("body", bodyList);
		map.put("bodyWidth", bodyWidthList);
		
    	return new ModelAndView("excelDownLoad", "excelMap", map);
    	
    }
    
    
    
    /**
     * 개별결제관리 리스트
     */
    @RequestMapping(value = "/individualPayList", method = RequestMethod.POST)
    public @ResponseBody DataList<LearnAppVO> individualPayList(LearnAppVO learnApp) throws Exception {
    	
    	DataList<LearnAppVO> result = new DataList<LearnAppVO>();
    	
    	result.setPagingYn(learnApp.getPagingYn());
    	
    	// 페이징 처리인 경우만 페이지 번호와 토탈 갯수를 저장한다.
		if(result.getPagingYn().equals("Y")) {
			result.setNumOfNums(learnApp.getNumOfNums());
			result.setNumOfRows(learnApp.getNumOfRows());
			result.setPageNo(learnApp.getPageNo());
			result.setTotalCount(payService.individualPayTotalCnt(learnApp));
		}

		// 결과 리스트를 저장
		result.setList(payService.individualPayList(learnApp));

		return result;
    }    
    
    /**
     * 단체결제관리 리스트
     */
    @RequestMapping(value = "/groupPayList", method = RequestMethod.POST)
    public @ResponseBody DataList<GroupLearnAppVO> groupPayList(GroupLearnAppVO groupLearnApp) throws Exception {
    	
    	DataList<GroupLearnAppVO> result = new DataList<GroupLearnAppVO>();
    	
    	result.setPagingYn(groupLearnApp.getPagingYn());
    	
    	// 페이징 처리인 경우만 페이지 번호와 토탈 갯수를 저장한다.
		if(result.getPagingYn().equals("Y")) {
			result.setNumOfNums(groupLearnApp.getNumOfNums());
			result.setNumOfRows(groupLearnApp.getNumOfRows());
			result.setPageNo(groupLearnApp.getPageNo());
			result.setTotalCount(payService.groupPayTotalCnt(groupLearnApp));
		}

		// 결과 리스트를 저장
		result.setList(payService.groupPayList(groupLearnApp));

		return result;
    }   
    
    /**
     * 단체결제관리  결제처리
     */
    @RequestMapping(value="/groupPayEdit", method=RequestMethod.POST)
    public @ResponseBody int groupPayEdit(@RequestBody List<GroupLearnAppVO> groupLearnAppList) throws Exception {
    	return payService.groupPayEdit(groupLearnAppList);
    }
    
    /**
     * 업체정산관리 
     */
    @RequestMapping(value="/calculateList", method=RequestMethod.POST)
    public @ResponseBody DataList<CalculateVO> calculateList(CalculateVO calculate) throws Exception {
    	
    	DataList<CalculateVO> result = new DataList<CalculateVO>();
    	
    	// 로그인 정보를 저장한다.
    	calculate.setLoginUser((MemberVO)LoginHelper.getLoginInfo());
    	
    	result.setPagingYn(calculate.getPagingYn());
    	
    	// 페이징 처리인 경우만 페이지 번호와 토탈 갯수를 저장한다.
		if(result.getPagingYn().equals("Y")) {
			result.setNumOfNums(calculate.getNumOfNums());
			result.setNumOfRows(calculate.getNumOfRows());
			result.setPageNo(calculate.getPageNo());
			result.setTotalCount(payService.calculateTotalCnt(calculate));
		}

		// 결과 리스트를 저장
		result.setList(payService.calculateList(calculate));
    	
    	return result;
    }
    
    /**
     * 포인트관리 리스트
     */
    @RequestMapping(value = "/pointList", method = RequestMethod.POST)
    public @ResponseBody DataList<PointVO> pointList(PointVO point) throws Exception {
    	
    	// TODO : 인자 VO 변경 해야함.
    	
    	DataList<PointVO> result = new DataList<PointVO>();
    	
    	result.setPagingYn(point.getPagingYn());
    	
    	// 페이징 처리인 경우만 페이지 번호와 토탈 갯수를 저장한다.
		if(result.getPagingYn().equals("Y")) {
			result.setNumOfNums(point.getNumOfNums());
			result.setNumOfRows(point.getNumOfRows());
			result.setPageNo(point.getPageNo());
			result.setTotalCount(payService.pointTotalCnt(point));
		}

		// 결과 리스트를 저장
		result.setList(payService.pointList(point));

		return result;
    }
    
    /**
     * 포인트 등록
     */
    @RequestMapping(value="/pointReg", method=RequestMethod.POST)
    public @ResponseBody PointVO pointReg(PointVO point) throws Exception {
        if(point != null) {
        	payService.pointReg(point);
        }

        return point;
    }
    
    /**
     * 쿠폰관리 리스트
     */
    @RequestMapping(value = "/couponList", method = RequestMethod.POST)
    public @ResponseBody DataList<CouponVO> couponList(CouponVO coupon) throws Exception {
    	DataList<CouponVO> result = new DataList<CouponVO>();
    	
    	result.setPagingYn(coupon.getPagingYn());
    	
    	// 페이징 처리인 경우만 페이지 번호와 토탈 갯수를 저장한다.
		if(result.getPagingYn().equals("Y")) {
			result.setNumOfNums(coupon.getNumOfNums());
			result.setNumOfRows(coupon.getNumOfRows());
			result.setPageNo(coupon.getPageNo());
			result.setTotalCount(payService.couponTotalCnt(coupon));
		}

		// 결과 리스트를 저장
		result.setList(payService.couponList(coupon));

		return result;
    }
    
    /**
     * 쿠폰 등록
     */
    @RequestMapping(value="/couponReg", method=RequestMethod.POST)
    public @ResponseBody CouponVO couponReg(CouponVO coupon) throws Exception {
        if(coupon != null) {
        	coupon.setUseYn("Y");
        	
        	if(coupon.getIssue() == 1 && coupon.getUserIds().length > 0) {
        		payService.couponReg(coupon);
        	} else {
        		for (int i=0; i<coupon.getIssue(); i++) {
        			payService.couponOnlyReg(coupon);
        		}
        	}
        }
        
        return coupon;
    }
 
    /**
     * 쿠폰 삭제
     */
    @RequestMapping(value="/couponDel", method=RequestMethod.POST)
    public @ResponseBody int couponDel(CouponVO coupon) throws Exception {
        return payService.couponDel(coupon);
    }
    
    /**
     * 개별결제리스트 엑셀 다운로드
     */
    @RequestMapping(value="/individualPayList/excelDownLoad")
	public ModelAndView individualPayExcelDownLoad(LearnAppVO learnApp) throws Exception {
    	
    	Map<String, Object> map = new HashMap<String, Object>();
    	
    	List<Object> headerList		= new ArrayList<Object>();
		List<Object> bodyList		= new ArrayList<Object>();
		List<Object> bodyWidthList	= new ArrayList<Object>();
		
		learnApp.setPagingYn("N");
    	
		List<LearnAppVO> dataList = payService.individualPayList(learnApp);
		
		String[] header = new String[]{"순번","결제일시","아이디","성명","기수","연수 과정","결제 금액","결제 구분","비고"};
		int[] bodyWidth = new int[]{10,20,10,10,10,10,10,10,20,20};
		
		for(int i=0; i<dataList.size(); ++i) {
			
			LearnAppVO data = dataList.get(i);
			
			String[] body = new String[header.length];
			
			body[0] = String.valueOf(i+1);								// 순번
			body[1] = data.getPaymentDate();							// 결제일시
			body[2] = data.getUser().getId();							// 아이디
			body[3] = data.getUser().getName();							// 성명
			body[4] = data.getCardinal().getName();						// 기수
			body[5] = data.getCourse().getName();						// 연수 과정
			body[6] = String.valueOf(data.getPayment());				// 결제 금액
			
			switch(data.getPaymentType()) {
			case "1" :
				data.setPaymentState("무통장입금");
				break;
			case "2" :
				data.setPaymentState("계쫘이체");
				break;
			case "3" :
				data.setPaymentState("가상계좌");
				break;
			case "4" :
				data.setPaymentState("신용카드");
				break;
			case "5" :
				data.setPaymentState("지난연기결제");
				break;
			case "6" :
				data.setPaymentState("무료");
				break;
			case "7" :
				data.setPaymentState("단체연수결제");
				break;
			}
			
			body[7] = data.getPaymentType();							// 결제 구분
			
			body[8] = data.getPaymentState();							// 비고
			
			bodyList.add(body);
		}
		
		headerList.add(header);
		bodyWidthList.add(bodyWidth);
		
		StringBuffer fileName = new StringBuffer();
		fileName.append("개별결제관리");
		fileName.append("_");
		fileName.append(GlobalMethod.getNow("yyyyMMddHHmmss"));
		fileName.append(".xls");
		
		map.put("fileName", fileName.toString());
		map.put("header", headerList);
		map.put("body", bodyList);
		map.put("bodyWidth", bodyWidthList);
		
    	return new ModelAndView("excelDownLoad", "excelMap", map);
    	
    }
    
    /**
     * 교육청(기관)결제리스트 엑셀 다운로드
     */
    @RequestMapping(value="/groupPayList/excelDownLoad")
	public ModelAndView groupPayExcelDownLoad(GroupLearnAppVO groupLearnApp) throws Exception {
    	
    	Map<String, Object> map = new HashMap<String, Object>();
    	
    	List<Object> headerList		= new ArrayList<Object>();
		List<Object> bodyList		= new ArrayList<Object>();
		List<Object> bodyWidthList	= new ArrayList<Object>();
		
		groupLearnApp.setPagingYn("N");
    	
		List<GroupLearnAppVO> dataList = payService.groupPayList(groupLearnApp);
		
		String[] header = new String[]{"단체(기관명)","과정명","총 신청자","총 연수금액","수강유효자","실결제금액","결제상태","연수기간"};
		int[] bodyWidth = new int[]{10,20,10,10,10,10,10,10,20,20};
		
		for(int i=0; i<dataList.size(); ++i) {
			
			GroupLearnAppVO data = dataList.get(i);
			
			String[] body = new String[header.length];
			
			body[0] = data.getSchoolName();										// 단체(기관명)
			body[1] = data.getCourseName();										// 과정명
			body[2] = String.valueOf(data.getTotalAppUser());					// 총 신청자
			body[3] = String.valueOf(data.getTotalPayment());					// 총 연수금액
			body[4] = String.valueOf(data.getValidAppUser());					// 수강유효자
			body[5] = String.valueOf(data.getTotalValidPayment());				// 실결제금액
			body[6] = data.getPaymentStateName();								// 결제상태
			body[7] = data.getLearnStartDate() + "~" + data.getLearnEndDate();	// 연수기간
			
			bodyList.add(body);
		}
		
		headerList.add(header);
		bodyWidthList.add(bodyWidth);
		
		StringBuffer fileName = new StringBuffer();
		fileName.append("교육청(기관)결제관리");
		fileName.append("_");
		fileName.append(GlobalMethod.getNow("yyyyMMddHHmmss"));
		fileName.append(".xls");
		
		map.put("fileName", fileName.toString());
		map.put("header", headerList);
		map.put("body", bodyList);
		map.put("bodyWidth", bodyWidthList);
		
    	return new ModelAndView("excelDownLoad", "excelMap", map);
    	
    }
    
    
    /**
     * 정산리스트 엑셀 다운로드 (업체, 강사, 튜터)
     */
    @RequestMapping(value="/calculateList/excelDownLoad")
	public ModelAndView calculateExcelDownLoad(CalculateVO calculate) throws Exception {
    	
    	Map<String, Object> map = new HashMap<String, Object>();
    	
    	List<Object> headerList		= new ArrayList<Object>();
		List<Object> bodyList		= new ArrayList<Object>();
		List<Object> bodyWidthList	= new ArrayList<Object>();
		
		calculate.setPagingYn("N");
    	
		List<CalculateVO> dataList = payService.calculateList(calculate);
		
		String[] header = new String[]{"순번","업체명","정산건수","원금액계","할인금액","사용포인트","실결제금액","금융수수료","정산금액","본사금액"};
		int[] bodyWidth = new int[]{10,20,10,10,10,10,10,10,20,20};
		
		for(int i=0; i<dataList.size(); ++i) {
			
			CalculateVO data = dataList.get(i);
			
			String[] body = new String[header.length];
			
			body[0] = String.valueOf(i+1);								// 순번
			body[1] = data.getName();									// 업체명
			body[2] = String.valueOf(data.getCntCal());					// 정산건수
			body[3] = String.valueOf(data.getSumPayment());				// 원금액계
			body[4] = String.valueOf(data.getSumDisPayment());			// 할인금액
			body[5] = String.valueOf(data.getSumDisPoint());			// 사용포인트
			body[6] = String.valueOf(data.getSumRealPayment());			// 실결제금액
			body[7] = String.valueOf(data.getSumCommPayment());			// 금융수수료
			body[8] = String.valueOf(data.getSumCalPayment());			// 정산금액
			body[9] = String.valueOf(data.getSumCompanyPayment());		// 본사금액
			
			bodyList.add(body);
		}
		
		headerList.add(header);
		bodyWidthList.add(bodyWidth);
		
		StringBuffer fileName = new StringBuffer();
		fileName.append("정산리스트");
		fileName.append("(");
		fileName.append(calculate.getCalType());
		fileName.append(")");
		fileName.append("_");
		fileName.append(GlobalMethod.getNow("yyyyMMddHHmmss"));
		fileName.append(".xls");
		
		map.put("fileName", fileName.toString());
		map.put("header", headerList);
		map.put("body", bodyList);
		map.put("bodyWidth", bodyWidthList);
		
    	return new ModelAndView("excelDownLoad", "excelMap", map);
    	
    }
    
    /**
     * 포인트리스트 엑셀 다운로드
     */
    @RequestMapping(value="/pointList/excelDownLoad")
	public ModelAndView pointExcelDownLoad(PointVO point) throws Exception {
    	
    	Map<String, Object> map = new HashMap<String, Object>();
    	
    	List<Object> headerList		= new ArrayList<Object>();
		List<Object> bodyList		= new ArrayList<Object>();
		List<Object> bodyWidthList	= new ArrayList<Object>();
		
		point.setPagingYn("N");
    	
		List<PointVO> dataList = payService.pointList(point);
		
		String[] header = new String[]{"순번","일시","구분","회원명","아이디","신청접수번호","적립포인트","사용포인트","포인트누계","비고(사유)"};
		int[] bodyWidth = new int[]{10,20,10,10,10,10,10,10,20,20};
		
		for(int i=0; i<dataList.size(); ++i) {
			
			PointVO data = dataList.get(i);
			
			String[] body = new String[header.length];
			
			body[0] = String.valueOf(i+1);								// 순번
			body[1] = data.getRegDate();								// 일시
			body[2] = data.getLearnAppId() == 0 ? "수강" : "이벤트";		// 구분
			body[3] = data.getName();									// 회원명
			body[4] = data.getUserId();									// 아이디
			body[5] = String.valueOf(data.getLearnAppId());				// 신청접수번호
			body[6] = String.valueOf(data.getGive());					// 적립포인트
			body[7] = String.valueOf(data.getWithdraw());				// 사용포인트
			body[8] = "";												// 포인트누계 (?)
			body[9] = data.getNote();									// 비고(사유)
			
			bodyList.add(body);
		}
		
		headerList.add(header);
		bodyWidthList.add(bodyWidth);
		
		StringBuffer fileName = new StringBuffer();
		fileName.append("포인트리스트");
		fileName.append("_");
		fileName.append(GlobalMethod.getNow("yyyyMMddHHmmss"));
		fileName.append(".xls");
		
		map.put("fileName", fileName.toString());
		map.put("header", headerList);
		map.put("body", bodyList);
		map.put("bodyWidth", bodyWidthList);
		
    	return new ModelAndView("excelDownLoad", "excelMap", map);
    	
    }
    
    /**
     * 쿠폰리스트 엑셀 다운로드
     */
    @RequestMapping(value="/couponList/excelDownLoad")
	public ModelAndView couponExcelDownLoad(CouponVO coupon) throws Exception {
    	
    	Map<String, Object> map = new HashMap<String, Object>();
    	
    	List<Object> headerList		= new ArrayList<Object>();
		List<Object> bodyList		= new ArrayList<Object>();
		List<Object> bodyWidthList	= new ArrayList<Object>();
		
		coupon.setPagingYn("N");
    	
		List<CouponVO> dataList = payService.couponList(coupon);
		
		String[] header = new String[]{"발행일","쿠폰번호","쿠폰할인내역","만료기한","사용상태","사용자ID","사용자명","사용일자","사용주문번호","쿠폰적용과정코드"};
		int[] bodyWidth = new int[]{10,20,10,10,10,10,10,10,20,20};
		
		for(int i=0; i<dataList.size(); ++i) {
			
			CouponVO data = dataList.get(i);
			
			String[] body = new String[header.length];
			
			body[0] = data.getRegDate();								// 발행일
			body[1] = data.getCouponNum();								// 쿠폰번호
			body[2] = "";												// 쿠폰할인내역 (?)
			body[3] = data.getExpDate();								// 만료기한
			body[4] = data.getUseYn().equals("Y") ? "사용가능" : "이미사용";	// 사용상태
			body[5] = data.getUserId();									// 사용자ID
			body[6] = data.getName();									// 사용자명
			body[7] = data.getUseDate();								// 사용일자
			body[8] = "";												// 사용주문번호 (?)
			body[9] = data.getCourseId();								// 쿠폰적용과정코드
			
			bodyList.add(body);
		}
		
		headerList.add(header);
		bodyWidthList.add(bodyWidth);
		
		StringBuffer fileName = new StringBuffer();
		fileName.append("쿠폰리스트");
		fileName.append("_");
		fileName.append(GlobalMethod.getNow("yyyyMMddHHmmss"));
		fileName.append(".xls");
		
		map.put("fileName", fileName.toString());
		map.put("header", headerList);
		map.put("body", bodyList);
		map.put("bodyWidth", bodyWidthList);
		
    	return new ModelAndView("excelDownLoad", "excelMap", map);
    	
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