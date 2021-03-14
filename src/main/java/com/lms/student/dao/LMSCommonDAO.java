package com.lms.student.dao;

import java.util.HashMap;


/**
 * @Author : 이종호
 * @Date : 2017. 7. 21.
 * @Class 설명 : Soft Engineer Group 공통 기능 매퍼
 * 
 */
public interface LMSCommonDAO {
	/**
	 * @Method Name : selectCodeName
	 * @Date : 2017. 7. 21.
	 * @User : 이종호
	 * @Param : GroupId 와 Code 를 가진 HashMap 객체
	 * @Return : 해당 하는 CodeName
	 * @Method 설명 : DAO로 부터 전달 받은 GroupId와 Code로 CodeName을 찾은 SQL과 매핑
	 */
	public String selectCodeName(HashMap<String, String> fullCode);
	

}
