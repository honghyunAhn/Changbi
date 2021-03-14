package com.lms.student.service;


import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lms.student.dao.SurveyDAO;
import com.lms.student.vo.SurveyAnswerVO;
import com.lms.student.vo.SurveyAutoVO;
import com.lms.student.vo.SurveysVO;


@Service(value = "service.serveyService")
public class surveyService {

	
	@Autowired
	private SurveyDAO surveyDao;

	// 설문조사명 유효성 검사
	public int validationSurveyTitle(SurveysVO vo) throws Exception{
			return surveyDao.validationSurveyTitle(vo);
		}
		
	// 설문조사 정보 추가
	public int insertSurveyInfo(SurveysVO vo) throws Exception{
		return surveyDao.insertSurveyInfo(vo);
	}
	
	// 설문조사 PK 찾기
	public int selectKey_insertSurveyInfo(SurveysVO vo) throws Exception{
		return surveyDao.selectKey_insertSurveyInfo(vo);
	}
	
	// 설문조사 질문 추가
	public int insertSurveyQuestion(SurveysVO vo) {
		return surveyDao.insertSurveyQuestion(vo);
	}
	
	// 설문조사 수정 페이지 
	public HashMap<String, Object> selectSurveyDetail(int survey_seq) {
		return surveyDao.selectSurveyDetail(survey_seq);
	}

	// 설문조사 수정
	public int updateSurveyInfo(SurveysVO surveysVO) {
		return surveyDao.updateSurveyInfo(surveysVO);
	}

	// 설문조사 수정시 기존 질문 삭제
	public int deleteSurveyQuestion(SurveysVO surveysVO) {
		return surveyDao.deleteSurveyQuestion(surveysVO);
	}

	// 설문조사 삭제
	public int deleteSurveyInfo(int survey_seq) {
		return surveyDao.deleteSurveyInfo(survey_seq);
	}
	
	// 일반설문 리스트
	public List<SurveysVO> surveyList(SurveysVO vo) throws Exception {
		return surveyDao.surveyList(vo);
	}

	// 일반설문 리스트 총 갯수
	public int surveyTotalCnt(SurveysVO vo) throws Exception {
		return surveyDao.surveyTotalCnt(vo);
	}

	// 일반설문 배포
	public int regSurvey(int survey_seq) {
		return surveyDao.regSurvey(survey_seq);
	}

	// 일반설문 배포 취소
	public int cancelSurvey(int survey_seq) {
		return surveyDao.cancelSurvey(survey_seq);
	}

	// 일반설문 배포 취소시, 기존의 응답 내용 삭제
	public void deleteSurveyAnswer(int survey_seq) {
		surveyDao.deleteSurveyAnswer(survey_seq);
	}

	// 일반설문 배포 취소시, 설문완료명단 삭제
	public void deleteSurveyComplete(int survey_seq) {
		surveyDao.deleteSurveyComplete(survey_seq);
	}

	// 설문통계 페이지 : 기본설문 정보
	public HashMap<String, Object> selectSurveyInfo(SurveysVO vo) {
		return surveyDao.selectSurveyInfo(vo);
	}
	
	// 설문통계 페이지 : 자동설문 정보
	public HashMap<String, Object> selectAutoSurveyInfo(SurveysVO vo) {
		return surveyDao.selectAutoSurveyInfo(vo);
	}
	
	// 설문 통계 페이지 : 설문 질문, 응답 조회
	public List<SurveysVO> selectSurveyResult(SurveysVO vo) {
		List<SurveysVO> result = surveyDao.selectSurveyResult(vo);

		// 객관식 선택지 별로 응답자 리스트 생성하여 controller로 리턴함
		if(result != null){
    		for(SurveysVO survey : result){
    			HashMap<Integer, Object> nameMap = null;
    			HashMap<Integer, Object> idMap = null;
    			int surveyType= survey.getSurvey_type_seq();
    			
    			switch(surveyType){
    			case 1 : // 객관식(중복선택)
    				nameMap = new HashMap<>();
    				idMap = new HashMap<>();
            		String [] type1_answer = survey.getSurvey_answer_sample().split("\\|");
            		
            		for(int i=0; i<type1_answer.length; i++){
            			ArrayList<String> type1_stuList = new ArrayList<>();
            			ArrayList<String> type1_idList = new ArrayList<>();
            			
            			for(SurveyAnswerVO answer : survey.getAnswerList()){
            				String[] type1_StuAnswer = answer.getSurvey_answer().split(",");
            					
            				for(String stuAnswer : type1_StuAnswer){
            					if(Integer.parseInt(stuAnswer) == (i+1)){
            						type1_stuList.add(answer.getUser_nm());
            						type1_idList.add(answer.getUser_id());
            					}
            				}
            			}
            			nameMap.put(i, type1_stuList);
            			idMap.put(i, type1_idList);
            		}
            		survey.setAnswer_userList(nameMap);
            		survey.setAnswer_idList(idMap);
    				break;
    			
    			case 2 : // 객관식(단일선택)
    				nameMap = new HashMap<>();
    				idMap = new HashMap<>();
            		String [] type2_answer = survey.getSurvey_answer_sample().split("\\|");
            		
            		for(int i=0; i<type2_answer.length; i++){
            			ArrayList<String> type2_stuList = new ArrayList<>();
            			ArrayList<String> type2_idList = new ArrayList<>();
            			
            			for(SurveyAnswerVO answer : survey.getAnswerList()){
            				int type2_answer2 = answer.getSurvey_answer_choice();
            				if(type2_answer2 == (i+1)){
            					type2_stuList.add(answer.getUser_nm());
            					type2_idList.add(answer.getUser_id());
            				}
            			}
            			nameMap.put(i, type2_stuList);
            			idMap.put(i, type2_idList);
            		}
            		survey.setAnswer_userList(nameMap);
            		survey.setAnswer_idList(idMap);
            		break;
    			}
        	}
    	}
		return result;
	}
	
	// 설문 응답자 리스트
	public List<HashMap<String, Object>> selectSurveyCompleteList(SurveysVO vo) {
		return surveyDao.selectSurveyCompleteList(vo);
	}

	// 설문 미응답자 리스트
	public List<HashMap<String, Object>> selectSurveyNoAnswerList(SurveysVO vo) {
		return surveyDao.selectSurveyNoAnswerList(vo);
	}
	
	// 설문 템플릿 추가
	public int insertSurveyTemplate(SurveysVO vo) {
		return surveyDao.insertSurveyTemplate(vo);
	}

	// 설문 템플릿 PK 찾기 
	public int selectKey_insertSurveyTemplate(SurveysVO vo) {
		return surveyDao.selectKey_insertSurveyTemplate(vo);
	}
	
	// 설문 템플릿 수정
	public int updateSurveyTemplate(SurveysVO vo) {
		return surveyDao.updateSurveyTemplate(vo);
	}
	// 설문 템플릿 삭제	
	public int deleteSurveyTemplate(SurveysVO vo) {
		return surveyDao.deleteSurveyTemplate(vo);
	}
	
	// 설문 템플릿 리스트
	public List<HashMap<String, Object>> selectSurveyTemplateList() {
		return surveyDao.selectSurveyTemplateList();
	}
	
	// 설문 템플릭 상세내용 
	public List<HashMap<String, Object>> surveyTemplateDetail(SurveysVO vo) {
		return surveyDao.surveyTemplateDetail(vo);
	}
	
	// 자동설문 등록시 기수 리스트 불러오기
	public List<HashMap<String, String>> selectGisuList(SurveysVO vo) {
		return surveyDao.selectGisuList(vo);
	}
	
	// 자동배포 설문 질문정보 등록
	public int insertAutoSurveyQuestion(SurveysVO vo) {
		return surveyDao.insertAutoSurveyQuestion(vo);
	}
	
	// 자동배포 설문 기본정보 등록
	public int insertAutoSurveyInfo(SurveysVO vo) {
		return surveyDao.insertAutoSurveyInfo(vo);
	}

	// 자동설문 배포 취소
	public int cancelAutoSurvey(int survey_seq) {
		return surveyDao.cancelAutoSurvey(survey_seq);
	}
	
	// 자동설문 리스트
	public List<SurveysVO> selectAutoSurveyList(SurveysVO vo) {
		return surveyDao.selectAutoSurveyList(vo);
	}
	// 자동설문 리스트 총 갯수
	public int autoSurveyTotalCnt(SurveysVO vo) {
		return surveyDao.autoSurveyTotalCnt(vo);
	}

	// 자동설문 기수통계 리스트(팝업)
	public List<SurveysVO> selectGisuAutoSurveyInfo(SurveysVO vo) {
		return surveyDao.selectGisuAutoSurveyInfo(vo);
	}
	public List<SurveysVO> selectGisuAutoSurveyList(SurveysVO vo) {
		return surveyDao.selectGisuAutoSurveyList(vo);
	}
}
