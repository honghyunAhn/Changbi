package forFaith.util.web;

import javax.servlet.http.HttpServletRequest;

import forFaith.util.StringUtil;

/**
 * @Class Name : WebCommon.java
 * @Description : 모바일 여부 및 useragent 값
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

public class WebCommon {

	public static boolean isMobile(HttpServletRequest request) {
		boolean isMobile = false;
		String userAgent = getUserAgent(request);

		if( StringUtil.isContain(userAgent, "lgtelecom")	|| StringUtil.isContain(userAgent, "android")	|| StringUtil.isContain(userAgent, "blackberry")
		 || StringUtil.isContain(userAgent, "iphone")		|| StringUtil.isContain(userAgent, "ipad")		|| StringUtil.isContain(userAgent, "ipod")
		 ||	StringUtil.isContain(userAgent, "samsung")		|| StringUtil.isContain(userAgent, "symbian")	|| StringUtil.isContain(userAgent, "sony")
		 || StringUtil.isContain(userAgent, "SHC-")		    || StringUtil.isContain(userAgent, "SPH-") ) {

			isMobile = true;
		}

		return isMobile;
	}

	public static String getUserAgent(HttpServletRequest request) {
		String userAgent = "";

		userAgent = request.getHeader("user-agent").toLowerCase();

		return userAgent;
	}
}
