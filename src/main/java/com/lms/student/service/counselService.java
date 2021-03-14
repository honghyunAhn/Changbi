package com.lms.student.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.changbi.tt.dev.data.vo.TestVO;
import com.changbi.tt.dev.data.vo.UserVO;
import com.lms.student.dao.CounselDAO;
import com.lms.student.dao.TestDAO;
import com.lms.student.vo.CounselVO;
import com.lms.student.vo.GisuCategoryVO;
import com.lms.student.vo.TestInfoVO;
import com.lms.student.vo.TestScoreVO;
import com.lms.student.vo.UserScoreVO;

@Service(value = "service.counselService")
public class counselService {

	
	@Autowired
	private CounselDAO counselDao;
	/**
	 * 과정명 가져오는 메소드
	 * @return 과정명
	 * @throws Exception
	 */
	
	// 상담 과정 조회
	public List<HashMap<String, String>> searchCurriculumSurvey() throws Exception{
		List<HashMap<String, String>> List = counselDao.searchCurriculumSurvey();
		return List;
	}

	public List<HashMap<String, String>> searchGisuListSurvey(String seq) throws Exception {
		List<HashMap<String, String>> List = counselDao.searchGisuListSurvey(seq);
		return List;
	}
	
	
	// 상담 리스트 조회
	public List<CounselVO> CounselList(CounselVO counsel) throws Exception {
		return counselDao.CounselList(counsel);
	}

	// 상담 리스트 총 갯수
	public int CounselTotalCnt(CounselVO counsel) throws Exception {
		return counselDao.CounselTotalCnt(counsel);
	}
	// 기수별 학생 리스트
	public List<HashMap<String, String>> searchStudent(GisuCategoryVO testVO) throws Exception{
		return counselDao.searchStudent(testVO);
	}
	// 기수별 학생 리스트
	public List<HashMap<String, String>> searchTeacher(GisuCategoryVO testVO) throws Exception{
		return counselDao.searchTeacher(testVO);
	}
	// 상담 내용 추가
	public int insertCounsel(CounselVO vo) {
		return counselDao.insertCounsel(vo);
	}
	
	public HashMap<String, String> selectCounsel(String seq) {
		return counselDao.selectCounsel(seq);
	}
	
	public int deleteCounsel(CounselVO vo) {
		return counselDao.deleteCounsel(vo);
	}
	
	public int updateCounsel(CounselVO vo) {
		return counselDao.updateCounsel(vo);
	}

	public HashMap<String, String> searchCurriculum(String crc_id) {
		HashMap<String, String> info = counselDao.searchCurriculum(crc_id);
		return info;
	}
	
	// 상담 학생 리스트 조회
	public List<CounselVO> counselStudentList(CounselVO counsel) {
		return counselDao.counselStudentList(counsel);
	}
	
	// 상담 학생 기본 정보 조회
	public HashMap<String, Object> counselStudentInfo(CounselVO counsel) {
		return counselDao.counselStudentInfo(counsel);
	}
	
	// 학생별 상담 리스트 조회 : 상담관리 첫 화면, 상담수정 후 화면에서 이용
	public ArrayList<HashMap<String, Object>> counselDetailList(CounselVO counsel) {
		return counselDao.counselDetailList(counsel);
	}

	public int counselStuTotalCnt(CounselVO counsel) {
		return counselDao.counselStuTotalCnt(counsel);
	}
}
