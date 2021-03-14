package com.changbi.tt.dev.data.dao;

import java.util.HashMap;
import java.util.List;

import com.changbi.tt.dev.data.vo.MailVO;

public interface MailDAO {
	public int insertMail(HashMap<String, Object> param);
	public int insertMailList(List<HashMap<String, Object>> list);
	public List<MailVO> selectMailList(MailVO mail);
	public MailVO selectReceiverList(int mail_seq);
	public int mailListTotalCnt(MailVO mail);
}
