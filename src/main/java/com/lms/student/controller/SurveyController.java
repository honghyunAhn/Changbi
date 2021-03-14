package com.lms.student.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.lms.student.service.surveyService;
import com.lms.student.vo.SurveysVO;

import forFaith.dev.util.LoginHelper;
import forFaith.dev.vo.MemberVO;
import forFaith.util.DataList;

@RequestMapping("student/Survey")
@Controller(value="controller.SurveyController")
public class SurveyController{

	@Autowired
	surveyService ss;
	
	// 설문조사명 중복 여부 확인
	@RequestMapping(value="/validationSurveyTitle",method=RequestMethod.POST)
	@ResponseBody public int validationSurveyTitle(SurveysVO vo) throws Exception{
		return ss.validationSurveyTitle(vo);
	}
	
	// 일반설문 생성
	@RequestMapping(value="/insertSurveyList",method=RequestMethod.POST)
	@ResponseBody public boolean insertSurveyList(@RequestBody List<SurveysVO> list) throws Exception{
		
		if(ss.insertSurveyInfo(list.get(0)) == 1){
			int survey_seq = ss.selectKey_insertSurveyInfo(list.get(0));
			int cnt = 0;
			
			for(int i=1; i<list.size(); i++){
				list.get(i).setSurvey_seq(survey_seq);
				cnt += ss.insertSurveyQuestion(list.get(i));
			}
			if(cnt == list.size()-1) return true;
		}
		return false;
	}
	
	// 일반설문 수정
	@RequestMapping(value="/updateSurveyList",method=RequestMethod.POST)
	@ResponseBody public boolean updateSurveyList(@RequestBody List<SurveysVO> list){
		
		if(ss.updateSurveyInfo(list.get(0)) == 1){
			if(ss.deleteSurveyQuestion(list.get(0)) > 0){
				int cnt = 0;
				
				for (int i = 1; i < list.size(); i++) {
					cnt += ss.insertSurveyQuestion(list.get(i));
				}
				if(cnt == list.size()-1) return true;
			}
		}
		return false;
	}
	
	// 일반설문 삭제
	@RequestMapping(value="/deleteSurvey",method=RequestMethod.POST)
	@ResponseBody public boolean deleteSurvey(@RequestBody int survey_seq){
		if(ss.deleteSurveyInfo(survey_seq) == 1) return true;
		return false;
	}
	
	// 설문 리스트 조회 - 일반설문 리스트, 자동설문 기수통계 리스트(팝업)
	@RequestMapping(value = "/surveyList", method = RequestMethod.POST)
    public @ResponseBody DataList<SurveysVO> surveyList(SurveysVO vo) throws Exception {
		String page = vo.getPage();
		
		DataList<SurveysVO> result = new DataList<SurveysVO>();
		result.setPagingYn(vo.getPagingYn());
		// 페이징 처리인 경우만 페이지 번호와 토탈 갯수를 저장한다.
		if(result.getPagingYn().equals("Y")) {
			result.setNumOfNums(vo.getNumOfNums());
			result.setNumOfRows(vo.getNumOfRows());
			result.setPageNo(vo.getPageNo());
			
			if(page != "gisu") result.setTotalCount(ss.surveyTotalCnt(vo));
		}
		// 결과 리스트를 저장
		switch(page){
		case "gisu" :
			List<SurveysVO> info = ss.selectGisuAutoSurveyInfo(vo);
			List<SurveysVO> list = new ArrayList<>();
			
			for(SurveysVO auto : info){
				String gisu_id = vo.getGisu_id();
				String keyword = vo.getSearchKeyword();
				if(gisu_id != null) auto.setGisu_id(gisu_id);
				if(keyword != null) auto.setSearchKeyword(keyword);
				
				List<SurveysVO> surveyList = ss.selectGisuAutoSurveyList(auto);
				
				for(SurveysVO survey : surveyList) {
					list.add(survey);
				}
			}
			result.setList(list);
			result.setTotalCount(list.size()); // 자동배포설문 리스트 토탈 갯수
			break;
		default :
			result.setList(ss.surveyList(vo));
		}
		return result;
	}
	
	// 일반설문 배포
	@RequestMapping(value="/regSurvey",method=RequestMethod.POST)
	@ResponseBody public boolean regSurvey(@RequestBody int seq) throws Exception{
		if(ss.regSurvey(seq) == 1) return true;
		return false;
	}
	
	// 일반설문 배포 취소
    @RequestMapping(value = "/cancelSurvey", method = RequestMethod.POST)
    public @ResponseBody boolean cancelSurvey(@RequestBody HashMap<String, Object> map){
    	int survey_seq = (int) map.get("survey_seq");
    	
    	if((boolean) map.get("flag")) {
    		ss.deleteSurveyAnswer(survey_seq);
    		ss.deleteSurveyComplete(survey_seq);
    	}
    	if(ss.cancelSurvey(survey_seq) == 1) return true;
    	return false;
    }
    
   	// 설문 미응답자 조회 (설문 통계 페이지에서 사용)
   	@RequestMapping(value="/noAnswerList",method=RequestMethod.POST)
   	@ResponseBody public List<HashMap<String, Object>> selectNoAnswerList(SurveysVO vo){
		return ss.selectSurveyNoAnswerList(vo);
	}
    
    // 템플릿 추가
 	@RequestMapping(value="/insertSurveyTemplate",method=RequestMethod.POST)
 	@ResponseBody public boolean insertSurveyTemplate(@RequestBody List<SurveysVO> list){
 		MemberVO loginUser = (MemberVO)LoginHelper.getLoginInfo();
 		list.get(0).setRegUser(loginUser);
 		list.get(0).setUpdUser(loginUser);
 		
 		if(ss.insertSurveyTemplate(list.get(0)) !=0){
 			int survey_template_seq = ss.selectKey_insertSurveyTemplate(list.get(0));
 			
 			for (int i = 1; i < list.size(); i++) {
 				list.get(i).setSurvey_template_seq(survey_template_seq);
 				if(ss.insertSurveyQuestion(list.get(i)) == 0) return false;
 			}
 			return true;
 		}return false;
 	}

 	// 템플릿 수정
  	@RequestMapping(value="/updateSurveyTemplate",method=RequestMethod.POST)
  	@ResponseBody public boolean updateSurveyTemplate(@RequestBody List<SurveysVO> list){
  		MemberVO loginUser = (MemberVO)LoginHelper.getLoginInfo();
  		list.get(0).setUpdUser(loginUser);

  		ss.updateSurveyTemplate(list.get(0));
		ss.deleteSurveyQuestion(list.get(0));
  		
		for (int i = 1; i < list.size(); i++) {
			if(ss.insertSurveyQuestion(list.get(i)) == 0) return false;
		}
		return true;
  	}
 	
  	// 템플릿 삭제 
   	@RequestMapping(value="/deleteSurveyTemplate",method=RequestMethod.POST)
   	@ResponseBody public boolean deleteSurveyTemplate(SurveysVO vo){
 		if(ss.deleteSurveyTemplate(vo) != 0) return true;
 		return false;
   	}
  	
  	// 템플릿 리스트
   	@RequestMapping(value="/selectSurveyTemplate",method=RequestMethod.POST)
   	@ResponseBody public String selectSurveyTemplate(){
		Gson gson = new Gson();
		return gson.toJson(ss.selectSurveyTemplateList());
	}

 	// 템플릿 상세 내용(질문 정보) 조회
 	@RequestMapping(value="/surveyTemplateDetail",method=RequestMethod.POST)
 	@ResponseBody public String surveyTemplateDetail(SurveysVO vo){
 		Gson gson = new Gson();
 		return gson.toJson(ss.surveyTemplateDetail(vo));
 	}
   	
	// 과정에 연결된 기수 리스트 조회 (자동설문 등록에서 기수별 통계 선택시 사용)
   	@RequestMapping(value="/selectGisuList",method=RequestMethod.POST)
   	@ResponseBody List<HashMap<String, String>> selectGisuList(SurveysVO vo){
   		return ss.selectGisuList(vo);
	}
 	
   	// 자동배포용 설문 배포
   	@RequestMapping(value="/regAutoSurvey",method=RequestMethod.POST)
   	@ResponseBody boolean regAutoSurvey(SurveysVO vo) throws Exception{
   		
   		if(ss.insertSurveyInfo(vo) == 1){
   			vo.setSurvey_seq(ss.selectKey_insertSurveyInfo(vo));
   	   		
   			if(ss.insertAutoSurveyQuestion(vo) > 0){
   				MemberVO loginUser = (MemberVO)LoginHelper.getLoginInfo();
   		  		vo.setRegUser(loginUser);
   		  		
   		  		if(ss.insertAutoSurveyInfo(vo) == 1){
   		  			return true;
   		  		}
   			}
   		}
   		return false;
	}

   	// 자동설문 배포 취소
    @RequestMapping(value = "/cancelAutoSurvey", method = RequestMethod.POST)
    public @ResponseBody boolean cancelAutoSurvey(SurveysVO vo){
    	if(ss.cancelAutoSurvey(vo.getSurvey_seq()) == 1) return true;
    	return false;
    }
    
	// 자동배포설문 리스트 불러오기
	@RequestMapping(value = "/selectAutoSurveyList", method = RequestMethod.POST)
    public @ResponseBody DataList<SurveysVO> selectAutoSurveyList(SurveysVO vo) throws Exception {
    	DataList<SurveysVO> result = new DataList<SurveysVO>();
    	result.setPagingYn(vo.getPagingYn());
    	// 페이징 처리인 경우만 페이지 번호와 토탈 갯수를 저장한다.
		if(result.getPagingYn().equals("Y")) {
			result.setNumOfNums(vo.getNumOfNums());
			result.setNumOfRows(vo.getNumOfRows());
			result.setPageNo(vo.getPageNo());
			
			result.setTotalCount(ss.autoSurveyTotalCnt(vo));
		}
		// 결과 리스트를 저장
		result.setList(ss.selectAutoSurveyList(vo));
		return result;
	}
}
