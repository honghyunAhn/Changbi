package forFaith.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import forFaith.dev.vo.MemberVO;

public class GradeInterceptor extends HandlerInterceptorAdapter{
	
	private static final Logger logger = LoggerFactory.getLogger(GradeInterceptor.class);
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		logger.debug("접근제어 interceptor : " + request.getRequestURI() + " ? " + request.getQueryString());
		MemberVO member = (MemberVO) request.getSession().getAttribute("loginUser");
		if(!(member.getGrade() == 9 || member.getGrade() == 8)) {
			response.sendRedirect("/forFaith/base/main");
			
			return false;
		}
		
		return true;
	}
}
