package com.changbi.tt.dev.data.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.JSONArray;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.changbi.tt.dev.data.service.CompleteService;
import com.changbi.tt.dev.data.vo.LearnAppVO;

import forFaith.dev.util.GlobalMethod;
import forFaith.util.DataList;
import forFaith.util.StringUtil;

@Controller(value="data.completeController")	// Controller value는 중복되면 안된다. value 값을 지정하지 않으면 클래스명이 value가 되므로 같은 클래스명이 존재하면 중복으로 인식
@RequestMapping("/data/complete")       		// 해당 클래스를 호출 하기 위한 Mapping 기본 값 뒤에 붙는 값에 의해 필요한 함수가 호출 된다.
public class CompleteController {

	@Autowired
	private CompleteService completeService;
	
    /**
     * log를 남기는 객체 생성
     * @author : 김준석(2018-02-17)
     */
    private static final Logger logger = LoggerFactory.getLogger(CompleteController.class);

	/**
     * 이수 처리
     */
    @RequestMapping(value = "/completeProc", method = RequestMethod.POST)
    public @ResponseBody String completeProc(LearnAppVO learnApp) throws Exception {
    	completeService.completeProc(learnApp);

		return learnApp.getIds();
    }
    
    /**
     * 이수 처리 후 처리 결과 리스트 조회
     */
    @RequestMapping(value = "/completeProcList", method = RequestMethod.POST)
    public @ResponseBody DataList<LearnAppVO> completeProcList(LearnAppVO learnApp) throws Exception {
    	DataList<LearnAppVO> result = new DataList<LearnAppVO>();
    	
		// 결과 리스트를 저장
		result.setList(completeService.completeProcList(learnApp));
		return result;
    }

    /**
     * 이수 처리를 위한 모든 리스트 출력
     */
    @RequestMapping(value = "/completeListAll", method = RequestMethod.POST)
    public @ResponseBody DataList<LearnAppVO> completeListAll(LearnAppVO learnApp, @RequestParam HashMap<String, String> param) throws Exception {

    	DataList<LearnAppVO> result = new DataList<LearnAppVO>();
    	result.setPagingYn(learnApp.getPagingYn());
    	
    	// 페이징 처리인 경우만 페이지 번호와 토탈 갯수를 저장한다.
		if(result.getPagingYn().equals("Y")) {
			result.setNumOfNums(learnApp.getNumOfNums());
			result.setNumOfRows(learnApp.getNumOfRows());
			result.setPageNo(learnApp.getPageNo());
		}    	
    	
		// 결과 리스트를 저장
    	result.setList(completeService.completeListAll(param));

    	return result;
    }    
    
    @RequestMapping(value = "/doComplete", method = RequestMethod.GET)
    public @ResponseBody String doComplete(@RequestParam HashMap<String, Object> param) throws Exception {

    	System.out.println("1111111111");
    	System.out.println((String)param.get("course_id"));
    	System.out.println((String)param.get("cardinal_id"));

    	int count = 0;

    	try {

           	JSONArray jsonList = new JSONArray(param.get("completeList").toString());
           	List<Object> completeList = jsonList.toList();
           	for (Object object : completeList) {
       			HashMap<String, String> tmpHash = new HashMap<String, String>();
           		String tmpObj = object.toString();
           		String userId = tmpObj.substring(tmpObj.indexOf("=")+1,tmpObj.length()-1);
           		tmpHash.put("user_id", userId);
           		tmpHash.put("course_id", (String)param.get("course_id"));
           		tmpHash.put("cardinal_id", (String)param.get("cardinal_id"));
           		if(((String)param.get("flag")).equals("1")) {
               		tmpHash.put("issueY", "Y"); //어떤 값이든 공백 혹은 null만 아니면 작동.       			
           		} else if(((String)param.get("flag")).equals("2")) {
               		tmpHash.put("issueN", "N"); //어떤 값이든 공백 혹은 null만 아니면 작동.       			       			
           		}
           		
            	int result = completeService.updateCompleteList(tmpHash);				
            	count++;
           	}
        	
		} catch (Exception e) {
			e.printStackTrace();
		}

    	
    	
    	return String.valueOf(count);
    }        
    
    /**
     * 이수자 현황 리스트 조회
     */
    @RequestMapping(value = "/completeList", method = RequestMethod.POST)
    public @ResponseBody DataList<LearnAppVO> completeList(LearnAppVO learnApp) throws Exception {
    	DataList<LearnAppVO> result = new DataList<LearnAppVO>();
    	
		// 결과 리스트를 저장
		result.setList(completeService.completeList(learnApp));

		return result;
    }
    
    /**
	 * 이수자 현황 엑셀 다운로드
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/excel/download/completeList", method = RequestMethod.POST)
	public ModelAndView excelDownloadCompleteList(LearnAppVO learnApp) throws Exception {
		Map<String, Object> map		= new HashMap<String, Object>();
		List<Object> hederList		= new ArrayList<Object>();
		List<Object> bodyList		= new ArrayList<Object>();
		List<Object> bodyWidthList	= new ArrayList<Object>();

		// 리스트 조회
		List<LearnAppVO> dataList = completeService.completeList(learnApp);

		String[] heder = new String[]{"과정코드","학교명","구분","성명","생년월일","온라인시험","온라인과제","학습참여도","출석시험","최종환산점수","이수현황","시도교육청","관할교육청","이수번호"};
		int[] bodyWidth = new int[]{10, 10, 5, 10, 10, 10, 10, 10, 10, 10, 10, 20, 20, 20};

		for(int i=0; i<dataList.size(); ++i) {
			LearnAppVO temp = dataList.get(i);
			String[] body = new String[heder.length];
			String sType = "";
			
			sType = (!StringUtil.isEmpty(temp.getsType()) && temp.getsType().equals("1") ? "초등" 
				  : (!StringUtil.isEmpty(temp.getsType()) && temp.getsType().equals("2") ? "중등" 
				  : (!StringUtil.isEmpty(temp.getsType()) && temp.getsType().equals("3") ? "고등"
				  : (!StringUtil.isEmpty(temp.getsType()) && temp.getsType().equals("4") ? "유아"
				  : (!StringUtil.isEmpty(temp.getsType()) && temp.getsType().equals("5") ? "특수"
				  : (!StringUtil.isEmpty(temp.getsType()) && temp.getsType().equals("6") ? "기관" : "기타"))))));

			body[0] = temp.getCourse().getId();
			body[1] = !StringUtil.isEmpty(temp.getSchoolName()) ? temp.getSchoolName() : "";
			body[2]	= sType;
			body[3] = temp.getUser() != null && !StringUtil.isEmpty(temp.getUser().getName()) ? temp.getUser().getName() : "";
			body[4] = temp.getUser() != null && !StringUtil.isEmpty(temp.getUser().getBirthDay()) ? temp.getUser().getBirthDay() : "";
			body[5] = temp.getObjScore()+"점";
			body[6] = temp.getSubScore()+"점";
			body[7] = temp.getPartScore()+"점";
			body[8] = temp.getAttScore()+"점";
			body[9] = temp.getTotalScore()+"점";
			body[10] = StringUtil.isEmpty(temp.getIssueNum()) ? "미이수" : "이수";
			body[11] = temp.getRegion() != null && !StringUtil.isEmpty(temp.getRegion().getName()) ? temp.getRegion().getName() : "";
			body[12] = temp.getJurisdiction();
			body[13] = !StringUtil.isEmpty(temp.getIssueNum()) ? temp.getIssueNum() : "";

			bodyList.add(body);
		}

		hederList.add(heder);
		bodyWidthList.add(bodyWidth);

		map.put("fileName", "이수자현황리스트_"+GlobalMethod.getNow("yyyyMMddHHmmss")+".xls");
		map.put("header", hederList);
		map.put("body", bodyList);
		map.put("bodyWidth", bodyWidthList);

		return new ModelAndView("excelDownLoad", "excelMap", map);
	}
    
    /**
     * Exception 처리
     * @param Exception
     * @return ModelAndView
     * @author : 김준석 - (2015-06-03)
     */
    @ExceptionHandler(Exception.class)
    public ModelAndView exceptionHandler(Exception e) {
        logger.info(e.getMessage());

        return new ModelAndView("/error/exception").addObject("msg", e.getMessage());
    }
}