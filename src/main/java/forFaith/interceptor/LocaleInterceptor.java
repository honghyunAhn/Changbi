package forFaith.interceptor;

import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.LocaleResolver;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import forFaith.type.LangType;
import forFaith.util.StringUtil;

/**
 * @Class Name : LocaleInterceptor.java
 * @Description : locale 변경 인터셉터
 * @Modification Information
 * @
 * @  수정일                 수정자                       수정내용
 * @ -------    --------    ---------------------------
 * @ 2017.03.21   김준석                      최초 생성
 *
 *  @author kjs
 *  @since 2017.06.29
 *  @version 1.0
 *  @see
 *
 */

public class LocaleInterceptor extends HandlerInterceptorAdapter {
	private static final Logger logger = LoggerFactory.getLogger(LocaleInterceptor.class);
	
	@Autowired
	private LocaleResolver localeResolver;
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		String localeCode = request.getParameter("locale");
		Locale locale = null;
		
		logger.info("LocaleInterceptor start ==> "+localeCode);
		
		if(!StringUtil.isEmpty(localeCode)) {
			logger.info("Locale[필터전] = "+localeCode);

			// 로케일이 잘못된 입력인 경우 영어로 default
			localeCode = LangType.isExists(localeCode) ? localeCode : LangType.EN.getCode();
			
			logger.info("Locale[필터후] = "+localeCode);
			
			// 로케일 설정
			locale = new Locale(localeCode);
			
			// 쿠키 또는 세션의 로케일로 설정
			localeResolver.setLocale(request, response, locale);
		}
		
		// 쿠키에 저장이 되었거나. 아니면 default로 설정 된 언어를 request로 항상 세팅해둔다.
		request.setAttribute("localeLanguage", localeResolver.resolveLocale(request).getLanguage());

		return true;
	}
}
