package com.changbi.tt.dev.data.dao;

import forFaith.domain.SendData;

public interface CommonDAO {

	// SMS HISTORY 저장
	void smsHistory(SendData sendData) throws Exception;
}