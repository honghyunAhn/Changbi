
package com.lms.student.exception;

/**
 * @Author : 이종호
 * @Date : 2017. 7. 18.
 * @Class 설명 : 그룹 코드가 정상적이지 않을 때 발생하는 예외처리 클래스 
 * 
 */
public class GroupIdNotFoundException extends Exception {

	public GroupIdNotFoundException(String message){
		super(message);
	}
}
