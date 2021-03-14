package com.changbi.tt.dev.data.dao;

import java.util.List;

import com.changbi.tt.dev.data.vo.ManagerVO;
import com.changbi.tt.dev.data.vo.UserVO;
import com.changbi.tt.dev.data.vo.WithdrawalVO;

public interface MemberDAO {

	// 멤버 리스트 조회
	List<UserVO> memberList(UserVO member) throws Exception;

	// 멤버 리스트 총 갯수
	int memberTotalCnt(UserVO member) throws Exception;

	// 멤버 조회
	UserVO memberInfo(UserVO member) throws Exception;

	// 멤버 등록
    void memberReg(UserVO member) throws Exception;

	// 멤버 삭제
	int memberDel(UserVO member) throws Exception;
	
	// 멤버 선택 삭제
	int memberSelectDel(List<UserVO> userList) throws Exception;
	
	// 비밀번호 초기화
	int userPwInit(UserVO user) throws Exception;
	
	// 탈퇴 회원 리스트 조회
	List<WithdrawalVO> memberOutList(WithdrawalVO withdrawal) throws Exception;

	// 탈퇴 회원 리스트 총 갯수
	int memberOutTotalCnt(WithdrawalVO withdrawal) throws Exception;

	// 탈퇴 회원 등록
	void memberOutReg(WithdrawalVO withdrawal) throws Exception;

	// 탈퇴 회원 데이터 삭제
	int memberOutDel(UserVO user) throws Exception;
	
	// 탈퇴회원 선택 삭제
	int memberOutSelectDel(List<UserVO> userList) throws Exception;
	
	// 관리자 상세 조회
	ManagerVO managerInfo(ManagerVO manager) throws Exception;
	
	// 해당 관리자의 담당교과지정 저장
	int managerCourseReg(ManagerVO manager) throws Exception;
	
	// 해당 관리자의 담당교과지정 삭제
	int managerCourseDel(ManagerVO manager) throws Exception;

	// 해당 관리자의 tcc영상 저장
	int managerTccReg(ManagerVO manager) throws Exception;
	
	// 해당 관리자의 tcc영상 삭제
	int managerTccDel(ManagerVO manager) throws Exception;
	
	// 관리자 선택 삭제
	int managerSelectDel(List<ManagerVO> managerList) throws Exception;
	
	// 관리자 담당교과지정 선택 삭제
	int managerCourseSelectDel(List<ManagerVO> managerList) throws Exception;
	
	// 관리자 TCC 선택 삭제
	int managerTccSelectDel(List<ManagerVO> managerList) throws Exception;

	// 관리자 정보수정(필수)
	int memberUpd(UserVO user) throws Exception;

	// 사용자 선택정보 테이블 유무 확인
	int selectIfAdditionalInfoExistAdmin(String id) throws Exception;

	// 사용자 정보수정(선택)1
	int updateAdditionalMemberInfoAdmin(UserVO user) throws Exception;

	// 사용자 정보수정(선택)2
	int insertAdditionalMemberInfoAdmin(UserVO user) throws Exception;
	
	
}