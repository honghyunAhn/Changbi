/**
 * 회원관리 화면 호출 Controller
 * @author : 김준석(2018-02-17)
 */

package com.changbi.tt.dev.data.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.changbi.tt.dev.data.service.MemberService;
import com.changbi.tt.dev.data.vo.ManagerVO;
import com.changbi.tt.dev.data.vo.UserVO;
import com.changbi.tt.dev.data.vo.WithdrawalVO;
import com.changbi.tt.dev.security.ShaEncoder;

import forFaith.dev.service.BaseService;
import forFaith.dev.util.GlobalMethod;
import forFaith.dev.util.LoginHelper;
import forFaith.dev.vo.MemberVO;
import forFaith.domain.RequestList;
import forFaith.util.DataList;
import forFaith.util.StringUtil;

@Controller(value="data.memberController")      // Controller value는 중복되면 안된다. value 값을 지정하지 않으면 클래스명이 value가 되므로 같은 클래스명이 존재하면 중복으로 인식
@RequestMapping("/data/member")       // 해당 클래스를 호출 하기 위한 Mapping 기본 값 뒤에 붙는 값에 의해 필요한 함수가 호출 된다.
public class MemberController {

	@Autowired
	private BaseService baseService;
	
	@Autowired
	private MemberService memberService;
	
	@Resource(name="shaEncoder")
	private ShaEncoder encoder;
	
    /**
     * log를 남기는 객체 생성
     * @author : 김준석(2018-02-17)
     */
    private static final Logger logger = LoggerFactory.getLogger(MemberController.class);

    /**
     * 회원 정보 리스트
     * @author : 김준석(2017-07-06)
     */
    @RequestMapping(value = "/memberList", method = RequestMethod.POST)
    public @ResponseBody DataList<UserVO> memberList(UserVO user) throws Exception {
    	DataList<UserVO> result = new DataList<UserVO>();
    	
    	result.setPagingYn(user.getPagingYn());
    	
    	// 페이징 처리인 경우만 페이지 번호와 토탈 갯수를 저장한다.
		if(result.getPagingYn().equals("Y")) {
			result.setNumOfNums(user.getNumOfNums());
			result.setNumOfRows(user.getNumOfRows());
			result.setPageNo(user.getPageNo());
			result.setTotalCount(memberService.memberTotalCnt(user));
		}

		// 결과 리스트를 저장
		result.setList(memberService.memberList(user));
		
		for (int i = 0; i < result.size(); i++) {
			System.out.println(result.get(i).toString());
		}
		return result;
    }
    
    /**
	 * 회원 관리 엑셀 다운로드
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/excel/download/memberList", method = RequestMethod.POST)
	public ModelAndView excelDownloadMemberList(UserVO user) throws Exception {
		
		Map<String, Object> map		= new HashMap<String, Object>();
		List<Object> hederList		= new ArrayList<Object>();
		List<Object> bodyList		= new ArrayList<Object>();
		List<Object> bodyWidthList	= new ArrayList<Object>();
	
		// 모든 데이터를 가져오기 위해.. paging 여부를 N으로 설정
		user.setPagingYn("N");
		 
		// 리스트 조회
		List<UserVO> dataList = memberService.memberList(user);

		String[] heder = new String[]{"성명","아이디","휴대전화","전자우편","가입일자"};
		int[] bodyWidth = new int[]{10, 20, 10, 20, 10};
		
		for(int i=0; i<dataList.size(); ++i) {
			UserVO temp = dataList.get(i);
			String[] body = new String[heder.length];
			 
			SimpleDateFormat before_format	= new SimpleDateFormat("yyyyMMddhhmmss");
			SimpleDateFormat after_format	= new SimpleDateFormat("yyyy-MM-dd");
			Date regDate = !StringUtil.isEmpty(temp.getRegDate()) ? before_format.parse(temp.getRegDate()) : null;
           
			body[0] = temp.getName();
			body[1] = temp.getId();
			body[2] = temp.getPhone();
			body[3] = temp.getEmail();		 
			body[4] = regDate != null ? after_format.format(regDate) : "";
			 
			bodyList.add(body);
		}
		 
		hederList.add(heder);
		bodyWidthList.add(bodyWidth);

		map.put("fileName", "회원관리리스트_"+GlobalMethod.getNow("yyyyMMddHHmmss")+".xls");
		map.put("header", hederList);
		map.put("body", bodyList);
		map.put("bodyWidth", bodyWidthList);

		return new ModelAndView("excelDownLoad", "excelMap", map);
	}
    
    /**
     * 회원 상세 정보
     * ajax용으로 사용 될 경우(페이지 이동 방식에선 사용 안함)
     * @author : 김준석(2017-07-06)
     */
    @RequestMapping(value = "/memberInfo", method = RequestMethod.POST)
    public @ResponseBody UserVO memberInfo(UserVO user) throws Exception {
    	UserVO result = null;

		// 결과 리스트를 저장
    	result = memberService.memberInfo(user);

		return result;
    }
    
    /**
     * 회원관리 : 회원 추가 or 수정
     * ajax용으로 사용 될 경우(현재사용)
     * @author 김준석(2018-02-20)
     */
    @RequestMapping(value="/memberReg", method=RequestMethod.POST)
    public @ResponseBody UserVO memberReg(UserVO user) throws Exception {
        if(user != null) {
            // 로그인 된 관리자 정보
        	MemberVO loginUser = (MemberVO)LoginHelper.getLoginInfo();

    		// 메일 발송과 별개로 올레측 DB에 저장한다.
        	user.setRegUser(loginUser);
        	user.setUpdUser(loginUser);

        	memberService.memberReg(user);
        }

        return user;
    }
    
    
    /**
     * 회원관리 : 회원 수정
     * 페이지 이동 방식(현재사용안함) X
     * @author 김준석(2018-02-20)
     */
    @RequestMapping(value="/memberUpd", method=RequestMethod.POST)
    public @ResponseBody UserVO memberUpd(UserVO user, RedirectAttributes redirectAttr) throws Exception {
        if(user != null) {
            // 로그인 된 관리자 정보
        	MemberVO loginUser = (MemberVO)LoginHelper.getLoginInfo();

    		// 메일 발송과 별개로 올레측 DB에 저장한다.
        	user.setRegUser(loginUser);
        	user.setUpdUser(loginUser);

        	// 프런트단과 맞춰서 비밀번호 hash
        	String enc_pw = encoder.saltEncoding(user.getPw(), user.getId());
        	user.setPw(enc_pw);
 
            //사용자정보수정(필수)
        	int result = memberService.memberUpd(user);
        	     		
        	//사용자 선택정보 테이블 유무 확인
        	int ifAdditionalInfoExistAdmin = memberService.selectIfAdditionalInfoExistAdmin(user.getId());
        	
        	//사용자정보수정(선택)
        	int additionalResult= 0;
        	if(ifAdditionalInfoExistAdmin >0){
        		additionalResult = memberService.updateAdditionalMemberInfoAdmin(user);
        	}else{
        		additionalResult = memberService.insertAdditionalMemberInfoAdmin(user);
        	}

        	// 검색 조건 저장
            redirectAttr.addFlashAttribute("search", user.getSearch());
        }
        return user;
    }
    
    /**
     * 회원관리 DB 상에서 삭제
     * ajax용으로 사용 될 경우(현재사용)
     * @author 김준석(2018-02-20)
     */
    @RequestMapping(value="/memberDel", method=RequestMethod.POST)
    public @ResponseBody int memberDel(UserVO user) throws Exception {
    	int result = memberService.memberDel(user);
        
        return result;
    }
    
    /**
     * 연수신청관리 : 회원관리 선택 삭제
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/memberSelectDel", method=RequestMethod.POST)
    public @ResponseBody int memberSelectDel(@RequestBody RequestList<UserVO> requestList) throws Exception {
    	int result = 0;
    	List<UserVO> userList = requestList.getList();

    	if(userList != null && userList.size() > 0) {
			// 삭제처리
			result = memberService.memberSelectDel(userList);
    	}

        return result;
    }
    
    /**
     * 선택 된 회원 비밀번호 초기화(1234로 변경)
     * @author 김준석(2018-02-20)
     */
    @RequestMapping(value="/userPwInit", method=RequestMethod.POST)
    public @ResponseBody int userPwInit(UserVO user) throws Exception {
    	// 프런트단과 맞춰서 비밀번호 hash 비밀번호 초기화 시 1234
    	String pw = "1234";
    	String enc_pw = encoder.saltEncoding(pw, user.getId());
    	user.setPw(enc_pw);
    	 
    	int result = memberService.userPwInit(user);
    	
    	return result;
    }
    
    /**
     * 탈퇴회원 정보 리스트
     * @author : 김준석(2018-02-20)
     */
    @RequestMapping(value = "/memberOutList", method = RequestMethod.POST)
    public @ResponseBody DataList<WithdrawalVO> memberOutList(WithdrawalVO withdrawal) throws Exception {
    	DataList<WithdrawalVO> result = new DataList<WithdrawalVO>();
    	
    	result.setPagingYn(withdrawal.getPagingYn());
    	
    	// 페이징 처리인 경우만 페이지 번호와 토탈 갯수를 저장한다.
		if(result.getPagingYn().equals("Y")) {
			result.setNumOfNums(withdrawal.getNumOfNums());
			result.setNumOfRows(withdrawal.getNumOfRows());
			result.setPageNo(withdrawal.getPageNo());
			result.setTotalCount(memberService.memberOutTotalCnt(withdrawal));
		}

		// 결과 리스트를 저장
		result.setList(memberService.memberOutList(withdrawal));

		return result;
    }
    
    /**
	 * 탈퇴회원 엑셀 다운로드
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/excel/download/memberOutList", method = RequestMethod.POST)
	public ModelAndView excelDownloadMemberOutList(WithdrawalVO withdrawal) throws Exception {
		Map<String, Object> map		= new HashMap<String, Object>();
		List<Object> hederList		= new ArrayList<Object>();
		List<Object> bodyList		= new ArrayList<Object>();
		List<Object> bodyWidthList	= new ArrayList<Object>();

		// 모든 데이터를 가져오기 위해.. paging 여부를 N으로 설정
		withdrawal.setPagingYn("N");

		// 리스트 조회
		List<WithdrawalVO> dataList = memberService.memberOutList(withdrawal);

		String[] heder = new String[]{"접수일시","접수번호","아이디","회원명","사유/비고"};
		int[] bodyWidth = new int[]{20, 10, 20, 10, 50};

		for(int i=0; i<dataList.size(); ++i) {
			WithdrawalVO temp = dataList.get(i);
			String[] body = new String[heder.length];
			SimpleDateFormat before_format	= new SimpleDateFormat("yyyyMMddhhmmss");
			SimpleDateFormat after_format	= new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
			Date regDate = !StringUtil.isEmpty(temp.getRegDate()) ? before_format.parse(temp.getRegDate()) : null;
			
			body[0] = regDate != null ? after_format.format(regDate) : "";
			body[1] = temp.getId()+"";
			body[2]	= temp.getUser().getId();
			body[3] = temp.getUser().getName();
			body[4] = temp.getNote();

			bodyList.add(body);
		}

		hederList.add(heder);
		bodyWidthList.add(bodyWidth);

		map.put("fileName", "탈퇴회원관리리스트_"+GlobalMethod.getNow("yyyyMMddHHmmss")+".xls");
		map.put("header", hederList);
		map.put("body", bodyList);
		map.put("bodyWidth", bodyWidthList);

		return new ModelAndView("excelDownLoad", "excelMap", map);
	}
    
    /**
     * 관리자 정보 리스트
     * @author : 김준석(2018-02-20)
     */
    @RequestMapping(value = "/managerList", method = RequestMethod.POST)
    public @ResponseBody DataList<MemberVO> managerList(MemberVO manager) throws Exception {
    	DataList<MemberVO> result = new DataList<MemberVO>();
    	
    	result.setPagingYn(manager.getPagingYn());
    	
    	// 페이징 처리인 경우만 페이지 번호와 토탈 갯수를 저장한다.
		if(result.getPagingYn().equals("Y")) {
			result.setNumOfNums(manager.getNumOfNums());
			result.setNumOfRows(manager.getNumOfRows());
			result.setPageNo(manager.getPageNo());
			result.setTotalCount(baseService.memberTotalCnt(manager));
		}
		
		// 결과 리스트를 저장
		result.setList(baseService.memberList(manager));

		return result;
    }
    
    /**
	 * 관리자 관리 엑셀 다운로드
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/excel/download/managerList", method = RequestMethod.POST)
	public ModelAndView excelDownloadManagerList(MemberVO manager) throws Exception {
		Map<String, Object> map		= new HashMap<String, Object>();
		List<Object> hederList		= new ArrayList<Object>();
		List<Object> bodyList		= new ArrayList<Object>();
		List<Object> bodyWidthList	= new ArrayList<Object>();
		String managerType = "";
		
		// 모든 데이터를 가져오기 위해.. paging 여부를 N으로 설정
		manager.setPagingYn("N");

		// 리스트 조회
		List<MemberVO> dataList = baseService.memberList(manager);

		String[] heder = new String[]{"아이디","성명","최근접속일시","일반전화","휴대전화","이메일","상태"};
		int[] bodyWidth = new int[]{10, 10, 20, 10, 10, 20, 10};

		for(int i=0; i<dataList.size(); ++i) {
			MemberVO temp = dataList.get(i);
			String[] body = new String[heder.length];
			SimpleDateFormat before_format	= new SimpleDateFormat("yyyyMMddhhmmss");
			SimpleDateFormat after_format	= new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
			Date regDate = !StringUtil.isEmpty(temp.getRegDate()) ? before_format.parse(temp.getRegDate()) : null;

			body[0] = temp.getId();
			body[1] = temp.getName();
			body[2]	= regDate != null ? after_format.format(regDate) : "";
			body[3] = temp.getTel();
			body[4] = temp.getPhone();
			body[5] = temp.getEmail();
			body[6] = !StringUtil.isEmpty(temp.getUseYn()) && temp.getUseYn().equals("N") ? "중지" : "정상" ;

			bodyList.add(body);
		}

		hederList.add(heder);
		bodyWidthList.add(bodyWidth);

		managerType = manager.getGrade() == 1 ? "튜터"
				   	: manager.getGrade() == 2 ? "강사"
				    : manager.getGrade() == 3 ? "업체"
				    : manager.getGrade() == 8 ? "관리자" : "최고관리자";
		
		map.put("fileName", managerType+"리스트_"+GlobalMethod.getNow("yyyyMMddHHmmss")+".xls");
		map.put("header", hederList);
		map.put("body", bodyList);
		map.put("bodyWidth", bodyWidthList);

		return new ModelAndView("excelDownLoad", "excelMap", map);
	}
    
    /**
	 * 멤버 ID 중복 체크 API(0이면 중복 아님, 1이면 중복)
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/managerIdCheck", method=RequestMethod.POST)
	public @ResponseBody int managerIdCheck(MemberVO member) throws Exception {
		return baseService.memberIdCheck(member);
	}
	
	/**
     * 관리자관리 : 관리자 추가 or 수정
     * ajax용으로 사용 될 경우(현재사용)
     * @author 김준석(2018-02-20)
     */
    @RequestMapping(value="/managerReg", method=RequestMethod.POST)
    public @ResponseBody ManagerVO managerReg(ManagerVO manager) throws Exception {
        if(manager != null) {
            // 로그인 된 관리자 정보
        	MemberVO loginUser = (MemberVO)LoginHelper.getLoginInfo();

    		// 메일 발송과 별개로 올레측 DB에 저장한다.
        	manager.setRegUser(loginUser);
        	manager.setUpdUser(loginUser);

        	// baseService.memberReg(member);
        	memberService.managerReg(manager);
        }

        return manager;
    }
    
    /**
     * 관리자관리 DB 상에서 삭제
     * ajax용으로 사용 될 경우(현재사용)
     * @author 김준석(2018-02-20)
     */
    @RequestMapping(value="/managerDel", method=RequestMethod.POST)
    public @ResponseBody int managerDel(ManagerVO manager) throws Exception {
    	// int result = baseService.memberDel(member);
    	int result = memberService.managerDel(manager);
        
        return result;
    }
    
    /**
     * 관리자관리 선택 삭제
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/managerSelectDel", method=RequestMethod.POST)
    public @ResponseBody int managerSelectDel(@RequestBody RequestList<ManagerVO> requestList) throws Exception {
    	int result = 0;
    	List<ManagerVO> managerList = requestList.getList();

    	if(managerList != null && managerList.size() > 0) {
			// 삭제처리
			result = memberService.managerSelectDel(managerList);
    	}

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