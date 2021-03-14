package forFaith.interceptor;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import forFaith.dev.util.GlobalMethod;
import forFaith.dev.util.LoginHelper;
import forFaith.util.StringUtil;

/**
 * @Class Name : LoginInterceptor.java
 * @Description : 페이지 요청 시 로그인 여부 체크 인터셉터
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

public class LoginInterceptor extends HandlerInterceptorAdapter {
	private static final Logger logger = LoggerFactory.getLogger(LoginInterceptor.class);

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		if(!LoginHelper.isAuth()) {
			logger.info("Login 화면으로 이동"+request.getRequestURI()+"?"+request.getQueryString());

			if(GlobalMethod.isAjax(request)) {
				// ajax로 호출 시 로그인 페이지를 다시 호출 해주기 위해 값을 세팅
				PrintWriter print = response.getWriter();
				print.write("ajaxLogin");
				print.flush();
				print.close();
			} else {
				// 세션에 저장하고 로그인 후 세션에서 삭제시
				String link = request.getRequestURI();
				link += StringUtil.isEmpty(request.getQueryString()) ? "" : "?"+request.getQueryString();
				
				request.getSession().setAttribute("link", link);
				response.sendRedirect("/forFaith/base/login");
			}
			
			return false;
		}

		return true;
	}
}
