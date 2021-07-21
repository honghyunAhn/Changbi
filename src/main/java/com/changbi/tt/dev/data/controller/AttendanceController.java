package com.changbi.tt.dev.data.controller;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.changbi.tt.dev.data.service.AttendanceService;
import com.changbi.tt.dev.data.service.LearnAppService;
import com.changbi.tt.dev.data.vo.AttendanceVO;
import com.changbi.tt.dev.data.vo.DateAttendanceVO;
import com.changbi.tt.dev.data.vo.InfoAttendanceVO;
import com.changbi.tt.dev.data.vo.LearnAppVO;
import com.changbi.tt.dev.data.vo.SmtpAttendanceVO;
import com.google.gson.Gson;

import forFaith.dev.util.LoginHelper;
import forFaith.dev.vo.MemberVO;
import forFaith.util.DataList;


@Controller(value="data.attendanceController")      // Controller value는 중복되면 안된다. value 값을 지정하지 않으면 클래스명이 value가 되므로 같은 클래스명이 존재하면 중복으로 인식
@RequestMapping("/data/attendance")       // 해당 클래스를 호출 하기 위한 Mapping 기본 값 뒤에 붙는 값에 의해 필요한 함수가 호출 된다.
public class AttendanceController {

	@Autowired
	private LearnAppService learnAppService;
	@Autowired
	private AttendanceService attendService;
	
    /**
     * log를 남기는 객체 생성
     * @author : 전상수(2020-03-03)
     */
    private static final Logger logger = LoggerFactory.getLogger(BasicController.class);
    
	/**
     * 출결날짜 정보 등록 
     * @param attendance
     */
    @RequestMapping(value="/dateReg", method=RequestMethod.POST)
    public @ResponseBody int dateReg(AttendanceVO attend) throws Exception {
        return attendService.insertDate(attend);
    }
    
    /**
     * 출결날짜 정보 조회 (현재 미사용)
     * @param attendance
     */
    @RequestMapping(value="/dateSearch", method=RequestMethod.POST)
    public @ResponseBody AttendanceVO dateSearch(AttendanceVO attend) throws Exception {
    	AttendanceVO vo = attendService.selectDate(attend);
        return vo;
    }

    /**
     * 출결일 정보 조회 
     * @param attendance
     */
    @RequestMapping(value="/selectAttendance", method=RequestMethod.POST)
    public @ResponseBody AttendanceVO selectAttendance(AttendanceVO attend) throws Exception {
        return attendService.selectAttendance(attend);
    }


    /**
     * 출결체크등록 
     * @param attendance
     */
    @RequestMapping(value="/attendanceCheck", method=RequestMethod.POST)
    public @ResponseBody int attendanceCheck(@RequestBody ArrayList<AttendanceVO> attend) throws Exception {
        return attendService.insertAttendance(attend);
    }
    
    
    /**
     * 연수신청 리스트 정보
     */
    @RequestMapping(value = "/learnAppList", method = RequestMethod.POST)
    public @ResponseBody DataList<LearnAppVO> learnAppList(LearnAppVO learnApp) throws Exception {
    	DataList<LearnAppVO> result = new DataList<LearnAppVO>();
    	
    	// 로그인 정보를 저장한다.
    	learnApp.setLoginUser((MemberVO)LoginHelper.getLoginInfo());
    	
    	result.setPagingYn(learnApp.getPagingYn());
    	
    	// 페이징 처리인 경우만 페이지 번호와 토탈 갯수를 저장한다.
		if(result.getPagingYn().equals("Y")) {
			result.setNumOfNums(learnApp.getNumOfNums());
			result.setNumOfRows(learnApp.getNumOfRows());
			result.setPageNo(learnApp.getPageNo());
			result.setTotalCount(learnAppService.learnAppTotalCnt(learnApp));
		}
		
		List <LearnAppVO> Learnlist=learnAppService.learnAppList(learnApp);
		List <AttendanceVO> requestList=new ArrayList<>();//질의 list
		
		
		String presentDate=learnApp.getAttend().getPresentDate();
		
		for(int i=0;i<Learnlist.size();i++){
			
			AttendanceVO attendVO=new AttendanceVO();
			attendVO.setUserId(Learnlist.get(i).getUser().getId());
			attendVO.setPresentDate(presentDate);
			attendVO.setCardinalId(Learnlist.get(i).getCardinal().getId());
			
			
			attendVO=attendService.selectAttendanceByDate(attendVO);
			
			Learnlist.get(i).setAttend(attendVO);
			
			
		}
		
		// 결과 리스트를 저장
		result.setList(Learnlist);

		return result;
    }
    
    @RequestMapping(value="/selectDates", method=RequestMethod.GET)
    public @ResponseBody ArrayList<DateAttendanceVO> selectDates(@RequestParam HashMap<String, Object> params) {
    	
    		ArrayList<DateAttendanceVO> map = attendService.selectDates(params);
    		
    		return map;
    }
    
    @RequestMapping(value="/deleteDate", method=RequestMethod.GET)
    public @ResponseBody String deleteDate(@RequestParam HashMap<String, String> params) {
    	
    		String result = attendService.deleteSmtpDate(params);
    		
    		return result;
    		
    }
    
    @RequestMapping(value="/selected", method=RequestMethod.POST)
    public @ResponseBody List<HashMap<String, Object>> selectedDate(@RequestParam HashMap<String, Object> params) {
    	
    		System.out.println(params.toString());
    		
    		List<HashMap<String, Object>> users = attendService.stuListDownload(params);
    		ArrayList<HashMap<String, Object>> list = attendService.selectedDate(params);
    		
    		if(list.isEmpty()) {
    			return users;
    		}
    		
    		for(int i = 0; i < list.size(); i++) {
    			for(int j = 0; j < users.size(); j++) {
    				if(String.valueOf(list.get(i).get("USER_ID")).equalsIgnoreCase(String.valueOf(users.get(j).get("USER_ID")))) {
    					users.remove(j);
    					j--;
    				}
    			}
    		}
    		
    		for(int i = 0; i < users.size(); i++) {
    			list.add(users.get(i));
    		}
    		
    		return list;
    }
    
    @RequestMapping(value="/attendanceUpdate", method=RequestMethod.POST)
    public @ResponseBody int attendanceUpdate(@RequestBody ArrayList<InfoAttendanceVO> attend) throws Exception {
        return attendService.attendanceUpdate(attend);
    }
    
    /**
     * @return 일수 등록 여부
     * @Method Name : newDatesAdd
     * @Date : 2020. 10. 23.
	 * @User : 양승균
	 * @param attend
	 * @Method 설명 : 출결 일수 등록
     */
    
    @RequestMapping(value="/newDatesAdd", method=RequestMethod.POST)
    public @ResponseBody String newDatesAdd(@RequestBody List<DateAttendanceVO> attend) {
    		return attendService.newDatesAdd(attend);
    }
    
    /**
     * @return 출결 정보 업데이트 여부
     * @Method Name : sutUpdate
     * @Date : 2020. 10. 27.
	 * @User : 양승균
	 * @param info
	 * @Method 설명 : 학생 출결 정보 업데이트
     */
    @RequestMapping(value="/sutUpdate", method=RequestMethod.POST)
    public @ResponseBody String sutUpdate(InfoAttendanceVO info){
    		
    		MemberVO loginUser = (MemberVO)LoginHelper.getLoginInfo();
    		String upd_id = loginUser.getId();
    		info.setUpduser(upd_id);
    		
    		String result = attendService.stuUpdate(info);
    		
    		return result;
    }
    /**
     * @return 시수 정보 업데이트 여부
     * @Method Name : sutSisuUpdate
     * @Date : 2020. 10. 27.
	 * @User : 양승균
	 * @param mapList
	 * @Method 설명 : 학생 시수 정보 업데이트
     */
    @ResponseBody
    @RequestMapping(value="/sutSisuUpdate", method=RequestMethod.POST)
    public String sutSisuUpdate(@RequestBody List<HashMap<String, Object>> mapList){
    	
    		String result = attendService.stuSisuUpdate(mapList);
    		
    		return result;
    }
    
    // 20 10 16 김태원
    // 엑셀 업로드와 동시에 일자 등록도 진행
    @ResponseBody
    @RequestMapping(value="/fileUpload", method=RequestMethod.POST)
    public void excelFileUpload(String courseId, String cardinalId, @RequestParam("dateExcel") MultipartFile file) throws IOException {
    	
    	List<DateAttendanceVO> list = new ArrayList<>();
    	List<HashMap<String, Object>> mapList = new ArrayList<>();
    	
    	String error = "";
    	System.out.println("courseId : " + courseId);
    	System.out.println("cardinalId : " + cardinalId);
    	
    	String fileName = file.getOriginalFilename();
    	System.out.println("fileName : " + fileName);
    	
    	String[] fileExtension = fileName.split("\\.");
    	System.out.println("fileExtension : " + fileExtension);
    	
    	int index = fileExtension.length - 1;
    	System.out.println("index : " + index);
    	
    	if(fileExtension[index].equals("xlsx")) {
    		mapList = attendService.xlsxToCustomerVoList(file);
    	} else if(fileExtension[index].equals("xls")) {
    		mapList = attendService.xlsToCustomerVoList(file);
    	} else {
    		error = "XLSX 또는 XLS 파일을 사용해주세요.";
    	}
    	System.out.println("mapList : " + mapList);
    	
    	mapList.remove(0);
    	for(int i=0; i<mapList.size(); i++) {
    		mapList.get(i).put("course_id", courseId);
    		mapList.get(i).put("cardinal_id", cardinalId);
    		mapList.get(i).toString();
    	}
    	System.out.println("anh288 - apList : " + mapList);
    	attendService.addSisu(mapList, courseId, cardinalId);
    	
    }
    
    @RequestMapping(value="/stuListDownload", method=RequestMethod.GET)
    public void stuListDownload(HttpServletResponse response, String course_id, String cardinal_id) throws IOException {
    	
    	HashMap<String, Object> map = new HashMap<>();
    	
    	map.put("course_id", course_id);
    	map.put("cardinal_id", cardinal_id);
    	
    	List<HashMap<String, Object>> mapList = attendService.stuListDownload(map);
    	
    	OutputStream ops = null;
    	
		try {
			XSSFWorkbook workbook = attendService.listExcelDownload(mapList);
			
			response.reset();
			String name = "학생리스트";
			String fileName = new String(name.getBytes("utf-8"), "iso-8859-1");
			response.setHeader("Content-Disposition", "attachment;filename=" + fileName + ".xlsx");
			response.setContentType("application/vnd.ms-excel");
			ops = new BufferedOutputStream(response.getOutputStream());
			
			workbook.write(ops);
			ops.flush();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(ops != null) ops.close();
		}
    	
    }
    
    @ResponseBody
    @RequestMapping(value="/attendUpload", method=RequestMethod.POST)
    public void attendUpload(String courseId, String cardinalId, @RequestParam("dateExcel") MultipartFile file) {
    	
    	attendService.inputUserInfo(file, courseId, cardinalId);
    }
    
    /**
     * @Method Name : attendinsert
     * @Date : 2020. 10. 28.
	 * @User : 양승균
	 * @param map
	 * @Method 설명 : 학생 출결 정보 등록
     */
    
    @ResponseBody
    @RequestMapping(value="/attendInsert", method=RequestMethod.POST)
    public void attendinsert(@RequestBody ArrayList<HashMap<String, Object>> map) {
    	
    	attendService.insertAttendanceInfo(map);
    }
    /**
     * @Method Name : searchterm
     * @Date : 2020. 10. 28.
	 * @User : 양승균
	 * @Param : params(과정번호, 기수번호, 기간 날짜 정보)
	 * @Return : 기간 출결 통계 리스트
	 * @Method 설명 : 기간 검색 시 해당 코스 및 기수 학생들의 출결 통계 반환
     */
    
    @RequestMapping(value="/searchTerm", method=RequestMethod.POST)
    public @ResponseBody List<List<HashMap<String, Object>>> searchterm(@RequestParam HashMap<String, Object> params) {
    	
		ArrayList<HashMap<String, Object>> list = attendService.selectedDate(params);
		List<HashMap<String, Object>> map = new ArrayList<>();
		List<HashMap<String, Object>> total = new ArrayList<>();
		List<List<HashMap<String, Object>>> mapList = new ArrayList<>();
		
		mapList.add(list);
		
		List<HashMap<String, Object>> list2 = list.stream().sorted((o1, o2) -> o1.get("ATT_DATE").toString().compareTo(o2.get("ATT_DATE").toString())).collect(Collectors.toList());
		
 		for(int i=0; i<list.size(); i++) {
			if(i == 0) {
				HashMap<String, Object> temp = new HashMap<>();
				temp.put("userName", list.get(i).get("USER_NM"));
				temp.put("userId", list.get(i).get("USER_ID"));
				switch ((String)list.get(i).get("ATT_FINAL_GUBUN")) {
				case "B4701":
					temp.put("attend", 1);
					temp.put("late", 0);
					temp.put("empty", 0);
					break;
				case "B4703":
					temp.put("attend", 0);
					temp.put("late", 1);
					temp.put("empty", 0);
					break;
				case "B4702":
					temp.put("attend", 0);
					temp.put("late", 0);
					temp.put("empty", 1);
					break;
				}
				map.add(temp);
			} else {
				if(list.get(i-1).get("USER_NM").equals(list.get(i).get("USER_NM"))) {
					for(int j=0; j<map.size(); j++) {
						if(list.get(i).get("USER_NM").equals(map.get(j).get("userName"))) {
							switch ((String)list.get(i).get("ATT_FINAL_GUBUN")) {
							case "B4701":
								int attend = (Integer)map.get(j).get("attend") + 1;
								map.get(j).put("attend", attend);
								break;
							case "B4703":
								int late = (Integer)map.get(j).get("late") + 1;
								map.get(j).put("late", late);
								break;
							case "B4702":
								int empty = (Integer)map.get(j).get("empty") + 1;
								map.get(j).put("empty", empty);
								break;
							}
						}
					}
				} else {
					HashMap<String, Object> temp = new HashMap<>();
 					temp.put("userName", list.get(i).get("USER_NM"));
 					temp.put("userId", list.get(i).get("USER_ID"));
 					switch ((String)list.get(i).get("ATT_FINAL_GUBUN")) {
					case "B4701":
						temp.put("attend", 1);
						temp.put("late", 0);
						temp.put("empty", 0);
						break;
					case "B4703":
						temp.put("attend", 0);
						temp.put("late", 1);
						temp.put("empty", 0);
						break;
					case "B4702":
						temp.put("attend", 0);
						temp.put("late", 0);
						temp.put("empty", 1);
						break;
					}
 					map.add(temp);
				}
			}
		}
		
		mapList.add(map);

		ArrayList<String> date = new ArrayList<>();
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date start = null;
		Date end = null;
		
		try {
			start = sdf.parse(String.valueOf(params.get("att_date")));
			end = sdf.parse(String.valueOf(params.get("end_date")));

			Calendar cal = Calendar.getInstance();
			
			 for(int i = 0; i < list2.size(); i++) {
				if(i == 0) {
					if(start.compareTo(sdf.parse(String.valueOf(list2.get(i).get("ATT_DATE")))) < 0) {
						start = sdf.parse(String.valueOf(list2.get(i).get("ATT_DATE")));	
					}
				}
				
				if(start.compareTo(sdf.parse(String.valueOf(list2.get(i).get("ATT_DATE")))) == 0) {
					
					if(!date.contains(String.valueOf(list2.get(i).get("ATT_DATE")))) {
						date.add(String.valueOf(list2.get(i).get("ATT_DATE")));
					}
				} else if(start.compareTo(end) == 0) {
					break;
				}
				
				if(i != list2.size()-1) {
					Date current = sdf.parse(String.valueOf(list2.get(i).get("ATT_DATE")));
					Date next = sdf.parse(String.valueOf(list2.get(i+1).get("ATT_DATE")));
					long dDiff = next.getTime() - current.getTime();
					long diff = dDiff / (24*60*60*1000);
					
					cal.setTime(start);
					cal.add(Calendar.DATE, Integer.parseInt(String.valueOf(diff)));
					start = cal.getTime();
				}
			}
		} catch (ParseException e) {
			
			e.printStackTrace();
		}
		
/*		System.out.println(date.toString());*/
		
		for(int i = 0; i < date.size(); i++) {
			int attend = 0;
			int late = 0;
			int empty = 0;
			
			HashMap<String, Object> temp = new HashMap<>();
			temp.put("ATT_DATE", date.get(i));
			
			for(int j = 0; j < list.size(); j++) {
				if(date.get(i).equalsIgnoreCase(String.valueOf(list.get(j).get("ATT_DATE")))) {
					switch (String.valueOf(list.get(j).get("ATT_FINAL_GUBUN"))) {
					case "B4701":
						attend++;
						break;
					case "B4703":
						late++;
						break;
					case "B4702":
						empty++;
						break;
					}
				}
			}
			
			temp.put("attend", attend);
			temp.put("late", late);
			temp.put("empty", empty);
			
			total.add(temp);
		}
		
		mapList.add(total);
		
		return mapList;
	}
    
    @RequestMapping(value="/datesExcelDownload", method=RequestMethod.GET)
    public void datesExcelDownload(HttpServletResponse response) throws IOException {
    	
    	OutputStream ops = null;
    	
		try {
			XSSFWorkbook workbook = attendService.sisuExcelDownload();
			
			response.reset();
			String name = "시수 추가";
			String fileName = new String(name.getBytes("utf-8"), "iso-8859-1");
			response.setHeader("Content-Disposition", "attachment;filename=" + fileName + ".xlsx");
			response.setContentType("application/vnd.ms-excel");
			ops = new BufferedOutputStream(response.getOutputStream());
			
			workbook.write(ops);
			ops.flush();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(ops != null) ops.close();
		}
    }
    
    /**
     * @Method Name : deleteRegFile
     * @Date : 2020. 10. 30.
	 * @User : 양승균
	 * @Param : 출결 일련 번호
	 * @Return : 업데이트 여부
	 * @Method 설명 : 사용자 파일 업로드 삭제 시 출결 파일 업로드 정보 변경
     * @throws Exception
     */
    
    @RequestMapping(value="/deleteRegFile", method=RequestMethod.POST)
    public @ResponseBody int deleteRegFile(int attInfoTimeSeq) throws Exception {

    	return attendService.deleteRegFile(attInfoTimeSeq);
    }	
    // 개인 출석부 정보 가져오기
    @RequestMapping(value="/studentList", method=RequestMethod.POST)
    public @ResponseBody Object studentList(String courseId, String cardinalId) throws Exception {
    	
    	HashMap<String, Object> map = new HashMap<>();
    	
    	map.put("course_id", courseId);
    	map.put("cardinal_id", cardinalId);
    	
    	List<HashMap<String, Object>> mapList = attendService.stuListDownload(map);
    	logger.info(mapList.toString());
    	
    	return mapList;
    }
    // 출석부 팝업
    @RequestMapping(value="/printAttendance", method=RequestMethod.POST)
    public String printAttendance(@RequestParam HashMap<String, Object> param, Model model) throws Exception {
    	Gson gson = new Gson();
    	model.addAttribute("info", param);
    	model.addAttribute("userInfo", gson.toJson(attendService.selectPersonalInfo(param)));
    	return "/admin/attendance/personalAttendance";
    }
    
}
