package forFaith.dev.util;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;

/**
 * @Class Name : GlobalConst.java
 * @Description : 공통 상수 정의
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

public class GlobalMethod {
	// ajax 호출 여부
	public final static boolean isAjax(HttpServletRequest request) {
	    return "XMLHttpRequest".equals(request.getHeader("X-Requested-With"));
	}

	/**
	 * 현재 시간 가져오기
	 * @param pattern
	 * @return
	 * 
	 * EX) pattern : yyyyMMdd				-> 20180511
	 *               yyyy-MM-dd HH:mm:ss	-> 2018-05-11 14:53:00 
	 *               yyyyMMddHHmmss			-> 20180511145300
	 */
	public final static String getNow(String pattern) {
		Date date = Calendar.getInstance().getTime();
		SimpleDateFormat sdf = new SimpleDateFormat(pattern);
		return sdf.format(date);
	}
}