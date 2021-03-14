package com.changbi.tt.dev.data.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.changbi.tt.dev.data.dao.PayDAO;
import com.changbi.tt.dev.data.vo.CalculateVO;
import com.changbi.tt.dev.data.vo.CardinalVO;
import com.changbi.tt.dev.data.vo.CouponVO;
import com.changbi.tt.dev.data.vo.CourseVO;
import com.changbi.tt.dev.data.vo.EduUserPayVO;
import com.changbi.tt.dev.data.vo.GroupLearnAppVO;
import com.changbi.tt.dev.data.vo.LearnAppVO;
import com.changbi.tt.dev.data.vo.PointVO;
import com.changbi.tt.dev.data.vo.UserVO;

import forFaith.util.DataList;

@Service(value="data.payService")
public class PayService {

	@Autowired
	private PayDAO payDao;
	
	public List<LearnAppVO> payListTest(LearnAppVO learnApp) {
		
		List<LearnAppVO> list = new ArrayList<>();
		List<HashMap<String, Object>> mapList = payDao.payListTest(learnApp);
		
		for(int i=0; i<mapList.size(); i++) {
			LearnAppVO vo = new LearnAppVO();
			HashMap<String, Object> map = mapList.get(i);			
			
			vo.setUser(new UserVO());
			vo.setCourse(new CourseVO());
			vo.setCardinal(new CardinalVO());
			vo.setEdu(new EduUserPayVO());
			
			String id = String.valueOf(map.get("ID"));
			int intId = Integer.parseInt(id);
			vo.setId(intId);
			vo.getUser().setId(String.valueOf(map.get("USER_ID")));
			vo.getUser().setName(String.valueOf(map.get("USER_NAME")));
			vo.setRegDate(String.valueOf(map.get("REG_DATE")));
			vo.getCourse().setId(String.valueOf(map.get("COURSE_ID")));
			vo.getCourse().setName(String.valueOf(map.get("COURSE_NAME")));
			vo.getCardinal().setId(String.valueOf(map.get("CARDINAL_ID")));
			vo.getCardinal().setName(String.valueOf(map.get("CARDINAL_NAME")));
			
			vo.setAdmin_add_yn(String.valueOf((map.get("ADMIN_ADD_YN") == null ? "" : map.get("ADMIN_ADD_YN"))));
			vo.getEdu().setPay_user_seq(String.valueOf((map.get("PAY_USER_SEQ") == null ? "" : map.get("PAY_USER_SEQ"))));
			vo.getEdu().setPay_ins_dt(String.valueOf(map.get("PAY_INS_DT") == null ? "" : map.get("PAY_INS_DT")));
			vo.getEdu().setPay_user_status(String.valueOf(map.get("PAY_USER_STATUS") == null ? "" : map.get("PAY_USER_STATUS")));
			vo.getEdu().setReal_pay_amount(String.valueOf(map.get("REAL_PAY_AMOUNT") == null ? "" : map.get("REAL_PAY_AMOUNT")));
			vo.getEdu().setDis_point(String.valueOf(map.get("DIS_POINT") == null ? "" : map.get("DIS_POINT")));
			vo.getEdu().setPay_crc_seq(String.valueOf(map.get("PAY_CRC_SEQ") == null ? "" : map.get("PAY_CRC_SEQ")));
			vo.getEdu().setPay_crc_amount(String.valueOf(map.get("PAY_CRC_AMOUNT") == null ? "" : map.get("PAY_CRC_AMOUNT")));
			
			list.add(vo);
		}
		
		return list;
	}
	
	// 개별결제관리 리스트 조회
	public List<LearnAppVO> individualPayList(LearnAppVO learnApp) throws Exception {
		return payDao.individualPayList(learnApp);
	}
	
	// 개별결제관리 리스트 총 갯수
	public int individualPayTotalCnt(LearnAppVO learnApp) throws Exception {
		return payDao.individualPayTotalCnt(learnApp);
	}
	
	// 단체결제관리 리스트 조회
	public List<GroupLearnAppVO> groupPayList(GroupLearnAppVO groupLearnApp) throws Exception {
		return payDao.groupPayList(groupLearnApp);
	}
	
	// 단체결제관리 리스트 총 갯수
	public int groupPayTotalCnt(GroupLearnAppVO groupLearnApp) throws Exception {
		return payDao.groupPayTotalCnt(groupLearnApp);
	}
	
	// 단테결제 처리
	public int groupPayEdit(List<GroupLearnAppVO> groupLearnAppList) throws Exception {
		
		int i = 0;
		
		for (GroupLearnAppVO groupLearnApp : groupLearnAppList) {
			payDao.groupPayEdit(groupLearnApp);
			i++;
		}
		
		return i;
	}
	
	// 정산관리 리스트 조회
	public List<CalculateVO> calculateList(CalculateVO calculate) throws Exception {
		return payDao.calculateList(calculate);
	}
	
	// 정산관리 리스트 총 갯수
	public int calculateTotalCnt(CalculateVO calculate) throws Exception {
		return payDao.calculateTotalCnt(calculate); 
	}
	
	// 포인트관리 리스트 조회
	public List<PointVO> pointList(PointVO point) throws Exception {
		return payDao.pointList(point);
	}
	
	// 포인트관리 리스트 총 갯수
	public int pointTotalCnt(PointVO point) throws Exception {
		return payDao.pointTotalCnt(point);
	}	
	
	// 포인트 등록
	public void pointReg(PointVO point) throws Exception {
		payDao.pointReg(point);
	}
	
	// 쿠폰관리 리스트 조회
	public List<CouponVO> couponList(CouponVO coupon) throws Exception {
		return payDao.couponList(coupon);
	}
	
	// 쿠폰관리 리스트 총 갯수
	public int couponTotalCnt(CouponVO coupon) throws Exception {
		return payDao.couponTotalCnt(coupon);
	}
	
	// 쿠폰 등록 (사용자 매핑)
	public void couponReg(CouponVO coupon) throws Exception {
		payDao.couponReg(coupon);
	}
	
	// 쿠폰 등록 (쿠폰만 발행, 유저ID 매핑 되지 않음)
	public void couponOnlyReg(CouponVO coupon) throws Exception {
		payDao.couponOnlyReg(coupon);
	}
	
	// 쿠폰 삭제
	public int couponDel(CouponVO coupon) throws Exception {
		return payDao.couponDel(coupon);
	}

	//결제관리 리스트(모집홍보DB연결) count
	public int payTotalCnt(LearnAppVO learnApp) throws Exception {
		return payDao.payTotalCnt(learnApp);
	}

	//결제관리 리스트(모집홍보DB연결) 조회
	public List<LearnAppVO> payList(LearnAppVO learnApp) throws Exception {
		return payDao.payList(learnApp);
	}

 

	
}