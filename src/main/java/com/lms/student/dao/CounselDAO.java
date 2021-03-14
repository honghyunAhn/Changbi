package com.lms.student.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import com.lms.student.vo.CounselVO;
import com.lms.student.vo.GisuCategoryVO;


public interface CounselDAO {

	List<CounselVO> CounselList(CounselVO counsel) throws Exception;
	List<HashMap<String, String>> searchCurriculumSurvey() throws Exception;
	List<HashMap<String, String>> searchGisuListSurvey(String seq) throws Exception;
	int CounselTotalCnt(CounselVO counsel) throws Exception;
	List<HashMap<String, String>> searchStudent(GisuCategoryVO testVO);
	List<HashMap<String, String>> searchTeacher(GisuCategoryVO testVO);
	int insertCounsel(CounselVO vo);
	HashMap<String, String> selectCounsel(String seq);
	int updateCounsel(CounselVO vo);
	int deleteCounsel(CounselVO vo);
	HashMap<String, String> searchCurriculum(String crc_id);
	List<CounselVO> counselStudentList(CounselVO counsel);
	HashMap<String, Object> counselStudentInfo(CounselVO counsel);
	ArrayList<HashMap<String, Object>> counselDetailList(CounselVO counsel);
	int counselStuTotalCnt(CounselVO counsel);
}
