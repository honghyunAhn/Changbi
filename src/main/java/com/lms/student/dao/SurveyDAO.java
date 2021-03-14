package com.lms.student.dao;

import java.util.HashMap;
import java.util.List;

import com.lms.student.vo.SurveyAutoVO;
import com.lms.student.vo.SurveysVO;


public interface SurveyDAO {
	//일반설문 CRUD
	int validationSurveyTitle(SurveysVO vo) throws Exception;
	int insertSurveyInfo(SurveysVO vo) throws Exception;
	int selectKey_insertSurveyInfo(SurveysVO vo) throws Exception;
	int insertSurveyQuestion(SurveysVO vo);
	HashMap<String, Object> selectSurveyDetail(int survey_seq);
	int updateSurveyInfo(SurveysVO surveysVO);
	int deleteSurveyQuestion(SurveysVO surveysVO); //설문수정시 기존 질문 삭제
	int deleteSurveyInfo(int survey_seq);
	List<SurveysVO> surveyList(SurveysVO vo) throws Exception;
	int surveyTotalCnt(SurveysVO vo) throws Exception;
	
	//일반설문 배포
	int regSurvey(int survey_seq);
	int cancelSurvey(int survey_seq);
	void deleteSurveyAnswer(int survey_seq);
	void deleteSurveyComplete(int survey_seq);
	
	//설문통계 페이지
	HashMap<String, Object> selectSurveyInfo(SurveysVO vo);
	HashMap<String, Object> selectAutoSurveyInfo(SurveysVO vo);
	List<SurveysVO> selectSurveyResult(SurveysVO vo);
	List<HashMap<String, Object>> selectSurveyCompleteList(SurveysVO vo);
	List<HashMap<String, Object>> selectSurveyNoAnswerList(SurveysVO vo);
	
	//설문 템플릿
	int insertSurveyTemplate(SurveysVO vo);
	int selectKey_insertSurveyTemplate(SurveysVO vo);
	int updateSurveyTemplate(SurveysVO vo);
	int deleteSurveyTemplate(SurveysVO vo);
	List<HashMap<String, Object>> selectSurveyTemplateList();
	List<HashMap<String, Object>> surveyTemplateDetail(SurveysVO vo);
	
	//자동설문 CRUD
	List<HashMap<String, String>> selectGisuList(SurveysVO vo); //자동설문 등록시 기수리스트 조회
	int insertAutoSurveyQuestion(SurveysVO vo);
	int insertAutoSurveyInfo(SurveysVO vo);
	int cancelAutoSurvey(int survey_seq); //자동설문 배포 취소
	
	//자동설문 리스트
	List<SurveysVO> selectAutoSurveyList(SurveysVO vo); 
	int autoSurveyTotalCnt(SurveysVO vo);
	
	//자동설문 기수통계 리스트(팝업)
	List<SurveysVO> selectGisuAutoSurveyInfo(SurveysVO vo);
	List<SurveysVO> selectGisuAutoSurveyList(SurveysVO vo);
}
