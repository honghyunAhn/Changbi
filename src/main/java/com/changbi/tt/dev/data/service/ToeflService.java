package com.changbi.tt.dev.data.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.changbi.tt.dev.data.dao.ToeflDAO;
import com.changbi.tt.dev.data.vo.ToeflPayVO;
import com.changbi.tt.dev.data.vo.ToeflVO;

@Service(value="data.toeflService")
public class ToeflService {
	
	@Autowired
	private ToeflDAO dao;
	
	public List<ToeflVO> selectToeflList(ToeflVO vo) {
		return dao.selectToeflList(vo);
	}
	
	public int toeflListTotalCnt(ToeflVO vo) {
		return dao.toeflListTotalCnt(vo);
	}
	
	public int insertToefl(ToeflVO vo) {
		return dao.insertToefl(vo);
	}
	
	public int deleteToefl(List<ToeflVO> list) {
		int result = 0;
		for(ToeflVO vo : list) result += dao.deleteToefl(vo);
		return result;
	}
	
	public List<ToeflPayVO> selectToeflPayList(ToeflPayVO vo) {
		return dao.selectToeflPayList(vo);
	}
	
	public int toeflPayListTotalCnt(ToeflPayVO vo) {
		return dao.toeflPayListTotalCnt(vo);
	}
	
	public ToeflPayVO selectToeflRefund(ToeflPayVO vo) {
		return dao.selectToeflRefund(vo);
	}
	
	public boolean updateToeflRefund(ToeflPayVO vo) {
		int result = dao.updateToeflRefund(vo) + dao.updateToeflPay(vo);
		
		if(result < 1) {
			return false;
		} else {
			return true;
		}
	}
	
}
