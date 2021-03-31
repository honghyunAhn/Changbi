package com.changbi.tt.dev.admin.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import forFaith.dev.service.BaseService;
import forFaith.dev.vo.MemberVO;

@Controller(value = "admin.adminController")
@RequestMapping(value = "/admin/adminManagement")
public class AdminController {

	@Autowired
	BaseService baseService;
	
	@RequestMapping(value = "/adminManagementForm")
	public void adminManagementForm(MemberVO member, Model model) {
		model.addAttribute("search", member);
	}
	@RequestMapping(value = "/adminManagementHistory")
	public void adminManagementHistory(MemberVO member, Model model) {
		model.addAttribute("search", member);
	}
}
