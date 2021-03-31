package com.changbi.tt.dev.data.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;

import forFaith.dev.service.BaseService;
import forFaith.dev.util.LoginHelper;
import forFaith.dev.vo.MemberVO;
import forFaith.util.DataList;

@Controller(value = "data.adminController")
@RequestMapping(value = "/data/adminManagement")
public class AdminController {

	private final Logger logger = LoggerFactory.getLogger(AdminController.class);
	
	@Autowired
	BaseService baseService;
	
	@Autowired
	private BCryptPasswordEncoder passwordEncoder;
	
	@ResponseBody
	@RequestMapping(value = "/adminList")
	public Object adminList(MemberVO member, Model model) throws Exception {
    	// 일반 게시물 리스트 가져오기
    	DataList<MemberVO> result = new DataList<MemberVO>();

    	result.setPagingYn(member.getPagingYn());
    	// 페이징 처리인 경우만 페이지 번호와 토탈 갯수를 저장한다.
		if(result.getPagingYn().equals("Y")) {
			result.setNumOfNums(member.getNumOfNums());
			result.setNumOfRows(member.getNumOfRows());
			result.setPageNo(member.getPageNo());
			result.setTotalCount(baseService.memberTotalCnt(member));
		}
		// 결과 리스트를 저장
		result.setList(baseService.memberList(member));
		model.addAttribute("dataList", result);
		return result;
	}
	
	@ResponseBody
	@RequestMapping(value = "/adminReg")
	public Object adminReg(MemberVO member) throws Exception {
		int result = 0;
		
		// 로그인 된 정보
		MemberVO loginUser = (MemberVO) LoginHelper.getLoginInfo();
		
		member.setRegUser(loginUser);
		member.setUpdUser(loginUser);
		
		member.setPw(passwordEncoder.encode(member.getPw()));
		
		result = baseService.memberReg(member);
		return result;
	}
	
}
