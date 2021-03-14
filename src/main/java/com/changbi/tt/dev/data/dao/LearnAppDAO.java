package com.changbi.tt.dev.data.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.changbi.tt.dev.data.vo.AttLecVO;
import com.changbi.tt.dev.data.vo.ChapterVO;
import com.changbi.tt.dev.data.vo.EduUserPayVO;
import com.changbi.tt.dev.data.vo.EduUserRefundVO;
import com.changbi.tt.dev.data.vo.LearnAppVO;
import com.changbi.tt.dev.data.vo.LearnCancelVO;
import com.changbi.tt.dev.data.vo.LearnChangeVO;
import com.changbi.tt.dev.data.vo.LearnDelayVO;
import com.changbi.tt.dev.data.vo.PointVO;
import com.changbi.tt.dev.data.vo.StatsVO;
import com.changbi.tt.dev.data.vo.UserVO;

public interface LearnAppDAO {

	// 연수신청관리 리스트 조회
	List<LearnAppVO> learnAppList(LearnAppVO learnApp) throws Exception;
	
	// 연수신청 리스트 총 갯수
	int learnAppTotalCnt(LearnAppVO learnApp) throws Exception;

	// 연수신청관리 상세 조회
	LearnAppVO learnAppInfo(LearnAppVO learnApp) throws Exception;
	
	// 연수신청 등록/수정
	int learnAppReg(LearnAppVO learnApp) throws Exception;
	
	// 수강자 입과 처리
	int learnAppIn(List<LearnAppVO> learnAppList) throws Exception;
	
	// LMS 입과 정보 중복 조회
	List<String> getLearnApp(LearnAppVO learnApp) throws Exception;
	
	// 잔여포인트 조회
	int getBalance(UserVO user) throws Exception;
	
	// 포인트 적립 / 사용
	void pointReg(PointVO point) throws Exception;

	// 연수신청 선택 삭제
	int learnAppSelectDel(List<LearnAppVO> learnAppList) throws Exception;
	
	// 수강관리 리스트 조회
	List<LearnAppVO> learnManList(LearnAppVO learnApp) throws Exception;

	// 수강관리 리스트 총 갯수
	int learnManTotalCnt(LearnAppVO learnApp) throws Exception;
	
	// 수강변경 처리
	int changeLearnApp(LearnAppVO learnApp) throws Exception;
	
	// 수강연기 처리
	int delayLearnApp(LearnAppVO learnApp) throws Exception;
	
	// 수강 취소 처리
	int cancelLearnApp(LearnAppVO learnApp) throws Exception;
	
	//전체 챕터/세부 페이지 조회(포팅)
	List<ChapterVO> getChapPage(LearnAppVO learnApp) throws Exception;
	
	//전체 챕터/세부 페이지 조회(링크)
	List<ChapterVO> getChapPage2(LearnAppVO learnApp) throws Exception;
	
	//수강이력정보 생성
	int insertAttLec(HashMap<String, Object> param) throws Exception;
	
	// 수강이력 리스트
	List<ChapterVO> attLecList(LearnAppVO learnApp) throws Exception;
	
	// 수강변경관리 리스트 조회
	List<LearnChangeVO> learnChangeList(LearnChangeVO learnChange) throws Exception;

	// 수강변경 상태 변경
	int learnChange(LearnChangeVO learnChange) throws Exception;

	// 수강변경관리 리스트 총 갯수
	int learnChangeTotalCnt(LearnChangeVO learnChange) throws Exception;
	
	// 수강연기관리 리스트 조회
	List<LearnDelayVO> learnDelayList(LearnDelayVO learnDelay) throws Exception;

	// 수강연기 상태 변경
	int learnDelay(LearnDelayVO learnDelay) throws Exception;
	
	// 수강연기관리 리스트 총 갯수
	int learnDelayTotalCnt(LearnDelayVO learnDelay) throws Exception;
	
	// 수강취소관리 리스트 조회
	List<LearnCancelVO> learnCancelList(LearnCancelVO learnCancel) throws Exception;

	// 수강취소 상태 변경
	int learnCancel(LearnCancelVO learnCancel) throws Exception;

	// 수강취소관리 리스트 총 갯수
	int learnCancelTotalCnt(LearnCancelVO learnCancel) throws Exception;
	
	// 수강이력 관리 조회
	List<AttLecVO> attLecHistory(LearnAppVO learnApp) throws Exception;
	
	// 튜터 첨삭이력 총 갯수
	int activeTotalCnt(StatsVO stats) throws Exception;
	
	// 튜터 첨삭이력 리스트
	List<Map<String,String>> activeList(StatsVO stats) throws Exception;

	//연수확인서 확인용 조회
	HashMap<String, Object> learnAppInfoForCertificate(LearnAppVO learnApp) throws Exception;
	
	// 실 납입금액 가져오기 
	String selectUsedPoint(LearnAppVO learnApp) throws Exception;

	// 환불정보 가져오기
	EduUserRefundVO getRefundInfo(String pay_user_seq);
	
	EduUserPayVO getEduUserPayInfo(String pay_user_seq);
 
	int payRefundReg(HashMap<String, Object> map);
}