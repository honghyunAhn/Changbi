/**
 * 회원관리 화면 호출 Controller
 * @author : 김준석(2018-02-17)
 */

package com.changbi.tt.dev.admin.controller;

import javax.annotation.Resource;

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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.changbi.tt.dev.data.service.MemberService;
import com.changbi.tt.dev.data.vo.ManagerVO;
import com.changbi.tt.dev.data.vo.UserVO;
import com.changbi.tt.dev.security.ShaEncoder;

import forFaith.dev.service.BaseService;
import forFaith.dev.util.LoginHelper;
import forFaith.dev.vo.CodeVO;
import forFaith.dev.vo.MemberVO;
import forFaith.util.StringUtil;

@Controller(value="admin.memberController")      // Controller value는 중복되면 안된다. value 값을 지정하지 않으면 클래스명이 value가 되므로 같은 클래스명이 존재하면 중복으로 인식
@RequestMapping("/admin/member")       // 해당 클래스를 호출 하기 위한 Mapping 기본 값 뒤에 붙는 값에 의해 필요한 함수가 호출 된다.
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
     * 회원관리 리스트
     * @author : 김준석(2015-06-03)
     */
    @RequestMapping(value="/memberList")
    public void memberList(@ModelAttribute("search") UserVO user, ModelMap model) throws Exception {}

    /**
     * 회원관리 상세조회
     * 페이지 이동 방식(현재 사용하는 방식)
     * @author 김준석(2018-02-20)
     */
    @RequestMapping(value="/memberEdit")
    public void memberEdit(@ModelAttribute("search") UserVO user, ModelMap model) throws Exception {
        if(user != null && !StringUtil.isEmpty(user.getId())) {
            // 선택 된 ID가 없으면 바로 edit 화면으로 이동하고 선택 된 ID가 있으면 해당 정보를 가지고 간다.
            model.addAttribute("member", memberService.memberInfo(user));
        }

        // 지역 코드 리스트 저장
        CodeVO code = new CodeVO();
        code.getCodeGroup().setId("region");	// 지역 분류 그룹
        code.setUseYn("Y");						// 사용 가능 한 코드만 조회

        // 모든 코드 분류 리스트를 가지고 오기 위해 페이징 처리 안함
        code.setPagingYn("N");

        // 지역 코드 리스트
        model.addAttribute("region", baseService.codeList(code));
    }

    /**
     * 회원관리 : 회원 추가 or 수정
     * 페이지 이동 방식(현재사용안함) X
     * @author 김준석(2018-02-20)
     */
    @RequestMapping(value="/memberReg", method=RequestMethod.POST)
    public String memberReg(UserVO user, RedirectAttributes redirectAttr) throws Exception {
        if(user != null) {
            // 로그인 된 관리자 정보
        	MemberVO loginUser = (MemberVO)LoginHelper.getLoginInfo();

    		// 메일 발송과 별개로 올레측 DB에 저장한다.
        	user.setRegUser(loginUser);
        	user.setUpdUser(loginUser);

        	// 프런트단과 맞춰서 비밀번호 hash
        	String enc_pw = encoder.saltEncoding(user.getPw(), user.getId());
        	user.setPw(enc_pw);

        	memberService.memberReg(user);

        	// 검색 조건 저장
            redirectAttr.addFlashAttribute("search", user.getSearch());
        }

        return "redirect:/admin/member/memberList";
    }

    /**
     * 회원관리 DB 상에서 삭제
     * 페이지 이동 방식(현재사용안함) X
     * @author 김준석(2018-02-20)
     */
    @RequestMapping(value="/memberDel", method=RequestMethod.POST)
    public String memberDel(UserVO user, RedirectAttributes redirectAttr) throws Exception {
    	memberService.memberDel(user);

    	// 검색 조건 저장
        redirectAttr.addFlashAttribute("search", user);

        return "redirect:/admin/member/memberList";
    }

    /**
     * 탈퇴회원관리 리스트
     * @author : 김준석(2015-06-03)
     */
    @RequestMapping(value="/memOutList")
    public void memOutList() {}

    /**
     * 관리자관리 리스트(1 : 튜터, 2 : 강사, 3 : 업체, 8 : 관리자, 9 : 최고관리자)
     * @author : 김준석(2015-06-03)
     */
    @RequestMapping(value="/managerList")
    public void managerList(@ModelAttribute("search") ManagerVO manager) {}

    /**
     * 관리자 상세조회
     * 페이지 이동 방식(현재 사용하는 방식)
     * @author 김준석(2018-02-20)
     */
    @RequestMapping(value="/managerEdit")
    public void managerEdit(@ModelAttribute("search") ManagerVO manager, ModelMap model) throws Exception {
        if(manager != null && !StringUtil.isEmpty(manager.getId())) {
            // 선택 된 ID가 없으면 바로 edit 화면으로 이동하고 선택 된 ID가 있으면 해당 정보를 가지고 간다.
        	// model.addAttribute("manager", baseService.memberInfo(manager));
            model.addAttribute("manager", memberService.managerInfo(manager));
        }

        // 과정분류 리스트 가져오기
        CodeVO code = new CodeVO();
        
        code.setUseYn("Y");
        code.setPagingYn("N");
        code.getCodeGroup().setId("course");
        
        model.addAttribute("courseList", baseService.codeList(code));
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