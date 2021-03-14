package com.changbi.tt.dev.data.service;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.changbi.tt.dev.data.dao.MemberDAO;
import com.changbi.tt.dev.data.vo.ManagerVO;
import com.changbi.tt.dev.data.vo.UserVO;
import com.changbi.tt.dev.data.vo.WithdrawalVO;

import forFaith.dev.dao.AttachFileDAO;
import forFaith.dev.dao.BaseDAO;
import forFaith.dev.util.LoginHelper;
import forFaith.dev.vo.AttachFileVO;
import forFaith.dev.vo.MemberVO;
import forFaith.util.StringUtil;

@Service(value="data.memberService")
public class MemberService {

	@Autowired
	private MemberDAO memberDao;
	
	@Autowired
	private BaseDAO baseDao;
	
	@Autowired
    private AttachFileDAO fileDao;

	// 멤버 리스트 조회
	public List<UserVO> memberList(UserVO user) throws Exception {
		return memberDao.memberList(user);
	}

	// 멤버 리스트 총 갯수
	public int memberTotalCnt(UserVO user) throws Exception {
		return memberDao.memberTotalCnt(user);
	}

	// 멤버 조회
	public UserVO memberInfo(UserVO user) throws Exception {
		return memberDao.memberInfo(user);
	}

	// 멤버 등록
	public void memberReg(UserVO user) throws Exception {
		// 멤버등록
		memberDao.memberReg(user);
	
		// 멤버등록이 정상적으로 진행 되고, 서비스 상태가 탈퇴 인 경우 탈퇴 데이터를 등록한다.
		/*
		 * if(!StringUtil.isEmpty(user.getId()) && user.getUseYn().equals("N")) { //
		 * 탈퇴회원 등록 MemberVO loginUser = (MemberVO)LoginHelper.getLoginInfo();
		 * 
		 * WithdrawalVO withdrawal = new WithdrawalVO(); withdrawal.setUser(user);
		 * withdrawal.setNote("관리자["+loginUser.getId()+"]에 의한 탈퇴 처리");
		 * 
		 * memberDao.memberOutReg(withdrawal); } else
		 * if(!StringUtil.isEmpty(user.getId()) && !user.getUseYn().equals("N")) { // 탈퇴
		 * 회원 데이터 삭제 memberDao.memberOutDel(user); }
		 */
		// LMS - 멤버등록이 정상적으로 진행 되고, 서비스 상태가 탈퇴 인 경우 탈퇴 데이터를 등록한다.
        if(!StringUtil.isEmpty(user.getId()) && user.getUseYn().equals("A0202")) {
        	// 탈퇴회원 등록
        	MemberVO loginUser = (MemberVO)LoginHelper.getLoginInfo();
        	
        	WithdrawalVO withdrawal = new WithdrawalVO();
        	withdrawal.setUser(user);
        	withdrawal.setNote("관리자["+loginUser.getId()+"]에 의한 탈퇴 처리");
        	
        	memberDao.memberOutReg(withdrawal);
        } else if(!StringUtil.isEmpty(user.getId()) && !user.getUseYn().equals("A0202")) {
        	// 탈퇴 회원 데이터 삭제
        	memberDao.memberOutDel(user);
        }
	}

	// 멤버 삭제
	public int memberDel(UserVO user) throws Exception {
	    int result = memberDao.memberDel(user);
	    
	    if(result > 0) {
	    	// 유저 데이터 삭제 시 탈퇴회원 데이터도 삭제
	    	memberDao.memberOutDel(user);
	    }
	    
	    return result;
	}
	
	// 멤버 선택 삭제
	public int memberSelectDel(List<UserVO> userList) throws Exception {
		int result = memberDao.memberSelectDel(userList);
		
		if(result > 0) {
	    	// 유저 데이터 삭제 시 탈퇴회원 데이터도 삭제
	    	memberDao.memberOutSelectDel(userList);
	    }
	    
	    return result;
	}
	
	// 비밀번호 초기화
	public int userPwInit(UserVO user) throws Exception {
		return memberDao.userPwInit(user);
	}
	
	// 탈퇴 회원 리스트 조회
	public List<WithdrawalVO> memberOutList(WithdrawalVO withdrawal) throws Exception {
		return memberDao.memberOutList(withdrawal);
	}

	// 탈퇴 회원 리스트 총 갯수
	public int memberOutTotalCnt(WithdrawalVO withdrawal) throws Exception {
		return memberDao.memberOutTotalCnt(withdrawal);
	}
	
	// 관리자 상세 조회
	public ManagerVO managerInfo(ManagerVO manager) throws Exception {
		return memberDao.managerInfo(manager);
	}
	
	// 관리자 등록
	public void managerReg(ManagerVO manager) throws Exception {
		// 관리자 등록
		baseDao.memberReg(manager);
		
		// ID가 생성 또는 update 라면 detail insert 또는 upadate
        if(!StringUtil.isEmpty(manager.getId())) {
        	// 파일 사용 가능 상태로 변경 처리
            // useYn을 Y로 바꾼다.
            List<AttachFileVO> attachFileList = new ArrayList<AttachFileVO>();
            
 			if(manager.getPhotoFile() != null && !StringUtil.isEmpty(manager.getPhotoFile().getFileId())) {
 				attachFileList.add(manager.getPhotoFile());
 			}
 			
			// 파일 사용 가능 상태로 변경
			if(attachFileList.size() > 0) {
				fileDao.attachFileUse(attachFileList);
			}
			
        	// 해당 관리자의 담당교과지정 삭제
        	memberDao.managerCourseDel(manager);
        	
        	// 해당 관리자의 담당교과지정 저장
        	if(manager.getCourseList() != null && manager.getCourseList().size() > 0)	{
        		memberDao.managerCourseReg(manager);
 			}
        	
        	// 관리자 등급이 강사인 경우에만 처리
        	if(manager.getGrade() == 2) {
	        	// 해당 관리자의 TCC 영상 삭제
	        	memberDao.managerTccDel(manager);
	        	
	        	// 해당 관리자의 TCC 영상 저장
	        	if(manager.getTccList() != null && manager.getTccList().size() > 0)	{
	        		memberDao.managerTccReg(manager);
	 			}
        	}
        }
	}

	// 관리자 삭제
	public int managerDel(ManagerVO manager) throws Exception {
	    int result = baseDao.memberDel(manager);
	    
	    if(result > 0) {
        	// 해당 관리자의 담당교과지정 삭제
        	memberDao.managerCourseDel(manager);
        	
        	// 관리자 등급이 강사인 경우에만 처리
        	if(manager.getGrade() == 2) {
	        	// 해당 관리자의 TCC 영상 삭제
	        	memberDao.managerTccDel(manager);
        	}
	    }
	    
	    return result;
	}
	
	// 관리자 삭제
	public int managerSelectDel(List<ManagerVO> managerList) throws Exception {
	    int result = memberDao.managerSelectDel(managerList);
	    
	    if(result > 0) {
        	// 해당 관리자의 담당교과지정 삭제
        	memberDao.managerCourseSelectDel(managerList);
        	
	        // 해당 관리자의 TCC 영상 삭제
	        memberDao.managerTccSelectDel(managerList);
	    }
	    
	    return result;
	}

	// 사용자정보수정(필수)
	public int memberUpd(UserVO user) throws Exception {		 
		
		int result = memberDao.memberUpd(user);
		
		// 멤버등록이 정상적으로 진행 되고, 서비스 상태가 탈퇴 인 경우 탈퇴 데이터를 등록한다.
		/*
		 * if(!StringUtil.isEmpty(user.getId()) && user.getUseYn().equals("N")) { //
		 * 탈퇴회원 등록 MemberVO loginUser = (MemberVO)LoginHelper.getLoginInfo();
		 * 
		 * WithdrawalVO withdrawal = new WithdrawalVO(); withdrawal.setUser(user);
		 * withdrawal.setNote("관리자["+loginUser.getId()+"]에 의한 탈퇴 처리");
		 * 
		 * memberDao.memberOutReg(withdrawal); } else
		 * if(!StringUtil.isEmpty(user.getId()) && !user.getUseYn().equals("N")) { // 탈퇴
		 * 회원 데이터 삭제 memberDao.memberOutDel(user); }
		 */
		
		// LMS - 멤버등록이 정상적으로 진행 되고, 서비스 상태가 탈퇴 인 경우 탈퇴 데이터를 등록한다.
        if(!StringUtil.isEmpty(user.getId()) && user.getUseYn().equals("A0202")) {
        	// 탈퇴회원 등록
        	MemberVO loginUser = (MemberVO)LoginHelper.getLoginInfo();
        	
        	WithdrawalVO withdrawal = new WithdrawalVO();
        	withdrawal.setUser(user);
        	withdrawal.setNote("관리자["+loginUser.getId()+"]에 의한 탈퇴 처리");
        	
        	memberDao.memberOutReg(withdrawal);
        } else if(!StringUtil.isEmpty(user.getId()) && !user.getUseYn().equals("A0202")) {
        	// 탈퇴 회원 데이터 삭제
        	memberDao.memberOutDel(user);
        }
		return result;
	}

	// 사용자 선택정보 테이블 유무 확인
	public int selectIfAdditionalInfoExistAdmin(String id) throws Exception {
		return memberDao.selectIfAdditionalInfoExistAdmin(id);
	}

	// 사용자 정보수정(선택)1
	public int updateAdditionalMemberInfoAdmin(UserVO user) throws Exception {
		return memberDao.updateAdditionalMemberInfoAdmin(user);
	}

	// 사용자 정보수정(선택)2
	public int insertAdditionalMemberInfoAdmin(UserVO user) throws Exception {	 
		return memberDao.insertAdditionalMemberInfoAdmin(user);
	}
	 
	
}