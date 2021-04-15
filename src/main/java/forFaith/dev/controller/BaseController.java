package forFaith.dev.controller;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import forFaith.dev.service.BaseService;
import forFaith.dev.util.LoginHelper;
import forFaith.dev.vo.CodeGroupVO;
import forFaith.dev.vo.CodeVO;
import forFaith.dev.vo.MemberVO;
import forFaith.domain.SendData;
import forFaith.domain.MultiRequest;
import forFaith.util.DataList;
import forFaith.util.EmailSender;
import forFaith.util.StringUtil;

/**
 * @Class Name : BaseController.java
 * @Description : 로그인, 코드 관련 기능제공
 * @Modification Information
 * @ @ 수정일 수정자 수정내용 @ ------- -------- --------------------------- @ 2017.03.21
 *   김준석 최초 생성
 *
 * @author kjs
 * @since 2017.03.21
 * @version 1.0
 * @see
 *
 */

@Controller("forFaith.baseController")
@RequestMapping("/forFaith/base")
public class BaseController extends CommonController {
	@Autowired
	private BaseService baseService;

	@Autowired
	private BCryptPasswordEncoder passwordEncoder;

	/** 이메일 발송 시 사용 */
	@Autowired
	private EmailSender emailSender;

	@Resource(name = "messageSource")
	private MessageSource messageSource;

	/**
	 * log를 남기는 객체 생성
	 * 
	 * @author : 김준석(2016-10-10)
	 */
	private static final Logger logger = LoggerFactory.getLogger(BaseController.class);

	/**
	 * 메인 화면
	 * 
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/main")
	public void main() throws Exception {
	}
	
	/**
	 * 로그인화면
	 * 
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/login")
	public String login(@ModelAttribute("member") MemberVO member, HttpServletRequest request, ModelMap model)
			throws Exception {
		// 세션에 저장되어 있던 link을 저장하고 세션에서 삭제시킴
		// link이 모델에 저장되어 있다면 action에서 넘어온거고 세션에 저장되어 있다면 최초 호출 시 넘어온 경우
		if (!StringUtil.isEmpty(request.getSession().getAttribute("link"))) {
			member.setLink(request.getSession().getAttribute("link") + "");
		}

		// 세션의 link 삭제 시킴
		request.getSession().removeAttribute("link");

		// 이미 로그인 정보가 세션이 존재하면 메인 페이지로 이동시킨다.
		if (LoginHelper.isAuth()) {
			return "redirect:/forFaith/base/main";
		} else {
			return "/forFaith/base/login";
		}
	}

	/**
	 * 로그인처리
	 * 
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/actionLogin", method = RequestMethod.POST)
	public String actionLogin(MemberVO member, HttpServletRequest request, RedirectAttributes redirectAttr)
			throws Exception {
		// 먼저 현재 로그인이 되어 있는지 먼저 판단함. 세션이 존재하면 메인으로 이동시키고 세션이 존재 하지 않으면 로그인 처리를
		// 한다.
		if (LoginHelper.isAuth()) {
			return "redirect:/forFaith/base/main";
		} else {
			MemberVO loginInfo = null;
			try {
				loginInfo = baseService.actionLogin(member);
			} catch (Exception e) {
				e.printStackTrace();
			}
			if (loginInfo != null && !StringUtil.isEmpty(loginInfo.getId())) {
				
				SimpleDateFormat fmt = new SimpleDateFormat("yyyy-MM-dd");
				
				//권한 만료 알림
				Date authExpiredEt = fmt.parse(loginInfo.getAuthExpiredEt());
				Date today = new Date();
				
				if(authExpiredEt.compareTo(today) < 0) {
					member.setMsg("접근권한이 만료되었습니다. 관리자에게 문의하시기 바랍니다.");
					redirectAttr.addFlashAttribute("member", member);
					return "redirect:/forFaith/base/login";
				}
				if(loginInfo.getUseYn().equals("N")) {
					member.setMsg("접근권한이 없습니다. 관리자에게 문의하시기 바랍니다.");
					redirectAttr.addFlashAttribute("member", member);
					return "redirect:/forFaith/base/login";
				}
				if (passwordEncoder.matches(member.getPw(), loginInfo.getPw())) {

					// 접근 주소 저장
					loginInfo.setIpAddress(getIp(request));

					// 로그인 성공 시(세션에 저장 시킴)
					LoginHelper.setLoginInfo(loginInfo);

					// 로그인 성공 시 로그인 시간을 update 시킴
					baseService.memberLoginUpd(loginInfo);

					// 모든 경우에 로그인 history 저장
					baseService.memberLoginHistory(loginInfo);
					
					Date pwExpiredEt = fmt.parse(loginInfo.getPwExpiredEt());
					
					int pwRemaining = pwExpiredEt.compareTo(today);
					
					//비밀번호 기한이 7일 이하이면 남은 기한정보를 화면으로 보냄
					if(pwRemaining <= 7) {
						member.setMsg(String.valueOf(pwRemaining));
						redirectAttr.addFlashAttribute("member", member);
					}
					
					return "redirect:"
							+ (StringUtil.isEmpty(member.getLink()) ? "/forFaith/base/main" : member.getLink());

				} else {
					member.setMsg("아이디 또는 비밀번호가 잘못되었습니다.");

					redirectAttr.addFlashAttribute("member", member);
					return "redirect:/forFaith/base/login";
				}

			} else {
				member.setMsg("아이디 또는 비밀번호가 잘못되었습니다.");

				redirectAttr.addFlashAttribute("member", member);
				return "redirect:/forFaith/base/login";
			}
		}
	}

	/**
	 * 로그아웃
	 * 
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/logout")
	public String logout() throws Exception {
		LoginHelper.setLogOut();

		return "redirect:/forFaith/base/login";
	}

	/**
	 * 멤버 관리 리스트 페이지
	 * 
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/memberList")
	public void memberList(@ModelAttribute("search") MemberVO member, ModelMap model) throws Exception {
		// 페이징 처리는 member 객체 내에 Paging 객체를 상속 받기 때문에 view 화면에서 search로 페이징 처리하면
		// 됨.
		// 페이징 처리를 하려면 VO 객체 내에 Common 객체를 상속해서 쓰면 됨.
		if (member.getPagingYn().equals("Y")) {
			member.setTotalCount(baseService.memberTotalCnt(member));
		}

		model.addAttribute("memberList", baseService.memberList(member));
	}

	/**
	 * 멤버 관리 추가 or 수정 페이지
	 * 
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/memberEdit")
	public void memberEdit(MemberVO member, ModelMap model) throws Exception {
		// 최고 관리자(9) 인 경우 처리
		if (member != null && !StringUtil.isEmpty(member.getId())) {
			// 선택 된 ID가 없으면 바로 edit 화면으로 이동하고 선택 된 ID가 있으면 해당 아카데미 정보를 가지고 간다.
			model.addAttribute("member", baseService.memberInfo(member));
		}

		// 검색 조건 저장
		model.addAttribute("search", member);
	}

	/**
	 * 멤버 추가 or 수정
	 * 
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/memberReg", method = RequestMethod.POST)
	public String memberReg(MemberVO member, RedirectAttributes redirectAttr) throws Exception {
		// 로그인 된 정보
		MemberVO loginUser = (MemberVO) LoginHelper.getLoginInfo();

		// 메일 발송과 별개로 올레측 DB에 저장한다.
		member.setRegUser(loginUser);
		member.setUpdUser(loginUser);

		baseService.memberReg(member);

		// 검색 조건 저장(리다이렉트에서 사용)
		redirectAttr.addFlashAttribute("search", member.getSearch());
		return "redirect:/forFaith/base/memberList";
	}

	/**
	 * 멤버 DB 상에서 삭제
	 * 
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/memberDel", method = RequestMethod.POST)
	public String memberDel(MemberVO member, RedirectAttributes redirectAttr) throws Exception {
		baseService.memberDel(member);

		// 검색 조건 저장
		redirectAttr.addFlashAttribute("search", member);
		return "redirect:/forFaith/base/memberList";
	}

	/**
	 * 멤버 사용 여부 상태값 변경 API
	 * 
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/memberUseChange", method = RequestMethod.POST)
	public @ResponseBody int memberUseChange(@RequestBody MultiRequest<MemberVO> multiRequest) throws Exception {
		int result = 0;

		if (multiRequest.getList() != null && multiRequest.getList().size() > 0) {
			// 로그인 된 정보
			MemberVO loginUser = (MemberVO) LoginHelper.getLoginInfo();

			// 로그인 된 유저 정보 입력
			multiRequest.getList().get(0).setUpdUser(loginUser);

			// 변경처리
			result = baseService.memberUseChange(multiRequest.getList());
		}

		return result;
	}

	/**
	 * 멤버 ID 중복 체크 API(0이면 중복 아님, 1이면 중복)
	 * 
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/memberIdCheck", method = RequestMethod.POST)
	public @ResponseBody int memberIdCheck(MemberVO member) throws Exception {
		return baseService.memberIdCheck(member);
	}

	/**
	 * 마이 페이지
	 * 
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/myPage")
	public void myPage(ModelMap model) throws Exception {
		if (LoginHelper.isAuth()) {
			MemberVO member = (MemberVO) LoginHelper.getLoginInfo();
			// 선택 된 ID가 없으면 바로 edit 화면으로 이동하고 선택 된 ID가 있으면 해당 아카데미 정보를 가지고 간다.
			model.addAttribute("member", baseService.memberInfo(member));
		}
	}

	/**
	 * 마이페이지 수정
	 * 
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/myPageReg", method = RequestMethod.POST)
	public String myPageReg(MemberVO member) throws Exception {
		// 로그인 된 정보
		MemberVO loginUser = (MemberVO) LoginHelper.getLoginInfo();

		// 메일 발송과 별개로 올레측 DB에 저장한다.
		member.setRegUser(loginUser);
		member.setUpdUser(loginUser);

		baseService.memberReg(member);

		return "redirect:/forFaith/base/myPage";
	}

	/**
	 * 코드 등록 페이지 호출
	 */
	@RequestMapping(value = "/code", method = RequestMethod.POST)
	public void code(CodeVO code, ModelMap model) throws Exception {
		// 코드분류그룹 조회
		model.addAttribute("codeGroup", baseService.codeGroupInfo(code.getCodeGroup()));
	}

	/**
	 * 코드 리스트 조회
	 */
	@RequestMapping(value = "/codeList", method = RequestMethod.POST)
	public @ResponseBody DataList<CodeVO> codeList(CodeVO code, ModelMap model) throws Exception {
		DataList<CodeVO> result = new DataList<CodeVO>();

		// 모든 데이터를 가지고 와야함 페이징 처리 안함
		code.setPagingYn("N");

		// 결과 리스트를 저장
		result.setList(baseService.codeList(code));

		return result;
	}

	/**
	 * 대중소분류 코드 리스트 조회
	 */
	@RequestMapping(value = "/cateCodeList", method = RequestMethod.POST)
	public @ResponseBody List<CodeVO> cateCodeList(CodeVO code, ModelMap model) throws Exception {
		// DataList<CodeVO> result = new DataList<CodeVO>();

		List<CodeVO> codeList = baseService.cateCodeList();
		List<CodeVO> result = new ArrayList<CodeVO>();

		for (int i = 0; i < codeList.size(); i++) {
			if (codeList.get(i).getDepth() == 1) {
				result.add(codeList.get(i));
			}
		}
		for (int i = 0; i < result.size(); i++) {
			
			List<CodeVO> sons = new ArrayList<CodeVO>();
			
			for (int j = 0; j < codeList.size(); j++) {
				if (result.get(i).getCode().equals(codeList.get(j).getParentcode())) {
					sons.add(codeList.get(j));
				}
			}

			result.get(i).setChildCodeList(sons);
		}
		
		for (int i = 0; i < result.size(); i++) {
			
			for (int j = 0; j <result.get(i).getChildCodeList().size(); j++) {
				List<CodeVO> grandSons = new ArrayList<CodeVO>();
				
				for (int k = 0; k < codeList.size(); k++) {
					if (result.get(i).getChildCodeList().get(j).getCode().equals(codeList.get(k).getParentcode())) {
						grandSons.add(codeList.get(k));
					}
				}
				result.get(i).getChildCodeList().get(j).setChildCodeList(grandSons);
			}
		}


		return result;
	}

	/**
	 * 코드 저장 및 수정
	 */
	@RequestMapping(value = "/codeReg", method = RequestMethod.POST)
	public @ResponseBody boolean codeReg(String big, String middle, String small, String bigCode, String middleCode,
			String smallCode,String code,String orderNum,String name) throws Exception {
		/*
		 * if(code != null) { // 로그인 된 관리자 정보 MemberVO loginUser =
		 * (MemberVO)LoginHelper.getLoginInfo();
		 * 
		 * // 메일 발송과 별개로 올레측 DB에 저장한다. code.setRegUser(loginUser);
		 * code.setUpdUser(loginUser);
		 * 
		 * baseService.codeReg(code); }
		 */

		List<HashMap<String, String>> result = new ArrayList<HashMap<String, String>>();

		MemberVO loginUser = (MemberVO) LoginHelper.getLoginInfo();

		String grandParent = null;
		String parent = null;
		String son = null;
		System.out.println(bigCode+","+middleCode);
		
		
		if(bigCode==null&&middleCode==null) {
			
			
			CodeVO codeVo = new CodeVO();
			codeVo.setRegUser(loginUser);
			codeVo.setUpdUser(loginUser);

			codeVo.setOrderNum(Integer.parseInt(orderNum));
			codeVo.setName(name);
			codeVo.setCode(code);
			codeVo.setDepth(1);
			
			CodeGroupVO cg = new CodeGroupVO();
			cg.setId("faq");

			codeVo.setCodeGroup(cg);

			baseService.codeReg(codeVo);
			
			
			
			
		}else if(bigCode.equals("")){//대분류참조안함
			
			if (big != null) {// 대분류
				if(!big.equals("")){
				CodeVO codeVo = new CodeVO();
				codeVo.setRegUser(loginUser);
				codeVo.setUpdUser(loginUser);

				baseService.makeCategorySequence();
				grandParent = "CATESEQ" + baseService.selectCategorySequence();
				codeVo.setCode(grandParent);
				codeVo.setDepth(1);
				codeVo.setName(big);

				CodeGroupVO cg = new CodeGroupVO();
				cg.setId("categorysequence");

				codeVo.setCodeGroup(cg);

				baseService.codeReg(codeVo);
				}
			}

			if (middle != null) {// 중분류
				if(!middle.equals("")){
				CodeVO codeVo = new CodeVO();
				codeVo.setRegUser(loginUser);
				codeVo.setUpdUser(loginUser);

				baseService.makeCategorySequence();
				parent = "CATESEQ" + baseService.selectCategorySequence();
				codeVo.setCode(parent);
				codeVo.setDepth(2);
				codeVo.setName(middle);
				CodeVO parentCode = new CodeVO();
				parentCode.setCode(grandParent);
				codeVo.setParentCode(parentCode);

				CodeGroupVO cg = new CodeGroupVO();
				cg.setId("categorysequence");

				codeVo.setCodeGroup(cg);

				baseService.codeReg(codeVo);
				}
			}

			if (small != null) {// 소분류
				if(!small.equals("")){
				CodeVO codeVo = new CodeVO();
				codeVo.setRegUser(loginUser);
				codeVo.setUpdUser(loginUser);

				baseService.makeCategorySequence();
				son = "CATESEQ" + baseService.selectCategorySequence();
				codeVo.setCode(son);
				codeVo.setDepth(3);
				codeVo.setName(small);
				CodeVO parentCode = new CodeVO();
				parentCode.setCode(parent);
				codeVo.setParentCode(parentCode);

				CodeGroupVO cg = new CodeGroupVO();
				cg.setId("categorysequence");

				codeVo.setCodeGroup(cg);

				baseService.codeReg(codeVo);
				}
			}
			
		}else{//대분류 참조
			System.out.println("대분류 참조");
			
			if(middleCode.equals("")){//대분류는 참조하지만, 중분류는 참조안함
				System.out.println("대분류는 참조하지만, 중분류는 참조안함");
				
				if (middle != null) {// 중분류
					if(!middle.equals("")){
					CodeVO codeVo = new CodeVO();
					codeVo.setRegUser(loginUser);
					codeVo.setUpdUser(loginUser);

					baseService.makeCategorySequence();
					parent = "CATESEQ" + baseService.selectCategorySequence();
					codeVo.setCode(parent);
					codeVo.setDepth(2);
					codeVo.setName(middle);
					CodeVO parentCode = new CodeVO();
					parentCode.setCode(bigCode);
					codeVo.setParentCode(parentCode);

					CodeGroupVO cg = new CodeGroupVO();
					cg.setId("categorysequence");

					codeVo.setCodeGroup(cg);

					baseService.codeReg(codeVo);
					}
				}

				if (small != null) {// 소분류
					if(!small.equals("")){
					CodeVO codeVo = new CodeVO();
					codeVo.setRegUser(loginUser);
					codeVo.setUpdUser(loginUser);

					baseService.makeCategorySequence();
					son = "CATESEQ" + baseService.selectCategorySequence();
					codeVo.setCode(son);
					codeVo.setDepth(3);
					codeVo.setName(small);
					CodeVO parentCode = new CodeVO();
					parentCode.setCode(parent);
					codeVo.setParentCode(parentCode);

					CodeGroupVO cg = new CodeGroupVO();
					cg.setId("categorysequence");

					codeVo.setCodeGroup(cg);

					baseService.codeReg(codeVo);
					}
				}
				
			}else{//대분류 중분류 모두 참조
				System.out.println("대분류 중분류 모두 참조");
				
				if (small != null) {// 소분류
					if(!small.equals("")){
					
					CodeVO codeVo = new CodeVO();
					codeVo.setRegUser(loginUser);
					codeVo.setUpdUser(loginUser);

					baseService.makeCategorySequence();
					son = "CATESEQ" + baseService.selectCategorySequence();
					codeVo.setCode(son);
					codeVo.setDepth(3);
					codeVo.setName(small);
					CodeVO parentCode = new CodeVO();
					parentCode.setCode(middleCode);
					codeVo.setParentCode(parentCode);

					CodeGroupVO cg = new CodeGroupVO();
					cg.setId("categorysequence");

					codeVo.setCodeGroup(cg);

					baseService.codeReg(codeVo);
					}
				}
				
			}
			
		}
		

		return true;
	}

	/**
	 * 코드 사용여부 업데이트
	 * 
	 * @author 전상수(2019-12-13)
	 */
	
	@RequestMapping(value = "/codeYnUpt", method = RequestMethod.POST)
	public @ResponseBody boolean codeYnUpt(String code, String yn) throws Exception {
		
		System.out.println("*****************************************");
		
		HashMap<String,String> hMap=new HashMap<String,String>();
		hMap.put("code", code);
		
		if(yn.equals("y")){
			hMap.put("yn", "N");
		}else{
			hMap.put("yn", "Y");
		}
		
		int result=baseService.codeYnUpt(hMap);
		
		if(result==1){
			return true;
		}else{
			return false;
		}
	}
	
	/**
	 * 코드 삭제
	 * 
	 * @author 김준석(2018-02-20)
	 */
	@RequestMapping(value = "/codeDel", method = RequestMethod.POST)
	public @ResponseBody int codeDel(CodeVO code) throws Exception {
		int result = baseService.codeDel(code);

		return result;
	}

	/**
	 * - ajax용(이메일 테스트용) - 메일 발송 테스트 관련 실제 사용은 안할수 있음.
	 * 
	 * @param
	 * @return int
	 * @throws IOException
	 */
	@RequestMapping(value = "/emailSendTest", method = RequestMethod.POST)
	public @ResponseBody int emailSendTest(String emailAddr) throws Exception {
		logger.info("email ===> " + emailAddr);

		int result = 1;

		// 이메일 발송
		if (result > 0 && !StringUtil.isEmpty(emailAddr)) {
			// 메일 관련 세팅
			SendData email = new SendData();

			String mailSubject = "";
			StringBuffer mailContent = new StringBuffer();

			// 메일 제목 세팅
			mailSubject = messageSource.getMessage("reply.mail.subject", null, Locale.getDefault());

			// 메일 내용 세팅
			mailContent.append(messageSource.getMessage("reply.mail.content", null, Locale.getDefault()));
			mailContent.append("\n\n\n");
			mailContent.append("문의내용 : \n");
			mailContent.append("테스트 문의" + "\n\n");
			mailContent.append("답글 : \n");
			mailContent.append("테스트 답변");

			// 메일 발송
			email.setReceiver(emailAddr); // 받을 사람 메일주소
			email.setSubject(mailSubject); // 메일 제목
			email.setContent(mailContent.toString()); // 메일 내용

			// 메일 발송
			try {
				emailSender.sendEmail(email);
			} catch (Exception ex) {
			}
		}

		return result;
	}

	/**
	 * Exception
	 * 
	 * @param Exception
	 * @return ModelAndView
	 * @author : KJS(2017-03-17)
	 */
	@ExceptionHandler(Exception.class)
	public ModelAndView exceptionHandler(Exception e) {
		logger.info(e.getMessage());

		return new ModelAndView("/error/exception").addObject("msg", e.getMessage());
	}
}