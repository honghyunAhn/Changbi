/**
 * 
 */
package com.lms.student.util;

import java.lang.reflect.Array;
import java.util.List;
import java.util.Map;

/**
 * @Author : 이종호
 * @Date : 2017. 7. 31.
 * @Class 설명 : Mybatis에서 동적 쿼리에 사용할 함수 클래스
 * 
 */
public class Comparator {
	
	public static boolean isEmpty(Object obj){
        if( obj instanceof String ) return obj==null || "".equals(obj.toString().trim());
        else if( obj instanceof List ) return obj==null || ((List)obj).isEmpty();
        else if( obj instanceof Map ) return obj==null || ((Map)obj).isEmpty();
        else if( obj instanceof Object[] ) return obj==null || Array.getLength(obj)==0;
        else return obj==null;
    }
     
    public static boolean isNotEmpty(String s){
        return !isEmpty(s);
    }

}
