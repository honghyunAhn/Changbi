package com.changbi.tt.dev.data.service;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFCellStyle;
import org.apache.poi.xssf.usermodel.XSSFDataFormat;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.changbi.tt.dev.data.dao.AttendanceDAO;
import com.changbi.tt.dev.data.vo.AttendanceVO;
import com.changbi.tt.dev.data.vo.DateAttendanceVO;
import com.changbi.tt.dev.data.vo.InfoAttendanceVO;
import com.ibm.icu.text.DateFormat;
import com.ibm.icu.text.SimpleDateFormat;
import com.ibm.icu.util.Calendar;

import forFaith.dev.dao.AttachFileDAO;
import forFaith.dev.util.LoginHelper;
import forFaith.dev.vo.AttachFileVO;
import forFaith.dev.vo.MemberVO;
import forFaith.util.StringUtil;

@Service(value = "data.attendanceService")
public class AttendanceService {

	@Autowired
	private AttendanceDAO attendDao;
	
	@Autowired
    private AttachFileDAO fileDao;

	public int insertDate(AttendanceVO attend) throws Exception {
		
		List<HashMap<String, Object>> mapList = new ArrayList<>();
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		
		Date dt1 = df.parse(attend.getStart());
		Date dt2 = df.parse(attend.getEnd());
		
		Calendar c1 = Calendar.getInstance();
		Calendar c2 = Calendar.getInstance();
		
		c1.setTime(dt1);
		c2.setTime(dt2);
		
		while(c1.compareTo(c2) != 1) {
			HashMap<String, Object> map = new HashMap<>();
			String date = df.format(c1.getTime());
			map.put("course_id", attend.getCourseId());
			map.put("cardinal_id", attend.getCardinalId());
			map.put("att_date", date);
			mapList.add(map);
			c1.add(Calendar.DATE, 1);
		}
		
		HashMap<String, Object> map = new HashMap<>();
		
		map.put("course_id", attend.getCourseId());
		map.put("cardinal_id", attend.getCardinalId());
		
		List<HashMap<String, Object>> compareList = attendDao.compareDates(map);

		if(compareList.size() > 0) {
			Date compareStartDate = df.parse((String)compareList.get(0).get("ATT_DATE"));
			Date compareEndDate   = df.parse((String)compareList.get(compareList.size()-1).get("ATT_DATE"));
			
			if(dt1.after(compareStartDate)) {
				String inputStart = attend.getStart();
				map.put("start_date", inputStart);
				if(dt2.before(compareEndDate)) {
					String inputEnd = attend.getEnd();
					map.put("end_date", inputEnd);
				}
				attendDao.compareDeleted(map);
			} else if (dt2.before(compareEndDate)) {
				String inputEnd = attend.getEnd();
				map.put("end_date", inputEnd);
				attendDao.compareDeleted(map);
			} else {
				for(int i=0; i<compareList.size(); i++) {
					for(int j=0; j<mapList.size(); j++) {
						if(compareList.get(i).get("ATT_DATE").equals(mapList.get(j).get("att_date"))) {
							mapList.remove(j);
						}
					}
				}
				return addDates(mapList);
			}
		}
		
		return addDates(mapList);		
	}
	
	public int addDates(List<HashMap<String, Object>> mapList) {
	
		return attendDao.addDates(mapList);
	}

	public AttendanceVO selectDate(AttendanceVO attend) throws Exception {
		return attendDao.selectDate(attend);
	}

	public int deleteDate(AttendanceVO attend) throws Exception {
		return attendDao.deleteDate(attend);

	}

	public int insertAttendance(List<AttendanceVO> attend) throws Exception {
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("datelist", attend);
		
		return attendDao.insertAttendance(map);

	}

	public AttendanceVO selectAttendance(AttendanceVO attend) throws Exception {
		return attendDao.selectAttendance(attend);

	}

	public AttendanceVO selectAttendanceById(AttendanceVO attend) throws Exception {
		return attendDao.selectAttendanceById(attend);

	}

	public AttendanceVO selectAttendanceByDate(AttendanceVO attend) throws Exception {
		return attendDao.selectAttendanceByDate(attend);

	}
	
	public ArrayList<DateAttendanceVO> selectDates(HashMap<String, Object> params){
		
		return attendDao.selectDates(params);
	}
	
	public String deleteSmtpDate(HashMap<String, String> params) {
		if(attendDao.deleteSmtpDate(params) <= 0) {
			return "Fail";
		} else {
			return "Success";
		}
	}
	
	public ArrayList<HashMap<String, Object>> selectedDate(HashMap<String, Object> params) {
		return attendDao.selectedDate(params);
	}
	
	public int attendanceUpdate(ArrayList<InfoAttendanceVO> attend) {
		int count = 0;
		for(int i=0; i<attend.size(); i++) {
			count += attendDao.attendanceUpdate(attend.get(i));
		}
		
		return count;
	}
	
	public String newDatesAdd(List<DateAttendanceVO> params) {
		
		HashMap<String, Object> map = new HashMap<>();
		List<HashMap<String, Object>> list = new ArrayList<>();
		
		map.put("course_id", params.get(0).getCourseId());
		map.put("cardinal_id", params.get(0).getCardinalId());
		
		List<DateAttendanceVO> dates = attendDao.selectDates(map);
		
		for(int i=0; i<dates.size(); i++) {
			System.out.println(dates.get(i).toString());
		}
		
		for(int i=0; i<params.size(); i++) {
			HashMap<String, Object> user = new HashMap<>();
			user.put("course_id", params.get(0).getCourseId());
			user.put("cardinal_id", params.get(0).getCardinalId());
			user.put("att_date", params.get(i).getAttDate());
			user.put("stand_in_time", params.get(i).getStandInTime());
			user.put("stand_out_time", params.get(i).getStandOutTime());
			user.put("sisu", params.get(i).getSisu());
			
			String inputStart = params.get(i).getAttDate() + " " + params.get(i).getStandInTime();
			String inputEnd = params.get(i).getAttDate() + " " + params.get(i).getStandOutTime();
			for(int j=0; j<dates.size(); j++) {
				String dbStart = dates.get(j).getAttDate() + " " + dates.get(j).getStandInTime();
				String dbEnd = dates.get(j).getAttDate() + " " + dates.get(j).getStandOutTime();
				if (inputStart.equals(dbStart)) {
					return "There is same Time please check it again";
				} else if (inputEnd.equals(dbEnd)) {
					return "There is same date please check it again";
				}
			}
			list.add(user);
		}
		
		if(attendDao.addSisu(list) > 0) {
			return "Success !";
		} else {
			return "Fail...";
		}
		
	}
	
	public InfoAttendanceVO stuAttendanceUpdate(HashMap<String, Object> map) {
		return attendDao.stuAttendanceUpdate(map);
	}
	
	public String stuName(String userId) {
		return attendDao.stuName(userId);
	}
	
	public String stuUpdate(InfoAttendanceVO info) {
		int result = 0;
		
		result = attendDao.stuUpdate(info);
		
		if(info.getAttInfoTimeSeq() > 0) {
			List<AttachFileVO> attachFileList = new ArrayList<AttachFileVO>();
			
			if(info.getCertiAttachFile() != null && !StringUtil.isEmpty(info.getCertiAttachFile().getFileId())) {
				attachFileList.add(info.getCertiAttachFile());
			}
			
			if(attachFileList.size() > 0) {
				try {
					fileDao.attachFileUse(attachFileList);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		
		if(result == 0 ) {
			return "Fail"; 
		} else {
			return "Success";
		}
		 
	}
	
//	20 10 16 김태원
//	xls 파일 읽은 후 vo에 저장하여 vo list 리턴 
//	public List<DateAttendanceVO> xlsToCustomerVoList(MultipartFile file) {
	public List<HashMap<String, Object>> xlsToCustomerVoList(MultipartFile file) {
		List<DateAttendanceVO> list = new ArrayList<>();
		List<HashMap<String, Object>> mapList = new ArrayList<>();
		
		InputStream fis = null;
		HSSFWorkbook workbook = null;
		
		try {
			
			fis = file.getInputStream();
			// 엑셀파일 전체 내용을 담고 있는 객체
			workbook = new HSSFWorkbook(fis);
			
			// 탐색에 사용할 Sheet, Row, Cell 객체
			HSSFSheet curSheet;
			HSSFRow curRow;
			HSSFCell curCell;
			DateAttendanceVO vo;
			
			// Sheet 탐색 for문
			for(int sheetIndex = 0; sheetIndex < workbook.getNumberOfSheets(); sheetIndex++) {
				// 현재 Sheet 반환
				curSheet = workbook.getSheetAt(sheetIndex);
				// row 탐색 for문
				for(int rowIndex = 0; rowIndex < curSheet.getPhysicalNumberOfRows(); rowIndex++) {
					// row 0은 헤더정보이기 때문에 무시
					if(rowIndex != 0) {
						// 현재 row 반환
						curRow = curSheet.getRow(rowIndex);
						vo = new DateAttendanceVO();
						HashMap<String, Object> map = new HashMap<>();
						
						String value;
						
						// row의 첫번째 cell값이 비어있지 않은 경우만 cell탐색
						if(!"".equals(curRow.getCell(0).getStringCellValue())) {
							
							// cell 탐색 for문
							for(int cellIndex = 0; cellIndex < curRow.getPhysicalNumberOfCells(); cellIndex++) {
								curCell = curRow.getCell(cellIndex);
								
								if(curCell != null) {
									value = "";
									
									//cell 스타일이 다르더라도 string으로 반환 받음
									switch (curCell.getCellType()) {
									case HSSFCell.CELL_TYPE_FORMULA:
										value = curCell.getCellFormula();
										break;
									case HSSFCell.CELL_TYPE_NUMERIC:
										value = curCell.getNumericCellValue() + "";
										break;
									case HSSFCell.CELL_TYPE_STRING:
										value = curCell.getStringCellValue() + "";
										break;
									case HSSFCell.CELL_TYPE_BLANK:
										value = curCell.getBooleanCellValue() + "";
										break;
									case HSSFCell.CELL_TYPE_ERROR:
										value = curCell.getErrorCellValue() + "";
										break;
									default:
										value = new String();
										break;
									}
									
									// 현재 column index에 따라서 vo에 입력
									switch (cellIndex) {
									case 0: // 수업 날짜
//										vo.setAttDate(value);
										map.put("att_date", value);
										break;
									case 1: // 시차 시작 시간
//										vo.setStandInTime(value);
										map.put("stand_in_time", value);
										break;
									case 2: // 시차 끝나는 시간 
//										vo.setStandOutTime(value);
										map.put("stand_out_time", value);
										break;
									case 3:
										map.put("sisu", value);
									default:
										break;
									}
								} else {
									continue;
								}
							}
							// cell 탐색 이후 vo 추가
//							list.add(vo);
							mapList.add(map);
						}
					}
				}
			}
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			try {
				if(workbook != null) workbook.close();
				if(fis != null) fis.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		
		return mapList;
	}
	
//	20 10 15 김태원
//	xlsx 파일 읽은 후 vo에 저장하여 vo list 리턴 
//	public List<DateAttendanceVO> xlsxToCustomerVoList(MultipartFile file) {
	public List<HashMap<String, Object>> xlsxToCustomerVoList(MultipartFile file) {
		// 리털 한 객체를 생성
//		List<DateAttendanceVO> list = new ArrayList<>();
		List<HashMap<String, Object>> mapList = new ArrayList<>();
		
		InputStream fis = null;
		XSSFWorkbook workbook = null;
		
		try {
			fis = file.getInputStream();
			// XSSFWorkbook은 엑셀파일 전체 내용을 담고있는 객체
			workbook = new XSSFWorkbook(fis);
			
			// 탐색에 사용할 Sheet, Row, Cell 객체
			XSSFSheet curSheet;
			XSSFRow curRow;
			XSSFCell curCell;
			DateAttendanceVO vo;
			
			// Sheet 탐색 for문
			for(int sheetIndex = 0; sheetIndex < workbook.getNumberOfSheets(); sheetIndex++) {
				// 현재 Sheet 반환
				curSheet = workbook.getSheetAt(sheetIndex);
				// row 탐색 for문
				for(int rowIndex = 0; rowIndex < curSheet.getPhysicalNumberOfRows(); rowIndex++) {
					// row 0은 헤더정보이기 때문에 무시
					if(rowIndex >= 1) {
						// 현재 row반환
						curRow = curSheet.getRow(rowIndex);
//						vo = new DateAttendanceVO();
						HashMap<String, Object> map = new HashMap<>();
						String value;
						
						// row의 첫번째 cell값이 비어있지 않은 경우만 cell 탐색
//						System.out.println("Index Check : " + rowIndex);
						if(!(curRow.getCell(0).getStringCellValue().equals("") || curRow.getCell(0).getStringCellValue() == null)) {
							
							// cell탐색 for문
							for(int cellIndex = 0; cellIndex < curRow.getPhysicalNumberOfCells(); cellIndex++) {
								curCell = curRow.getCell(cellIndex);
								
								if(curCell != null) {
									value = "";
									// cell 스타일이 다르더라도 String으로 반환받음
									switch (curCell.getCellType()) {
									case XSSFCell.CELL_TYPE_FORMULA:
										value = curCell.getCellFormula();
										break;
									case XSSFCell.CELL_TYPE_NUMERIC:
										value = curCell.getNumericCellValue() + "";
										break;
									case XSSFCell.CELL_TYPE_STRING:
										value = curCell.getStringCellValue() + "";
										break;
									case XSSFCell.CELL_TYPE_BLANK:
										value = curCell.getBooleanCellValue() + "";
										break;
									case XSSFCell.CELL_TYPE_ERROR:
										value = curCell.getErrorCellValue() + "";
										break;
									default:
										value = new String();
										break;
									}
									
									// 현재 column index에 따라서 vo에 입력
									switch (cellIndex) {
									case 0: // 수업 날짜
//										vo.setAttDate(value);
										map.put("att_date", value);
										break;
									case 1: // 시차 시작시간
//										vo.setStandInTime(value);
										map.put("stand_in_time", value);
										break;
									case 2: // 시차 끝나는시간
//										vo.setStandOutTime(value);
										map.put("stand_out_time", value);
										break;
									case 3:
										map.put("sisu", value);
										break;
									default:
										break;
									}
								} else {
									continue;
								}
							}
							// cell 탐색 이후 vo 추가
//							list.add(vo);
							mapList.add(map);
						} else {
							break;
						}
					}
				}
			}
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			try {
				if(workbook != null) workbook.close();
				if(fis != null) fis.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return mapList;
	}

	public void addSisu(List<HashMap<String, Object>> mapList, String courseId, String cardinalId) {
		
		HashMap<String, Object> map = new HashMap<>();
		map.put("course_id", courseId);
		map.put("cardinal_id", cardinalId);
		List<DateAttendanceVO> dateMap = attendDao.selectDates(map);
		
		if(dateMap.size() != 0) {
			for(int i=0; i<dateMap.size(); i++) {
				for(int j=0; j<mapList.size(); j++) {
					DateAttendanceVO vo = dateMap.get(i);
					HashMap<String, Object> compare = mapList.get(j);
					if(vo.getAttDate().equals(compare.get("att_date"))
							&& vo.getStandInTime().equals(compare.get("stand_in_time"))
							&& vo.getStandOutTime().equals(compare.get("stand_out_time"))) {
						mapList.remove(j);
						j--;
					}
				}
			}
		}
		
		if(mapList.size() != 0){
			attendDao.addSisu(mapList);
		}
		
	}
	
	public List<HashMap<String, Object>> stuListDownload(HashMap<String, Object> map) {
		
		List<HashMap<String, Object>> mapList = attendDao.stuListDownload(map);
		
		return mapList;
	}
	
	public XSSFWorkbook sisuExcelDownload() throws Exception {
		
		XSSFWorkbook workbook = new XSSFWorkbook();
		
		XSSFSheet sheet = workbook.createSheet("sisu");
		
		XSSFRow row = null;
		XSSFCell cell = null;
		
		XSSFCellStyle style = workbook.createCellStyle();
		XSSFDataFormat format = workbook.createDataFormat();
		
		style.setDataFormat(format.getFormat("@"));
		
		row = sheet.createRow(0);
		String[] exHeader = {"EX)2020-01-01", "EX)09:00", "EX)09:50", "시수의 차시를 숫자로 적어주세요."};
		for(int i=0; i<exHeader.length; i++) {
			cell = row.createCell(i);
			cell.setCellValue(exHeader[i]);
			sheet.setDefaultColumnStyle(i, style);
		}
		
		row = sheet.createRow(1);
		String[] headerKey = {"수업 날짜", "시수 시작시간", "시수 끝나는 시간", "시차"};
		
		for(int i=0; i<headerKey.length; i++) {
			cell = row.createCell(i);
			cell.setCellValue(headerKey[i]);
			sheet.setDefaultColumnStyle(i, style);
		}
		
		return workbook;
		
	}
	
	public XSSFWorkbook listExcelDownload(List<HashMap<String, Object>> mapList) throws Exception {
		
		XSSFWorkbook workbook = new XSSFWorkbook();
		
		XSSFSheet sheet = workbook.createSheet("users");
		
		XSSFRow row = null;
		XSSFCell cell = null;
		
		XSSFCellStyle style = workbook.createCellStyle();
		XSSFDataFormat format = workbook.createDataFormat();
		
		style.setDataFormat(format.getFormat("@"));
		
		row = sheet.createRow(0);
		cell = row.createCell(0);
		cell.setCellValue("출결 구분값은 (출석, 결석, 지각/조퇴) 중 하나로 입력 해주세요.");
		
		row = sheet.createRow(1);
		String[] headerKey = {"ID", "이름", "날짜", "출석 구분", "입실 시간", "퇴실 시간"};
		
		for(int i=0; i<headerKey.length; i++) {
			cell = row.createCell(i);
			cell.setCellValue(headerKey[i]);
			sheet.setDefaultColumnStyle(i, style);
		}
		
		for(int i=0; i<mapList.size(); i++) {
			row = sheet.createRow(i + 2);
			HashMap<String, Object> map = mapList.get(i);
			
			cell = row.createCell(0);
			cell.setCellValue((String)map.get("USER_ID"));
			
			cell = row.createCell(1);
			cell.setCellValue((String)map.get("USER_NM"));
		}
		
		return workbook;
	}

	public void inputUserInfo(MultipartFile file, String courseId, String cardinalId) {
		// 리털 한 객체를 생성
		List<HashMap<String, Object>> mapList = new ArrayList<>();
		List<HashMap<String, Object>> attendMapList = new ArrayList<>();
		List<HashMap<String, Object>> emptyMapList = new ArrayList<>();
		
		InputStream fis = null;
		XSSFWorkbook workbook = null;
		
		try {
			fis = file.getInputStream();
			// XSSFWorkbook은 엑셀파일 전체 내용을 담고있는 객체
			workbook = new XSSFWorkbook(fis);
			
			// 탐색에 사용할 Sheet, Row, Cell 객체
			XSSFSheet curSheet;
			XSSFRow curRow;
			XSSFCell curCell;
			
			// Sheet 탐색 for문
			for(int sheetIndex = 0; sheetIndex < workbook.getNumberOfSheets(); sheetIndex++) {
				// 현재 Sheet 반환
				curSheet = workbook.getSheetAt(sheetIndex);
				// row 탐색 for문
				for(int rowIndex = 0; rowIndex < curSheet.getPhysicalNumberOfRows(); rowIndex++) {
					// row 0은 헤더정보이기 때문에 무시
					if(rowIndex >= 2) {
						// 현재 row반환
						curRow = curSheet.getRow(rowIndex);
						
//						vo = new DateAttendanceVO();
						HashMap<String, Object> map = new HashMap<>();
						String value;
						// row의 첫번째 cell값이 비어있지 않은 경우만 cell 탐색
						
						try {
							curCell = curRow.getCell(0, XSSFRow.RETURN_NULL_AND_BLANK);
							
			                if(curCell == null || curCell.getCellType() == XSSFCell.CELL_TYPE_BLANK) {
			                	System.out.println("값이 비어있음");
			                	break;
			                } else if(!"".equals(curRow.getCell(0).getStringCellValue())) {
								
								// cell탐색 for문
								for(int cellIndex = 0; cellIndex < curRow.getPhysicalNumberOfCells(); cellIndex++) {
									curCell = curRow.getCell(cellIndex);
									
									if(curCell != null) {
										value = "";
										// cell 스타일이 다르더라도 String으로 반환받음
										switch (curCell.getCellType()) {
										case XSSFCell.CELL_TYPE_FORMULA:
											value = curCell.getCellFormula();
											break;
										case XSSFCell.CELL_TYPE_NUMERIC:
											value = curCell.getNumericCellValue() + "";
											break;
										case XSSFCell.CELL_TYPE_STRING:
											value = curCell.getStringCellValue() + "";
											break;
										case XSSFCell.CELL_TYPE_BLANK:
											value = curCell.getBooleanCellValue() + "";
											break;
										case XSSFCell.CELL_TYPE_ERROR:
											value = curCell.getErrorCellValue() + "";
											break;
										default:
											value = new String();
											break;
										}
										
										// 현재 column index에 따라서 vo에 입력
										System.out.println("Cell Index Check : " + cellIndex);
										switch (cellIndex) {
										case 0: // 학생 아이디
											map.put("user_id", value);
											break;
										case 1: // 학생 이름
											map.put("user_nm", value);
											break;
										case 2: // 날짜
											map.put("att_date", value);
											break;
										case 3: // 최종구분
											System.out.println("Index3 Check : " + value);
											switch(value) {
											case "출석":
												map.put("att_final_gubun", "B4701");
												break;
											case "지각/조퇴":
												map.put("att_final_gubun", "B4703");
												break;
											case "결석":
												map.put("att_final_gubun", "B4702");
												break;
											}
											break;
										case 4: // 입실시간
											map.put("in_time", value);
											break;
										case 5: // 퇴실시간
											map.put("out_time", value);
											break;
										default:
											break;
										}
									} else {
										continue;
									}
								}
								// cell 탐색 이후 vo 추가
								map.put("course_id", courseId);
								map.put("cardinal_id", cardinalId);
								System.out.println("Att Final Gubun Check : " + map.get("att_final_gubun"));
								if(map.get("att_final_gubun").equals("B4702")) {
									emptyMapList.add(map);
								} else {
									attendMapList.add(map);
								}
							}
						} catch (Exception e) {
							e.printStackTrace();
						}
					}
				}
			}
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			try {
				if(workbook != null) workbook.close();
				if(fis != null) fis.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		
		
		if(!attendMapList.isEmpty()) {
			for(int i=0; i<attendMapList.size(); i++) {
				int result = attendDao.registeredList(attendMapList.get(i));
				if(result != 0) {
					attendMapList.remove(i);
					i--;
				} else {
					mapList.add(attendMapList.get(i));
				}
			}
		} else {
			System.out.println("Attend Map List is Empty");
		}
		
		if(!emptyMapList.isEmpty()) {
			for(int i=0; i<emptyMapList.size(); i++) {
				int result = attendDao.registeredList(emptyMapList.get(i));
				if(result != 0) {
					emptyMapList.remove(i);
					i--;
				} else {
					mapList.add(emptyMapList.get(i));
				}
			}
		}
		
	if(!attendMapList.isEmpty()) {
		attendDao.attendInputUserInfo(attendMapList);
	} else {
		System.out.println("Attend Map List is Empty");
	}
	
	if(!emptyMapList.isEmpty()) {
		attendDao.emptyInputUserInfo(emptyMapList);
	} else {
		System.out.println("Empty Map List is Empty");
	}
		try {
			insertInfo(mapList);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void insertInfo(List<HashMap<String, Object>> mapList)  {
		List<HashMap<String, Object>> userSisuList = new ArrayList<>();
		
		for(int i = 0; i < mapList.size(); i++) {
			HashMap<String, Object> map = mapList.get(i);
			
			int count = attendDao.selectAttendanceInfo(map);
			System.out.println(map.get("user_id")+" "+count);
			if(count != 0) {
				continue;
			}
			
			System.out.println("Insert Info Map Test : " + map.toString());
			
			List<HashMap<String, Object>> sisuList = attendDao.selectAttendanceSisu(map);
			
			for(int j = 0; j < sisuList.size(); j++) {
				HashMap<String, Object> userSisu = new HashMap<>();
				
				userSisu.put("att_sisu_seq", sisuList.get(j).get("ATT_SISU_SEQ"));
				userSisu.put("user_id", map.get("user_id"));
				
				System.out.println("Insert Info SisuList Check : " + sisuList.get(j).toString());
				
				if(map.get("att_final_gubun").equals("B4702")){
					userSisu.put("att_info_gubun", "B4702");
					userSisuList.add(userSisu);
					continue;
				}
				
				SimpleDateFormat sdf = new SimpleDateFormat("HH:mm");
				
				try {
					Date inTime = sdf.parse(String.valueOf(map.get("in_time")));
					Date outTime = sdf.parse(String.valueOf(map.get("out_time")));
					Date standInTime = sdf.parse(String.valueOf(sisuList.get(j).get("STAND_IN_TIME")));
					Date standOutTime = sdf.parse(String.valueOf(sisuList.get(j).get("STAND_OUT_TIME")));
					
					if(inTime.compareTo(standInTime) > 0) {
						if(inTime.compareTo(standOutTime) > 0) {
							userSisu.put("att_info_gubun", "B4702");
						} else {
							userSisu.put("att_info_gubun", "B4702");
						}
					} else if(outTime.compareTo(standOutTime) < 0) {
						if(outTime.compareTo(standInTime) < 0) {
							userSisu.put("att_info_gubun", "B4702");
						} else {
							userSisu.put("att_info_gubun", "B4702");
						}
					} else {
						userSisu.put("att_info_gubun", "B4701");
					}
				} catch (Exception e) {
					e.printStackTrace();
				}
				
				userSisuList.add(userSisu);
			}
		}
		
		if(!userSisuList.isEmpty()) {
			attendDao.insertAttendanceSisu(userSisuList);
		}
	}

	public void scheduledInsertInfo()  {
		List<HashMap<String, Object>> userSisuList = new ArrayList<>();
		List<HashMap<String, Object>> userTimeList = new ArrayList<>();
		
		userTimeList = attendDao.selectAttendanceTime();
		
		for(int i = 0; i < userTimeList.size(); i++) {
			HashMap<String, Object> map = userTimeList.get(i);
			int count = attendDao.selectAttendanceInfo(map);
			
			if(count != 0) {
				continue;
			}
			
			List<HashMap<String, Object>> sisuList = attendDao.selectAttendanceSisu(map);
			
			for(int j = 0; j < sisuList.size(); j++) {
				HashMap<String, Object> userSisu = new HashMap<>();
				
				userSisu.put("att_sisu_seq", sisuList.get(j).get("ATT_SISU_SEQ"));
				userSisu.put("user_id", map.get("USER_ID"));
				
				if(map.get("ATT_FINAL_GUBUN").equals("B4702")){
					userSisu.put("att_info_gubun", "B4702");
					userSisuList.add(userSisu);
					continue;
				}
				
				SimpleDateFormat sdf = new SimpleDateFormat("HH:mm");
				
				try {
					Date inTime = sdf.parse(String.valueOf(map.get("IN_TIME")));
					Date outTime = sdf.parse(String.valueOf(map.get("OUT_TIME")));
					Date standInTime = sdf.parse(String.valueOf(sisuList.get(j).get("STAND_IN_TIME")));
					Date standOutTime = sdf.parse(String.valueOf(sisuList.get(j).get("STAND_OUT_TIME")));
					
					if(inTime.compareTo(standInTime) > 0) {
						if(inTime.compareTo(standOutTime) > 0) {
							userSisu.put("att_info_gubun", "B4702");
						} else {
							userSisu.put("att_info_gubun", "B4702");
						}
					} else if(outTime.compareTo(standOutTime) < 0) {
						if(outTime.compareTo(standInTime) < 0) {
							userSisu.put("att_info_gubun", "B4702");
						} else {
							userSisu.put("att_info_gubun", "B4702");
						}
					} else {
						userSisu.put("att_info_gubun", "B4701");
					}
				} catch (Exception e) {
					e.printStackTrace();
				}
				
				userSisuList.add(userSisu);
			}
		}
		
		if(!userSisuList.isEmpty()) {
			attendDao.insertAttendanceSisu(userSisuList);
		}
	}
	
	public List<HashMap<String, Object>> selectUserSisu(HashMap<String, Object> map) {
		return attendDao.selectUserSisu(map);
	}
	
	public String stuSisuUpdate(List<HashMap<String, Object>> mapList) {
		MemberVO loginUser = (MemberVO)LoginHelper.getLoginInfo();
		String upd_id = loginUser.getId();
		
		int result = 0;
		
		for(int i = 0; i < mapList.size(); i++) {
			mapList.get(i).put("UPD_USER", upd_id);
			result = attendDao.stuSisuUpdate(mapList.get(i));
			
			if(result == 0) {
				return "Fail";
			}
		}
		
		return "Success";
	}

	public void insertAttendanceInfo(List<HashMap<String, Object>> map) {
		List<HashMap<String, Object>> empty = new ArrayList<>();
		List<HashMap<String, Object>> attend = new ArrayList<>();
		List<HashMap<String, Object>> mapList = new ArrayList<>();
		
		for(int i = 0; i < map.size(); i++) {
			if("B4702".equalsIgnoreCase(String.valueOf(map.get(i).get("att_final_gubun")))) {
				empty.add(map.get(i));
			} else {
				attend.add(map.get(i));
			}
		}
		
		for(int i=0; i<attend.size(); i++) {
			int result = attendDao.registeredList(attend.get(i));
			if(result != 0) {
				attend.remove(i);
			} else {
				mapList.add(attend.get(i));
			}
		}
		
		for(int i=0; i<empty.size(); i++) {
			int result = attendDao.registeredList(empty.get(i));
			if(result != 0) {
				empty.remove(i);
			} else {
				mapList.add(empty.get(i));
			}
		}
		
		if(!attend.isEmpty()) {
		attendDao.attendInputUserInfo(attend);
	}
	
	if(!empty.isEmpty()) {
		attendDao.emptyInputUserInfo(empty);
	}
		try {
			insertInfo(mapList);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public int deleteRegFile(int attInfoTimeSeq) {
		return attendDao.deleteRegFile(attInfoTimeSeq);
	}
	
	public List<HashMap<String, Object>> selectPersonalInfo(HashMap<String, Object> map) {
		return attendDao.selectPersonalInfo(map);
	}
}
