package com.changbi.tt.dev.data.dao;

import java.util.List;

import com.changbi.tt.dev.data.vo.ToeflPayVO;
import com.changbi.tt.dev.data.vo.ToeflVO;

public interface ToeflDAO {

	//모의토플 리스트
	public List<ToeflVO> selectToeflList(ToeflVO vo);
	
	//모의토플 리스트 총 개수(paging용)
	public int toeflListTotalCnt(ToeflVO vo);
	
	//모의토플 등록
	public int insertToefl(ToeflVO vo);
	
	//모의토플 삭제
	public int deleteToefl(ToeflVO vo);
	
	//모의토플 결제 리스트
	public List<ToeflPayVO> selectToeflPayList(ToeflPayVO vo);
	
	//모의토플 결제 리스트 총 개수(paging용)
	public int toeflPayListTotalCnt(ToeflPayVO vo);
	
	// 모의토플 결제 환불 조회 
	public ToeflPayVO selectToeflRefund(ToeflPayVO vo);
	
	// 모의토플 환불 정보 수정
	public int updateToeflRefund(ToeflPayVO vo);
	
	// 모의토플 결제 정보 수정
	public int updateToeflPay(ToeflPayVO vo);
}
