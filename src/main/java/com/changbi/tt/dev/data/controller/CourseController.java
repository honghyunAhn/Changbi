package com.changbi.tt.dev.data.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.changbi.tt.dev.data.service.CourseService;
import com.changbi.tt.dev.data.vo.CardinalVO;
import com.changbi.tt.dev.data.vo.ChapterVO;
import com.changbi.tt.dev.data.vo.CourseVO;
import com.changbi.tt.dev.data.vo.GroupLearnVO;

import forFaith.dev.service.BaseService;
import forFaith.dev.util.GlobalMethod;
import forFaith.dev.util.LoginHelper;
import forFaith.dev.vo.CodeVO;
import forFaith.dev.vo.MemberVO;
import forFaith.dev.vo.SubChapVO;
import forFaith.domain.RequestList;
import forFaith.util.DataList;
import forFaith.util.StringUtil;

@Controller(value="data.courseController")      // Controller value는 중복되면 안된다. value 값을 지정하지 않으면 클래스명이 value가 되므로 같은 클래스명이 존재하면 중복으로 인식
@RequestMapping("/data/course")       // 해당 클래스를 호출 하기 위한 Mapping 기본 값 뒤에 붙는 값에 의해 필요한 함수가 호출 된다.
public class CourseController {

	@Autowired
	private CourseService courseService;
	
	@Autowired
	private BaseService baseService;
 	
    /**
     * log를 남기는 객체 생성
     * @author : 김준석(2018-02-17)
     */
    private static final Logger logger = LoggerFactory.getLogger(CourseController.class);

    
    /**
     * 학습영역 정보 리스트 
     */
    @RequestMapping(value = "/studyRangeList", method = RequestMethod.POST)
    public @ResponseBody DataList<CodeVO> studyRangeList(CodeVO code) throws Exception {
     
    	DataList<CodeVO> result = new DataList<CodeVO>();    	 
    	
    	//학습영역 리스트
    	List<CodeVO> srList = new ArrayList<CodeVO>();
        srList = courseService.studyRangeList(code);      
        
        //페이징x
        result.setPagingYn("N");
    	
        // 결과 리스트 저장
    	result.setList(srList);	
    	 
		return result;
    }
    
    
    /**
     * 연수과정관리 정보 리스트
     */
    @RequestMapping(value = "/trainProcessList", method = RequestMethod.POST)
    public @ResponseBody DataList<CourseVO> trainProcessList(CourseVO course) throws Exception {
    	DataList<CourseVO> result = new DataList<CourseVO>();
    	
    	//대분류만, 중분류만 있을 경우 검색어 course에 저장
    	String parentcode = course.getSubCourseCode().getParentCode().getCode();
    	course.getSubCourseCode().setParentcode(parentcode);
    	// 로그인 정보를 저장한다.
    	course.setLoginUser((MemberVO)LoginHelper.getLoginInfo());
    	
    	result.setPagingYn(course.getPagingYn());
    	
    	// 페이징 처리인 경우만 페이지 번호와 토탈 갯수를 저장한다.
		if(result.getPagingYn().equals("Y")) {
			result.setNumOfNums(course.getNumOfNums());
			result.setNumOfRows(course.getNumOfRows());
			result.setPageNo(course.getPageNo());
			result.setTotalCount(courseService.trainProcessTotalCnt(course));
		}
		
		// 결과 리스트를 저장
		List<CourseVO> trainProcessList = courseService.trainProcessList(course);		
		result.setList(trainProcessList);

		return result;
    }
    
    /**
	 * 연수과정 관리 엑셀 다운로드
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/excel/download/trainProcessList", method = RequestMethod.POST)
	public ModelAndView excelDownloadTrainProcessList(CourseVO course) throws Exception {
		Map<String, Object> map		= new HashMap<String, Object>();
		List<Object> hederList		= new ArrayList<Object>();
		List<Object> bodyList		= new ArrayList<Object>();
		List<Object> bodyWidthList	= new ArrayList<Object>();

		// 모든 데이터를 가져오기 위해.. paging 여부를 N으로 설정
		course.setPagingYn("N");

		// 리스트 조회
		List<CourseVO> dataList = courseService.trainProcessList(course);

		String[] heder = new String[]{"대분류","학습영역","과정코드","과정명","시간","신청구분","과정상태"};
		int[] bodyWidth = new int[]{10, 20, 10, 20, 5, 10, 20};

		for(int i=0; i<dataList.size(); ++i) {
			CourseVO temp = dataList.get(i);
			String[] body = new String[heder.length];
 
			body[0] = temp.getId();
			body[1] =  temp.getSubCourseCode()==null ? "":temp.getSubCourseCode().getName() ;
			body[2] =  temp.getCourseCode()==null ? "":temp.getCourseCode().getName() ; 
			body[3] = temp.getName();		
			body[4] = temp.getCompleteTime()+"시간";
			body[5] = !StringUtil.isEmpty(temp.getAcceptYn()) && temp.getAcceptYn().equals("N") ? "신청불가" : "신청가능" ;
			body[6] = !StringUtil.isEmpty(temp.getUseYn()) && temp.getUseYn().equals("N") ? "중지" : "서비스" ;
		
			bodyList.add(body);
		}

		hederList.add(heder);
		bodyWidthList.add(bodyWidth);

		map.put("fileName", "학습과정 리스트_"+GlobalMethod.getNow("yyyyMMddHHmmss")+".xls");
		map.put("header", hederList);
		map.put("body", bodyList);
		map.put("bodyWidth", bodyWidthList);

		return new ModelAndView("excelDownLoad", "excelMap", map);
	}
    
    /**
     * 연수과정관리 : 과정 추가
     * ajax용으로 사용 될 경우(현재사용)
     * @author 김준석(2018-02-20)
     */
    @RequestMapping(value="/trainProcessReg", method=RequestMethod.POST)
    public @ResponseBody CourseVO trainProcessReg(CourseVO course) throws Exception {
        if(course != null) {
            // 로그인 된 관리자 정보
        	MemberVO loginUser = (MemberVO)LoginHelper.getLoginInfo();

    		// 메일 발송과 별개로 올레측 DB에 저장한다.
        	course.setRegUser(loginUser);
        	course.setUpdUser(loginUser);

        	courseService.trainProcessReg(course);
        }

        return course;
    }
    
    /**
     * 연수과정관리 : 과정 추가
     * ajax용으로 사용 될 경우(현재사용)
     * @author 김준석(2018-02-20)
     */
    @RequestMapping(value="/trainProcessUpd", method=RequestMethod.POST)
    public @ResponseBody Integer trainProcessUpd(CourseVO course, Authentication auth) throws Exception {
    	int result = 0;
    	int updResult = 0;
    	
        if(course != null) {
            // 로그인 된 관리자 정보
        	MemberVO loginUser = (MemberVO)LoginHelper.getLoginInfo();

    		// 메일 발송과 별개로 올레측 DB에 저장한다.
        	course.setUpdUser(loginUser);
        	//LMS 해당 과정의 연수신청정보의 REAL_END_DATE를 복습기간에 맞춰 수정
        	updResult = courseService.realEndDateUpd(course);
        	
        	result = courseService.trainProcessUpd(course, auth);
        	
        }

        return result;
    }
    
    /**
     * 연수과정관리 : 과정 데이터 DB 상에서 삭제
     * ajax용으로 사용 될 경우(현재사용)
     * @author 김준석(2018-02-20)
     */
    @RequestMapping(value="/trainProcessDel", method=RequestMethod.POST)
    public @ResponseBody int trainProcessDel(CourseVO course) throws Exception {
    	int result = courseService.trainProcessDel(course);
        
        return result;
    }
    
    /**
     * 연수신청관리 : 과정 데이터 선택 삭제
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/trainProcessSelectDel", method=RequestMethod.POST)
    public @ResponseBody int trainProcessSelectDel(@RequestBody RequestList<CourseVO> requestList) throws Exception {
    	int result = 0;
    	List<CourseVO> courseList = requestList.getList();

    	if(courseList != null && courseList.size() > 0) {
			// 삭제처리
			result = courseService.trainProcessSelectDel(courseList);
    	}

        return result;
    }
    
    /**
     * 대분류 selectbox 선택시 해당 학습영역리스트 출력
     */
    @RequestMapping(value="/selectCourseList", method=RequestMethod.POST)
    public @ResponseBody DataList<CodeVO> selectCourseList(CodeVO code) throws Exception{
    	DataList<CodeVO> result = new DataList<CodeVO>();
    	List<CodeVO> selectCourseList = courseService.selectCourseList(code);
    	System.out.println("selectCourseList:"+selectCourseList.size());
    	result.setList(selectCourseList);
    	return result;
    }
    
    
    
    /**
	 * 과정별 세부챕터 리스트 조회
	 */
	@RequestMapping(value="/chapterList", method=RequestMethod.POST)
	public @ResponseBody DataList<ChapterVO> chapterList(ChapterVO chapter, ModelMap model) throws Exception {
		DataList<ChapterVO> result = new DataList<ChapterVO>();
		// 결과 리스트를 저장
		result.setList(courseService.chapterList(chapter));

		return result;
	}
	@RequestMapping(value="/subChapList", method=RequestMethod.POST)
	public @ResponseBody DataList<SubChapVO> subChapterList(SubChapVO vo, ModelMap model) throws Exception {
    	DataList<SubChapVO> result = new DataList<SubChapVO>();
		// 결과 리스트를 저장
		result.setList(courseService.chapPageList(vo));

		return result;
	}
	/**
     * 과정별 세부챕터 저장 및 수정
     */
    @RequestMapping(value="/chapterReg", method=RequestMethod.POST)
    public @ResponseBody ChapterVO chapterReg(ChapterVO chapter) throws Exception {
        if(chapter != null) {
            // 로그인 된 관리자 정보
        	MemberVO loginUser = (MemberVO)LoginHelper.getLoginInfo();

    		// 메일 발송과 별개로 올레측 DB에 저장한다.
        	chapter.setRegUser(loginUser);
        	chapter.setUpdUser(loginUser);

        	courseService.chapterReg(chapter);
        }

        return chapter;
    }
	
    
    //목차 excel 파일 읽어오기
    @ResponseBody
	@RequestMapping(value="/subChapxls" , method = RequestMethod.POST)
    public Object subChapxls (MultipartHttpServletRequest request, Model model, HttpServletResponse response) {
    	
    	logger.debug("목차 excel 파일 읽어오기 컨트롤러 시작");
    	
    	response.setCharacterEncoding("UTF-8");
    	
    	List<SubChapVO> list = new ArrayList<SubChapVO>();
    	try {
			MultipartFile file = null;
			
			Iterator<String> iterator = request.getFileNames();
			if(iterator.hasNext()) file = request.getFile(iterator.next());
			
			list = courseService.xlsToVOList(file);
		} catch (Exception e) {
			e.printStackTrace();
		}
  
    	logger.debug("목차 excel 파일 읽어오기 컨트롤러 종료");
    	return list;
    }
   
	/**
     * 과정별 세부챕터 저장 및 수정
     */
    @RequestMapping(value="/newChapterReg", method=RequestMethod.POST)
    public @ResponseBody ChapterVO newChapterReg(ChapterVO chapter) throws Exception {
        if(chapter != null) {
            // 로그인 된 관리자 정보
        	MemberVO loginUser = (MemberVO)LoginHelper.getLoginInfo();

    		// 메일 발송과 별개로 올레측 DB에 저장한다.
        	chapter.setRegUser(loginUser);
        	chapter.setUpdUser(loginUser);

        	courseService.newChapterReg(chapter);
        }

        return chapter;
    }
    //챕터 일괄등록
    @ResponseBody
    @RequestMapping(value="/insertChap", method = RequestMethod.POST)
    public boolean insertChap(@RequestBody List<SubChapVO> list) {
    	logger.debug("포팅 차시 등록 컨트롤러 시작");
    	try {
			courseService.insertChap(list);
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
    	logger.debug("포팅 차시 등록 컨트롤러 종료");
    	return true;
    }
    @ResponseBody
    @RequestMapping(value="/delSubPage", method = RequestMethod.POST)
    public boolean delSubPage(SubChapVO vo) {
    	try {
			courseService.delSubPage(vo);
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
    	return true;
    }
    @ResponseBody
    @RequestMapping(value="/delSubChap", method = RequestMethod.POST)
    public boolean delSubChap(SubChapVO vo) {
    	try {
			courseService.delSubChap(vo);
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
    	return true;
    }
    /**
     * 과정별 세부챕터 삭제
     * @author 김준석(2018-02-20)
     */
    @RequestMapping(value="/chapterDel", method=RequestMethod.POST)
    public @ResponseBody int chapterDel(ChapterVO chapter) throws Exception {
    	int result = courseService.chapterDel(chapter);
        
        return result;
    }
	
	/**
     * 기수 리스트 정보
     */
    @RequestMapping(value = "/cardinalList", method = RequestMethod.POST)
    public @ResponseBody DataList<CardinalVO> cardinalList(CardinalVO cardinal) throws Exception {
    	DataList<CardinalVO> result = new DataList<CardinalVO>();
    	
    	System.out.println("1111111111");

    	try {
        	// 로그인 정보를 저장한다.
        	cardinal.setLoginUser((MemberVO)LoginHelper.getLoginInfo());
        	
        	result.setPagingYn(cardinal.getPagingYn());
        	
        	// 페이징 처리인 경우만 페이지 번호와 토탈 갯수를 저장한다.
    		if(result.getPagingYn().equals("Y")) {
    			result.setNumOfNums(cardinal.getNumOfNums());
    			result.setNumOfRows(cardinal.getNumOfRows());
    			result.setPageNo(cardinal.getPageNo());
    			result.setTotalCount(courseService.cardinalTotalCnt(cardinal));
    		}

    		// 결과 리스트를 저장
    		result.setList(courseService.cardinalList(cardinal));

    		
		} catch (Exception e) {
			e.printStackTrace();
		}
    	

    	System.out.println("1111111111");
		
		return result;
    }
    
    /**
	 * 기수 관리 엑셀 다운로드
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/excel/download/cardinalList", method = RequestMethod.POST)
	public ModelAndView excelDownloadCardinalList(CardinalVO cardinal) throws Exception {
		Map<String, Object> map		= new HashMap<String, Object>();
		List<Object> hederList		= new ArrayList<Object>();
		List<Object> bodyList		= new ArrayList<Object>();
		List<Object> bodyWidthList	= new ArrayList<Object>();
		String addTitle = "";

		// 모든 데이터를 가져오기 위해.. paging 여부를 N으로 설정
		cardinal.setPagingYn("N");

		// 리스트 조회
		List<CardinalVO> dataList = courseService.cardinalList(cardinal);

		String[] heder = new String[]{"기수코드","기수명","접수기간","연수기간","이수구분","상태구분"};
		int[] bodyWidth = new int[]{10, 20, 30, 30, 10, 10};

		for(int i=0; i<dataList.size(); ++i) {
			CardinalVO temp = dataList.get(i);
			String[] body = new String[heder.length];

			body[0] = temp.getId();
			body[1] = temp.getName();
			body[2]	= temp.getAppStartDate()+" ~ "+temp.getAppEndDate();
			body[3] = temp.getLearnStartDate()+" ~ "+temp.getLearnEndDate();
			body[4] = !StringUtil.isEmpty(temp.getComplateYn()) && temp.getComplateYn().equals("N") ? "미처리" : "처리" ;
			body[5] = !StringUtil.isEmpty(temp.getUseYn()) && temp.getUseYn().equals("N") ? "중지" : "서비스" ;

			bodyList.add(body);
		}

		hederList.add(heder);
		bodyWidthList.add(bodyWidth);
		
		addTitle = "";
		addTitle = cardinal.getLearnType().equals("J") ? "직무" + cardinal.getCredits().replaceAll(",", "/") + "학점"
				 : cardinal.getLearnType().equals("G") ? "단체"
				 : cardinal.getLearnType().equals("M") ? "집합" : "자율";
		
		map.put("fileName", "기수관리("+addTitle+") 리스트_"+GlobalMethod.getNow("yyyyMMddHHmmss")+".xls");
		map.put("header", hederList);
		map.put("body", bodyList);
		map.put("bodyWidth", bodyWidthList);

		return new ModelAndView("excelDownLoad", "excelMap", map);
	}
    
    /**
     * 기수 상세 조회 페이지
     * @param course
     * @param model
     * @throws Exception
     */
    @RequestMapping(value="/cardinalInfo")
    public @ResponseBody CardinalVO cardinalInfo(CardinalVO cardinal) throws Exception {
    	CardinalVO result = new CardinalVO();
    	
    	if(cardinal != null && !StringUtil.isEmpty(cardinal.getId())) {
            // 선택 된 ID가 없으면 바로 edit 화면으로 이동하고 선택 된 ID가 있으면 해당 정보를 가지고 간다.
    		result = courseService.cardinalInfo(cardinal);
        }

        return result;
    }
    
    /**
     * 기수관리 : 기수 추가
     * ajax용으로 사용 될 경우(현재사용)
     * @author 김준석(2018-02-20)
     */
    @RequestMapping(value="/cardinalReg", method=RequestMethod.POST)
    public @ResponseBody CardinalVO cardinalReg(CardinalVO cardinal) throws Exception {

    	
    	if(cardinal != null) {
            // 로그인 된 관리자 정보
        	MemberVO loginUser = (MemberVO)LoginHelper.getLoginInfo();

    		// 메일 발송과 별개로 올레측 DB에 저장한다.
        	cardinal.setRegUser(loginUser);
        	cardinal.setUpdUser(loginUser);

        	courseService.cardinalReg(cardinal);
        }

        return cardinal;
    }
    
    /**
     * 기수관리 : 기수 수정
     * ajax용으로 사용 될 경우(현재사용)
     * @author 김준석(2018-02-20)
     */
    @RequestMapping(value="/cardinalUpd", method=RequestMethod.POST)
    public @ResponseBody Integer cardinalUpd(CardinalVO cardinal) throws Exception {
    	int result = 0;

        if(cardinal != null) {
            // 로그인 된 관리자 정보
        	MemberVO loginUser = (MemberVO)LoginHelper.getLoginInfo();

    		// 메일 발송과 별개로 올레측 DB에 저장한다.
        	cardinal.setUpdUser(loginUser);

        	result = courseService.cardinalUpd(cardinal);
        }

        return result;
    }
    
    /**
     * 기수관리 : 기수 데이터 DB 상에서 삭제
     * ajax용으로 사용 될 경우(현재사용)
     * @author 김준석(2018-02-20)
     */
    @RequestMapping(value="/cardinalDel", method=RequestMethod.POST)
    public @ResponseBody int cardinalDel(CardinalVO cardinal) throws Exception {
    	int result = courseService.cardinalDel(cardinal);
        
        return result;
    }
    
    /**
     * 연수신청관리 : 기수 데이터 선택 삭제
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/cardinalSelectDel", method=RequestMethod.POST)
    public @ResponseBody int cardinalSelectDel(@RequestBody RequestList<CardinalVO> requestList) throws Exception {
    	int result = 0;
    	List<CardinalVO> cardinalList = requestList.getList();

    	if(cardinalList != null && cardinalList.size() > 0) {
			// 삭제처리
			result = courseService.cardinalSelectDel(cardinalList);
    	}

        return result;
    }
    
    /**
     * 단체연수 리스트 정보
     */
    @RequestMapping(value = "/groupLearnList", method = RequestMethod.POST)
    public @ResponseBody DataList<GroupLearnVO> groupLearnList(GroupLearnVO groupLearn) throws Exception {
    	DataList<GroupLearnVO> result = new DataList<GroupLearnVO>();
    	
    	result.setPagingYn(groupLearn.getPagingYn());
    	
    	// 페이징 처리인 경우만 페이지 번호와 토탈 갯수를 저장한다.
		if(result.getPagingYn().equals("Y")) {
			result.setNumOfNums(groupLearn.getNumOfNums());
			result.setNumOfRows(groupLearn.getNumOfRows());
			result.setPageNo(groupLearn.getPageNo());
			result.setTotalCount(courseService.groupLearnTotalCnt(groupLearn));
		}

		// 결과 리스트를 저장
		result.setList(courseService.groupLearnList(groupLearn));

		return result;
    }
    
    /**
     * 단체연수관리 : 단체연수 추가 or 수정
     * ajax용으로 사용 될 경우(현재사용)
     * @author 김준석(2018-02-20)
     */
    @RequestMapping(value="/groupLearnReg", method=RequestMethod.POST)
    public @ResponseBody GroupLearnVO groupLearnReg(GroupLearnVO groupLearn) throws Exception {
        if(groupLearn != null) {
            // 로그인 된 관리자 정보
        	MemberVO loginUser = (MemberVO)LoginHelper.getLoginInfo();

    		// 메일 발송과 별개로 올레측 DB에 저장한다.
        	groupLearn.setRegUser(loginUser);
        	groupLearn.setUpdUser(loginUser);

        	courseService.groupLearnReg(groupLearn);
        }

        return groupLearn;
    }
    
    /**
     * 단체연수관리 : 단체연수 데이터 DB 상에서 삭제
     * ajax용으로 사용 될 경우(현재사용)
     * @author 김준석(2018-02-20)
     */
    @RequestMapping(value="/groupLearnDel", method=RequestMethod.POST)
    public @ResponseBody int groupLearnDel(GroupLearnVO groupLearn) throws Exception {
    	int result = courseService.groupLearnDel(groupLearn);
        
        return result;
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
    
    
    
    /**
     * 대분류 코드 삭제    
     */
    @RequestMapping(value="/subCourseDelete", method=RequestMethod.POST)
    public @ResponseBody int subCourseDelete(CodeVO code) throws Exception {
    	//대분류 코드 삭제1- 과정테이블의 학습영역 코드 삭제
    	int result1 = courseService.subCourseDeleteRelatedCode(code);
    	//대분류 코드 삭제2- 코드테이블의 대분류,학습영역 코드 삭제
    	int result = courseService.subCourseDelete(code);     
    	
    	
    	
    	
    	
        return result;
    }
    
    /*
     * 학습영역 코드 삭제
     */
    @RequestMapping(value="/studyRangeDelete", method=RequestMethod.POST)
    public @ResponseBody int studyRangeDelete(CodeVO code) throws Exception {
    	//학습영역 코드 삭제1- 과정테이블의 학습영역 코드 삭제
    	int result1 = courseService.studyRangeDeleteRelatedCode(code);
    	//학습영역 코드 삭제2- 코드테이블의 학습영역 코드 삭제
    	int result = baseService.codeDel(code);        
        return result;
    }
    

    /*
     * LMS 기수 정보 팝업
     */
	
	 @RequestMapping(value = "/cardinalList2", method = RequestMethod.POST)
	 public @ResponseBody DataList<CardinalVO> cardinalList2(@RequestParam HashMap<String, Object> param, CardinalVO cardinal) throws Exception {
		DataList<CardinalVO> result = new DataList<CardinalVO>();
    	System.out.println("id : "+param.get("courseId"));
    	 // 로그인 정보를 저장한다.
		 param.put("loginUser", (MemberVO)LoginHelper.getLoginInfo());
		 
		 
		 //페이징 처리
		 param.put("pagingYn", "Y");
		 param.put("numOfRows", cardinal.getNumOfRows());
		 param.put("firstIndex", cardinal.getFirstIndex());
		 result.setNumOfNums(cardinal.getNumOfNums());
		 result.setNumOfRows(cardinal.getNumOfRows());
		 result.setPageNo(Integer.parseInt((String) param.get("pageNo")));
		 result.setTotalCount(courseService.selectCourseCardinalList2TotCnt(param));
		 int total = courseService.selectCourseCardinalList2TotCnt(param);
		 System.out.println("total : "+total);
		 
		// 결과 리스트를 저장
		 result.setList(courseService.selectCourseCardinalList2(param));
		 System.out.println("size : "+result.size());
	 	return result;
	 }

	 @RequestMapping(value="/deleteGisuPayment", method=RequestMethod.POST)
	    public @ResponseBody void deleteGisuPayment(int pay) throws Exception {
		 	
	        courseService.deleteGisuPayment(pay);
	    }
	 
}