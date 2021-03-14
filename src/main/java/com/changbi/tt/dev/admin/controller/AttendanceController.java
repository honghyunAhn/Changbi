package com.changbi.tt.dev.admin.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.changbi.tt.dev.data.dao.AttendanceDAO;
import com.changbi.tt.dev.data.vo.SmtpAttendanceVO;
import com.changbi.tt.dev.data.vo.UserVO;

@Controller(value="admin.attendanceController")
@RequestMapping("/admin/attendance")
public class AttendanceController {
	
	/**
     * 출결일수관리
     */
    @RequestMapping(value="/insertDate")
    public void insertDate(@ModelAttribute("search") UserVO user, ModelMap model) {
    	
    		System.out.println("확인 : " + user.toString());
    	
    }
    
	/**
     * 출결관리
     */
    @RequestMapping(value="/attendanceCheck")
    public void attendanceCheck(@ModelAttribute("search") UserVO user, ModelMap model) {
    }
    
}
