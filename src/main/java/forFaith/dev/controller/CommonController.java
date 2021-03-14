package forFaith.dev.controller;

import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.MessageSource;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;

import com.changbi.tt.dev.data.vo.UserVO;

import forFaith.dev.util.GlobalConst;
import forFaith.exceptions.InvalidAccessException;
import forFaith.exceptions.UserMustLoginException;

public class CommonController {
	
	/**
     * log를 남기는 객체 생성
     * @author : 김준석(2016-10-10)
     */
    private static final Logger logger = LoggerFactory.getLogger(CommonController.class);

	protected String getIp(HttpServletRequest request) {
		 
        String ip = request.getHeader("X-Forwarded-For");
 
        logger.info(">>>> X-FORWARDED-FOR : " + ip);
 
        if (ip == null) {
            ip = request.getHeader("Proxy-Client-IP");
            logger.info(">>>> Proxy-Client-IP : " + ip);
        }
        if (ip == null) {
            ip = request.getHeader("WL-Proxy-Client-IP"); // 웹로직
            logger.info(">>>> WL-Proxy-Client-IP : " + ip);
        }
        if (ip == null) {
            ip = request.getHeader("HTTP_CLIENT_IP");
            logger.info(">>>> HTTP_CLIENT_IP : " + ip);
        }
        if (ip == null) {
            ip = request.getHeader("HTTP_X_FORWARDED_FOR");
            logger.info(">>>> HTTP_X_FORWARDED_FOR : " + ip);
        }
        if (ip == null) {
            ip = request.getRemoteAddr();
        }
        
        logger.info(">>>> Result : IP Address : "+ip);
 
        return ip;
    }

	protected String getMessage(MessageSource messageSource, String code) {
		return messageSource.getMessage(code, null, Locale.getDefault());
	}

	protected String getMessage(MessageSource messageSource, Object [] arguments, String code) {
		return messageSource.getMessage(code, arguments, Locale.getDefault());
	}

	protected HashMap<String, Object> getAjaxFailResult(String message) {
		HashMap<String, Object> result = new HashMap<String, Object>();
		result.put(GlobalConst.AJAX_RESPONSE_CODE, GlobalConst.TEXT_FAIL);
		result.put(GlobalConst.AJAX_RESPONSE_MESSAGE, message);
		return result;
	}

	protected HashMap<String, Object> getDefaultAjaxSuccessResult() {
		HashMap<String, Object> result = new HashMap<String, Object>();
		result.put(GlobalConst.AJAX_RESPONSE_CODE, GlobalConst.TEXT_SUCCESS);
		return result;
	}

	protected HashMap<String, Object> getAjaxSuccessResult(String message) {
		HashMap<String, Object> result = new HashMap<String, Object>();
		result.put(GlobalConst.AJAX_RESPONSE_CODE, GlobalConst.TEXT_FAIL);
		result.put(GlobalConst.AJAX_RESPONSE_MESSAGE, message);
		return result;
	}

	protected HashMap<String, Object> getSimpleAjaxResult() {
		HashMap<String, Object> result = new HashMap<String, Object>();
		return result;
	}

	protected String forward() {
		return "forward:"+GlobalConst.URL_FORWARD;
	}

	protected String forward(String strForwardURL) {
		return "forward:" + strForwardURL;
	}

	protected String getMessageAndBackScript(String message) {
		return "alert('"+message+"'); history.back();";
	}

	protected String getMessageAndMoveUrlScript(String message, String url) {
		return "alert('"+message+"'); location.href='"+url + "';";
	}

	/**
	 * 로그인 아이디 조회
	 * @return
	 * @throws UserMustLoginException
	 */
	protected String getLoginUserId() {
		Authentication authen = SecurityContextHolder.getContext().getAuthentication();
		if (authen == null || authen.getPrincipal() instanceof String) {
			return null;
		}
		return authen.getName();
	}

	/**
	 * 로그인 아이디 조회
	 * 로그인이 안됐을 경우 UserMustLoginException
	 * @return
	 * @throws UserMustLoginException
	 */
	protected String getLoginUserIdWithException() throws UserMustLoginException {
		Authentication authen = SecurityContextHolder.getContext().getAuthentication();
		if (authen == null || authen.getPrincipal() instanceof String) {
			throw new UserMustLoginException();
		}
		return authen.getName();
	}

	/**
	 * 로그인 사용자 정보 조회
	 * @return
	 * @throws UserMustLoginException
	 */
	protected UserVO getLoginUserInfo() {
		Authentication authen = SecurityContextHolder.getContext().getAuthentication();
		if (authen == null || authen.getPrincipal() instanceof String) {
			return null;
		}
		return (UserVO)authen.getDetails();
	}

	/**
	 * 로그인 체크
	 * 로그인이 없는 접근은 exception 발생
	 * @throws UserMustLoginException
	 */
	protected Authentication getAuthenticationWithException() throws UserMustLoginException {
		Authentication authen = SecurityContextHolder.getContext().getAuthentication();
		if (authen == null || authen.getPrincipal() instanceof String) throw new UserMustLoginException();
		return authen;
	}

	/**
	 * 필수 입력 파라메터 입력 체크
	 * 값이 없을 경우 InvalidAccessException 발생
	 * @param fields
	 * @param target
	 */
	protected void checkNullParameterWithException(String [] fields, Map<String, String> target) throws InvalidAccessException {
		if (fields == null || fields.length < 1) return;
		if (target == null) throw new InvalidAccessException();
		String field;
		for(int i=0; i<fields.length; i++) {
			field = fields[i];
			if (StringUtils.isBlank(target.get(field))) {
				throw new InvalidAccessException();
			}
		}
	}
}
