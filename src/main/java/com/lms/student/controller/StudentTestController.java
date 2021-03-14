package com.lms.student.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.lms.student.service.testService;
import com.lms.student.vo.ClassInfoVO;
import com.lms.student.vo.GisuCategoryVO;
import com.lms.student.vo.GradeVO;
import com.lms.student.vo.TestInfoVO;
import com.lms.student.vo.TestScoreVO;
import com.lms.student.vo.UserScoreVO;


@RequestMapping("student/TestManagement")
@Controller(value="controller.StudentTestController")
public class StudentTestController{

	@Autowired
	testService testService;

	/**
	 * 
	 * @return 과정 정보 리스트 불러오기
	 * @throws Exception
	 */
	@RequestMapping(value="/searchCirriculumList", method=RequestMethod.POST)
	@ResponseBody public List<HashMap<String, String>> searchCurriculumSeq() throws Exception {
		List<HashMap<String, String>> result = testService.searchCurriculumSeq();
		
		return result;
	}
	/**
	 * 
	 * @param seq
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/searchGisuList",method=RequestMethod.POST)
	@ResponseBody public List<HashMap<String, String>> searchGisuList(@RequestBody String seq) throws Exception{
		String changeSeq = seq.split("=")[0];
		List<HashMap<String, String>> result = testService.searchGisuList(changeSeq);
		return result;
		
	}
	
	@RequestMapping(value="/searchTestList",method=RequestMethod.POST)
	@ResponseBody public List<HashMap<String, String>> searchTestList(GisuCategoryVO testVO) throws Exception{
		List<HashMap<String, String>> result = new ArrayList<>();
		
		result = testService.callSmallCategory(testVO);
		
		return result;
	}
	/**
	 * 양승균
	 * searchGrade : 성적 등급 검색
	 * @param grade
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/searchGrade", method=RequestMethod.POST)
	@ResponseBody public List<HashMap<String,String>> searchGrade(GradeVO grade) throws Exception {
		//System.out.println("기수 = " + grade.toString());
		
		List<HashMap<String,String>> map = new ArrayList<>();
		map = testService.searchGrade(grade);
		return map;
	}
	
	/**
	 * 양승균
	 * deleteGrade : 성적 등급 삭제
	 * @param grade_seq
	 * @return
	 * @throws Exception
	 */
	
	@RequestMapping(value="/deleteGrade", method=RequestMethod.POST)
	@ResponseBody public String deleteGrade(String grade_seq) throws Exception {
		
		int result = testService.deleteGrade(grade_seq);
		
		if(result != 0) {
			return "TRUE";
		} else {
			return "FALSE";
		}
	}
	
	/**
	 * 양승균
	 * saveGrade : 성적 등급 저장
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	
	@RequestMapping(value="/saveGrade", method= RequestMethod.POST)
	@ResponseBody public String saveGrade(@RequestBody List<HashMap<String, String>> vo) throws Exception {
	//	for(int i = 0; i < vo.size(); i++) {
	//		System.out.println("grade" + (i+1) +": " + vo.get(i).toString());
	//	}

		for(int i = 0; i < vo.size(); i++) {
			GradeVO grade = new GradeVO();
			
			grade.setCourse_id(vo.get(i).get("course_id"));
			grade.setCardinal_id(vo.get(i).get("cardinal_id"));
			grade.setStart_score(Integer.parseInt(vo.get(i).get("start_score")));
			grade.setEnd_score(Integer.parseInt(vo.get(i).get("end_score")));
			grade.setGrade(String.valueOf(vo.get(i).get("grade")));
			
			if(!String.valueOf(vo.get(i).get("grade_seq")).equalsIgnoreCase("0")) {
				System.out.println("grade_seq = " +vo.get(i).get("grade_seq"));
				
				grade.setGrade_seq(String.valueOf(vo.get(i).get("grade_seq")));
				int result = testService.updateGrade(grade);
				
				if(result == 0) {
					return "FALSE";
				}
			} else {
				int compare = 0;
				compare = testService.checkGrade(grade);
			//	System.out.println("비교 = " + compare);
				
				if(compare != 0) {
					return "FALSE";
				}

				int result = testService.saveGrade(grade);
				
				if(result == 0) {
					return "FALSE";
				}
			}
		}
		return "TRUE";
	}
	
	/**
	 * @DATE 201006
	 * 양승균
	 * @NAME : checkTestName 
	 * @param testVO
	 * @return
	 * @throws Exception
	 * 시험 이름 중복 확인
	 */
	
	@RequestMapping(value="/checkTestName",method=RequestMethod.POST)
	@ResponseBody public int checkTestName(GisuCategoryVO testVO) throws Exception{
		
		int count = 0;
		List<HashMap<String, String>> result = testService.checkTestName(testVO);

		for(int i = 0; i < result.size(); i++) {
			HashMap<String, String> map = result.get(i);
			TestInfoVO test = new TestInfoVO();
			test.setCat_seq(Integer.parseInt(String.valueOf(map.get("CAT_SEQ"))));
			test.setTest_nm(testVO.getCat_nm());
			count = testService.checkTest(test);
			
			if(count != 0) {
				break;
			}
		}
		
		return count;
	}
	
	@RequestMapping(value="/TestListAll",method=RequestMethod.POST)
	@ResponseBody public List<HashMap<String, String>> TestListAll(GisuCategoryVO testVO) throws Exception{
		List<HashMap<String, String>> result = testService.TestListAll(testVO);
		
		for(int i = 0; i < result.size(); i++) {
			if(String.valueOf(result.get(i).get("state")).equalsIgnoreCase("A1801")) {
				result.remove(i);
				i--;
			}
		}
		
		if ((String.valueOf(testVO.getTest_seq())).equalsIgnoreCase("-1")) {
			return result;
		}
		List<HashMap<String, String>> list = testService.searchTestScore(Integer.parseInt(String.valueOf(testVO.getTest_seq())));
		
//		for (int i = 0; i < result.size(); i++) {
//			System.out.println("TestListAll -- 병합 전 result["+i+"] : " + result.get(i).toString());
//		}
//		for (int i = 0; i < list.size(); i++) {
//			System.out.println("TestListAll -- list["+i+"] : " + list.get(i).toString());
//		}
		for (int i = 0; i < result.size(); i++) {
			for (int j = 0; j < list.size(); j++) {
				if (result.get(i).get("USER_ID").equalsIgnoreCase(list.get(j).get("USER_ID"))) {
					if (list.get(j).get("CONTENT") == null || list.get(j).get("CONTENT").equalsIgnoreCase("") || list.get(j).get("CONTENT").equalsIgnoreCase("null")) {
						list.get(j).replace("CONTENT", "");
					}
					result.get(i).putAll(list.get(j));
				}
			}
		}
		
		for (int i = 0; i < result.size(); i++) {
			System.out.println("TestListAll -- 병합 후 result["+i+"] : " + result.get(i).toString());
			
		}
		return result;
		
	}
	
	@RequestMapping(value="/insertTestInfo",method=RequestMethod.POST)
	@ResponseBody public String insertTestInfo(TestInfoVO vo) throws Exception{
		System.out.println(vo.toString());
		
		int result = testService.insertTestInfo(vo);
		if (result == 1 ) {
			return "성공!!";
		} else return "실패!!";
		
	}
	
	@RequestMapping(value="/makeProgressInSmall", method=RequestMethod.POST)
	@ResponseBody public List<HashMap<String, String>> makeProgressInSmall(GisuCategoryVO testVO) throws Exception {
		System.out.println(testVO.toString());
		List<HashMap<String, String>> result = new ArrayList<HashMap<String,String>>();
		result = testService.makeProgressInSmall(testVO);
//		for (int i = 0; i < result.size(); i++) {
//			System.out.println("makeProgressInSmall -- result["+i+"] : " + result.get(i).toString());
//		}
		return result; 
	}
	@RequestMapping(value="/callSmallCategory", method=RequestMethod.POST)
	@ResponseBody public List<HashMap<String, String>> callSmallCategory(GisuCategoryVO testVO) throws Exception {
		System.out.println("callSmallCategory - > " + testVO.toString());
		List<HashMap<String, String>> result = new ArrayList<HashMap<String,String>>();
		//result = testService.callSmallCategory(testVO);
		for (int i = 0; i < result.size(); i++) {
			System.out.println("callSmallCategory - result["+i+"] : " + result.get(i).toString());
		}
		return result; 
	}
	@RequestMapping(value="/searchCategoryList", method=RequestMethod.POST)
	@ResponseBody public List<HashMap<String, String>> searchCategoryList(GisuCategoryVO testVO) throws Exception {
		System.out.println(testVO.toString());
		List<HashMap<String, String>> result = new ArrayList<HashMap<String,String>>();
		result = testService.searchCategoryList(testVO);
		System.out.println(result.size());
		System.out.println(result.toString());
		for (int i = 0; i < result.size(); i++) {
			System.out.println(result.get(i).toString());
		}
		return result; 
	}
	@RequestMapping(value="/saveTestData",method=RequestMethod.POST)
	@ResponseBody public String saveTestData(@RequestBody List<HashMap<String, String>>  vo) throws Exception{
		for (int i = 0; i < vo.size(); i++) {
			System.out.println("vo : " + vo.get(i).toString());
		}
		String check = testService.checkTesting(Integer.parseInt(String.valueOf(vo.get(0).get("test_seq"))));
		List<String> list = testService.selectTestUser(Integer.parseInt(String.valueOf(vo.get(0).get("test_seq"))));
//		System.out.println("testuser = " + list.toString());
		String content;
		try {
			for (int i = 0; i < vo.size(); i++) {
//				System.out.println("saveTestData - vo : " + vo.get(i).toString());
				TestScoreVO voo = new TestScoreVO();
				if(String.valueOf(vo.get(i).get("user_id")).equals("testuserlms")){
					continue;
				}
				if(String.valueOf(vo.get(i).get("user_id")).equals("testuserlms2")){
					continue;
				}
				voo.setUser_id(String.valueOf(vo.get(i).get("user_id")));
				voo.setTest_seq(Integer.parseInt(String.valueOf(vo.get(0).get("test_seq"))));
				voo.setRetest(0);
				voo.setScore(Double.parseDouble(String.valueOf(vo.get(i).get("score"))));
				voo.setPlus_score(Integer.parseInt(String.valueOf(vo.get(i).get("plus_score"))));
				if (String.valueOf(vo.get(i).get("comment")).equalsIgnoreCase("")) {
					content = "";
				} else {
					content = String.valueOf(vo.get(i).get("comment"));
				}
				voo.setContent(content);
				if (check.equalsIgnoreCase("TRUE") && list.contains(voo.getUser_id())) {
						int result = testService.updateTestScore(voo);
//						System.out.println(result + " -- insert : " + voo.toString());
						
				}else {
					testService.insertTestScore(voo);
//					System.out.println("update : " + voo.toString());
				}						
			}	
		} catch (Exception e) {
			return e.getMessage();
		}
		testService.updateCheckTesting(Integer.parseInt(String.valueOf(vo.get(0).get("test_seq"))));
	
		return "true";
	}
	
	
	@RequestMapping(value="/ClearTesting",method=RequestMethod.POST)
	@ResponseBody public String ClearTesting(String test_seq) throws Exception{
		String result = testService.ClearTesting(Integer.parseInt(test_seq));
		int resulta = testService.deleteTestScore(Integer.parseInt(test_seq));
		if (result == "1" ) {
			return "성공!!";
		} else return "실패!!";
		
	}
	

	/**
	 * @Method Name : insertCategoryList
	 * @Date : 2020. 10. 06.
	 * @User : 양승균(수정)
	 * @Param : 카테고리 정보
	 * @Return : 카테고리 저장 여부
	 * @Method 설명 : 기수별 카테고리 저장
	 */
	@RequestMapping(value="/insertCategoryList",method=RequestMethod.POST)
	@ResponseBody public String insertCategoryList(@RequestBody List<HashMap<String, String>>  GisuCategoryVO) throws Exception{
		ArrayList<GisuCategoryVO> list = new ArrayList<GisuCategoryVO>();
		ArrayList<GisuCategoryVO> insertData = new ArrayList<GisuCategoryVO>();
		ArrayList<GisuCategoryVO> updateData = new ArrayList<GisuCategoryVO>();
		List<HashMap<String, String>> savedList3 = new ArrayList<HashMap<String,String>>();
		
		List<HashMap<String, String>> savedList = new ArrayList<HashMap<String,String>>();
		GisuCategoryVO tvo = new GisuCategoryVO();
		tvo.setCrc_id(GisuCategoryVO.get(0).get("crc_id"));
		tvo.setGisu_id(GisuCategoryVO.get(0).get("gisu_id"));
		String catValue = GisuCategoryVO.get(0).get("obj");
		
		for (int i = 0; i < GisuCategoryVO.size(); i++) {
			if (!(catValue.equalsIgnoreCase("bigC"))) {
				tvo.setBig_cat_seq(Integer.parseInt(String.valueOf(GisuCategoryVO.get(i).get("big_cat_seq"))));
			}
			if (catValue.equalsIgnoreCase("smallC")) {
				tvo.setMid_cat_seq(Integer.parseInt(String.valueOf(GisuCategoryVO.get(i).get("mid_cat_seq"))));
			}
			savedList.addAll(testService.searchBigCategoryList(tvo));
		}
		/*for (int i = 0; i < GisuCategoryVO.size(); i++) {
			for (int j = 0; j <savedList.size(); j++) {
				if (GisuCategoryVO.get(i).get("cat_nm").equalsIgnoreCase(String.valueOf(savedList.get(j).get("cat_nm")))) {
					GisuCategoryVO.get(i).put("cat_seq", String.valueOf(savedList.get(j).get("cat_seq")));
				}
			}
		}*/
//		for (int i = 0; i < savedList.size(); i++) {
//			System.out.println(i + "번째 : " + savedList.get(i).toString());
//		}
		
		for (int i = 0; i < savedList.size()-1; i++) {
			for (int j = i+1; j < savedList.size(); j++) {
				if (Integer.parseInt(String.valueOf(savedList.get(i).get("cat_seq")))== Integer.parseInt(String.valueOf(savedList.get(j).get("cat_seq")))) {
//					System.out.println("지운 데이터 -- " +i +"번째 , "+j+"번째 : "+ savedList.get(j).toString());
					savedList3.add(savedList.get(j));
					savedList.remove(j);
					j--;
				}
			}
		}
//		for (int i = 0; i < savedList.size(); i++) {
//			System.out.println(i + "번째 : " + savedList.get(i).toString());
//		}
		
		for (int i = 0; i < GisuCategoryVO.size(); i++) {
			GisuCategoryVO vo = new GisuCategoryVO();
			vo.setCrc_id(GisuCategoryVO.get(i).get("crc_id"));
			vo.setGisu_id(GisuCategoryVO.get(i).get("gisu_id"));
			vo.setCat_nm(GisuCategoryVO.get(i).get("cat_nm"));
			vo.setCat_percent(Double.parseDouble(GisuCategoryVO.get(i).get("cat_percent")));
			if (GisuCategoryVO.get(i).get("cat_seq") != null) {
				vo.setCat_seq(Integer.parseInt(String.valueOf(GisuCategoryVO.get(i).get("cat_seq"))));
			}
			if (!(catValue.equalsIgnoreCase("bigC"))) {
				vo.setBig_cat_seq(Integer.parseInt(String.valueOf(GisuCategoryVO.get(i).get("big_cat_seq"))));
			} 
			if (catValue.equalsIgnoreCase("smallC")) {
//				System.out.println("확인용 ::::::: " + GisuCategoryVO.get(i).toString());
				vo.setMid_cat_seq(Integer.parseInt(String.valueOf(GisuCategoryVO.get(i).get("mid_cat_seq"))));
			}
//			System.out.println("vo : " + vo.toString());
			list.add(vo);
		}
		
//		for (int i = 0; i < list.size(); i++) {
//			System.out.println("List : " + list.get(i).toString());
//		}
//		if (savedList.size()!=0) {
//			for (int i = 0; i < savedList.size(); i++) {
//				System.out.println("savedList : " + savedList.get(i).toString());
//			}
//		}
		
		for (int i = 0; i < list.size(); i++) {
			boolean flag = false;
			for (int j = 0; j < savedList.size(); j++) {
//					System.out.println("업데이트 확인용 ->> "+list.get(i).getCat_nm() +" : " + savedList.get(j).get("cat_nm"));
//					System.out.println("확인용 ->> list[" +i+"] : "+ list.get(i).getCat_seq() +", savedList [" +j+ "] : "+Integer.parseInt(String.valueOf(savedList.get(j).get("cat_seq"))));
				if ((list.get(i).getCat_seq() == Integer.parseInt(String.valueOf(savedList.get(j).get("cat_seq"))) && flag ==false )) {
					updateData.add(new GisuCategoryVO(	Integer.parseInt(String.valueOf(savedList.get(j).get("cat_seq"))),
														String.valueOf(savedList.get(j).get("crc_id")),
														String.valueOf(savedList.get(j).get("gisu_id")),
														list.get(i).getCat_nm(),
														list.get(i).getCat_percent(),
														Integer.parseInt(String.valueOf(savedList.get(j).get("big_cat_seq"))),
														Integer.parseInt(String.valueOf(savedList.get(j).get("mid_cat_seq")))));
//					System.out.println("1-remove data "+j+"번째  : " + savedList.get(j).toString());
					if ((list.get(i).getCat_seq() == Integer.parseInt(String.valueOf(savedList.get(j).get("cat_seq"))))) {
						flag = true;
					}
					savedList.remove(j);
//					System.out.println(savedList.size());
					j--;
					continue;
				}
				if (list.get(i).getCat_seq() == Integer.parseInt(String.valueOf(savedList.get(j).get("big_cat_seq"))) && list.get(i).getCat_seq() != 0) {
					updateData.add(new GisuCategoryVO(	Integer.parseInt(String.valueOf(savedList.get(j).get("cat_seq"))),
														String.valueOf(savedList.get(j).get("crc_id")),
														String.valueOf(savedList.get(j).get("gisu_id")),
														String.valueOf(savedList.get(j).get("cat_nm")),
														Double.parseDouble(String.valueOf(savedList.get(j).get("cat_percent"))),
														Integer.parseInt(String.valueOf(savedList.get(j).get("big_cat_seq"))),
														Integer.parseInt(String.valueOf(savedList.get(j).get("mid_cat_seq")))));
//					System.out.println("2-remove data "+j+"번째  : " + savedList.get(j).toString());
					savedList.remove(j);
//					System.out.println(savedList.size());
					j--;
					continue;
				}
				if (list.get(i).getCat_seq() == Integer.parseInt(String.valueOf(savedList.get(j).get("mid_cat_seq"))) && list.get(i).getCat_seq() != 0) {
					updateData.add(new GisuCategoryVO(	Integer.parseInt(String.valueOf(savedList.get(j).get("cat_seq"))),
														String.valueOf(savedList.get(j).get("crc_id")),
														String.valueOf(savedList.get(j).get("gisu_id")),
														String.valueOf(savedList.get(j).get("cat_nm")),
														Double.parseDouble(String.valueOf(savedList.get(j).get("cat_percent"))),
														Integer.parseInt(String.valueOf(savedList.get(j).get("big_cat_seq"))),
														Integer.parseInt(String.valueOf(savedList.get(j).get("mid_cat_seq")))));
//					System.out.println("3-remove data "+j+"번째  : " + savedList.get(j).toString());
					savedList.remove(j);
//					System.out.println(savedList.size());
					j--;
					continue;
				}
			}
			if (flag == false && list.get(i).getCat_seq() == 0) {
				insertData.add(list.get(i));
			}
			flag = false;
		}
		
		if (insertData.size() != 0 ) {
//			for (int i = 0; i < insertData.size(); i++) {
//				System.out.println("insertData : "+ insertData.get(i).toString());
//			}
			for (int i = 0; i < insertData.size(); i++) {
				testService.createBigCategory(insertData.get(i));
			}	
		}
		if (updateData.size()!=0) {
/*			for (int i = 0; i < updateData.size(); i++) {
				for (int j = 0; j < savedList3.size(); j++) {
					if (updateData.get(i).getCat_seq()==Integer.parseInt(String.valueOf(savedList3.get(j).get("cat_seq")))
					|| 	updateData.get(i).getCat_nm().equalsIgnoreCase(String.valueOf(savedList3.get(j).get("cat_nm")))) {
						savedList3.remove(j);
					}
				}
			}*/
			for (int i = 0; i < updateData.size(); i++) {
//				System.out.println("updateData : " + updateData.get(i));
				testService.updateBigCategory(updateData.get(i));
			}	
		}		
		for (int i = 0; i < savedList.size(); i++) {
//			System.out.println("deleteData(savedList) : " + savedList.get(i));
			testService.deleteBigCategory(Integer.parseInt(String.valueOf(savedList.get(i).get("cat_seq"))));
		}
		return "true";
	}
		
	
	@RequestMapping(value="/createUpperCategory",method=RequestMethod.POST)
	@ResponseBody public List<HashMap<String, String>> createUpperCategory(GisuCategoryVO GisuCategoryVO) throws Exception{
		List<HashMap<String, String>> list = testService.createUpperCategory(GisuCategoryVO);
//		if (list.size()!=0) {
//			for (int i = 0; i < list.size(); i++) {
//				System.out.println("createUpperCategory >> "+list.get(i).toString());
//			}
//		}
		return list;
	}
	@RequestMapping(value="/deleteTestInfo",method=RequestMethod.POST)
	@ResponseBody public int deleteTestInfo(GisuCategoryVO GisuCategoryVO) throws Exception{
		int result = testService.deleteTestInfo(GisuCategoryVO);
		return result;
	}
	
	@RequestMapping(value="/deleteCategory",method=RequestMethod.POST)
	@ResponseBody public int deleteCategory(String seq) throws Exception{
		int result = testService.deleteCategory(seq);
		return result;
	}
	
	@RequestMapping(value="/searchtUserTestInfo",method=RequestMethod.POST)
	@ResponseBody public List<HashMap<String, String>> searchtUserTestInfo(UserScoreVO vo) throws Exception{
		GisuCategoryVO testVO = new GisuCategoryVO();
		testVO.setCrc_id(vo.getCrc_id());
		testVO.setGisu_id(vo.getGisu_id());
		List<HashMap<String, String>> testInfo = testService.searchtUserTestInfo(vo);
		List<HashMap<String, String>> catInfo = testService.searchtCategoryInfo(vo);
		List<HashMap<String, String>> needInfo = new ArrayList<HashMap<String,String>>();
		List<HashMap<String, String>> haveNotInfo = new ArrayList<HashMap<String,String>>();
		List<HashMap<String, String>> memberList = testService.TestListAll(testVO);
		List<HashMap<String, String>> testList = testService.callSmallCategory(testVO);
		List<HashMap<String, String>> testInfoM = new ArrayList<HashMap<String,String>>();
		List<String> mL = new ArrayList<String>();
		HashMap<String, HashMap<Integer,Double>> testInfoMember = new HashMap<String, HashMap<Integer,Double>>();
		List<HashMap<String, String>> list = testService.createUpperCategory(testVO);
	
		for(int i = 0; i < memberList.size(); i++) {
			if(String.valueOf(memberList.get(i).get("state")).equalsIgnoreCase("A1801")) {
				memberList.remove(i);
				i--;
			}
		}
		
		for (int i = 0; i < testInfo.size(); i++) {
			if (String.valueOf(testInfo.get(i).get("TEST_SEQ")).equalsIgnoreCase("") || String.valueOf(testInfo.get(i).get("TEST_SEQ")).equalsIgnoreCase("NULL") || String.valueOf(testInfo.get(i).get("TEST_SEQ")).equalsIgnoreCase(null)) {
				haveNotInfo.add(testInfo.get(i));
				testInfo.remove(i);
				i--;
			}
		}
		
		for (int i = 0; i < memberList.size(); i++) {
			mL.add(String.valueOf(memberList.get(i).get("USER_ID")));
			testInfoM.add(new HashMap<String,String>());
			testInfoM.get(i).put("USER_ID", String.valueOf(memberList.get(i).get("USER_ID")));
		}
		
//		for(int i = 0; i < testList.size(); i++) {
//			System.out.println("testList 확인 = " + testList.get(i).toString());
//		}
		
		HashMap<String, String> testCount = new HashMap<>();
		
		for(int i = 0; i < catInfo.size(); i++) {
			if(!String.valueOf(catInfo.get(i).get("BIG_CAT_SEQ")).equalsIgnoreCase("0") && !String.valueOf(catInfo.get(i).get("MID_CAT_SEQ")).equalsIgnoreCase("0")) {
				int count = testService.testCount(String.valueOf(catInfo.get(i).get("CAT_SEQ")));
				testCount.put(String.valueOf(catInfo.get(i).get("CAT_SEQ")), String.valueOf(count));				
			}
		}
		
		for (int i = 0; i < testInfo.size(); i++) {
			String user_id = String.valueOf(testInfo.get(i).get("USER_ID"));
			
//			System.out.println("testInfo [ " +i+" ] : "+ testInfo.get(i).toString());
			if (testInfoMember.get(String.valueOf(testInfo.get(i).get("USER_ID")))==null) {
				testInfoMember.put(String.valueOf(testInfo.get(i).get("USER_ID")),new HashMap<Integer, Double>());
			}
			
			double addScore = Double.parseDouble(String.valueOf(testInfo.get(i).get("SCORE")))+Double.parseDouble(String.valueOf(testInfo.get(i).get("PLUS_SCORE")));
			double totalScore = Double.parseDouble(String.valueOf(testInfo.get(i).get("TOTAL_SCORE")));
			
			double userScore = 0.00;
			if (addScore >= totalScore) {
				userScore = totalScore;
			}else {
				userScore = addScore;
			}
			testInfoMember.get(String.valueOf(testInfo.get(i).get("USER_ID"))).put(Integer.parseInt(String.valueOf(testInfo.get(i).get("CAT_SEQ"))), userScore);
			for (int j = 0; j < testInfoM.size(); j++) {
				if (String.valueOf(testInfoM.get(j).get("USER_ID")).equalsIgnoreCase(user_id)) {
					
					if(testInfoM.get(j).get(String.valueOf(testInfo.get(i).get("CAT_SEQ"))) != null) {
						double score = userScore + Double.parseDouble(String.valueOf(testInfoM.get(j).get(String.valueOf(testInfo.get(i).get("CAT_SEQ")))));
						testInfoM.get(j).put(String.valueOf(testInfo.get(i).get("CAT_SEQ")), String.valueOf(score));
						
					} else {
						testInfoM.get(j).put(String.valueOf(testInfo.get(i).get("CAT_SEQ")), String.valueOf(userScore));
					}
					
					testInfoM.get(j).put(String.valueOf(testInfo.get(i).get("TEST_NM")), String.valueOf(userScore));
					break;
				}
			}
		}
		
		for(int i = 0; i < catInfo.size(); i++) {
			if(!String.valueOf(catInfo.get(i).get("BIG_CAT_SEQ")).equalsIgnoreCase("0") && !String.valueOf(catInfo.get(i).get("MID_CAT_SEQ")).equalsIgnoreCase("0")) {
				String cat = String.valueOf(catInfo.get(i).get("CAT_SEQ"));
			
				for(int j = 0; j < testInfoM.size(); j++) {
//					System.out.println("testinfoM = " + String.valueOf(testInfoM.get(j).get(cat)));
					if(!(String.valueOf(testInfoM.get(j).get(cat)).equalsIgnoreCase("null"))) {
						double score = Double.parseDouble(String.valueOf(testInfoM.get(j).get(cat)));
						double total = Double.parseDouble(String.valueOf(testCount.get(cat)));
						double finalScore = score/total;
						/*	System.out.println("score = " + score + "total = " + total + " final = " + finalScore);*/
						testInfoM.get(j).put(cat, String.valueOf(Math.round(finalScore*100)/100.0));
					}
				}
			}
		}
		
//		for(int i = 0; i < testInfoM.size(); i++) {
//			System.out.println("testInfoM 2차 확인 = " + testInfoM.get(i).toString());
//		}
		
		// 중분류 가져오기..
		for (int i = 0; i < catInfo.size(); i++) {
			Integer cat_seq = Integer.parseInt(String.valueOf(catInfo.get(i).get("CAT_SEQ")));
			int nm = cat_seq;	
			for (int j = 0; j < mL.size(); j++) {
				if (!(testInfoMember.containsKey(mL.get(j)))) {
					continue;
				}
				if (testInfoMember.get(mL.get(j)).containsKey(nm)) {
					needInfo.add(catInfo.get(i));
					break;
				}
			}
		}
		
		for (int i = 0; i < needInfo.size(); i++) {
			for (int j = 0; j < catInfo.size(); j++) {
				if (String.valueOf(needInfo.get(i).get("MID_CAT_SEQ")).equalsIgnoreCase(String.valueOf(catInfo.get(j).get("CAT_SEQ"))) && (!(needInfo.contains(catInfo.get(j))))) {
					needInfo.add(catInfo.get(j));
				}
			}
		}
		for (int i = 0; i < needInfo.size(); i++) {
			for (int j = 0; j < catInfo.size(); j++) {
				if (String.valueOf(needInfo.get(i).get("BIG_CAT_SEQ")).equalsIgnoreCase(String.valueOf(catInfo.get(j).get("CAT_SEQ"))) && (!(needInfo.contains(catInfo.get(j)))) && String.valueOf(needInfo.get(i).get("MID_CAT_SEQ")).equalsIgnoreCase("0")) {
					needInfo.add(catInfo.get(j));
				}
			}
		}
		for (int i = 0; i < needInfo.size(); i++) {
			for (int j = 0; j < testInfo.size(); j++) {
				if (String.valueOf(needInfo.get(i).get("CAT_SEQ")).equalsIgnoreCase(String.valueOf(testInfo.get(j).get("CAT_SEQ")))) {
					needInfo.get(i).put("TOTAL_SCORE", String.valueOf(testInfo.get(j).get("TOTAL_SCORE")));
					break;
				}
			}
		}
		
//		for (int i = 0; i < needInfo.size(); i++) {
//			System.out.println("needInfo ["+i+"] : "+needInfo.get(i).toString());
//		}
		
		
		HashMap<String,Double> percent = new HashMap<String,Double>();
		for (int i = 0; i < testInfoM.size(); i++) {	
			for (int j = 0; j < needInfo.size(); j++) {
				if (String.valueOf(needInfo.get(j).get("MID_CAT_SEQ")).equalsIgnoreCase("0")) {
					continue;
				}
				String cat_seq = String.valueOf(needInfo.get(j).get("CAT_SEQ"));
				String cat_percent = String.valueOf(needInfo.get(j).get("CAT_PERCENT"));
				String total_score = String.valueOf(needInfo.get(j).get("TOTAL_SCORE"));
				if (i==0) {
					if (percent.get(String.valueOf(needInfo.get(j).get("MID_CAT_SEQ"))) == null && needInfo.get(j).get("MID_CAT_SEQ") != "0" && needInfo.get(j).get("BIG_CAT_SEQ") != "0") {
						percent.put(String.valueOf(needInfo.get(j).get("MID_CAT_SEQ")), Double.parseDouble(cat_percent));
					}else if(needInfo.get(j).get("MID_CAT_SEQ") != "0" && needInfo.get(j).get("BIG_CAT_SEQ") != "0"){
						percent.replace(String.valueOf(needInfo.get(j).get("MID_CAT_SEQ")), (percent.get(String.valueOf(needInfo.get(j).get("MID_CAT_SEQ")))+Double.parseDouble(cat_percent)));
					}	
				}
				
				if (testInfoM.get(i).get(cat_seq) != null) {
					Double fixedScore = Double.parseDouble(testInfoM.get(i).get(cat_seq))*(Double.parseDouble(cat_percent)/100);
					if (total_score != "null" && Double.parseDouble(total_score)!=100) {
						fixedScore = fixedScore * (100/(Double.parseDouble(total_score)));
					}
					if (testInfoM.get(i).get(String.valueOf(needInfo.get(j).get("MID_CAT_SEQ")))== null && needInfo.get(j).get("BIG_CAT_SEQ") != "0" && String.valueOf(needInfo.get(j).get("MID_CAT_SEQ")) != "0") {
						testInfoM.get(i).put(String.valueOf(needInfo.get(j).get("MID_CAT_SEQ")), String.valueOf(Math.round(fixedScore*100)/100.0));
					} else if(testInfoM.get(i).get(String.valueOf(needInfo.get(j).get("MID_CAT_SEQ")))!=null && String.valueOf(needInfo.get(j).get("MID_CAT_SEQ")) != "0" && needInfo.get(j).get("BIG_CAT_SEQ") != "0"){
						fixedScore = Double.parseDouble(testInfoM.get(i).get(String.valueOf(needInfo.get(j).get("MID_CAT_SEQ"))))+Math.round(fixedScore*100)/100.0;
						testInfoM.get(i).replace(String.valueOf(needInfo.get(j).get("MID_CAT_SEQ")), String.valueOf(fixedScore));				
					}
				}
			}
		}
		for (int i = 0; i < testInfoM.size(); i++) {
			for (int j = 0; j < needInfo.size(); j++) {
				if ((!(String.valueOf(needInfo.get(j).get("MID_CAT_SEQ")).equalsIgnoreCase("0"))) || String.valueOf(needInfo.get(j).get("BIG_CAT_SEQ")).equalsIgnoreCase("0")) {
					continue;
				}
				String cat_seq = String.valueOf(needInfo.get(j).get("CAT_SEQ"));
				String cat_percent = String.valueOf(needInfo.get(j).get("CAT_PERCENT"));
				
				if (i==0) {
					if (percent.get(String.valueOf(needInfo.get(j).get("BIG_CAT_SEQ"))) == null) {
						percent.put(String.valueOf(needInfo.get(j).get("BIG_CAT_SEQ")), Double.parseDouble(cat_percent));
					}else {
						percent.replace(String.valueOf(needInfo.get(j).get("BIG_CAT_SEQ")), (percent.get(String.valueOf(needInfo.get(j).get("BIG_CAT_SEQ")))+Double.parseDouble(cat_percent)));
					}	
				}
				if (testInfoM.get(i).get(cat_seq) != null) {
					Double fixedScore = Double.parseDouble(testInfoM.get(i).get(cat_seq))*(Double.parseDouble(cat_percent)/100);
					
					if (testInfoM.get(i).get(String.valueOf(needInfo.get(j).get("BIG_CAT_SEQ")))== null) {
						testInfoM.get(i).put(String.valueOf(needInfo.get(j).get("BIG_CAT_SEQ")), String.valueOf(Math.round(fixedScore*100)/100.0));
					} else {
						fixedScore = Double.parseDouble(testInfoM.get(i).get(String.valueOf(needInfo.get(j).get("BIG_CAT_SEQ"))))+Math.round(fixedScore*100)/100.0;
						testInfoM.get(i).replace(String.valueOf(needInfo.get(j).get("BIG_CAT_SEQ")), String.valueOf(fixedScore));				
					}
				}
			}
			
		}
		Iterator<String> keys = percent.keySet().iterator();
    	while (keys.hasNext()){
            	String key = keys.next();					
            for (int i = 0; i < testInfoM.size(); i++) {
            	if (testInfoM.get(i).get(key)==null) {
					continue;
				}
            	double score = Double.parseDouble(testInfoM.get(i).get(key)) * Math.round((100.0/percent.get(key)*100)/100.0);
            	testInfoM.get(i).replace(key, String.valueOf(Math.round(score*100)/100.0));
            } 
		}
			
		for (int i = 0; i < testInfoM.size(); i++) {
			for (int j = 0; j < needInfo.size(); j++) {
				if ((!(String.valueOf(needInfo.get(j).get("MID_CAT_SEQ")).equalsIgnoreCase("0"))) || (!(String.valueOf(needInfo.get(j).get("BIG_CAT_SEQ")).equalsIgnoreCase("0")))) {
					continue;
				}
				String cat_seq = String.valueOf(needInfo.get(j).get("CAT_SEQ"));
				String cat_percent = String.valueOf(needInfo.get(j).get("CAT_PERCENT"));
				if (testInfoM.get(i).get(cat_seq) != null) {
					Double fixedScore = Double.parseDouble(testInfoM.get(i).get(cat_seq))*(Double.parseDouble(cat_percent)/100);
					if (testInfoM.get(i).get("TOTAL") == null) {
						testInfoM.get(i).put("TOTAL", String.valueOf(Math.round(fixedScore*100)/100.0));
					} else {
						fixedScore = Double.parseDouble(testInfoM.get(i).get("TOTAL"))+(Math.round(fixedScore*100)/100.0);
						fixedScore = Math.round(fixedScore*100)/100.0;
						testInfoM.get(i).replace("TOTAL", String.valueOf(fixedScore));
					}
				}
			}
		}

		for (int i = 0; i < testInfoM.size(); i++) {
			if (testInfoM.get(i).get("TOTAL") == null) {
				testInfoM.remove(i);
				i--;
			}
		}
			
		for (int i = 0; i < testInfoM.size(); i++) {
			for (int j = 0; j < memberList.size(); j++) {
				if (String.valueOf(testInfoM.get(i).get("USER_ID")).equalsIgnoreCase(String.valueOf(memberList.get(j).get("USER_ID")))) {
					testInfoM.get(i).put("USER_NM", String.valueOf(memberList.get(j).get("USER_NAME")));
					break;
				}
			}
		}
		
		for (int i = 0; i < testInfoM.size(); i++) {
			for (int j = 0; j < needInfo.size(); j++) {
				if (testInfoM.get(i).get(String.valueOf(needInfo.get(j).get("CAT_SEQ"))) != null) {
						String score = testInfoM.get(i).get(String.valueOf(needInfo.get(j).get("CAT_SEQ")));
					if (String.valueOf(needInfo.get(j).get("BIG_CAT_SEQ")).equalsIgnoreCase("0") && String.valueOf(needInfo.get(j).get("MID_CAT_SEQ")).equalsIgnoreCase("0")) {
						testInfoM.get(i).put("대분류▨"+String.valueOf(needInfo.get(j).get("CAT_NM")), score);
					} else if((!String.valueOf(needInfo.get(j).get("BIG_CAT_SEQ")).equalsIgnoreCase("0")) && String.valueOf(needInfo.get(j).get("MID_CAT_SEQ")).equalsIgnoreCase("0")) {
						for(int z = 0; z < list.size(); z++) {
							if(String.valueOf(list.get(z).get("CAT_SEQ")).equalsIgnoreCase(String.valueOf(needInfo.get(j).get("CAT_SEQ")))) {
								testInfoM.get(i).put("중분류▨"+list.get(z).get("big_cat_nm")+"▨"+String.valueOf(needInfo.get(j).get("CAT_NM")), score);
							}
						}
					}else {
						for(int z = 0; z < list.size(); z++) {
							if(String.valueOf(list.get(z).get("CAT_SEQ")).equalsIgnoreCase(String.valueOf(needInfo.get(j).get("CAT_SEQ")))) {
								testInfoM.get(i).put("소분류▨"+list.get(z).get("big_cat_nm")+"▨"+list.get(z).get("mid_cat_nm")+"▨"+String.valueOf(needInfo.get(j).get("CAT_NM")), score +" / " +Double.parseDouble(String.valueOf(needInfo.get(j).get("TOTAL_SCORE"))));
							}
						}
					}
					testInfoM.get(i).remove(String.valueOf(needInfo.get(j).get("CAT_SEQ")));
				}
			}
		}
		
		for(int i = 0; i < testInfoM.size(); i++) {
			for(int j = 0; j < testList.size(); j++) {
				if (testInfoM.get(i).get(String.valueOf(testList.get(j).get("TEST_NM"))) != null) {
					String score = testInfoM.get(i).get(String.valueOf(testList.get(j).get("TEST_NM")));
					testInfoM.get(i).put(String.valueOf(testList.get(j).get("SMALL_CAT_NM"))+"▨"+String.valueOf(testList.get(j).get("TEST_NM")), score +" / " +Double.parseDouble(String.valueOf(testList.get(j).get("TOTAL_SCORE"))));
					
					testInfoM.get(i).remove(String.valueOf(testList.get(j).get("TEST_NM")));
				}
			}
		}
		
//		for (int i = 0; i < testInfoM.size(); i++) {
//			System.out.println("testInfoM 확인 : "+ testInfoM.get(i).toString());
//		}
		
		return testInfoM;
	}
	
	
	@RequestMapping(value="/insertClassList",method=RequestMethod.POST)
	@ResponseBody public String insertClassList(@RequestBody List<HashMap<String, String>>  vo) throws Exception{
		ClassInfoVO cvo = new ClassInfoVO();
		ArrayList<ClassInfoVO> bigC = new ArrayList<ClassInfoVO>();
		ArrayList<ClassInfoVO> smallC = new ArrayList<ClassInfoVO>();
		for (int i = 0; i < vo.size(); i++) {
			System.out.println(vo.get(i).toString());
		}
		
		for (int i = 0; i < vo.size(); i++) {
			cvo = new ClassInfoVO();
			if (vo.get(i).get("class_name").equals(vo.get(i).get("upper_class_name")) && vo.get(i).get("class_seq").equals(vo.get(i).get("upper_class_seq"))) {
				cvo.setClass_name(String.valueOf(vo.get(i).get("class_name")));
				cvo.setClass_seq(Integer.parseInt(String.valueOf(vo.get(i).get("class_seq"))));
				cvo.setCrc_id(String.valueOf(vo.get(i).get("crc_id")));
				cvo.setGisu_id(String.valueOf(vo.get(i).get("gisu_id")));
				bigC.add(cvo);
			}else {
				cvo.setClass_name(String.valueOf(vo.get(i).get("class_name")));
				cvo.setClass_seq(Integer.parseInt(String.valueOf(vo.get(i).get("class_seq"))));
				cvo.setCrc_id(String.valueOf(vo.get(i).get("crc_id")));
				cvo.setGisu_id(String.valueOf(vo.get(i).get("gisu_id")));
				cvo.setClass_upper_seq(Integer.parseInt(String.valueOf(vo.get(i).get("upper_class_seq"))));
				cvo.setClass_upper_name(String.valueOf(vo.get(i).get("upper_class_name")));
				smallC.add(cvo);
			}
		}
		for (int i = 0; i < bigC.size(); i++) {
			if (bigC.get(i).getClass_seq() == -1) {
				System.out.println("insert 데이터 - " + bigC.get(i).toString());
				testService.insertClassList(bigC.get(i));
			} else {
				System.out.println("update 데이터 - " + bigC.get(i).toString());
				testService.updateClassList(bigC.get(i));
			}
		}
		for (int i = 0; i < smallC.size(); i++) {
			if (smallC.get(i).getClass_seq() == -1) {
				System.out.println("insert 데이터 - " + smallC.get(i).toString());
				testService.insertClassList(smallC.get(i));
			} else {
				System.out.println("update 데이터 - " + smallC.get(i).toString());
				testService.updateClassList(smallC.get(i));
			}
		}
		
		return "";
	}
	@RequestMapping(value="/searchClassList",method=RequestMethod.POST)
	@ResponseBody public List<ClassInfoVO> searchClassList(ClassInfoVO vo) throws Exception{
		return testService.searchClassList(vo);
	}
	
	@RequestMapping(value="/deleteClassList",method=RequestMethod.POST)
	@ResponseBody public int deleteClassList(ClassInfoVO vo) throws Exception{
		return testService.deleteClassList(vo); 
	}
	
	
	
	// 여기서 부터 내일 할것 
	
	@RequestMapping(value="/selectableUser",method=RequestMethod.POST)
	@ResponseBody public List<ClassInfoVO> selectableUser(@RequestBody ClassInfoVO vo) throws Exception{
		System.out.println(vo.toString());
		List<ClassInfoVO> list = testService.selectableUser(vo);
		
		for(int i = 0; i < list.size(); i++) {
			if(String.valueOf(list.get(i).getState()).equalsIgnoreCase("A1801")) {
				list.remove(i);
				i--;
			}
		}
		
		for (int i = 0; i < list.size(); i++) {
			System.out.println("selectableUser ["+i+"] : "+list.get(i).toString());
		}
		return list;
	}
	
	@RequestMapping(value="/insertUserInClass",method=RequestMethod.POST)
	@ResponseBody public int insertUserInClass(@RequestBody List<ClassInfoVO> vo) throws Exception{
		for (int i = 0; i < vo.size(); i++) {
			testService.insertUserInClass(vo.get(i));
		}
		return 0; 
	}
	@RequestMapping(value="/deleteUserInClass",method=RequestMethod.POST)
	@ResponseBody public int deleteUserInClass(@RequestBody List<ClassInfoVO> vo) throws Exception{
		for (int i = 0; i < vo.size(); i++) {
			testService.deleteUserInClass(vo.get(i));
		}
		return 0; 
	}
}
