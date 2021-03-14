package com.changbi.tt.dev.data.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.changbi.tt.dev.data.dao.CompleteDAO;
import com.changbi.tt.dev.data.vo.LearnAppVO;

@Service(value="data.completeService")
public class CompleteService {
	
	@Autowired
	private CompleteDAO completeDao;
	
	// 이수처리
	public void completeProc(LearnAppVO learnApp) throws Exception {
		// 프로시저 호출 후 ids 결과값을 받는다.
		completeDao.completeProc(learnApp);
	}
	
	// 이수처리 후 리스트 ids로 조회 함
	public List<LearnAppVO> completeProcList(LearnAppVO learnApp) throws Exception {
		return completeDao.completeProcList(learnApp);
	}

	// 이수현황 리스트
	public List<LearnAppVO> completeList(LearnAppVO learnApp) throws Exception {
		return completeDao.completeList(learnApp);
	}

	public List<LearnAppVO> completeListAll(HashMap<String, String> param) throws Exception {
		return completeDao.completeListAll(param);
	}

	public int updateCompleteList(HashMap<String, String> param) throws Exception {
		return completeDao.updateCompleteList(param);
	}

}