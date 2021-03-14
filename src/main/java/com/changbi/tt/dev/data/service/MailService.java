package com.changbi.tt.dev.data.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.MailSender;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

import com.changbi.tt.dev.data.dao.MailDAO;
import com.changbi.tt.dev.data.vo.MailVO;
import com.changbi.tt.dev.data.vo.SmsVO;
import com.gargoylesoftware.htmlunit.javascript.host.Console;

import forFaith.dev.util.LoginHelper;
import forFaith.dev.vo.MemberVO;

/**
 * mail.properties 내용
-----------------------------
transport.protocol=smtp
smtp.user=searpier
smtp.host=smtp.gmail.com
smtp.port=587
smtp.starttls.enable=true
smtp.socketFactory.class=javax.net.ssl.SSLSocketFactory
smtp.auth=true
admin.username=searpier
admin.password=wjstkdtntkdtn0
---------------------------------
 */
@Component
public class MailService {
	
	@Autowired
	private MailDAO mailDao;
	
	private Authenticator authenticator;
	
	//mail.properties 의 세팅값으로 전송된다.
	@Value("#{mail['smtp.user']}")
	private String from="searpier";

	@Value("#{mail['transport.protocol']}")
	private String protocol="smtp";

	@Value("#{mail['smtp.host']}")
	private String host="smtp.gmail.com";

	@Value("#{mail['smtp.port']}")
	private String port="587";

	@Value("#{mail['smtp.starttls.enable']}")
	private String tls="true";

	@Value("#{mail['smtp.socketFactory.class']}")
	private String ssl="javax.net.ssl.SSLSocketFactory";

	@Value("#{mail['smtp.auth']}")
	private String auth="true";

	@Value("#{mail['admin.username']}")
	private String username="searpier@gmail.com";

	@Value("#{mail['admin.password']}")
	private String password="wjstkdtntkdtn0";

	private Properties props_mailing;
	
	/**
	 * @Method 설명 : 메일 보낼 때 사용하는 프로퍼티들을 준비한다
	 */
	private void prepareProperties() {
		if (props_mailing != null) {
			return;
		}
		props_mailing = new Properties();

		// 프로토콜 설정
		props_mailing.setProperty("mail.transport.protocol", protocol);

		// SMTP 서비스 주소(호스트)
		props_mailing.setProperty("mail.smtp.host", host);

		// SMTP 서비스 포트 설정
		props_mailing.setProperty("mail.smtp.port", port);

		// 로그인 할때 Transport Layer Security(TLS) 설정
		props_mailing.setProperty("mail.smtp.starttls.enable", tls);

		// Secure Socket Layer(SSL) 설정
		props_mailing.setProperty("mail.smtp.socketFactory.class", ssl);

		// SMTP 인증을 설정
		props_mailing.setProperty("mail.smtp.auth", auth);

		// 유저 설정
		props_mailing.setProperty("mail.smtp.user", from);
	}
	private void prepareAuthenticator() {
		if (authenticator != null) {
			return;
		}

		authenticator = new Authenticator() {
			/**
			 * getPasswordAuthentication
			 */
			@Override
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(username, password);
			}
		};
	}
	public synchronized String sendMail(HashMap<String, Object> param) {
		
		// 값을 준비한다
		prepareProperties();
		prepareAuthenticator();
		
		//메일 세션을 가져온다
		Session mailSession = Session.getDefaultInstance(props_mailing,authenticator);
		
		// 메세지를 작성한다
		Message msg = new MimeMessage(mailSession);
		
		try {
			// 메시지를 세팅한다 -> setFrom은 mail.properties에서 세팅된 값으로 가기때문에 의미없지만 없으면 오류남
			// 보안상의 문제때문에 google도 보내는 주소를 변경하지 못하게 되었다(인증주소로 발송됨)
			msg.setFrom(new InternetAddress((String)param.get("from")));
			msg.setSubject((String)param.get("subject"));
			msg.setSentDate(new Date());
			
		} catch (Exception e) {
			return null;
		}
		
		String[] recipientsArr = ((String)param.get("to")).split(",");
		String[] nameArr = ((String)param.get("nm_list")).split(",");
		
		int failCnt = 0;
		int successCnt = 0;
		String msgTxt = (String)param.get("content");
		
		for(int i=0; i< recipientsArr.length; i++) {
			try {
				msg.setText(msgTxt.replace("%고객명%", nameArr[i]));
				msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(recipientsArr[i], false));
//				System.out.println(msg.toString());
				Transport.send(msg);
				successCnt ++;
			} catch(Exception e) {
				e.printStackTrace();
				failCnt++;
				continue;
			}
		}
		JSONObject result = new JSONObject();
		result.put("failCnt", failCnt);
		result.put("successCnt", successCnt);
		return result.toString();
	}
	
	public void insertMail(HashMap<String, Object> param) {
		MemberVO member = (MemberVO) LoginHelper.getLoginInfo();
		param.put("admin_id", member.getId());
		param.put("send_name", member.getName());
		
		mailDao.insertMail(param);
		int seq = (int)param.get("MAIL_SEQ");
		
		if(seq != 0) {
			String[] mailArr = ((String)param.get("to")).split(",");
			String[] nmArr = ((String)param.get("nm_list")).split(",");
			String[] idArr = ((String)param.get("id_list")).split(",");
			
			List<HashMap<String, Object>> list = new ArrayList<>();
			
			for(int i = 0; i < nmArr.length; i++) {
				HashMap<String, Object> map = new HashMap<>();
				map.put("mail_seq", seq);
				map.put("user_id", idArr[i]);
				map.put("user_nm", nmArr[i]);
				map.put("user_email", mailArr[i]);
				list.add(map);
			}
			
			mailDao.insertMailList(list);
		}
	}
	//전송 리스트 조회
	public List<MailVO> selectMailList(MailVO mail) {
		return mailDao.selectMailList(mail);
	}
	//mail_list 전체 개수
	public int mailListTotalCnt(MailVO mail) {
		return mailDao.mailListTotalCnt(mail);
	}
	//mail_list 명단 조회
	public MailVO mailDetail(int mail_seq) {
		MailVO list = mailDao.selectReceiverList(mail_seq);
		return list;
	}
}
