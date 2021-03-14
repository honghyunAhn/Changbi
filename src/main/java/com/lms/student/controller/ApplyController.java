package com.lms.student.controller;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.lms.student.service.ApplyService;
import com.lms.student.vo.ApplyVO;

import forFaith.dev.util.LoginHelper;
import forFaith.dev.vo.MemberVO;
import forFaith.util.DataList;

@Controller(value="controller.ApplyController")
@RequestMapping("/admin/apply")
public class ApplyController {

	@Autowired
	ApplyService applyService;
	
	/**
	 * 지원자 리스트 조회 페이지
	 * @throws Exception 
	 */
	@ResponseBody
	@RequestMapping(value="/applyList", method = RequestMethod.POST)
	public DataList<ApplyVO> applyList(ApplyVO apply, Model model) throws Exception{
		DataList<ApplyVO> result = new DataList<ApplyVO>();
		
		result.setPagingYn(apply.getPagingYn());
		// 페이징 처리인 경우만 페이지 번호와 토탈 갯수를 저장한다.
		if(result.getPagingYn().equals("Y")) {
			result.setNumOfNums(apply.getNumOfNums());
			result.setNumOfRows(apply.getNumOfRows());
			result.setPageNo(apply.getPageNo());
			result.setTotalCount(applyService.applyTotalCnt(apply));
		}
		// 결과 리스트를 저장
		result.setList(applyService.applyList(apply));
		return result;
	}
	
	/**
	 * 특정 학생 지원신청서 조회 페이지
	 * @throws Exception 
	 */
	@RequestMapping(value="/viewApplyForm")
	public void viewApplyForm(ApplyVO apply, ModelMap model) throws Exception{
		HashMap<String, Object> applyForm = applyService.selectApplyForm(apply);
		model.addAttribute("apply", applyForm);
	}
	
	/**
	 * 서류, 면접 전형 결과 저장
	 */
	@ResponseBody
	@RequestMapping(value = "/apply_rt_update", method = RequestMethod.POST)
	public boolean upadateApplyResult(@RequestBody ArrayList<ApplyVO> apply_array){
		int cnt = 0;
		MemberVO loginUser = (MemberVO)LoginHelper.getLoginInfo();
		
		for(ApplyVO vo : apply_array) {
			vo.setStu_app_rt_doc_id(loginUser.getId());
			vo.setStu_app_rt_itv_id(loginUser.getId());
			
			if(applyService.updateApplyResult(vo)) ++cnt;
		}
		if(cnt == apply_array.size()) return true;
		return false;
	}
	
	/**
	 * 연수인원 확정
	 * @throws Exception 
	 */
	@ResponseBody
	@RequestMapping(value = "/confirm_student", method = RequestMethod.POST)
	public boolean confirmStudent(@RequestBody ArrayList<ApplyVO> apply_array) throws Exception{
		int cnt = 0;
		
		for(ApplyVO vo : apply_array) {
			if(applyService.checkStudent(vo) == 0){
				
				MemberVO loginUser = (MemberVO)LoginHelper.getLoginInfo();
				vo.setUpdUser(loginUser);
				if(applyService.confirmStudent(vo)) ++cnt;
			}
		}
		if(cnt == apply_array.size()) return true;
		return false;
	}
	
	/**
	 * 연수인원 취소
	 * @throws Exception 
	 */
	@ResponseBody
	@RequestMapping(value = "/cancel_confirm", method = RequestMethod.POST)
	public boolean cancelConfirm(@RequestBody ArrayList<ApplyVO> apply_array) throws Exception{
		int cnt = 0;

		for(ApplyVO vo : apply_array) {
			if(applyService.checkStudent(vo) == 1){
				
				MemberVO loginUser = (MemberVO)LoginHelper.getLoginInfo();
				vo.setUpdUser(loginUser);
				if(applyService.cancelConfirm(vo)) ++cnt;
			}
		}
		if(cnt == apply_array.size()) return true;
		return false;
	}
	
	/**
	 * 출력할 지원서 조회
	 * @throws Exception 
	 */
	@RequestMapping(value = "/print_applyForm", method = RequestMethod.POST)
	public String printApplyForm(String[] user_id, String[] gisu_id, Model model) throws Exception{
		ArrayList<HashMap<String, Object>> applyFormList = new ArrayList<>();
		Gson gson = new Gson();
		
		for(int i=0; i<user_id.length; i++) {
			ApplyVO apply = new ApplyVO();
			apply.setUser_id(user_id[i]);
			apply.setGisu_id(gisu_id[i]);

			HashMap<String, Object> applyForm = applyService.selectApplyForm(apply);
			applyFormList.add(applyForm);
		}
		model.addAttribute("applyFormList", applyFormList);
		model.addAttribute("applyGsonList", gson.toJson(applyFormList));
		return "/admin/apply/applyFormPrint";
	}
}
