package forFaith.util;

import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.Iterator;
import java.util.Locale;
import java.util.Map;
import java.util.Map.Entry;

import javax.servlet.http.HttpServletRequest;

import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;

/**
 * @Class Name : GlobalUtil.java
 * @Description : 공통 기능 유틸
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

public class GlobalUtil {

	/*
	 * Http Request Parameter 처리
	 */

	public static String getParameter(HttpServletRequest request, String key, String rep) {
		String val = request.getParameter(key);
		if (val == null || val.isEmpty()) return rep;
		return val;
	}

	public static String getParameter(HttpServletRequest request, String key) {
		return getParameter(request, key, "");
	}

	public static int getInt(HttpServletRequest request, String key) {
		if (key == null) return 0;

		String value = getParameter(request, key);

		if (value == null) return 0;

		try {
			return Integer.parseInt((String)value);
		} catch(NumberFormatException e) {
			return 0;
		}
	}

	public static long getLong(HttpServletRequest request, String key) {
		if (key == null) return 0;

		String value = getParameter(request, key);

		if (value == null) return 0;

		try {
			return Long.parseLong(value);
		} catch(NumberFormatException e) {
			return 0;
		}

	}

	/*
	 * 유효성 체크
	 */
	public static boolean isValid(Object obj) {
		if (obj instanceof String) {
			return (((String) obj).length() > 0);
		}

		return (obj != null);
	}

	public static boolean isValid(String [] arr) {
		return (arr != null);
	}

	public static boolean isValid(String str) {
		return (str != null && str.trim().length() > 0);
	}

	/*
	 * formatting
	 */

	public static String getDeimalFormat(int number) {
		return getDecimalFormat(number, "###,###,###,###");
	}

	public static String getDeimalFormat(long number) {
		return getDecimalFormat(number, "###,###,###,###");
	}

	public static String getDeimalFormat(double number) {
		return getDecimalFormat(number, "###,###,###,###");
	}

	public static String getDecimalFormat(int number, String pattern) {
		DecimalFormat decimalFormat = new DecimalFormat(pattern);
		return decimalFormat.format(number);
	}

	public static String getDecimalFormat(float number, String pattern) {
		DecimalFormat decimalFormat = new DecimalFormat(pattern);
		return decimalFormat.format(number);
	}

	public static String getDecimalFormat(double number, String pattern) {
		DecimalFormat decimalFormat = new DecimalFormat(pattern);
		return decimalFormat.format(number);
	}

	// 용량크기에 대한 fancy formatting
	public static String getFancySize(double value) {
		String size = "";
		if ((1024 < value) && (value < 1024 * 1024))
    		size = getDecimalFormat((float)value/1024, "###,###.##")+" KB";
		else if (1024 * 1024 <= value)
			size = getDecimalFormat((float)value/(1024*1024), "###,###.##")+" MB";
		else if (1024 * 1024 * 1024 <= value)
			size = getDecimalFormat((float)value/(1024*1024), "###,###.##")+" GB";
		else
			size = getDecimalFormat((float)value, "###,###.##")+" Bytes";

		return size;
	}

	public static String getFancySize(long value) {
		String size = "";
		if ((1024 < value) && (value < 1024 * 1024))
    		size = getDecimalFormat((float)value/1024, "###,###.##")+" KB";
		else if (1024 * 1024 <= value)
			size = getDecimalFormat((float)value/(1024*1024), "###,###.##")+" MB";
		else if (1024 * 1024 * 1024 <= value)
			size = getDecimalFormat((float)value/(1024*1024), "###,###,###.##")+" GB";
		else
			size = getDecimalFormat((float)value, "###,###.##")+" Bytes";

		return size;
	}

	/*
	 * 문자열처리
	 */

	// left padding
	public static String lpad(int num, int len) {
		StringBuffer sb = new StringBuffer(String.valueOf(num));
		int l = sb.length();
		for(int i=1; i<=(len-l);i++) {
			sb.insert(0, "0");
		}
		return sb.toString();
	}

	// 파일 확장자 추출
	public static String getExtension(String filename) {
		if (filename.lastIndexOf(".")<0) return "";
		return filename.substring(filename.lastIndexOf(".")+1);
	}

	// new line -> html line break
	public static String Cr2Br(String str) {
		return StringUtils.replace(StringUtils.replace(str, "\n\r", "<br/>"),"\n","<br/>");
	}

	// 문자열 자르기
	public static String getLimitByte(String string, int len) {
		if (len == 0)
			return string;
		else
			return getLimitByte(string, len, '+', "..");
	}

	public static String getLimitByte(String str, int length ,char type, String tail) {
		String test = "가";
		int div = test.getBytes().length;

		String f_str = null;

		if (length == 0)
			return str;

		if (str == null || str.length() == 0)
			return "";

		byte[] bytes = str.getBytes();
		int len = bytes.length;

		if (length >= len)
			return str;

		int charbyte_count = 0;	// 한글을 2byte로 취급하여 계산한 byte count
		int hcheck_count = 0;	// 한글을 체크하기 위한 count
		int cut_index = 0; // 자를 위치
		for(int i=0; i<len; i++) {
			++cut_index;
			if (((int)bytes[i] & 0x80) == 0) {
				if (charbyte_count+1 > length) {
					cut_index = cut_index - 1;
					break;
				}
				++charbyte_count; // 아스키문자
			}
			else {
				++hcheck_count;
				if (hcheck_count==div) {
					if (charbyte_count+2 > length) {
						if ("-".equals(type)) {
							cut_index = cut_index - div;
						}
						break;
					}
					hcheck_count = 0;
					charbyte_count = charbyte_count+2;	// 한글은 2byte로 계산(화면상표시기준)
				}
			}

		}

		f_str = new String(bytes, 0, cut_index);

		return f_str+tail;
	}

	public static String getLimitChar(String string, int len) {
		if (len == 0)
			return string;
		else
			return getLimitChar(string, len, '+', "..");
	}

	public static String getLimitChar(String str, int length ,char type, String tail) {
		String f_str = null;

		if (length == 0)
			return str;

		if (str == null || str.length() == 0)
			return "";

		int len = str.length();

		if (length >= len)
			return str;

		int tail_len = tail.length();
		if(type == '+'){
			f_str = str.substring(0,length);
		}else {
			f_str = str.substring(0,len-tail_len);
		}

		return f_str+tail;
	}

	// 널이거나 길이0인 문자열을 replace문자열로 반환
	public static String emptyReplace(Object str, String replace) {
		if (str == null) return replace;
		str=str.toString().trim();
		if(str.equals("")){
			return replace;
		}else{
			return str.toString().trim();
		}
	}
	public static String emptyReplace(Object str) {
		if (str == null) return "";
		return str.toString().trim();
	}

	// 문자열치환(정규식사용)
	public static String replace(String src, String regex, String rep) {
		if (src == null || "".equals(src)) return src;
		return src.replaceAll(regex, rep);
	}

	public static int ifnull(String source,int rep) {
		if (source == null || source.isEmpty()) return rep;
		return Integer.parseInt(source);
	}

	// 날짜문자열에서 구분문자 제거
	public static String removeDateSeparator(String src) {
		if (src == null) return "";
		return src.replaceAll("[-/:\\s\\.]+", "");
	}
	public static String removePhoneSeparation(String src) {
		if (src == null) return "";
		return src.replaceAll("[-\\s]+", "");
	}

	/*
	 * 날짜처리
	 */
	public static String getDate(java.util.Date date, String format) {
		if (date==null || format == null) return "";
		SimpleDateFormat sdf = new SimpleDateFormat(format, Locale.getDefault());
		return sdf.format(date);
	}
	public static String getFormatDate(String format) {
		return getFormatDate(new Date(), format);
	}
	public static String getFormatDate(java.util.Date date, String format) {
		return (new java.text.SimpleDateFormat( format )).format( date );
	}
	public static String getFormatDate(String datestr, String from_format, String to_format) {
		String result = datestr;
		try {
			java.util.Date date;
			if (datestr == null || "".equals(datestr.trim())) {
				date = new java.util.Date();
			} else {
				java.text.SimpleDateFormat format = new java.text.SimpleDateFormat(from_format);
				date = format.parse(datestr);
			}

			java.text.SimpleDateFormat format1 = new java.text.SimpleDateFormat(to_format);

			result = format1.format(date);
		} catch (Exception ex) {
		}

		return result;
	}
	public static String getCurrentDate(String format) {
		return getDate(new Date(), format);
	}
	// 금일자
	public static String getCurrentDate() {
		return getDate(new Date(), "yyyyMMdd");
	}
	// 어제일자
	public static String getYesterDate() {
		Calendar cal = Calendar.getInstance();
		cal.set(Calendar.DAY_OF_MONTH, cal.get(Calendar.DAY_OF_MONTH) -1);
		return getDate(new Date(cal.getTimeInMillis()), "yyyyMMdd");
	}
	// 현재달
	public static String getCurrentMonth() {
		Calendar cal = Calendar.getInstance();
		return getDate(new Date(cal.getTimeInMillis()), "yyyyMM");
	}
	// 일주일전 일자
	public static String getPastWeekDate() {
		Calendar cal = Calendar.getInstance();
		cal.set(Calendar.DAY_OF_MONTH, cal.get(Calendar.DAY_OF_MONTH) -7);
		return getDate(new Date(cal.getTimeInMillis()), "yyyyMMdd");
	}
	// ? 일전 일자
	public static String getPastDate(int day) {
		Calendar cal = Calendar.getInstance();
		cal.set(Calendar.DAY_OF_MONTH, cal.get(Calendar.DAY_OF_MONTH) -day);
		return getDate(new Date(cal.getTimeInMillis()), "yyyyMMdd");
	}
	// 금년도
	public static String getCurrentYear() {
		return getDate(new Date(), "yyyy");
	}
	// 해당달 마지막일
    public static int getLastDay(String yyyymm) {
		Calendar cal = new GregorianCalendar();
		cal.setLenient(false);
		cal.set(Integer.parseInt(yyyymm.substring(0,4)), Integer.parseInt(yyyymm.substring(4,6))-1, 1);
		return cal.getActualMaximum(GregorianCalendar.DATE);
	}
	public static String getDate(int day) {
		Calendar calendar = Calendar.getInstance();
		calendar.add(Calendar.DATE, day);
		return getDate(calendar.getTime(), "yyyyMMdd");
	}
	public static String getDate(int day, String format) {
		Calendar calendar = Calendar.getInstance();
		calendar.add(Calendar.DATE, day);
		return getDate(calendar.getTime(), format);
	}

	// 허용확장자체크
	public static boolean checkValidExtension(final Map<String, MultipartFile> files, final String [] avails) {
		Iterator<Entry<String, MultipartFile>> itr = files.entrySet().iterator();
		MultipartFile file = null;
		while (itr.hasNext()) {
		    Entry<String, MultipartFile> entry = itr.next();

		    file = entry.getValue();
		    String orginFileName = file.getOriginalFilename();

		    if ((orginFileName != null && !"".equals(orginFileName)) && !isValidExtension(file.getOriginalFilename(), avails)) {
		    	return false;
		    }
		}

		return true;
	}
	public static boolean isValidExtension(String filename, final String [] avails) {
		if (filename == null || "".equals(filename)) return false;
		if (avails == null || avails.length < 1) return true;
		int idx = filename.lastIndexOf(".");
		if (idx < 0) return false;

		String ext = filename.substring(idx+1).toUpperCase();
		for(int i=0; i<avails.length; i++) {
			if (ext.equalsIgnoreCase(avails[i])) return true;
		}
		return false;
	}


	// 접속 ip 반환(L4 client ip 적용)
	public static String getRemoteAddress(HttpServletRequest request) {
		String ip = request.getHeader("X-Forwarded-For");

		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
		    ip = request.getHeader("Proxy-Client-IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
		    ip = request.getHeader("WL-Proxy-Client-IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
		    ip = request.getHeader("HTTP_CLIENT_IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
		    ip = request.getHeader("HTTP_X_FORWARDED_FOR");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
		    ip = request.getRemoteAddr();
		}

	    return ip;
	}

}
