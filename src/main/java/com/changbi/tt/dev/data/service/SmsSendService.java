package com.changbi.tt.dev.data.service;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.nio.charset.Charset;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.ContentType;
import org.apache.http.entity.mime.HttpMultipartMode;
import org.apache.http.entity.mime.MultipartEntityBuilder;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.changbi.tt.dev.data.dao.SmsDAO;
import com.changbi.tt.dev.data.vo.SmsVO;

import forFaith.dev.util.LoginHelper;
import forFaith.dev.vo.MemberVO;

@Service(value="data.smsSendService")
public class SmsSendService {
	
	@Autowired
	private SmsDAO smsDao;

	private static final Logger logger = LoggerFactory.getLogger(SmsSendService.class);
	
	private final String encodingType = "utf-8";
	private final String boundary = "____boundary____";
	
	//인증정보 세팅
	private Map<String, Object> setCertification() {
		Map<String, Object> sms = new HashMap<String, Object>();
		
		sms.put("user_id", "sesoc"); // SMS 아이디
		sms.put("key", "t7s6tjxaeq5ylbznoe0pp6vxaycnfpwy"); //인증키
		
		return sms;
	}
	
	//전송내용 세팅(일반 SMS/MMS용)
	private Map<String, Object> setContentForSMS(HashMap<String, Object> param, Map<String, Object> sms) {
		/*sms.put("msg", (String)param.get("msg")); // 메세지 내용
		sms.put("receiver", (String)param.get("receiver")); // 수신번호
		sms.put("destination", (String)param.get("destination")); // 수신인 %고객명% 치환 */

		for(int i = 1; i <= Integer.parseInt(String.valueOf(param.get("cnt"))); i++) {
			sms.put("msg_" + i, param.get("msg_" + i));
			sms.put("rec_" + i, param.get("rec_" + i));
		}
		sms.put("cnt", param.get("cnt")); 
		sms.put("msg_type", param.get("msg_type"));
		sms.put("sender", "0260005394"); // 발신번호
		
		if (!((String)param.get("rdate")).equals("") && !((String)param.get("rtime")).equals("")) {
			sms.put("rdate", (String)param.get("rdate")); // 예약일자 - 20161004 : 2016-10-04일기준
			sms.put("rtime", (String)param.get("rtime")); // 예약시간 - 1930 : 오후 7시30분
		}
		
		sms.put("title", (String)param.get("title")); // LMS, MMS 제목 (미입력시 본문중 44Byte 또는 엔터 구분자 첫라인)
		
		// TEST할 때 사용하는 코드
//		sms.put("testmode_yn", "Y"); // Y 인경우 실제문자 전송X , 자동취소(환불) 처리
		
		logger.debug("sms.toString() : " + sms.toString());
		
		return sms;
	}
	//전송내용 세팅(SMS 전송결과 조회용)
	private Map<String, Object> setContentForHistory(HashMap<String, Object> param, Map<String, Object> sms) {
		sms.put("page", param.get("page"));
		sms.put("page_size", param.get("page_size"));
		sms.put("start_date", (String)param.get("start_date"));
		sms.put("limit_day", param.get("limit_day"));
		
		logger.debug("sms.toString() : " + sms.toString());
		
		return sms;
	}
	//상세내역 조회용 내용 세팅
	private Map<String, Object> setContentForDetail(HashMap<String, Object> param, Map<String, Object> sms) {
		sms.put("page", param.get("page"));
		sms.put("page_size", param.get("page_size"));
		sms.put("mid", param.get("mid"));
		
		logger.debug("sms.toString() : " + sms.toString());
		
		return sms;
	}
	//전송처리
	private HttpResponse transmit(Map<String, Object> sms, String url) throws ClientProtocolException, IOException {
		MultipartEntityBuilder builder = MultipartEntityBuilder.create();
		
		builder.setBoundary(boundary);
		builder.setMode(HttpMultipartMode.BROWSER_COMPATIBLE);
		builder.setCharset(Charset.forName(encodingType));
		
		for(Iterator<String> i = sms.keySet().iterator(); i.hasNext();){
			String key = i.next();
			builder.addTextBody(key, (String)sms.get(key)
					, ContentType.create("Multipart/related", encodingType));
		}
		
		HttpEntity entity = builder.build();
		
		HttpClient client = HttpClients.createDefault();
		HttpPost post = new HttpPost(url);
		post.setEntity(entity);
		
		HttpResponse res = client.execute(post);
		
		return res;
	}
	
	//sms 발송(sms/mms 자동변환)
	public String send_sms(HashMap<String, Object> param) {
		
		String sms_url = "https://apis.aligo.in/send_mass/"; // 전송요청 URL
		
		String responseStr = "";
		
		try {
			//API인증정보
			Map<String, Object> sms = setCertification();
			//전송 내용 세팅
			sms = setContentForSMS(param, sms);
			//전송결과
			HttpResponse res = transmit(sms, sms_url);
			
			/**************** 문자전송결과 예제 ******************/
			/* "result_code":결과코드,"message":결과문구, */
			/* "msg_id":메세지ID,"error_cnt":에러갯수,"success_cnt":성공갯수 */
			if(res != null){
				
				BufferedReader in = new BufferedReader(new InputStreamReader(res.getEntity().getContent(), encodingType));
				String buffer = null;
				
				while((buffer = in.readLine())!=null) responseStr += buffer;
				
				in.close();
			}
		} catch(Exception e){
			responseStr = e.getMessage();
		}
		
		return responseStr;
	}
	
	//전송내역 조회 api 요청 메소드
	public String smsHistory(HashMap<String, Object> param) {
		
		String smsList_url = "https://apis.aligo.in/list/";
		String responseStr = "";
		try {
			//API인증정보
			Map<String, Object> sms = setCertification();
			//전송 내용 세팅
			sms = setContentForHistory(param, sms);
			//전송결과
			HttpResponse res = transmit(sms, smsList_url);
			responseStr = EntityUtils.toString(res.getEntity());
			
		} catch (Exception e) {
			responseStr = e.getMessage();
		}
		return responseStr;
	}
	
	//전송내역 상세조회 api 요청 메소드
	public String smsDetail(HashMap<String, Object> param) {
		String smsList_url = "https://apis.aligo.in/sms_list/";
		String responseStr = "";
		
		try {
			//API인증정보
			Map<String, Object> sms = setCertification();
			//전송 내용 세팅
			sms = setContentForDetail(param, sms);
			//전송결과
			HttpResponse res = transmit(sms, smsList_url);
			responseStr = EntityUtils.toString(res.getEntity());
			
		} catch (Exception e) {
			responseStr = e.getMessage();
		}
		return responseStr;
	}
	//전송내용 db에 저장
	public int insertSms(HashMap<String, Object> param) {
		MemberVO member = (MemberVO) LoginHelper.getLoginInfo(); 
		param.put("admin_id", member.getId());
		param.put("send_num", "0260005394");
		param.put("send_name", member.getName());
		return smsDao.insertSms(param);
	}
	//전송 리스트 조회
	public List<SmsVO> selectSmsList(SmsVO sms) {
		return smsDao.selectSmsList(sms);
	}
	//smslist 전체 개수
	public int smsListTotalCnt(SmsVO sms) {
		return smsDao.smsListTotalCnt(sms);
	}
}
