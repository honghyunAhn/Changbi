package forFaith.util;

import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Component;

import forFaith.domain.SendData;

/**
 * @Class Name : EmailSender.java
 * @Description : 메일 발송용
 * @Modification Information
 * @
 * @  수정일                 수정자                       수정내용
 * @ -------    --------    ---------------------------
 * @ 2017.03.21   김준석                      최초 생성
 *
 *  @author kjs
 *  @since 2017.03.21
 *  @version 1.0
 *  @see
 *
 */

@Component
public class EmailSender {
	@Autowired
    protected JavaMailSender mailSender;

	@Value("#{config['Globals.Mail.UserName']}")
	String mailFromUser;

    public void sendEmail(SendData email) throws Exception {
        MimeMessage msg = mailSender.createMimeMessage();
        MimeMessageHelper helper = new MimeMessageHelper(msg);

        helper.setFrom(this.mailFromUser);
        helper.setTo(email.getReceiver());
        helper.setSubject(email.getSubject());
        helper.setText(email.getContent());

        mailSender.send(msg);
    }
}
