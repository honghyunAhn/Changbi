package com.lms.student.service;


import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.lms.student.dao.ApplyDAO;
import com.lms.student.vo.ApplyVO;
import com.lms.student.vo.StuInfoBasicVO;

import forFaith.dev.dao.AttachFileDAO;
import forFaith.dev.vo.AttachFileDetailVO;
import forFaith.dev.vo.AttachFileVO;

@Service
public class ApplyService {

	@Autowired
	private ApplyDAO applyDao;
	
	@Autowired
	private AttachFileDAO fileDao;
	
	// 지원자 리스트 조회
	public List<ApplyVO> applyList(ApplyVO apply){
		return applyDao.applyList(apply);
	}
	
	// 지원자 리스트 총 갯수
	public int applyTotalCnt(ApplyVO apply) throws Exception {
		return applyDao.applyTotalCnt(apply);
	}
	
	// 지원서 정보 조회
	public HashMap<String, Object> selectApplyForm(ApplyVO apply) throws Exception {
		return applyDao.selectApplyForm(apply);
	}	
	
	// 서류, 면접 전형 결과 수정
	public boolean updateApplyResult(ApplyVO applyVO) {
		if(applyDao.updateApplyResult(applyVO) == 1) return true;
		return false;
	}

	@Transactional
	public boolean confirmStudent(ApplyVO applyVO) throws Exception {
		// 지원자 정보를 학적부로 복사
		applyDao.insertCopyStuApplyForm(applyVO);
		applyDao.insertCopyStuApplyEduHistory(applyVO);
		applyDao.insertCopyStuApplyCareer(applyVO);
		applyDao.insertCopyStuApplyStudy(applyVO);
		applyDao.insertCopyStuApplyLanguage(applyVO);
		applyDao.insertCopyStuApplyLicense(applyVO);
		applyDao.insertCopyStuApplySes(applyVO);
		applyDao.insertCopyStuApplyKmove(applyVO);
		applyDao.insertCopyStuApplyOverseas(applyVO);
		applyDao.insertCopyStuApplyIntroduce(applyVO);
		
		// 지원서 첨부파일 정보 등록
		regAttachFile(applyVO);
		
		// 입과 처리
		if(applyDao.updateLearnApp(applyVO) == 1) return true;
		return false;
	}
	
	// 지원서 첨부파일 정보 등록
	public boolean regAttachFile(ApplyVO applyVO) throws Exception{
		HashMap<String, Object> apply = applyDao.selectApplyForm(applyVO);
		
		ArrayList<String> savedName = new ArrayList<>();
		savedName.add((String)apply.get("stu_app_photo_saved"));
		savedName.add((String)apply.get("stu_app_edu_file_saved"));
		savedName.add((String)apply.get("stu_app_isr_file_saved"));
		savedName.add((String)apply.get("stu_app_imm_file_saved"));
		savedName.add((String)apply.get("stu_app_worknet_file_saved"));
		
		ArrayList<String> originalName = new ArrayList<>();
		originalName.add((String)apply.get("stu_app_photo_origin"));
		originalName.add((String)apply.get("stu_app_edu_file_origin"));
		originalName.add((String)apply.get("stu_app_isr_file_origin"));
		originalName.add((String)apply.get("stu_app_imm_file_origin"));
		originalName.add((String)apply.get("stu_app_worknet_file_origin"));
		
		List<AttachFileVO> attachFileList = new ArrayList<AttachFileVO>();
		StuInfoBasicVO stuBasic = applyDao.selectStuInfoBasic(applyVO);
		
		String currDate = new SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
		Random random = new Random();
		int randomNumber = 1000000;
		
		for(int i=0; i < originalName.size(); i++){
			AttachFileVO attachFile = new AttachFileVO();
			AttachFileDetailVO attachFileDetail = new AttachFileDetailVO();
			
			if(savedName.get(i) != null && savedName.get(i).length() != 0){
				
				// 첨부파일 테이블에 등록하는 정보 : 파일확장자, savedName, originalName, fileID(랜덤으로 생성해서 등록)
				// *** file_path는 등록하지 않는다. 학적부에서의 첨부파일 삭제와 관련있음 ***
				String[] splitName = originalName.get(i).split("\\.");
				attachFileDetail.setFileExt(splitName[1]);
				attachFileDetail.setFileName(savedName.get(i));
				attachFileDetail.setOriginFileName(originalName.get(i));
				attachFile.addDetail(attachFileDetail);
				
				// fileId = "FILE_현재 날짜_랜덤 8자리 수"
		        randomNumber = random.nextInt(9000000)+randomNumber;
		        String fileId = "FILE_" + currDate + randomNumber;
		        attachFile.setFileId(fileId);
		        
		        // 첨부파일 테이블(ff_attach_file, ff_attach_file_detail)에 파일정보 등록
		        fileDao.attachFileReg(attachFile);
				fileDao.attachFileDetailReg(attachFile);
				attachFileList.add(attachFile);
				
				// 학적부에 등록할 첨부파일ID(=fileID) 세팅
				switch(i){
					case 0 :
						stuBasic.setStu_photo_attached(attachFile.getFileId());
						break;
					case 1:
						stuBasic.setStu_edu_attached(attachFile.getFileId());
						break;
					case 2:
						stuBasic.setStu_isr_attached(attachFile.getFileId());
						break;
					case 3:
						stuBasic.setStu_imm_attached(attachFile.getFileId());
						break;
					case 4:
						stuBasic.setStu_worknet_attached(attachFile.getFileId());
						break;
				}
			}
		}
		// 학적부 첨부파일 사용가능 상태로 변경 
		if(attachFileList.size() > 0) fileDao.attachFileUse(attachFileList);

		// 학적부 테이블에 첨부파일ID 저장
		if(applyDao.regAttachFileID(stuBasic) == 1) return true;
		return false;
	}

	public int checkStudent(ApplyVO vo) {
		return applyDao.checkStudent(vo);
	}
	
	public boolean cancelConfirm(ApplyVO applyVO) throws Exception {
		int result = applyDao.deleteStuInfo(applyVO);
		if(result == 1){
			if(applyDao.changeAcceptance(applyVO) == 1) return true;
		}
		return false;
	}
}
