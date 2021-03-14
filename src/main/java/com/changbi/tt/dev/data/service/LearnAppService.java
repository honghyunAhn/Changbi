package com.changbi.tt.dev.data.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.changbi.tt.dev.data.dao.LearnAppDAO;
import com.changbi.tt.dev.data.vo.AttLecVO;
import com.changbi.tt.dev.data.vo.ChapterVO;
import com.changbi.tt.dev.data.vo.CourseVO;
import com.changbi.tt.dev.data.vo.EduUserPayVO;
import com.changbi.tt.dev.data.vo.EduUserRefundVO;
import com.changbi.tt.dev.data.vo.LearnAppVO;
import com.changbi.tt.dev.data.vo.LearnCancelVO;
import com.changbi.tt.dev.data.vo.LearnChangeVO;
import com.changbi.tt.dev.data.vo.LearnDelayVO;
import com.changbi.tt.dev.data.vo.PointVO;
import com.changbi.tt.dev.data.vo.StatsVO;

import forFaith.dev.vo.SubChapVO;
import forFaith.util.StringUtil;

@Service(value="data.learnAppService")
public class LearnAppService {
	
	@Autowired
	private LearnAppDAO learnAppDao;
	
	// 연수신청관리 리스트 조회
	public List<LearnAppVO> learnAppList(LearnAppVO learnApp) throws Exception {
		return learnAppDao.learnAppList(learnApp);
	}

	// 연수신청 리스트 총 갯수
	public int learnAppTotalCnt(LearnAppVO learnApp) throws Exception {
		return learnAppDao.learnAppTotalCnt(learnApp);
	}

	// 연수신청관리 상세 조회
	public LearnAppVO learnAppInfo(LearnAppVO learnApp) throws Exception {
		return learnAppDao.learnAppInfo(learnApp);
	}
	
	// 연수신청 등록/수정
	public int learnAppReg(LearnAppVO learnApp) throws Exception {
		int result = 0;
		
		if (learnApp.getPaymentState() == null) {
			learnApp.setPaymentState("2");
			result =	learnAppDao.learnAppReg(learnApp);
			
		} else {
			// 포인트 적립 시 사용 처리
			// 이전 결제 상태와 다른 경우에만 처리
			if(!learnApp.getPaymentState().equals(learnApp.getPrevPaymentState())) {
				// 적립 포인트를 가지고 온다.
				PointVO point = learnApp.getPoint();
				
				// 잔여포인트를 가지고 온다.
				int balance = learnAppDao.getBalance(learnApp.getUser());
				
				if(learnApp.getPaymentState().equals("2")) {
					// 결제상태가 완료인 경우 포인트 적립시키고 잔여포인트 더해준다.
					balance += point.getGive();
				} else if(learnApp.getPaymentState().equals("4")){
					// 결제상태가 환불인 경우 포인트 사용
					balance = (balance - point.getGive() > 0) ? balance - point.getGive() : 0;
					
					point.setWithdraw(point.getGive());			// 적립 되는 포인트 만큼 사용으로 변경
					point.setGive(0);							// 적립은 0으로 변경
					point.setNote("[관리자]수강신청 결제변경 처리에 따른 포인트 삭제 - 사용처리");
				}
				
				point.setBalance(balance);
				
				// 포인트 적립 및 사용처리
				 learnAppDao.pointReg(point);
				 
				 result =	learnAppDao.learnAppReg(learnApp);
			}
		}
		
		return result;
	}
	
	public int learnAppIn(List<LearnAppVO> learnAppList) throws Exception {
		return learnAppDao.learnAppIn(learnAppList);
	}
	
	// 입과 정보 중복 조회
	public List<String> getLearnApp(LearnAppVO learnApp) throws Exception {
		return learnAppDao.getLearnApp(learnApp);
	}
	
	// 연수신청 선택 삭제
	public int learnAppSelectDel(List<LearnAppVO> learnAppList) throws Exception {
		return learnAppDao.learnAppSelectDel(learnAppList);
	}
	
	// 수강관리 리스트 조회
	public List<LearnAppVO> learnManList(LearnAppVO learnApp) throws Exception {
		return learnAppDao.learnManList(learnApp);
	}

	// 수강관리 리스트 총 갯수
	public int learnManTotalCnt(LearnAppVO learnApp) throws Exception {
		return learnAppDao.learnManTotalCnt(learnApp);
	}
	
	// 전체 챕터/세부페이지 조회(포팅)
	public List<ChapterVO> getChapPage(LearnAppVO learnApp) throws Exception {
		return learnAppDao.getChapPage(learnApp);
	}
	// 전체 챕터/세부페이지 조회(링크)
		public List<ChapterVO> getChapPage2(LearnAppVO learnApp) throws Exception {
			return learnAppDao.getChapPage2(learnApp);
		}
	//수강이력정보 생성
	public void insertAttLec(List<ChapterVO> chapList, LearnAppVO learnAppVO) throws Exception {
		for(ChapterVO c: chapList) {
			HashMap<String, Object> param = new HashMap<String, Object>();
			param.put("learn_app_id", learnAppVO.getId());
			param.put("user_id", learnAppVO.getUser().getId());
			param.put("cardinal_id", learnAppVO.getCardinal().getId());
			param.put("course_id", learnAppVO.getCourse().getId());
			param.put("chapter", c.getId());
			param.put("chasi", c.getOrderNum());
			if(c.getMainUrl() == null) {
				for(SubChapVO s : c.getSubChapList()) {
					param.put("subchap", s.getSeq());
					learnAppDao.insertAttLec(param);
				}
			} else {
				param.put("subchap", 0);
				learnAppDao.insertAttLec(param);
			}
		}
			
	}
	// 수강이력 리스트
	public List<ChapterVO> attLecList(LearnAppVO learnApp) throws Exception {
		return learnAppDao.attLecList(learnApp);
	}
	
	// 수강변경관리 리스트 조회
	public List<LearnChangeVO> learnChangeList(LearnChangeVO learnChange) throws Exception {
		return learnAppDao.learnChangeList(learnChange);
	}

	// 수강변경관리 리스트 총 갯수
	public int learnChangeTotalCnt(LearnChangeVO learnChange) throws Exception {
		return learnAppDao.learnChangeTotalCnt(learnChange);
	}
	
	// 수강변경 처리
	public int learnChange(LearnChangeVO learnChange) throws Exception {
		int result = 0;
		
		if(learnChange != null && learnChange.getLearnApp() != null && learnChange.getLearnApp().getId() > 0) {
			LearnAppVO learnApp = learnChange.getLearnApp();
			
			learnApp.setUpdUser(learnChange.getUpdUser());
			
			result = learnAppDao.changeLearnApp(learnApp);
			
			if(result > 0) {
				learnAppDao.learnChange(learnChange);
			}
		}
		
		return result;
	}
	
	// 수강연기관리 리스트 조회
	public List<LearnDelayVO> learnDelayList(LearnDelayVO learnDelay) throws Exception {
		return learnAppDao.learnDelayList(learnDelay);
	}

	// 수강연기관리 리스트 총 갯수
	public int learnDelayTotalCnt(LearnDelayVO learnDelay) throws Exception {
		return learnAppDao.learnDelayTotalCnt(learnDelay);
	}
	
	// 수강연기 처리
	public int learnDelay(LearnDelayVO learnDelay) throws Exception {
		int result = 0;
		
		// 신청 정보가 존재하고 신청 ID가 존재해야 하며, 변경하려는 기수와 기수 ID 가 존재 해야 함.
		if( learnDelay != null && learnDelay.getLearnApp() != null && learnDelay.getLearnApp().getId() > 0
		 && learnDelay.getNewCardinal() != null && !StringUtil.isEmpty(learnDelay.getNewCardinal().getId()) ) {
			LearnAppVO learnApp = learnDelay.getLearnApp();
			
			learnApp.setCardinal(learnDelay.getNewCardinal());
			
			learnApp.setUpdUser(learnDelay.getUpdUser());
			
			result = learnAppDao.delayLearnApp(learnApp);
			
			if(result > 0) {
				learnAppDao.learnDelay(learnDelay);
			}
		}
		
		return result;
	}
	
	// 수강취소관리 리스트 조회
	public List<LearnCancelVO> learnCancelList(LearnCancelVO learnCancel) throws Exception {
		return learnAppDao.learnCancelList(learnCancel);
	}

	// 수강취소관리 리스트 총 갯수
	public int learnCancelTotalCnt(LearnCancelVO learnCancel) throws Exception {
		return learnAppDao.learnCancelTotalCnt(learnCancel);
	}
	
	// 수강취소 처리
	public int learnCancel(LearnCancelVO learnCancel) throws Exception {
		int result = 0;
		
		if(learnCancel != null && learnCancel.getLearnApp() != null && learnCancel.getLearnApp().getId() > 0) {
			LearnAppVO learnApp = learnCancel.getLearnApp();
			
			learnApp.setUpdUser(learnCancel.getUpdUser());
			
			result = learnAppDao.cancelLearnApp(learnApp);
			
			if(result > 0) {
				learnAppDao.learnCancel(learnCancel);
			}
		}
		
		return result;
	}
	
	// 수강이력 관리 조회
	public List<AttLecVO> attLecHistory(LearnAppVO learnApp) throws Exception {
		return learnAppDao.attLecHistory(learnApp);
	}
	
	// 튜터 첨삭이력 총 갯수
	public int activeTotalCnt(StatsVO stats) throws Exception {
		return learnAppDao.activeTotalCnt(stats);
	}
	
	// 튜터 첨삭이력 리스트
	public List<Map<String,String>> activeList(StatsVO stats) throws Exception {
		return learnAppDao.activeList(stats);
	}
	//연수확인서 확인용 조회
	public HashMap<String, Object> learnAppInfoForCertificate(LearnAppVO learnApp) throws Exception{
		return learnAppDao.learnAppInfoForCertificate(learnApp);
	}
	// 실 납입금액 가져오기 
	public String selectUsedPoint(LearnAppVO learnApp) throws Exception {		
		String result= learnAppDao.selectUsedPoint(learnApp);		
		return result;
	}

	public EduUserRefundVO getRefundInfo(String pay_user_seq) {
		return learnAppDao.getRefundInfo(pay_user_seq);
	}
	
	public EduUserPayVO getEduUserPayInfo(String pay_user_seq) {
		return learnAppDao.getEduUserPayInfo(pay_user_seq);
	}
	
	public int payRefundReg(HashMap<String, Object> map) {
		return learnAppDao.payRefundReg(map);
	}
	 
}