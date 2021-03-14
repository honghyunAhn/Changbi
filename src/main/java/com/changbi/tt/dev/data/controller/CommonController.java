/**
 * Common Controller
 * @author : kjs(2016-10-10)
 */

package com.changbi.tt.dev.data.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.nio.charset.Charset;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.ContentType;
import org.apache.http.entity.mime.HttpMultipartMode;
import org.apache.http.entity.mime.MultipartEntityBuilder;
import org.apache.http.impl.client.HttpClients;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.changbi.tt.dev.data.service.CommonService;
import com.changbi.tt.dev.data.service.SmsSendService;
import com.changbi.tt.dev.data.vo.SmsVO;

import forFaith.dev.util.LoginHelper;
import forFaith.dev.vo.MemberVO;
import forFaith.domain.SendData;
import forFaith.util.EmailSender;
import forFaith.util.StringUtil;

@Controller(value="data.commonController")		// Controller value는 중복되면 안된다. value 값을 지정하지 않으면 클래스명이 value가 되므로 같은 클래스명이 존재하면 중복으로 인식
@RequestMapping("/data/common")					// 해당 클래스를 호출 하기 위한 Mapping 기본 값 뒤에 붙는 값에 의해 필요한 함수가 호출 된다.
public class CommonController {

	@Autowired
	private EmailSender emailSender;

	@Autowired
	private SmsSendService smsSendService;
	
	@Autowired
	private CommonService commonService;

	@Resource(name = "messageSource")
	private MessageSource messageSource;


	@Value("#{config['Globals.Sms.SendNum']}")
	String smsCallbackNum;

	/**
	 * log를 남기는 객체 생성
	 * @author : 김준석(2016-10-10)
	 */
	private static final Logger logger = LoggerFactory.getLogger(CommonController.class);

	/**
	 * 답변저장 후 데이터 전송(한번에 전송받는다) - ajax용
	 * @param springFileUpload
	 * @param session
	 * @return AttachFileVO
	 * @throws IOException
	 */
	@RequestMapping(value = "/sendMail", method = RequestMethod.POST)
	public @ResponseBody int sendMail(SendData sendData) throws Exception {
		logger.info("email ===> "+sendData.getReceiver());

		int result = 0;

		// 로그인 된 정보
		// MemberVO loginUser = (MemberVO)LoginHelper.getLoginInfo();

		// 이메일 발송
		if(!StringUtil.isEmpty(sendData.getReceiver())) {
			// 메일 제목 세팅
			// subject = messageSource.getMessage("reply.mail.subject", null, Locale.getDefault());

			// 메일 내용 세팅
			// content.append(messageSource.getMessage("reply.mail.content", null, Locale.getDefault()));

			// 메일 발송
			try {
				emailSender.sendEmail(sendData);
				result = 1;
			} catch(Exception ex) {}
		}

		return result;
	}

	/*@RequestMapping(value = "/sendSms", method = RequestMethod.POST)
	public @ResponseBody int sendSms(SendData sendData) throws Exception {
		logger.info("phone ===> "+sendData.getReceiver());
		
		int result = 0;

		// 메일 발송
		try {
			SmsVO smsVO = new SmsVO();
			
			smsVO.setMsg(sendData.getContent());
			smsVO.setPhone(sendData.getReceiver());
			smsVO.setCallback(smsCallbackNum);
			
			boolean sent = smsSendService.sendSms(smsVO);
			
			result = sent ? 1 : 0;
		} catch(Exception ex) {
			logger.error("sms send failed: ", ex);
		}

		return result;
	}*/
	
	/**
	 * sms 발신 
	 * @author : 김신원
	 */
	@ResponseBody
	 @RequestMapping(value ="/sendSms" , method = RequestMethod.POST)
	 public Object send_sms(
	   @RequestParam(defaultValue = "") String receiver,
	   @RequestParam(defaultValue = "") String destination,
	   @RequestParam(defaultValue = "") String msg,
	   @RequestParam(defaultValue = "") String title,
	   @RequestParam(defaultValue = "") String rdate,
	   @RequestParam(defaultValue = "") String rtime) {
	  logger.debug("특정 기수 지원자들 대상 문자발송 컨트롤러 시작");
	  
	  String responseStr = "";
	  
	  try{

	   final String encodingType = "utf-8";
	   final String boundary = "____boundary____";
	  
	   //******************** 인증정보 ********************//
	   String sms_url = "https://apis.aligo.in/send/"; // 전송요청 URL
	   
	   Map<String, String> sms = new HashMap<String, String>();
	   
	   sms.put("user_id", "sesoc"); // SMS 아이디
	   sms.put("key", "t7s6tjxaeq5ylbznoe0pp6vxaycnfpwy"); //인증키
	   //******************** 인증정보 ********************//
	   
	   //******************** 전송정보 ********************//
	   sms.put("msg", msg); // 메세지 내용
	   sms.put("receiver", "01077227421"); // 수신번호
	   sms.put("destination", receiver); // 수신인 %고객명% 치환
	   sms.put("sender", "0260005394"); // 발신번호
		
		// 문자예약
	   /*if (!rdate.isEmpty() && !rtime.isEmpty()) {
	    sms.put("rdate", rdate); // 예약일자 - 20161004 : 2016-10-04일기준
	    sms.put("rtime", rtime); // 예약시간 - 1930 : 오후 7시30분
	   }*/
	   
	   if (!title.isEmpty()) {
	    sms.put("title", title); // LMS, MMS 제목 (미입력시 본문중 44Byte 또는 엔터 구분자 첫라인)
	   }
	   
	   // TEST할 때 사용하는 코드
	   sms.put("testmode_yn", "Y"); // Y 인경우 실제문자 전송X , 자동취소(환불) 처리
	   System.out.println("sms.toString() : " + sms.toString());
	   //******************** 전송정보 ********************//

	   //******************** 전송처리 ********************//
	   MultipartEntityBuilder builder = MultipartEntityBuilder.create();
	   
	   builder.setBoundary(boundary);
	   builder.setMode(HttpMultipartMode.BROWSER_COMPATIBLE);
	   builder.setCharset(Charset.forName(encodingType));
	   
	   for(Iterator<String> i = sms.keySet().iterator(); i.hasNext();){
	    String key = i.next();
	    builder.addTextBody(key, sms.get(key)
	      , ContentType.create("Multipart/related", encodingType));
	   }
	   
	   HttpEntity entity = builder.build();
	   
	   HttpClient client = HttpClients.createDefault();
	   HttpPost post = new HttpPost(sms_url);
	   post.setEntity(entity);
	   
	   HttpResponse res = client.execute(post);
	   System.out.println("res.toString() : " + res.toString());
	   //******************** 전송처리 ********************//

	   //**************** 문자전송결과 예제 ******************//
	   /* "result_code":결과코드,"message":결과문구, 
	    "msg_id":메세지ID,"error_cnt":에러갯수,"success_cnt":성공갯수 */
	   if(res != null){
	    BufferedReader in = new BufferedReader(new InputStreamReader(res.getEntity().getContent(), encodingType));
	    String buffer = null;
	    while((buffer = in.readLine())!=null){
	     responseStr += buffer;
	    }
	    System.out.println("1111111111111111111111111111111111111111111111111111111111111111111111111111111");
	    System.out.println(responseStr);
	    in.close();
	   }
	//   System.out.println("responseStr : " + responseStr);
	   
	   // TODO: 차후 DB에 SMS Data 저장하기 위한 예비소스
	//   JSONParser parser = new JSONParser();
	//   Object obj = parser.parse(responseStr);
	//   JSONObject jsonObj = (JSONObject)obj;
	//
	//   String result_code = (String) jsonObj.get("result_code");
	//   String message = (String) jsonObj.get("message");
	//   System.out.println("result_code" + result_code);
	//   System.out.println("success_cnt" + (String) jsonObj.get("success_cnt"));
	//   System.out.println("error_cnt" + (String) jsonObj.get("error_cnt"));
	//   System.out.println("message" + message);
	  }catch(Exception e){
	   responseStr = e.getMessage();
	   System.out.println("222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222");
	    System.out.println(responseStr);
	   
	  }
	  
	  logger.debug("특정 기수 지원자들 대상 문자발송 컨트롤러 종료");
	  return responseStr;
	 }

	
	
	@RequestMapping(value = "/smsHistory", method = RequestMethod.POST)
	public @ResponseBody void smsHistory(SendData sendData ,
			 @RequestParam(defaultValue = "") String receiver,
			   @RequestParam(defaultValue = "") String destination,
			   @RequestParam(defaultValue = "") String msg,
			   @RequestParam(defaultValue = "") String title,
			   @RequestParam(defaultValue = "") String userId,
			   @RequestParam(defaultValue = "") String rdate,
			   @RequestParam(defaultValue = "") String rtime) throws Exception {
		MemberVO loginUser = (MemberVO)LoginHelper.getLoginInfo();
		
		sendData.setSubject(title);  
		sendData.setContent(msg);
		sendData.setUserId(userId);
		sendData.setReceiver(receiver); 
		sendData.setRegId(loginUser.getId());
		
		commonService.smsHistory(sendData);
	}
}
