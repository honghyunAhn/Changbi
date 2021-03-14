package com.lms.student.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.lms.student.service.StudentTbService;
import com.lms.student.vo.StuInfoBasicVO;
import com.lms.student.vo.StuInfoEduHistoryVO;
import com.lms.student.vo.StuInfoLanguageVO;
import com.lms.student.vo.StuInfoLicenseVO;
import com.lms.student.vo.StuInfoOverseasVO;
import com.lms.student.vo.StudentTbVO;
import com.lms.student.vo.MouVO;

import forFaith.dev.util.LoginHelper;
import forFaith.dev.vo.MemberVO;
import forFaith.util.DataList;


@Controller(value="controller.StudentTbController")
@RequestMapping("/student/studentTb")
public class StudentTbController {

	@Autowired
	StudentTbService stuTbService;
	
	/**
	 * 학적부 리스트 조회 페이지
	 */
	@ResponseBody
	@RequestMapping(value="/studentList", method = RequestMethod.POST)
	public DataList<StudentTbVO> studentList(@ModelAttribute("search") StudentTbVO stuTb, ModelMap model) throws Exception {
		DataList<StudentTbVO> result = new DataList<StudentTbVO>();
		
		result.setPagingYn(stuTb.getPagingYn());
		// 페이징 처리인 경우만 페이지 번호와 토탈 갯수를 저장한다.
		if(result.getPagingYn().equals("Y")) {
			result.setNumOfNums(stuTb.getNumOfNums());
			result.setNumOfRows(stuTb.getNumOfRows());
			result.setPageNo(stuTb.getPageNo());
			result.setTotalCount(stuTbService.studentTotalCnt(stuTb));
		}
		// 결과 리스트를 저장
		result.setList(stuTbService.selectStuTable_List(stuTb));
		return result;
	}
	
	/**
	 * 학적부 상세 페이지
	 */
/*	@ResponseBody
	@RequestMapping(value="/studentDetail", method = RequestMethod.POST)
	public DataList<StudentTbVO> studentDetail(StudentTbVO stuTb) throws Exception {
		List<StudentTbVO> result = stuTbService.selectStuTable_List(stuTb);
		return result;
	}*/
	
	@ResponseBody
	@RequestMapping(value="/updateStudentTb", method=RequestMethod.POST)
    public Integer updateStudentTb(StuInfoBasicVO basic, StuInfoEduHistoryVO eduHistory , StuInfoLanguageVO language, StuInfoLicenseVO license, StuInfoOverseasVO overseas) throws Exception {
		
    	int result = 0;
    	MemberVO loginUser = (MemberVO)LoginHelper.getLoginInfo();
    	String upd_id = loginUser.getId();
        
    	if(basic != null) basic.setUpdUser(loginUser);
        
        if(eduHistory.getEduHistoryList() != null)
    		for(StuInfoEduHistoryVO vo : eduHistory.getEduHistoryList()){
    			vo.setStu_edu_ins_id(upd_id);
    			vo.setStu_edu_udt_id(upd_id);
    		}
        
    	if(language.getLanguageList() != null)
    		for(StuInfoLanguageVO vo : language.getLanguageList()){
    			vo.setStu_lang_ins_id(upd_id);
    			vo.setStu_lang_udt_id(upd_id);
    		}
    	
    	if(license.getLicenseList() != null)
    		for(StuInfoLicenseVO vo : license.getLicenseList()){
    			vo.setStu_license_ins_id(upd_id);
    			vo.setStu_license_udt_id(upd_id);
    		}
    	
    	if(overseas.getOverseasList() != null)
    		for(StuInfoOverseasVO vo : overseas.getOverseasList()){
    			vo.setStu_overseas_ins_id(upd_id);
    			vo.setStu_overseas_udt_id(upd_id);
    		}
    	
    	result = stuTbService.updateStudentTb(basic, eduHistory, language, license, overseas);
        return result;
    }
	
	@ResponseBody
	@RequestMapping(value="/studentTableMOU", method = RequestMethod.POST)
	public DataList<MouVO> studentTableMOU(@ModelAttribute("search") MouVO mou, ModelMap model) throws Exception {
		DataList<MouVO> result = new DataList<MouVO>();
		result.setPagingYn(mou.getPagingYn());
		String temp = mou.getSearchKeyword();
		System.out.println(temp);
		// 페이징 처리인 경우만 페이지 번호와 토탈 갯수를 저장한다.
		if(result.getPagingYn().equals("Y")) {
			result.setNumOfNums(mou.getNumOfNums());
			result.setNumOfRows(mou.getNumOfRows());
			result.setPageNo(mou.getPageNo());
			//result.setTotalCount(stuTbService.mouTotalCnt());
		}
		// 결과 리스트를 저장
		result.setList(stuTbService.selectMOU(mou));
		return result;
	}
}
