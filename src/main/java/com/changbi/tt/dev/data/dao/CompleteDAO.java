package com.changbi.tt.dev.data.dao;

import java.util.HashMap;
import java.util.List;

import com.changbi.tt.dev.data.vo.LearnAppVO;

public interface CompleteDAO {

	// 이수처리
	void completeProc(LearnAppVO learnApp) throws Exception;

	// 이수처리 후 리스트 ids로 조회 함
	List<LearnAppVO> completeProcList(LearnAppVO learnApp) throws Exception;

	// 이수현황 리스트
	List<LearnAppVO> completeList(LearnAppVO learnApp) throws Exception;
	
	List<LearnAppVO> completeListAll(HashMap<String, String> param) throws Exception;
	
	int updateCompleteList(HashMap<String, String> param) throws Exception;
}