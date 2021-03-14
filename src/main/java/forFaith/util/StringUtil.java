package forFaith.util;

import org.springframework.util.StringUtils;

/**
 * @Class Name : StringUtil.java
 * @Description : 문자열 유틸
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

public class StringUtil extends StringUtils {

    public static boolean isEmpty(String str) {
        boolean isEmpty = true;

        if(str != null && !str.equals("")) {
            isEmpty = false;
        }

        return isEmpty;
    }

    public static boolean isContain(String str, char target) {
        return isContain(str, String.valueOf(target));
    }

    public static boolean isContain(String str, String target) {
        boolean isContain = false;

        if(str.indexOf(target) >= 0) {
            isContain = true;
        }

        return isContain;
    }
    
    public static String numToStr(int num) {
    	return numToStr(num, 2);
    }

    public static String numToStr(int num, int cipher) {

        return numToStr(num, cipher, 0);
    }

    public static String numToStr(int num, int cipher, int add) {
        String str = "";

        if (add != 0) {
            num = num + add;
        }

        str = num+"";

        if(str.length() < cipher) {
            String zero = "";

            for(int i=0; i<cipher-str.length(); ++i) {
                zero += "0";
            }

            str = zero+str;
        }

        return str;
    }

    // 숫자 타입의 문자열인지 체크
    public static boolean isNumber(String str) {
        char charVal = ' ';

        if(StringUtil.isEmpty(str)) return false;

        for(int i=0; i<str.length(); ++i) {
            charVal = str.charAt(i);

            if(charVal < 48 || charVal > 57) {
                return false;
            }
        }

        return true;
    }
}