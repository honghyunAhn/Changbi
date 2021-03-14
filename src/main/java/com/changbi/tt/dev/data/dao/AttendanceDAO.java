package com.changbi.tt.dev.data.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.changbi.tt.dev.data.vo.AttendanceVO;
import com.changbi.tt.dev.data.vo.DateAttendanceVO;
import com.changbi.tt.dev.data.vo.InfoAttendanceVO;
import com.changbi.tt.dev.data.vo.SmtpAttendanceVO;

public interface AttendanceDAO {

	int insertDate(AttendanceVO attend)  throws Exception;
	AttendanceVO selectDate(AttendanceVO attend)  throws Exception;
	int deleteDate(AttendanceVO attend)  throws Exception;
	int insertAttendance(Map<String, Object> attend)  throws Exception;
	AttendanceVO selectAttendance(AttendanceVO attend)  throws Exception;
	AttendanceVO selectAttendanceById(AttendanceVO attend)  throws Exception;
	AttendanceVO selectAttendanceByDate(AttendanceVO attend)  throws Exception;
	
	List<String> compareCourse(String course_id, String cardinal_id);
	
	ArrayList<DateAttendanceVO> selectDates(HashMap<String, Object> params);
	
//	HashMap<String, Object> selectDates(HashMap<String, Object> params);
	
	int deleteSmtpDate(HashMap<String, String> params);
	
	ArrayList<HashMap<String, Object>> selectedDate(HashMap<String, Object> params);
	
	int attendanceUpdate(InfoAttendanceVO attendance);
	
	int newDatesAdd(List<DateAttendanceVO> params);
	
	InfoAttendanceVO stuAttendanceUpdate(HashMap<String, Object> map);
	
	String stuName(String userId);
	
	int stuUpdate(InfoAttendanceVO info);
	
	int addDates(List<HashMap<String, Object>> mapList);
	int addSisu(List<HashMap<String, Object>> mapList);
	List<HashMap<String, Object>> compareDates(HashMap<String, Object> map);
	void compareDeleted(HashMap<String, Object> map);
	int registeredList(HashMap<String, Object> map);
	
	List<HashMap<String, Object>> stuListDownload(HashMap<String, Object> map);
	
	public void attendInputUserInfo(List<HashMap<String, Object>> mapList);
	public void emptyInputUserInfo(List<HashMap<String, Object>> mapList);
	
	int selectAttendanceInfo(HashMap<String, Object> map);
	
	List<HashMap<String, Object>> selectAttendanceSisu(HashMap<String, Object> map);
	
	int insertAttendanceSisu(List<HashMap<String, Object>> mapList);
	
	List<HashMap<String, Object>> selectAttendanceTime();
	
	List<HashMap<String, Object>> selectUserSisu(HashMap<String, Object> map);
	
	int stuSisuUpdate(HashMap<String, Object> map);
	
	public int deleteRegFile(int attInfoTimeSeq);
	
	// 출석부 정보 출력
	public List<HashMap<String, Object>> selectPersonalInfo(HashMap<String, Object> map);
}
