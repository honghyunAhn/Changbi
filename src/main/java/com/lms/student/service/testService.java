package com.lms.student.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lms.student.dao.TestDAO;
import com.lms.student.vo.ClassInfoVO;
import com.lms.student.vo.GisuCategoryVO;
import com.lms.student.vo.GradeVO;
import com.lms.student.vo.TestInfoVO;
import com.lms.student.vo.TestScoreVO;
import com.lms.student.vo.UserScoreVO;

@Service(value = "service.testService")
public class testService {

	@Autowired
	private TestDAO testDao;
	
	/**
	 * 과정명 가져오는 메소드
	 * @return 과정명
	 * @throws Exception
	 */
	public List<HashMap<String, String>> searchCurriculumSeq() throws Exception{
		List<HashMap<String, String>> List = testDao.searchCurriculumSeq();
		return List;
	}

	public List<HashMap<String, String>> searchGisuList(String seq) throws Exception {
		List<HashMap<String, String>> List = testDao.searchGisuList(seq);
		return List;
	}

	public List<HashMap<String, String>> searchCategoryList(GisuCategoryVO testVO) throws Exception {
		List<HashMap<String, String>> List = testDao.searchCategoryList(testVO);
		return List;
	}
	
	public List<HashMap<String, String>> searchBigCategoryList(GisuCategoryVO testVO) throws Exception{
		List<HashMap<String, String>> List = testDao.searchBigCategoryList(testVO);
		return List;
	}
	
	public int createBigCategory(GisuCategoryVO gisuCategoryVO) throws Exception{
		int result = testDao.createBigCategory(gisuCategoryVO);
		return result;
		
	}

	public int updateBigCategory(GisuCategoryVO gisuCategoryVO) {
		int result = testDao.updateBigCategory(gisuCategoryVO);
		return result;
	}

	public int deleteBigCategory(int cat_seq) {
		int result = testDao.deleteBigCategory(cat_seq);
		return result;
	}
	public List<HashMap<String, String>> createUpperCategory(GisuCategoryVO vo) throws Exception{
		List<HashMap<String, String>> List = testDao.createUpperCategory(vo);
		return List;
	}
	public int insertTestInfo(TestInfoVO testInfoVO) {
		int result = testDao.insertTestInfo(testInfoVO);
		return result;
	}
	
	public List<HashMap<String, String>> callSmallCategory(GisuCategoryVO testVO) {
		List<HashMap<String, String>> List = testDao.callSmallCategory(testVO);
		return List;
	}

	public List<HashMap<String, String>> makeProgressInSmall(GisuCategoryVO testVO) {
		List<HashMap<String, String>> List = testDao.makeProgressInSmall(testVO);
		return List;
	}
	
	public List<HashMap<String,String>> searchGrade(GradeVO grade) {
		List<HashMap<String,String>> map = testDao.searchGrade(grade);
		return map;
	}
	
	public int checkGrade(GradeVO vo) {
		int result = testDao.checkGrade(vo);
		return result;
	}
	
	public int updateGrade(GradeVO vo){
		int result = testDao.updateGrade(vo);
		return result;
	}
	
	public int deleteGrade(String seq) {
		int result = testDao.deleteGrade(seq);
		return result;
	}
	
	public int saveGrade(GradeVO vo) {
		int result = testDao.saveGrade(vo);
		return result;
	}
	
	public List<String> selectTestUser(int test_seq) {
		List<String> list = testDao.selectTestUser(test_seq);
		return list;
	}
	
	public List<HashMap<String, String>> searchTestList(GisuCategoryVO testVO) {
		List<HashMap<String, String>> List = testDao.searchTestList(testVO);
		return List;
	}

	public List<HashMap<String, String>> TestListAll(GisuCategoryVO testVO) {
		List<HashMap<String, String>> List = testDao.TestListAll(testVO);
		return List;
	}
	public List<HashMap<String, String>> searchTestScore(int test_seq){
		List<HashMap<String, String>> List = testDao.searchTestScore(test_seq);
		return List;
	}
	
	public List<HashMap<String,String>> searchtUserTestInfo(UserScoreVO vo){
		List<HashMap<String, String>> List = testDao.searchtUserTestInfo(vo);
		return List;
	}
	
	public List<HashMap<String,String>> searchtCategoryInfo(UserScoreVO vo){
		List<HashMap<String, String>> List = testDao.searchtCategoryInfo(vo);
		return List;
	}

	public String checkTesting(int string) {
		String result = testDao.checkTesting(string);
		return result;
	}
	public String updateCheckTesting(int string) {
		String result = testDao.updateCheckTesting(string);
		return result;
	}
	public String ClearTesting(int string) {
		String result = testDao.ClearTesting(string);
		return result;
	}
	public int deleteTestScore(int test_seq) {
		int result = testDao.deleteTestScore(test_seq);
		return result;
	}
	public int insertTestScore(TestScoreVO voo) {
		int result = testDao.insertTestScore(voo);
		return result;
	}
	
	public int updateTestScore(TestScoreVO voo) {
		int result = testDao.updateTestScore(voo);
		return result;
	}

	public List<HashMap<String, String>> checkTestName(GisuCategoryVO testVO) {
		List<HashMap<String, String>> result = testDao.checkTestName(testVO);
		return result;
	}

	public int deleteTestInfo(GisuCategoryVO gisuCategoryVO) {
		int result = testDao.deleteTestInfo(gisuCategoryVO);
		return result;
	}
	
	public int deleteCategory(String seq) {
		int result = testDao.deleteCategory(seq);
		return result;
	}
	
	public int insertClassList(ClassInfoVO vo) {
		return testDao.insertClassList(vo);
	}

	public int updateClassList(ClassInfoVO vo) {
		return testDao.updateClassList(vo);
	}

	public int deleteClassList(ClassInfoVO vo) {
		return testDao.deleteClassList(vo);
	}
	public List<ClassInfoVO> searchClassList(ClassInfoVO vo) throws Exception{
		return testDao.searchClassList(vo);
	}
	
	public List<ClassInfoVO> selectableUser(ClassInfoVO vo) throws Exception{
		return testDao.selectableUser(vo);
	}
	
	public int insertUserInClass(ClassInfoVO vo) throws Exception{
		return testDao.insertUserInClass(vo);
	}

	public int deleteUserInClass(ClassInfoVO vo) throws Exception{
		return testDao.deleteUserInClass(vo);
	}

	public int testCount(String seq) {
		return testDao.testCount(seq);
	}
	
	public int checkTest(TestInfoVO testInfoVO) {
		int result = testDao.checkTest(testInfoVO);
		return result;
	}
}
