package com.lms.student.dao;


import java.util.HashMap;
import java.util.List;

import com.lms.student.vo.ApplyVO;
import com.lms.student.vo.StuInfoBasicVO;

public interface ApplyDAO {
	public List<ApplyVO> applyList(ApplyVO vo);
	public int applyTotalCnt(ApplyVO vo);
	public HashMap<String, Object> selectApplyForm(ApplyVO vo);
	public int updateApplyResult(ApplyVO vo);
	
	public int checkStudent(ApplyVO vo);
	public int insertCopyStuApplyForm(ApplyVO vo);
	public int insertCopyStuApplyEduHistory(ApplyVO vo);
	public int insertCopyStuApplyCareer(ApplyVO vo);
	public int insertCopyStuApplyStudy(ApplyVO vo);
	public int insertCopyStuApplyLanguage(ApplyVO vo);
	public int insertCopyStuApplyLicense(ApplyVO vo);
	public int insertCopyStuApplySes(ApplyVO vo);
	public int insertCopyStuApplyKmove(ApplyVO vo);
	public int insertCopyStuApplyOverseas(ApplyVO vo);
	public int insertCopyStuApplyIntroduce(ApplyVO vo);
	
	public StuInfoBasicVO selectStuInfoBasic(ApplyVO vo);
	public int updateLearnApp(ApplyVO vo);
	public int regAttachFileID(StuInfoBasicVO stuBasic);
	
	public int deleteStuInfo(ApplyVO vo);
	public int changeAcceptance(ApplyVO vo);
	
}
