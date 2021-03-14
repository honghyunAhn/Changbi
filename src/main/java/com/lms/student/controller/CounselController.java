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

import com.lms.student.service.counselService;
import com.lms.student.vo.CounselVO;
import com.lms.student.vo.GisuCategoryVO;

import forFaith.util.DataList;


@RequestMapping("student/Counsel")
@Controller(value="controller.CounselController")
public class CounselController{

	@Autowired
	counselService cs;

	@RequestMapping(value="/searchCirriculumList", method=RequestMethod.POST)
	@ResponseBody public List<HashMap<String, String>> searchCurriculumSeq() throws Exception {
		List<HashMap<String, String>> result = cs.searchCurriculumSurvey();
		
		return result;
	}

	@RequestMapping(value="/searchCirriculum", method=RequestMethod.POST)
	@ResponseBody public HashMap<String, String> searchCurriculum(String crc_id) throws Exception {
		System.out.println("crc_id: " + crc_id);
		HashMap<String, String> result = cs.searchCurriculum(crc_id);
		return result;
	}
	
	@RequestMapping(value="/searchGisuList",method=RequestMethod.POST)
	@ResponseBody public List<HashMap<String, String>> searchGisuList(@RequestBody String seq) throws Exception{
		String changeSeq = seq.split("=")[0];
		List<HashMap<String, String>> result = cs.searchGisuListSurvey(changeSeq);
		return result;
		
	}
	
	 @RequestMapping(value = "/counselList", method = RequestMethod.POST)
	    public @ResponseBody DataList<CounselVO> CounselList(CounselVO Counsel) throws Exception {
	    	DataList<CounselVO> result = new DataList<CounselVO>();
	    	
	    	result.setPagingYn(Counsel.getPagingYn());
	    	// 페이징 처리인 경우만 페이지 번호와 토탈 갯수를 저장한다.
			if(result.getPagingYn().equals("Y")) {
				result.setNumOfNums(Counsel.getNumOfNums());
				result.setNumOfRows(Counsel.getNumOfRows());
				result.setPageNo(Counsel.getPageNo());
				result.setTotalCount(cs.CounselTotalCnt(Counsel));
			}
			System.out.println("result 값 : " + result.toString());

			// 결과 리스트를 저장
			result.setList(cs.CounselList(Counsel));
			
			for (int i = 0; i < result.size(); i++) {
				System.out.println(result.get(i).toString());
			}
			return result;
	    }
	 
	@RequestMapping(value = "/counselStudentList", method = RequestMethod.POST)
    public @ResponseBody DataList<CounselVO> counselStudentList(CounselVO Counsel) throws Exception {
    	DataList<CounselVO> result = new DataList<CounselVO>();
    	
    	result.setPagingYn(Counsel.getPagingYn());
    	// 페이징 처리인 경우만 페이지 번호와 토탈 갯수를 저장한다.
		if(result.getPagingYn().equals("Y")) {
			result.setNumOfNums(Counsel.getNumOfNums());
			result.setNumOfRows(Counsel.getNumOfRows());
			result.setPageNo(Counsel.getPageNo());
			result.setTotalCount(cs.counselStuTotalCnt(Counsel));
		}
		// 결과 리스트를 저장
		result.setList(cs.counselStudentList(Counsel));
		return result;
	}
	
	@RequestMapping(value = "/counselDetail", method = RequestMethod.POST)
	public @ResponseBody ArrayList<Object> counselDetail(CounselVO counsel) throws Exception {
		HashMap<String, Object> stuInfo = cs.counselStudentInfo(counsel);
		ArrayList<HashMap<String, Object>> detailList = cs.counselDetailList(counsel);
		
		ArrayList<Object> result = new ArrayList<>();
		result.add(stuInfo);
		result.add(detailList);
		return result;
	}
	
	 @RequestMapping(value="/searchStudent",method=RequestMethod.POST)
		@ResponseBody public List<HashMap<String, String>> searchStudent(GisuCategoryVO testVO) throws Exception{
			List<HashMap<String, String>> result = cs.searchStudent(testVO);
			return result;
	 }
	 @RequestMapping(value="/searchTeacher",method=RequestMethod.POST)
		@ResponseBody public List<HashMap<String, String>> searchTeacher(GisuCategoryVO testVO) throws Exception{
			List<HashMap<String, String>> result = cs.searchTeacher(testVO);
			for (int i = 0; i < result.size(); i++) {
				System.out.println("searchTeacher - result["+i+"] :"+ result.get(i).toString());
			}
			return result;
	 }
	 
	 
	 @RequestMapping(value="/insertCounsel",method=RequestMethod.POST)
		@ResponseBody public String insertTestInfo(CounselVO vo) throws Exception{
			System.out.println(vo.toString());
			int result = cs.insertCounsel(vo);
			if (result == 1 ) {
				return "성공!!";
			} else return "실패!!";
			
		}
	 
	 @RequestMapping(value="/deleteCounsel",method=RequestMethod.POST)
		@ResponseBody public ArrayList<HashMap<String, Object>> deleteCounsel(CounselVO vo) throws Exception{
			int result = cs.deleteCounsel(vo);
			if (result == 1 ) return cs.counselDetailList(vo);
			else return null;
			
		}
	 @RequestMapping(value="/updateCounsel",method=RequestMethod.POST)
		@ResponseBody public ArrayList<HashMap<String, Object>> updateCounsel(CounselVO vo) throws Exception{
			int result = cs.updateCounsel(vo); 
			if (result == 1 ) return cs.counselDetailList(vo);
			else return null;
		}
}
