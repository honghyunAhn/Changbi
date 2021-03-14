package com.changbi.tt.dev.data.dao;

import java.util.HashMap;
import java.util.List;

import com.changbi.tt.dev.data.vo.CalculateVO;
import com.changbi.tt.dev.data.vo.CouponVO;
import com.changbi.tt.dev.data.vo.EduUserPayVO;
import com.changbi.tt.dev.data.vo.GroupLearnAppVO;
import com.changbi.tt.dev.data.vo.LearnAppVO;
import com.changbi.tt.dev.data.vo.PointVO;

import forFaith.util.DataList;

public interface PayDAO {
	
	List<HashMap<String, Object>> payListTest(LearnAppVO learnApp);

	// 개별결제관리 리스트 조회
	List<LearnAppVO> individualPayList(LearnAppVO learnApp) throws Exception;
	
	// 개별결제관리 리스트 총 갯수
	int individualPayTotalCnt(LearnAppVO learnApp) throws Exception;

	// 단체결제관리 리스트 조회
	List<GroupLearnAppVO> groupPayList(GroupLearnAppVO groupLearnApp) throws Exception;
	
	// 단체결제관리 리스트 총 갯수
	int groupPayTotalCnt(GroupLearnAppVO groupLearnApp) throws Exception;
	
	// 단체결제 결제처리
	int groupPayEdit(GroupLearnAppVO groupLearnApp) throws Exception;
	
	// 정산관리 리스트 조회
	List<CalculateVO> calculateList(CalculateVO calculate) throws Exception;
	
	// 정산관리 리스트 총 갯수
	int calculateTotalCnt(CalculateVO calculate) throws Exception;
	
	// 포인트관리 리스트 조회
	List<PointVO> pointList(PointVO pointVO) throws Exception;
	
	// 포인트관리 리스트 총 갯수
	int pointTotalCnt(PointVO pointVO) throws Exception;
	
	// 포인트등록
	void pointReg(PointVO pointVO) throws Exception;
	
	// 쿠폰관리 리스트 조회
	List<CouponVO> couponList(CouponVO coupon) throws Exception;
	
	// 쿠폰관리 리스트 총 갯수
	int couponTotalCnt(CouponVO coupon) throws Exception;
	
	// 쿠폰등록 (사용자 매핑)
	void couponReg(CouponVO coupon) throws Exception;

	// 쿠폰 등록 (쿠폰만 발행, 유저ID 매핑 되지 않음)
	void couponOnlyReg(CouponVO coupon) throws Exception;
	
	// 쿠폰 삭제
	int couponDel(CouponVO coupon) throws Exception;

	//결제관리 리스트(모집홍보DB연결) count
	int payTotalCnt(LearnAppVO learnApp) throws Exception;

	//결제관리 리스트(모집홍보DB연결) 조회
	List<LearnAppVO> payList(LearnAppVO learnApp) throws Exception;
}