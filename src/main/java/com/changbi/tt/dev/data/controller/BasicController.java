/**
 * 회원관리 화면 호출 Controller
 * @author : 김준석(2018-02-17)
 */

package com.changbi.tt.dev.data.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.changbi.tt.dev.data.service.BasicService;
import com.changbi.tt.dev.data.vo.BoardFileVO;
import com.changbi.tt.dev.data.vo.ComCodeGroupVO;
import com.changbi.tt.dev.data.vo.ComCodeVO;
import com.changbi.tt.dev.data.vo.EventVO;
import com.changbi.tt.dev.data.vo.InfoVO;
import com.changbi.tt.dev.data.vo.IpAddressVO;
import com.changbi.tt.dev.data.vo.PolicyDelayCancelVO;
import com.changbi.tt.dev.data.vo.PolicyPointVO;
import com.changbi.tt.dev.data.vo.SchoolVO;
import com.changbi.tt.dev.util.FileService;

import forFaith.dev.util.LoginHelper;
import forFaith.dev.vo.MemberVO;
import forFaith.util.DataList;

@Controller(value="data.basicController")      // Controller value는 중복되면 안된다. value 값을 지정하지 않으면 클래스명이 value가 되므로 같은 클래스명이 존재하면 중복으로 인식
@RequestMapping("/data/basic")       // 해당 클래스를 호출 하기 위한 Mapping 기본 값 뒤에 붙는 값에 의해 필요한 함수가 호출 된다.
public class BasicController {

	@Autowired
	private BasicService basicService;
	
    /**
     * log를 남기는 객체 생성
     * @author : 김준석(2018-02-17)
     */
    private static final Logger logger = LoggerFactory.getLogger(BasicController.class);

    /**
     * 학교 정보 리스트
     */
    @RequestMapping(value = "/schoolList", method = RequestMethod.POST)
    public @ResponseBody DataList<SchoolVO> schoolList(SchoolVO school) throws Exception {
    	DataList<SchoolVO> result = new DataList<SchoolVO>();
    	
    	result.setPagingYn(school.getPagingYn());
    	
    	// 페이징 처리인 경우만 페이지 번호와 토탈 갯수를 저장한다.
		if(result.getPagingYn().equals("Y")) {
			result.setNumOfNums(school.getNumOfNums());
			result.setNumOfRows(school.getNumOfRows());
			result.setPageNo(school.getPageNo());
			result.setTotalCount(basicService.schoolTotalCnt(school));
		}

		// 결과 리스트를 저장
		result.setList(basicService.schoolList(school));

		return result;
    }    

    /**
     * 학교 정보 등록 
     * @param school
     */
    @RequestMapping(value="/schoolReg", method=RequestMethod.POST)
    public @ResponseBody SchoolVO schoolReg(SchoolVO school) throws Exception {
        if(school != null) {
        	basicService.schoolReg(school);
        }

        return school;
    }
    
    /**
     * 연수자 IP 정보 리스트 
     * @param ipAddress
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/ipList", method=RequestMethod.POST)
 	public @ResponseBody DataList<IpAddressVO> ipList(IpAddressVO ipAddress) throws Exception {
 		DataList<IpAddressVO> result = new DataList<IpAddressVO>();
    	
    	result.setPagingYn(ipAddress.getPagingYn());
    	
    	// 페이징 처리인 경우만 페이지 번호와 토탈 갯수를 저장한다.
		if(result.getPagingYn().equals("Y")) {
			result.setNumOfNums(ipAddress.getNumOfNums());
			result.setNumOfRows(ipAddress.getNumOfRows());
			result.setPageNo(ipAddress.getPageNo());
			result.setTotalCount(basicService.ipTotalCnt(ipAddress));
		}

		// 결과 리스트를 저장
		result.setList(basicService.ipList(ipAddress));

		return result;
 	}
 	
 	/**
 	 * 연수자 IP 정보 삭제
 	 * @param ipAddress
 	 * @return
 	 * @throws Exception
 	 */
    @RequestMapping(value="/ipDel", method=RequestMethod.POST)
 	public @ResponseBody int ipInfoList(IpAddressVO ipAddress) throws Exception {
    	int result = basicService.ipDel(ipAddress);
    	return result;
 	}
    
    /**
     * 포인트 정책 등록
     * @param policyPoint
     */
    @RequestMapping(value="/policyPointReg", method=RequestMethod.POST)
    public @ResponseBody PolicyPointVO policyPointReg(PolicyPointVO policyPoint) throws Exception {
    	// 로그인 된 관리자 정보
    	MemberVO loginUser = (MemberVO)LoginHelper.getLoginInfo();
    	// 사용자정보 저장 
    	policyPoint.setRegUser(loginUser);
    	policyPoint.setUpdUser(loginUser);

        basicService.policyPointReg(policyPoint);

        return policyPoint;
    }
    
	/**
	 * 수강 연기/취소 정책 등록 
	 * @param policyDelayCancel
	 */
    @RequestMapping(value="/policyDelayCancelReg", method=RequestMethod.POST)
    public @ResponseBody PolicyDelayCancelVO policyDelayCancelReg(PolicyDelayCancelVO policyDelayCancel) throws Exception {
        if(policyDelayCancel != null) {
        	// 로그인 된 관리자 정보
        	MemberVO loginUser = (MemberVO)LoginHelper.getLoginInfo();

    		// 사용자정보 저장 
        	policyDelayCancel.setRegUser(loginUser);
        	policyDelayCancel.setUpdUser(loginUser);
        	
        	basicService.policyDelayCancelReg(policyDelayCancel);
        }

        return policyDelayCancel;
    }
    
    /**
     * 이벤트 정보 리스트
     */
    @RequestMapping(value = "/eventList", method = RequestMethod.POST)
    public @ResponseBody DataList<EventVO> eventList(EventVO event) throws Exception {
    	DataList<EventVO> result = new DataList<EventVO>();
    	
    	result.setPagingYn(event.getPagingYn());
    	
    	// 페이징 처리인 경우만 페이지 번호와 토탈 갯수를 저장한다.
		if(result.getPagingYn().equals("Y")) {
			result.setNumOfNums(event.getNumOfNums());
			result.setNumOfRows(event.getNumOfRows());
			result.setPageNo(event.getPageNo());
			result.setTotalCount(basicService.eventTotalCnt(event));
		}

		// 결과 리스트를 저장
		result.setList(basicService.eventList(event));

		return result;
    }    
    
    /**
     * 이벤트 정보 등록 
     * @param school
     */
    @RequestMapping(value="/eventReg", method=RequestMethod.POST)
    public @ResponseBody EventVO eventReg(EventVO event) throws Exception {
        if(event != null) {
        	basicService.eventReg(event);
        }

        return event;
    }
    
    /**
     * 이벤트 정보 삭제 
     * @param board
     */
    @RequestMapping(value="/eventDel", method=RequestMethod.POST)
    public @ResponseBody int eventDel(EventVO event) throws Exception {
    	int result = basicService.eventDel(event);
    	return result;
    }
    
    /**
     * 배너 생성
     */
    @ResponseBody
    @RequestMapping(value = "/bannerInsert", method = RequestMethod.POST)
    public int bannerInsert(@RequestParam HashMap<String, Object> param, MultipartHttpServletRequest multiRequest) throws Exception {
    	logger.debug("배너 등록 컨트롤러 시작");
    	// 로그인 된 관리자 정보
    	MemberVO loginUser = (MemberVO)LoginHelper.getLoginInfo();
    	param.put("login_id", loginUser.getId());
		List<MultipartFile> fileList = multiRequest.getFiles("file");
		int result = 0;
		// 업로드한 파일이 없으면 실행되지 않음
		if (fileList != null) {
			// 파일이 저장될 경로 설정
			String path = "edu/ban/img";

			if (!fileList.isEmpty()) {
				// 넘어온 파일을 리스트로 저장
				String edu_ban_origin_pc = fileList.get(0).getOriginalFilename();
				String edu_ban_saved_pc = FileService.saveFile(fileList.get(0), path);
				if(fileList.get(1) != null) {
					String edu_ban_origin_mo = fileList.get(1).getOriginalFilename();
					String edu_ban_saved_mo = FileService.saveFile(fileList.get(1), path);
					param.put("edu_ban_origin_mo", edu_ban_origin_mo);
					param.put("edu_ban_saved_mo", edu_ban_saved_mo);
				}
				param.put("edu_ban_origin_pc", edu_ban_origin_pc);
				param.put("edu_ban_saved_pc", edu_ban_saved_pc);
				result = basicService.bannerInsert(param);
			}
		}
		logger.debug("배너 등록 컨트롤러 종료");
		return result;
    }
    
    /**
     * 배너 정보 리스트
     */
    @ResponseBody
    @RequestMapping(value = "/bannerSelect", method = RequestMethod.POST)
    public ArrayList<HashMap<String, Object>> bannerSelect(String edu_ban_nm) throws Exception {
    	logger.debug("배너 정보 리스트 컨트롤러 시작");
    	ArrayList<HashMap<String, Object>> reuslt = basicService.bannerSelect(edu_ban_nm);
		logger.debug("배너 정보 리스트 컨트롤러 종료");
		return reuslt;
    }
    
    /**
     * 배너 정보 리스트
     */
//    @RequestMapping(value = "/bannerList", method = RequestMethod.POST)
//    public @ResponseBody DataList<BannerVO> bannerList(BannerVO banner) throws Exception {
//    	System.out.println("미사용" + banner.getSearchKeyword());
//    	DataList<BannerVO> result = new DataList<BannerVO>();
//    	
//    	// 미사용인 배너만 가져옴
//    	banner.setUseYn("N");
//
//    	result.setPagingYn(banner.getPagingYn());
//    	
//    	// 페이징 처리인 경우만 페이지 번호와 토탈 갯수를 저장한다.
//		if(result.getPagingYn().equals("Y")) {
//			result.setNumOfNums(banner.getNumOfNums());
//			result.setNumOfRows(banner.getNumOfRows());
//			result.setPageNo(banner.getPageNo());
//			result.setTotalCount(basicService.bannerTotalCnt(banner));
//		}
//
//		// 결과 리스트를 저장
//		result.setList(basicService.bannerList(banner));
//
//		return result;
//    }
    
    /**
     * 관리 배너 정보 리스트
     */
//    @RequestMapping(value = "/bannerManaged", method = RequestMethod.POST)
//    public @ResponseBody List<BannerVO> bannerManaged(BannerVO banner) throws Exception {
//    	// 사용여부(useYn)가 Y인 배너만 가져와서 jsp로 보내고 jsp에서 분별해서 뿌린다
//    	List<BannerVO> bannerList = basicService.bannerList(banner);
//
//		return bannerList;
//    }
    
    /**
     * 메인 배너 순서 변경
     */
//    @RequestMapping(value = "/bannerOrder", method = RequestMethod.POST)
//    public @ResponseBody void bannerOdUpdate(@RequestParam(defaultValue="") ArrayList<String> banner_seq_array) throws Exception {
//    	HashMap<String, Object> map = new HashMap<>();
//    	if (banner_seq_array.size() != 0) {
//			for (int i = 0; i < banner_seq_array.size(); i++) {
//				map.put("id", banner_seq_array.get(i));
//				map.put("od", i+1);
//				basicService.bannerOdUpdate(map);
//			}
//		}
//    }
    
    /**
     * 배너 사용여부, 순서 변경
     */
//    @RequestMapping(value = "/bannerState", method = RequestMethod.POST)
//    public @ResponseBody int bannerState(BannerVO banner) throws Exception {
//    	int result = 0;
//    	int od_update = 0;
//    	
//    	// 메인 배너 혹은 hot&New 이면서 사용하려고 하는 배너만 순서를 지정한다
//    	if ((banner.getPosition().equals("2") || banner.getPosition().equals("4")) && banner.getUseYn().equals("N")) {
//    		ArrayList<Integer> bannerOdList = basicService.bannerOdList();
//        	// 현재 저장 되어 있는 순서중 가장 큰 수
//        	int max_od = 0;
//        	if(bannerOdList.size() != 0){
//        		max_od = bannerOdList.get(bannerOdList.size()-1);			
//        	}else{
//        		max_od = 0;
//        	}
//        	// 메인 배너 혹은 hot&New 등록 시 가장 마지막 순서로 등록 해 줄 수
//        	od_update = max_od + 1;
//		}
//    	
//    	banner.setOd(od_update);
//    	
//    	result = basicService.bannerState(banner);
//    	
//    	return result;
//    	
//    }
    
    /**
     * 배너 정보 등록 
     * @param school
     */
//    @RequestMapping(value="/bannerReg", method=RequestMethod.POST)
//    public @ResponseBody BannerVO bannerReg(BannerVO banner) throws Exception {
//    	
//    	// 로그인 된 관리자 정보
//    	MemberVO loginUser = (MemberVO)LoginHelper.getLoginInfo();
//
//		// 사용자정보 저장
//    	banner.setUserId(loginUser.getId());
//    	banner.setRegUser(loginUser);
//    	banner.setUpdUser(loginUser);
//    	
//        if(banner != null) {
//        	basicService.bannerReg(banner);
//        }
//
//        return banner;
//    }
    
    /**
     * 배너 정보 삭제 
     * @param board
     */
//    @RequestMapping(value="/bannerDel", method=RequestMethod.POST)
//    public @ResponseBody int bannerDel(BannerVO banner) throws Exception {
//    	int result = basicService.bannerDel(banner);
//    	return result;
//    }
    
    /**
     * 안내페이지 정보 리스트
     */
    @RequestMapping(value = "/infoList", method = RequestMethod.POST)
    public @ResponseBody DataList<InfoVO> infoList(InfoVO info) throws Exception {
    	DataList<InfoVO> result = new DataList<InfoVO>();
    	
    	result.setPagingYn(info.getPagingYn());
    	
    	// 페이징 처리인 경우만 페이지 번호와 토탈 갯수를 저장한다.
		if(result.getPagingYn().equals("Y")) {
			result.setNumOfNums(info.getNumOfNums());
			result.setNumOfRows(info.getNumOfRows());
			result.setPageNo(info.getPageNo());
			result.setTotalCount(basicService.infoTotalCnt(info));
		}

		// 결과 리스트를 저장
		result.setList(basicService.infoList(info));

		return result;
    }
    
    /**
     * 안내페이지 정보 등록 
     * @param school
     */
    @RequestMapping(value="/infoReg", method=RequestMethod.POST)
    public @ResponseBody InfoVO infoReg(InfoVO info) throws Exception {
    	
    	// 로그인 된 관리자 정보
    	MemberVO loginUser = (MemberVO)LoginHelper.getLoginInfo();

		// 사용자정보 저장
    	info.setUserId(loginUser.getId());
    	info.setRegUser(loginUser);
    	info.setUpdUser(loginUser);
    	
        if(info != null) {
        	basicService.infoReg(info);
        }

        return info;
    }
    
    /**
     * 안내페이지 정보 삭제 
     * @param board
     */
    @RequestMapping(value="/infoDel", method=RequestMethod.POST)
    public @ResponseBody int infoDel(InfoVO info) throws Exception {
    	int result = basicService.infoDel(info);
    	return result;
    }
    
    /**
	 * 공통코드 리스트 조회
	 */
	@RequestMapping(value = "/comCodeList", method = RequestMethod.POST)
	public @ResponseBody List<ComCodeGroupVO> comCodeList(@ModelAttribute("search") ComCodeGroupVO code, ModelMap model) throws Exception {
		if(code.getSearchCondition().equals("com_code")){
			String searchKeyword = code.getSearchKeyword();
			if(searchKeyword != null & searchKeyword.length() != 0) code.setCom_code_length(searchKeyword.length());
		}
		return basicService.comCodeList(code);
	}
    
	/**
	 * 공통 그룹코드 추가
	 */
	@RequestMapping(value = "/insertGroupCode", method = RequestMethod.POST)
	public @ResponseBody boolean insertGroupCode(ComCodeGroupVO code) throws Exception {
		MemberVO loginUser = (MemberVO)LoginHelper.getLoginInfo();
		code.setGroup_ins_id(loginUser.getId());
		code.setGroup_udt_id(loginUser.getId());
		
		int result = basicService.insertGroupCode(code);
		if(result == 1) return true;
		return false;
	}
	
	/**
	 * 공통 그룹코드 수정
	 */
	@RequestMapping(value = "/updateGroupCode", method = RequestMethod.POST)
	public @ResponseBody boolean updateGroupCode(ComCodeGroupVO code) throws Exception {
		MemberVO loginUser = (MemberVO)LoginHelper.getLoginInfo();
		code.setGroup_udt_id(loginUser.getId());
		
		int result = basicService.updateGroupCode(code);
		if(result == 1) return true;
		return false;
	}
	
	/**
	 * 공통코드 수정
	 */
	@RequestMapping(value = "/updateComCode", method = RequestMethod.POST)
	public @ResponseBody boolean updateComCode(ComCodeVO code) throws Exception {
		MemberVO loginUser = (MemberVO)LoginHelper.getLoginInfo();
		code.setCode_udt_id(loginUser.getId());
		
		int result = basicService.updateComCode(code);
		if(result == 1) return true;
		return false;
	}
	
    /**
	 * 공통코드 삭제
	 */
	@RequestMapping(value = "/deleteComCode", method = RequestMethod.POST)
	public @ResponseBody boolean deleteComCode(ComCodeVO code) throws Exception {
		int result = basicService.deleteComCode(code);
		if(result == 1) return true;
		return false;
	}
	
	/**
	 * 공통코드 추가
	 */
	@RequestMapping(value = "/insertComCode", method = RequestMethod.POST)
	public @ResponseBody boolean insertComCode(ComCodeVO code) throws Exception {
		MemberVO loginUser = (MemberVO)LoginHelper.getLoginInfo();
		code.setCode_ins_id(loginUser.getId());
		code.setCode_udt_id(loginUser.getId());
		
		int result = basicService.insertComCode(code);
		if(result == 1) return true;
		return false;
	}
	
    /**
     * Exception 처리
     * @param Exception
     * @return ModelAndView
     * @author : 김준석 - (2015-06-03)
     */
    @ExceptionHandler(Exception.class)
    public ModelAndView exceptionHandler(Exception e) {
        logger.info(e.getMessage());

        return new ModelAndView("/error/exception").addObject("msg", e.getMessage());
    }
}