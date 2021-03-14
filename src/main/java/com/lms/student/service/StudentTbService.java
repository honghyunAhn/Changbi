package com.lms.student.service;


import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lms.student.dao.StudentTbDAO;
import com.lms.student.vo.MouVO;
import com.lms.student.vo.StuInfoBasicVO;
import com.lms.student.vo.StuInfoEduHistoryVO;
import com.lms.student.vo.StuInfoLanguageVO;
import com.lms.student.vo.StuInfoLicenseVO;
import com.lms.student.vo.StuInfoOverseasVO;
import com.lms.student.vo.StudentTbVO;

import forFaith.dev.dao.AttachFileDAO;
import forFaith.dev.vo.AttachFileVO;
import forFaith.util.StringUtil;

@Service
public class StudentTbService {

	@Autowired
	private StudentTbDAO stuTbDao;
	
	@Autowired
    private AttachFileDAO fileDao;

	@SuppressWarnings("unchecked")
	public List<StudentTbVO> selectStuTable_List(StudentTbVO stuTb) throws ParseException {
		
		List<StudentTbVO> list = stuTbDao.selectStuTable_List(stuTb);
		List<HashMap<String, Object>> detail = stuTbDao.selectStudentTb_detail(stuTb);
		
		for(int i=0; i<list.size(); i++){
			StudentTbVO stuTbVO = list.get(i);
			
			for(int j=0; j<detail.size(); j++){
				HashMap<String, Object> detailVO = detail.get(j);
				
				if(stuTbVO.getStu_seq() == (Integer)detailVO.get("stu_seq")){
					ArrayList<HashMap<String, Object>> eduHistoryList = (ArrayList<HashMap<String, Object>>) detailVO.get("eduHistoryList");
					ArrayList<HashMap<String, Object>> languageList = (ArrayList<HashMap<String, Object>>) detailVO.get("languageList");
					ArrayList<HashMap<String, Object>> licenseList = (ArrayList<HashMap<String, Object>>) detailVO.get("licenseList");
					ArrayList<HashMap<String, Object>> overseasList = (ArrayList<HashMap<String, Object>>) detailVO.get("overseasList");
					ArrayList<HashMap<String, Object>> classList = (ArrayList<HashMap<String, Object>>) detailVO.get("classList");
					
					//나이 데이터 처리 : 만 나이 계산
					Calendar cal = Calendar.getInstance();
					int year = cal.get(Calendar.YEAR);
					int birthYear = Integer.parseInt((String)detailVO.get("stu_user_birth_year"));
					stuTbVO.setStu_user_age(year-birthYear);
				
					//주소 데이터 처리
					String address = (String)detailVO.get("stu_addr");
					String address_detail = (String)detailVO.get("stu_addr_detail");

					String addr = address + " " + address_detail;
					stuTbVO.setStu_addr(addr);
					
					//학력사항 데이터 처리
					if(eduHistoryList.size() == 0){
						stuTbVO.setStu_edu_sc_nm("");
						stuTbVO.setStu_edu_major("");
						stuTbVO.setStu_edu_sc_lo("");
						stuTbVO.setStu_edu_gd_ck("");
					}else if(eduHistoryList.size() == 1){
						HashMap<String, Object> edu = eduHistoryList.get(0);
						
						stuTbVO.setStu_edu_sc_nm((String)edu.get("stu_edu_sc_nm"));
						stuTbVO.setStu_edu_major((String)edu.get("stu_edu_major"));
						stuTbVO.setStu_edu_sc_lo((String)edu.get("stu_edu_sc_lo"));
						stuTbVO.setStu_edu_gd_ck((String)edu.get("stu_edu_gd_ck"));
					}else{
						SimpleDateFormat sdf = new SimpleDateFormat("yy-mm-dd");
						String date = (String)eduHistoryList.get(0).get("stu_edu_gd_dt");
						Date recent = sdf.parse(date);
						
						for(int k=0; k<eduHistoryList.size(); k++){
							HashMap<String, Object> edu = eduHistoryList.get(k);
							
							//졸업예정이나 졸업유예 상태인 학력정보가 있다면, 그것이 최종학력이므로 저장하고 끝낸다.
							if(edu.get("stu_edu_gd_ck").equals("B1001") | edu.get("stu_edu_gd_ck").equals("B1002")){
								stuTbVO.setStu_edu_sc_nm((String)edu.get("stu_edu_sc_nm"));
								stuTbVO.setStu_edu_major((String)edu.get("stu_edu_major"));
								stuTbVO.setStu_edu_sc_lo((String)edu.get("stu_edu_sc_lo"));
								stuTbVO.setStu_edu_gd_ck((String)edu.get("stu_edu_gd_ck"));
								break;
								
							//전부 졸업상태일 경우, 졸업일자를 비교하여 최근의 것으로 저장한다.
							}else if(edu.get("stu_edu_gd_ck").equals("B1000")){
								String gd_dt = (String)edu.get("stu_edu_gd_dt");
								Date compareDt = sdf.parse(gd_dt);
								int result = recent.compareTo(compareDt);
								
								if(result == -1 | result ==0){
									recent = compareDt;
									stuTbVO.setStu_edu_sc_nm((String)edu.get("stu_edu_sc_nm"));
									stuTbVO.setStu_edu_major((String)edu.get("stu_edu_major"));
									stuTbVO.setStu_edu_sc_lo((String)edu.get("stu_edu_sc_lo"));
									stuTbVO.setStu_edu_gd_ck((String)edu.get("stu_edu_gd_ck"));
								}
							}
						}
					}
					
					//자격증 데이터 처리 
					String license_summary = "";
					for(int k=0; k<licenseList.size(); k++){
						HashMap<String, Object> license = licenseList.get(k);
						String license_nm = (String)license.get("stu_license_nm");
						
						if(license_nm != null) {
							switch(license_nm){
							case "B2900":
								license_nm = "정보처리기사";
								break;
							case "B2901":
								license_nm = "정보처리산업기사";
								break;
							case "B2906":
								license_nm = (String)license.get("stu_license_note");
								break;
							}
						}else { //광주 지원서 페이지에서 지원한 데이터를 학적부로 생성한 경우
							license_nm = (String)license.get("stu_license_note");
						}
						license_summary += "," + license_nm;
					}
					stuTbVO.setStu_license(license_summary);
					
					//어학성적 데이터 처리
					String lang_summary = "";
					for(int k=0; k<languageList.size(); k++){
						HashMap<String, Object> language = languageList.get(k);
						
						String lang_test_nm = (String)language.get("stu_lang_test_nm");
						String lang_grade = (String)language.get("stu_lang_grade");
						
						if(lang_test_nm != null) {
							switch(lang_test_nm){
							case "B2902":
								lang_test_nm = "JLPT1급";
								break;
							case "B2903":
								lang_test_nm = "JLPT2급";
								break;
							case "B2904":
								lang_test_nm = "JPT";
								break;
							case "B2905":
								lang_test_nm = "TOEIC";
								break;
							case "B2906":
								lang_test_nm = (String)language.get("stu_lang_note");
								break;
							}
						}else { //광주 지원서 페이지에서 지원한 데이터를 학적부로 생성한 경우
							lang_test_nm = (String)language.get("stu_lang_note");
						}
						lang_summary += "," + lang_test_nm + " " + lang_grade;
					}
					stuTbVO.setStu_language(lang_summary);
					
					//정보처리기사 데이터 처리
					/*if(licenseList.size() == 0) stuTbVO.setInfoProcessing("B2501");
					
					for(int k=0; k<licenseList.size(); k++){
						HashMap<String, Object> license = licenseList.get(k);
						
						String license_nm = (String)license.get("stu_license_nm");
						license_nm = license_nm.replaceAll(" ", "");
						
						if(license_nm.equals("정보처리기사") | license_nm.equals("정보처리산업기사") | license_nm.equals("정처기") | license_nm.equals("정처산기") | license_nm.equals("정보처리")){
							stuTbVO.setInfoProcessing("B2500");
							break;
						}else{
							stuTbVO.setInfoProcessing("B2501");
						}
					}*/
					
					//해외연수경험 데이터 처리
					String overseas_summary = "";
					for(int k=0; k<overseasList.size(); k++){
						HashMap<String, Object> overseas = overseasList.get(k);
						
						String overseas_purpose = (String)overseas.get("stu_overseas_purpose");
						String overseas_nm = (String)overseas.get("stu_overseas_nm");
						String overseas_st = (String)overseas.get("stu_overseas_st");
						String overseas_et = (String)overseas.get("stu_overseas_et");
						
						if(overseas_nm != null) overseas_summary += "," + overseas_nm + " " + overseas_st + "~" + overseas_et + " " + overseas_purpose;
						else overseas_summary = "";
					}
					stuTbVO.setStu_overseas(overseas_summary);
					
					//반 이름 데이터 처리
					String class_summary = "";
					for(int k=0; k<classList.size(); k++) class_summary += "," + classList.get(k).get("stu_class");
					stuTbVO.setStu_class(class_summary);
					
					//null인 항목 체크
					if(stuTbVO.getStu_user_nm_en() == null) stuTbVO.setStu_user_nm_en("");
					if(stuTbVO.getStu_user_nm_jp() == null) stuTbVO.setStu_user_nm_jp("");
					if(stuTbVO.getStu_mou_ck() == null) stuTbVO.setStu_mou_ck("");
					if(stuTbVO.getStu_benefit_ck() == null) stuTbVO.setStu_benefit_ck("");
					if(stuTbVO.getStu_quit_dt() == null) stuTbVO.setStu_quit_dt("");
					if(stuTbVO.getStu_memo() == null) stuTbVO.setStu_memo("");

					break;
				}
			}
		}
		return list;
	}

	public int studentTotalCnt(StudentTbVO stuTb) {
		return stuTbDao.studentTotalCnt(stuTb);
	}

	public HashMap<String, Object> selectStudentTb_detail(StudentTbVO stuTb) {
		List<HashMap<String, Object>> detail = stuTbDao.selectStudentTb_detail(stuTb);
		return detail.get(0);
	}
	
	public List<HashMap<String, Object>> selectBenefitCode() {
		return stuTbDao.selectBenefitCode();
	}

	public int updateStudentTb(StuInfoBasicVO basic, StuInfoEduHistoryVO eduHistory, StuInfoLanguageVO language, StuInfoLicenseVO license, StuInfoOverseasVO overseas) throws Exception{
		int stu_seq = basic.getStu_seq();
		int result = stuTbDao.updateStuInfoBasic(basic);
		//학력, 어학, 자격, 해외경험 기존 데이터 삭제
		stuTbDao.deleteStuInfoEduHistory(stu_seq);
		stuTbDao.deleteStuInfoLanguage(stu_seq);
		stuTbDao.deleteStuInfoLicense(stu_seq);
		stuTbDao.deleteStuInfoOverseas(stu_seq);
		
		// 비어있는 리스트 삭제 후, 학력 어학 자격 해외경험 데이터 삽입
		insertNewData(eduHistory, language, license, overseas);
		
    	changeAttachFileUse(basic);
		return result;
	}
	
	public void insertNewData(StuInfoEduHistoryVO eduHistory, StuInfoLanguageVO language, StuInfoLicenseVO license, StuInfoOverseasVO overseas){
		
		ArrayList<Integer> removeArr = new ArrayList<>();
		
		if(eduHistory.getEduHistoryList() != null){
			// 학력정보 빈 리스트 체크
			for (StuInfoEduHistoryVO eduInfo : eduHistory.getEduHistoryList()) {
				if (eduInfo.getStu_edu_sc_nm().trim().equals(""))
					removeArr.add(eduHistory.getEduHistoryList().indexOf(eduInfo));
			}
			// 학력정보가 비어있는 리스트가 제거된 리스트로 세팅  
			eduHistory.setEduHistoryList(removeEmptyList(eduHistory.getEduHistoryList(), removeArr));
			// 인덱스 리스트 초기화
			removeArr.clear();
			// 빈 리스트가 제거된 새로운 학력정보 삽입
			stuTbDao.insertStuInfoEduHistory(eduHistory);
		}

		// 언어능력 
		if(language.getLanguageList() != null){
			for (StuInfoLanguageVO langInfo : language.getLanguageList()) {
				if (langInfo.getStu_lang_test_nm().trim().equals(""))
					removeArr.add(language.getLanguageList().indexOf(langInfo));
			}
			language.setLanguageList(removeEmptyList(language.getLanguageList(), removeArr));
			removeArr.clear();
			stuTbDao.insertStuInfoLanguage(language);
		}

		// 자격증
		if(license.getLicenseList() != null){
			for (StuInfoLicenseVO licenseInfo : license.getLicenseList()) {
				if (licenseInfo.getStu_license_nm().trim().equals(""))
					removeArr.add(license.getLicenseList().indexOf(licenseInfo));
			}
			license.setLicenseList(removeEmptyList(license.getLicenseList(), removeArr));
			removeArr.clear();
			stuTbDao.insertStuInfoLicense(license);
		}
		
		// 해외경험
		if(overseas.getOverseasList() != null){
			for (StuInfoOverseasVO overseasInfo : overseas.getOverseasList()) {
				if(overseasInfo.getStu_overseas_nm().trim().equals(""))
					removeArr.add(overseas.getOverseasList().indexOf(overseasInfo));
			}
			overseas.setOverseasList(removeEmptyList(overseas.getOverseasList(), removeArr));
			removeArr.clear();
			stuTbDao.insertStuInfoOverseas(overseas);
		}
	}
	
	private <T> List<T> removeEmptyList(List<T> list, ArrayList<Integer> removeArr) {
		// 내림차순 정렬(오름차순 -> 역정렬)
		Collections.sort(removeArr);
		Collections.reverse(removeArr);

		// 비어있는 리스트 제거
		for (Integer index : removeArr) list.remove(index.intValue());
		return list;
	}
	
	public void changeAttachFileUse(StuInfoBasicVO basic) throws Exception{
		if(basic.getStu_seq() > 0){
    		List<AttachFileVO> attachFileList = new ArrayList<AttachFileVO>();
			
    		if(basic.getStu_photo_file() != null && !StringUtil.isEmpty(basic.getStu_photo_file().getFileId()))
 				attachFileList.add(basic.getStu_photo_file());
    		
    		if(basic.getStu_edu_file() != null && !StringUtil.isEmpty(basic.getStu_edu_file().getFileId()))
 				attachFileList.add(basic.getStu_edu_file());
 			
            if(basic.getStu_isr_file() != null && !StringUtil.isEmpty(basic.getStu_isr_file().getFileId()))
            	attachFileList.add(basic.getStu_isr_file());
            
            if(basic.getStu_imm_file() != null && !StringUtil.isEmpty(basic.getStu_imm_file().getFileId()))
            	attachFileList.add(basic.getStu_imm_file());
            
            if(basic.getStu_worknet_file() != null && !StringUtil.isEmpty(basic.getStu_worknet_file().getFileId()))
            	attachFileList.add(basic.getStu_worknet_file());
            
            if(basic.getStu_quit_file() != null && !StringUtil.isEmpty(basic.getStu_quit_file().getFileId()))
            	attachFileList.add(basic.getStu_quit_file());
            
			// 파일 사용 가능 상태로 변경
			if(attachFileList.size() > 0) {
				fileDao.attachFileUse(attachFileList);
			}
    	}
	}

	public List<MouVO> selectMOU(MouVO mou) {
		return stuTbDao.selectMOU(mou);
	}
	
}
