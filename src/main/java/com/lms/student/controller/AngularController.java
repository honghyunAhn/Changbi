/**
 * 
 */
package com.lms.student.controller;

import java.util.Locale;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.lms.student.exception.GroupIdNotFoundException;
import com.lms.student.service.LMSCommonService;

import forFaith.util.CodeConverter;


/**
 * @Author : 이종호
 * @Date : 2017. 7. 21.
 * @Class 설명 : AngularJS를 위한 샘플 컨트롤러 
 * 
 */
@Controller
public class AngularController {
	
	@Autowired
	LMSCommonService lcs;
	
	@ResponseBody
	@RequestMapping(value = "codeconverter", method = RequestMethod.POST,produces = "application/text; charset=utf8")
	public String codeconverter(@RequestParam("code") String code, Locale locale){
		String result = "";
		try {
			result = lcs.selectCodeName(CodeConverter.getCodeMap(code, locale));
		} catch (GroupIdNotFoundException e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
}
