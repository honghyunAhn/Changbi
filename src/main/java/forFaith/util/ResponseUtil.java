package forFaith.util;

import java.io.PrintWriter;
import java.util.StringTokenizer;

import javax.servlet.http.HttpServletResponse;

import org.springframework.util.StringUtils;

/**
 * @Class Name : ResponseUtil.java
 * @Description : 응답데이터 유틸
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

public class ResponseUtil {
	public static String forward(String url) {
		return "forward:/common/forward.do";
	}

	private static String xml = "<?xml version='1.0' encoding='utf-8'?><response>"
			+"<command>${command}</command>"
			+"<error>${error}</error>"
			+"<error_message><![CDATA[${message}]]></error_message>"
			+"<result><![CDATA[${result}]]></result>"
			+"</response>";

	public static void sendAjaxXmlResponse(HttpServletResponse res, String command
		, String error, String msg, String result) throws Exception {
		String response = xml;

		response = StringUtils.replace(response,"${command}", command);
		response = StringUtils.replace(response,"${error}", error);
		response = StringUtils.replace(response,"${message}", str2alert(msg));
		response = StringUtils.replace(response,"${result}", result);

		res.setContentType("text/xml; charset=utf-8");
		PrintWriter out = res.getWriter();
		out.println(response);
		out.flush();
	}

	public static void sendAjaxXmlResponse(HttpServletResponse res, String command, String result) throws Exception {
		sendAjaxXmlResponse(res, command,"0","",result);
	}

	public static void sendAjaxXmlErrorResponse(HttpServletResponse res, String command, String msg) throws Exception {
		sendAjaxXmlResponse(res, command,"1",msg,"");
	}

	public static void sendAjaxTextResponse(HttpServletResponse res, String msg) throws Exception {
		res.setContentType("text/plain; charset=utf-8");
		PrintWriter out = res.getWriter();
		out.println(msg);
		out.flush();
	}

	public static void htmlAlertPrint(HttpServletResponse res, String message) throws Exception {
		htmlAlertPrint(res, message, null);
	}

	public static void htmlAlertPrint(HttpServletResponse res, String message, String url)
			throws Exception {
		res.setContentType("text/html; charset=utf-8");
		PrintWriter out = res.getWriter();
		if (message == null) message = "";
		if (message.length() > 100) {
			StringTokenizer tokenMessage = new StringTokenizer(message, "\n");
			message = tokenMessage.nextToken();
		}
		message = str2alert(message);
		out.println("<body style='background-color:#F2F2F2'><script type='text/javascript'>");
		out.println("alert('" + message + "');");
		if (url == null || url.isEmpty()) out.println("history.back();");
		else out.println("location.href = '"+url+"'");
		out.println("</script></body>");
		out.flush();
	}

	public static void htmlScriptPrint(HttpServletResponse res, String script)
			throws Exception {
		res.setContentType("text/html; charset=utf-8");
		PrintWriter out = res.getWriter();
		out.println("<body style='background-color:#F2F2F2'><script type='text/javascript'>");
		out.println(script);
		out.println("</script></body>");
		out.flush();
	}

	public static String str2alert(String s) {
		if (s == null) {
			return null;
		}
		String str = s.replaceAll("<br>", "\n").replaceAll("<br\\s*/>", "\n");
		StringBuffer buf = new StringBuffer();
		char[] c = str.toCharArray();
		int len = c.length;
		for (int i = 0; i < len; i++) {
			if (c[i] == '\n') {
				buf.append("\\n");
			} else if (c[i] == '\t') {
				buf.append("\\t");
			} else if (c[i] == '"') {
				buf.append(" ");
			} else if (c[i] == '\'') {
				buf.append("\\'");
			} else if (c[i] == '\r') {
				buf.append("\\r");
			} else {
				buf.append(c[i]);
			}
		}

		return buf.toString();
	}
}
