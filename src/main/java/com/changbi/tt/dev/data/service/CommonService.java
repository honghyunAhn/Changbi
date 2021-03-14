package com.changbi.tt.dev.data.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.changbi.tt.dev.data.dao.CommonDAO;

import forFaith.domain.SendData;

@Service(value="data.commonService")
public class CommonService {

	@Autowired
	private CommonDAO commonDao;
	
	// SMS HISTORY 저장
	public void smsHistory(SendData sendData) throws Exception {
		commonDao.smsHistory(sendData);
	}
}