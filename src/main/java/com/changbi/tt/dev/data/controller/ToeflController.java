package com.changbi.tt.dev.data.controller;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.changbi.tt.dev.data.service.ToeflService;
import com.changbi.tt.dev.data.vo.CourseVO;
import com.changbi.tt.dev.data.vo.ToeflPayVO;
import com.changbi.tt.dev.data.vo.ToeflVO;

import forFaith.dev.util.LoginHelper;
import forFaith.dev.vo.MemberVO;
import forFaith.util.DataList;

@Controller(value="data.toeflController")
@RequestMapping("/data/toefl")
public class ToeflController {

	@Autowired
	private ToeflService toeflService;
	
	private static final Logger logger = LoggerFactory.getLogger(ToeflController.class);
	
	//모의토플 리스트
	@RequestMapping(value = "/toeflList", method = RequestMethod.POST)
    public @ResponseBody DataList<ToeflVO> toeflList(ToeflVO vo) throws Exception {
		
		logger.debug("모의토플 리스트 가져오기 컨트롤러 시작");
		
		DataList<ToeflVO> result = new DataList<ToeflVO>();
		
		//로그인 정보 저장
		vo.setLoginUser((MemberVO)LoginHelper.getLoginInfo());
		
		result.setPagingYn(vo.getPagingYn());
		
		// 페이징 처리인 경우만 페이지 번호와 토탈 갯수를 저장한다.
		if(result.getPagingYn().equals("Y")) {
			result.setNumOfNums(vo.getNumOfNums());
			result.setNumOfRows(vo.getNumOfRows());
			result.setPageNo(vo.getPageNo());
			result.setTotalCount(toeflService.toeflListTotalCnt(vo));
		}
		List<ToeflVO> toeflList = toeflService.selectToeflList(vo);
		result.setList(toeflList);
		
		logger.debug("모의토플 리스트 가져오기 컨트롤러 종료");
		
		return result;
    }
	
	//모의토플 등록
	@RequestMapping(value="/insertToefl", method=RequestMethod.POST)
	public @ResponseBody ToeflVO insertToefl(ToeflVO vo) {
		
		logger.debug("모의토플 등록 컨트롤러 시작");
		
		if(vo != null) {
			// 로그인 된 관리자 정보
        	MemberVO loginUser = (MemberVO)LoginHelper.getLoginInfo();
        	vo.setRegUser(loginUser);
        	vo.setUpdUser(loginUser);
        	
        	toeflService.insertToefl(vo);
		}
		
		logger.debug("모의토플 등록 컨트롤러 종료");
		
		return vo;
	}
	
	//모의토플 삭제
	@RequestMapping(value="/deleteToefl", method=RequestMethod.POST)
    public @ResponseBody int trainProcessDel(@RequestBody List<ToeflVO> list) {
		logger.debug("모의토플 삭제 컨트롤러 시작");
			int result = 0;
		try {
			result = toeflService.deleteToefl(list);
		} catch (Exception e) {
			e.printStackTrace();
			return result;
		}
		
		logger.debug("모의토플 삭제 컨트롤러 종료");
		
        return result;
    }
	//모의토플
	@RequestMapping(value="/toeflPayList", method=RequestMethod.POST)
    public @ResponseBody DataList<ToeflPayVO> toeflList(ToeflPayVO vo) throws Exception {
		
		logger.debug("모의토플 결제 리스트 조회 컨트롤러 시작");

		DataList<ToeflPayVO> result = new DataList<ToeflPayVO>();
		
		//로그인 정보 저장
		vo.setLoginUser((MemberVO)LoginHelper.getLoginInfo());
		
		result.setPagingYn(vo.getPagingYn());
		
		// 페이징 처리인 경우만 페이지 번호와 토탈 갯수를 저장한다.
		if(result.getPagingYn().equals("Y")) {
			result.setNumOfNums(vo.getNumOfNums());
			result.setNumOfRows(vo.getNumOfRows());
			result.setPageNo(vo.getPageNo());
			result.setTotalCount(toeflService.toeflPayListTotalCnt(vo));
			logger.info(" "+toeflService.toeflPayListTotalCnt(vo));
		}
		List<ToeflPayVO> toeflList = toeflService.selectToeflPayList(vo);
		logger.info(toeflList.toString());
		result.setList(toeflList);
		
		logger.debug("모의토플 결제 리스트 조회 컨트롤러 종료");
		
        return result;
    }
	
	@RequestMapping(value="/toeflRefund", method=RequestMethod.POST)
    public @ResponseBody boolean toeflRefund(ToeflPayVO vo) throws Exception {
		
		logger.debug("모의토플 환불 정보 수정 컨트롤러 시작");

		boolean result;
		try {
			result = toeflService.updateToeflRefund(vo);
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
		
		logger.debug("모의토플 환불 정보 수정 컨트롤러 종료");
		
		return result;
    }
	
}
