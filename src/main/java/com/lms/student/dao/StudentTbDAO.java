package com.lms.student.dao;


import java.util.HashMap;
import java.util.List;

import com.lms.student.vo.MouVO;
import com.lms.student.vo.StuInfoBasicVO;
import com.lms.student.vo.StuInfoEduHistoryVO;
import com.lms.student.vo.StuInfoLanguageVO;
import com.lms.student.vo.StuInfoLicenseVO;
import com.lms.student.vo.StuInfoOverseasVO;
import com.lms.student.vo.StudentTbVO;

public interface StudentTbDAO {
	public List<StudentTbVO> selectStuTable_List(StudentTbVO stuTb);
	public int studentTotalCnt(StudentTbVO stuTb);
	public List<HashMap<String, Object>> selectStudentTb_detail(StudentTbVO stuTb);
	public List<HashMap<String, Object>> selectBenefitCode();
	
	public void deleteStuInfoEduHistory(int stu_seq);
	public void deleteStuInfoLanguage(int stu_seq);
	public void deleteStuInfoLicense(int stu_seq);
	public void deleteStuInfoOverseas(int stu_seq);
	
	public int updateStuInfoBasic(StuInfoBasicVO basic);
	
	public void insertStuInfoEduHistory(StuInfoEduHistoryVO eduHistory);
	public void insertStuInfoLanguage(StuInfoLanguageVO language);
	public void insertStuInfoLicense(StuInfoLicenseVO license);
	public void insertStuInfoOverseas(StuInfoOverseasVO overseas);
	
	public List<MouVO> selectMOU(MouVO mou);
	
}
