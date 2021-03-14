package com.lms.student.dao;

import java.util.HashMap;
import java.util.List;

import com.lms.student.vo.ClassInfoVO;
import com.lms.student.vo.GisuCategoryVO;
import com.lms.student.vo.GradeVO;
import com.lms.student.vo.TestInfoVO;
import com.lms.student.vo.TestScoreVO;
import com.lms.student.vo.UserScoreVO;


public interface TestDAO {

	List<HashMap<String, String>> searchCurriculumSeq() throws Exception;

	List<HashMap<String, String>> searchGisuList(String seq) throws Exception;

	List<HashMap<String, String>> searchCategoryList(GisuCategoryVO testVO) throws Exception;

	List<HashMap<String, String>> searchBigCategoryList(GisuCategoryVO testVO);
	
	int createBigCategory(GisuCategoryVO gisuCategoryVO);

	int updateBigCategory(GisuCategoryVO gisuCategoryVO);

	int deleteBigCategory(int cat_seq);
	
	List<HashMap<String, String>> createUpperCategory(GisuCategoryVO testVO) throws Exception;
	
	int insertTestInfo(TestInfoVO testInfoVO);

	List<HashMap<String, String>> callSmallCategory(GisuCategoryVO testVO);

	List<HashMap<String, String>> makeProgressInSmall(GisuCategoryVO testVO);

	List<HashMap<String, String>> searchTestList(GisuCategoryVO testVO);

	List<HashMap<String, String>> TestListAll(GisuCategoryVO testVO);
	
	List<HashMap<String, String>> searchTestScore(int test_seq);

	String checkTesting(int test_seq);
	
	String updateCheckTesting(int test_seq);
	
	String ClearTesting(int test_seq);
	
	int deleteTestScore(int test_seq);
	
	int insertTestScore(TestScoreVO voo);

	int updateTestScore(TestScoreVO voo);

	List<HashMap<String, String>> checkTestName(GisuCategoryVO testVO);

	int deleteTestInfo(GisuCategoryVO gisuCategoryVO);
	
	int deleteCategory(String seq);
	
	List<HashMap<String,String>> searchtUserTestInfo(UserScoreVO vo);
	
	List<HashMap<String,String>> searchtCategoryInfo(UserScoreVO vo);
	
	int insertClassList(ClassInfoVO vo);

	int updateClassList(ClassInfoVO vo);

	int deleteClassList(ClassInfoVO vo);
	
	List<ClassInfoVO> searchClassList(ClassInfoVO vo) throws Exception;
	
	List<ClassInfoVO> selectableUser(ClassInfoVO vo) throws Exception;
	
	int insertUserInClass(ClassInfoVO vo);

	int deleteUserInClass(ClassInfoVO vo);
	
	List<HashMap<String,String>> searchGrade(GradeVO grade);
	
	int saveGrade(GradeVO vo);
	
	int checkGrade(GradeVO vo);
	
	int updateGrade(GradeVO vo);
	
	int deleteGrade(String seq);
	
	List<String> selectTestUser(int test_seq);
	
	int testCount(String seq);
	
	int checkTest(TestInfoVO testInfoVO);
}
