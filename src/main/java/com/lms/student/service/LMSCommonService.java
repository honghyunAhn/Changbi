package com.lms.student.service;

import java.util.HashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lms.student.dao.LMSCommonDAO;

/**
 * @Author : 이종호
 * @Date : 2017. 7. 21.
 * @Class 설명 : Soft Engineer Group 공통 기능 서비스
 * 
 */
@Service
public class LMSCommonService{
	
	private static final Logger logger = LoggerFactory.getLogger(LMSCommonService.class);
	
	@Autowired
	private LMSCommonDAO sgcDao;
	
	/**
	 * @Method Name : selectCodeName
	 * @Date : 2017. 7. 21.
	 * @User : 이종호
	 * @Param : GroupId 와 Code 를 가진 HashMap 객체
	 * @Return : 해당 하는 CodeName
	 * @Method 설명 : 컨트롤러로 부터 전달 받은 GroupId와 Code를 Code 이름 검색 DAO에 전달 하고,
	 * 							DAO로 부터 전달 받은 Code 이름을 서비스에 전달해준다.
	 */
	public String selectCodeName(HashMap<String, String> fullCode){
		logger.debug("공통 코드 이름 검색 서비스 시작");
		String result = sgcDao.selectCodeName(fullCode);
		logger.debug("공통 코드 이름 검색 서비스 종료");
		
		return result;
	}
	
}
