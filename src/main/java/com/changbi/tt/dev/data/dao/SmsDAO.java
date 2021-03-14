package com.changbi.tt.dev.data.dao;

import java.util.HashMap;
import java.util.List;

import com.changbi.tt.dev.data.vo.SmsVO;

public interface SmsDAO {
	public int insertSms(HashMap<String, Object> param);
	public List<SmsVO> selectSmsList(SmsVO sms);
	public int smsListTotalCnt(SmsVO sms);
}
