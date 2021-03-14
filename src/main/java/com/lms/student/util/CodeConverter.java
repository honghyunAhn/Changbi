/**
 * 
 */
package com.lms.student.util;

import java.util.HashMap;
import java.util.Locale;

import com.lms.student.exception.GroupIdNotFoundException;

/**
 * @Author : 이종호
 * @Date : 2017. 7. 18.
 * @Class 설명 : 공통코드 관련 유틸 클래스
 * 
 */
public class CodeConverter {

	/**
	 * 그룹 아이디 길이
	 */
	private static final int GROUP_ID_SIZE = 3;
	
	/**
	 * 리턴 될 Map의 그룹아이디 Key 
	 */
	private static final String GROUP_ID = "group_id";
	
	/**
	 * 리턴 될 Map의 코드 Key
	 */
	private static final String CODE = "code";
	
	/**
	 * 지역 코드
	 * */
	private static final String LOCALE = "locale";
	
	/**
	 * 코드 변환 중 예외 발생시 보여줄 메시지
	 */
	private static final String MESSAGE = "Group id is not correct!";
	
	/**
	 * @Method Name : getCodeMap
	 * @Date : 2017. 7. 18.
	 * @User : 이종호
	 * @Param : 전체 코드
	 * @Return : 그룹 아이디와 코드를 포함한 Map 객체
	 * @Method 설명 : 전체 코드를 입력 받아 그룹 아이디와 코드를 포함한 Map 객체로 리턴하는 함수
	 */
	public static HashMap<String, String> getCodeMap(String fullcode , Locale locale) throws GroupIdNotFoundException{
		HashMap<String, String> resultMap = new HashMap<>();
		
		if(fullcode != null && fullcode.length() > GROUP_ID_SIZE){
			resultMap.put(GROUP_ID, fullcode.substring(0,3));
			resultMap.put(CODE, fullcode.substring(3));
			resultMap.put(LOCALE, locale.toString());
		}else{
			throw new GroupIdNotFoundException(MESSAGE);
		}
		
		return resultMap;
	}
	
	/**
	 * @Method Name : getGroupId
	 * @Date : 2017. 7. 18.
	 * @User : 이종호
	 * @Param : 전체 코드
	 * @Return : 그룹 아이디
	 * @Method 설명 : 전체 코드를 입력 받아 그룹 아이디로 리턴하는 함수
	 */
	public static String getGroupId(String fullcode) throws GroupIdNotFoundException{
		String groupId = null;
		if(fullcode != null && fullcode.length() > GROUP_ID_SIZE){
			groupId = fullcode.substring(0, 3);
		}else{
			throw new GroupIdNotFoundException(MESSAGE);
		}
		
		return groupId;
	}
	
	/**
	 * @Method Name : getCode
	 * @Date : 2017. 7. 18.
	 * @User : 이종호
	 * @Param : 전체 코드
	 * @Return : 코드
	 * @Method 설명 : 전체 코드를 입력 받아 코드로 리턴하는 함수 
	 */
	public static String getCode(String fullcode) throws GroupIdNotFoundException{
		String code = null;
		if(fullcode != null && fullcode.length() > GROUP_ID_SIZE){
			code = fullcode.substring(3);
		}else{
			throw new GroupIdNotFoundException(MESSAGE);
		}
		
		return code;
	}
}
