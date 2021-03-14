package com.changbi.tt.dev.data.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.apache.poi.openxml4j.opc.OPCPackage;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.changbi.tt.dev.data.dao.CourseDAO;
import com.changbi.tt.dev.data.vo.CardinalVO;
import com.changbi.tt.dev.data.vo.ChapterVO;
import com.changbi.tt.dev.data.vo.CourseVO;
import com.changbi.tt.dev.data.vo.GroupLearnVO;
import com.changbi.tt.dev.data.vo.PaymentAdminVO;

import forFaith.dev.dao.AttachFileDAO;
import forFaith.dev.util.LoginHelper;
import forFaith.dev.vo.AttachFileVO;
import forFaith.dev.vo.CodeVO;
import forFaith.dev.vo.MemberVO;
import forFaith.dev.vo.SubChapVO;
import forFaith.util.StringUtil;

@Service(value="data.courseService")
public class CourseService {

	private static final Logger logger = LoggerFactory.getLogger(CourseService.class);
	
	@Autowired
	private CourseDAO courseDao;
	
	@Autowired
    private AttachFileDAO fileDao;
	
    // 연수영역 리스트 조회
    public List<CodeVO> studyRangeList(CodeVO code) throws Exception {
        return courseDao.studyRangeList(code);
    }
	
	// 연수과정관리 리스트 조회
	public List<CourseVO> trainProcessList(CourseVO course) throws Exception {
		
		
		return courseDao.trainProcessList(course);
	}

	// 연수과정관리 리스트 총 갯수
	public int trainProcessTotalCnt(CourseVO course) throws Exception {
		return courseDao.trainProcessTotalCnt(course);
	}

	// 연수과정관리 상세 조회
	public CourseVO trainProcessInfo(CourseVO course) throws Exception {
		return courseDao.trainProcessInfo(course);
	}
	
	// 연수과정 등록
	public void trainProcessReg(CourseVO course) throws Exception {
		courseDao.trainProcessReg(course);
		
		// ID가 생성 또는 update 라면 detail insert 또는 upadate
        if(!StringUtil.isEmpty(course.getId())) {
        	// 파일 사용 가능 상태로 변경 처리
            // useYn을 Y로 바꾼다.
            List<AttachFileVO> attachFileList = new ArrayList<AttachFileVO>();
            
 			if(course.getMainImg() != null && !StringUtil.isEmpty(course.getMainImg().getFileId())) {
 				attachFileList.add(course.getMainImg());
 			}
 			
			// 파일 사용 가능 상태로 변경
			if(attachFileList.size() > 0) {
				fileDao.attachFileUse(attachFileList);
			}
			
			// 태그에 테이블 명이 존재 하기 때문에 공통으로 처리 하지 않고 페이지에 종속적으로 처리함. 단 resultMap만 CommonDAO에서 사용함.
			courseDao.courseCardinalDel(course);
			
 			if(course.getCardinalList() != null && course.getCardinalList().size() > 0)	{
 				courseDao.courseCardinalReg(course);
 			}
        }
	}
	
	// 연수과정 수정
	public int trainProcessUpd(CourseVO course, Authentication auth) throws Exception {
		int result = courseDao.trainProcessUpd(course);

		// ID가 생성 또는 update 라면 detail insert 또는 upadate
        if(result > 0) {
        	// 파일 사용 가능 상태로 변경 처리
            // useYn을 Y로 바꾼다.
            List<AttachFileVO> attachFileList = new ArrayList<AttachFileVO>();
            
 			if(course.getMainImg() != null && !StringUtil.isEmpty(course.getMainImg().getFileId())) {
 				attachFileList.add(course.getMainImg());
 			}
 			if(course.getCurriculumFile() != null && !StringUtil.isEmpty(course.getCurriculumFile().getFileId())) {
 				attachFileList.add(course.getCurriculumFile());
 			}
 			
			// 파일 사용 가능 상태로 변경
			if(attachFileList.size() > 0) {
				fileDao.attachFileUse(attachFileList);
			}
			
			// cardinalList 삭제 전, 과정 기수 매핑 시퀀스 가져오기
			List<HashMap<String, Object>> beforeSeq = courseDao.selectCnCourseSeq(course);

			// 태그에 테이블 명이 존재 하기 때문에 공통으로 처리 하지 않고 페이지에 종속적으로 처리함. 단 resultMap만 CommonDAO에서 사용함.
			courseDao.courseCardinalDel(course); 
			
			// 새로 생성된 과정,기수 매핑 시퀀스 가져와서 paymentList에 세팅 후, 분납 정보 저장
			List<CardinalVO> cardinalList = course.getCardinalList();
			
 			if(cardinalList != null && cardinalList.size() > 0) {
 				courseDao.courseCardinalReg(course);
 				HashMap<Object, Object> seqMap = new HashMap<>();
 				List<HashMap<String, Object>> afterSeq = courseDao.selectCnCourseSeq(course);
 				
 				for(HashMap<String, Object> cnCourse1 : beforeSeq){
					for(HashMap<String, Object> cnCourse2 : afterSeq){
						if(cnCourse1.get("CARDINAL_ID").equals(cnCourse2.get("CARDINAL_ID"))){
							seqMap.put(cnCourse1.get("SEQ"), cnCourse2.get("SEQ"));
							break;
						}
					}
				}
 				
 				for(int i = 0; i < beforeSeq.size(); i++) {
 					if(seqMap.get(beforeSeq.get(i).get("SEQ")) == null) {
 						courseDao.deleteGisuPaymentList(beforeSeq.get(i));
 					}
 				}
 				
 				for(CardinalVO cardinal : cardinalList){
 					List<PaymentAdminVO> paymentList = cardinal.getPaymentList();
 					
 		            // 로그인 된 관리자 정보
 		        	MemberVO loginUser = (MemberVO)LoginHelper.getLoginInfo();
 					
 					if(paymentList != null && paymentList.size() > 0){
 						for(int i = 0; i < paymentList.size(); i++){
 							PaymentAdminVO payment = paymentList.get(i);
 							payment.setCourse_id(course.getId());
 	 						payment.setId(loginUser.getId());
 	 						//System.out.println("payment = "+ i + " " + payment.getPayCrcSeq());
 	 						
 	 						// 기존 납입정보 수정 후 리스트 삭제
 	 						if(payment.getPayCrcSeq() != 0) {
 	 							courseDao.gisuPaymentUpdate(payment);
 	 							cardinal.getPaymentList().remove(i);
 	 							i--;
 	 						}
 	 						//System.out.println("list = " + i + " " + cardinal.getPaymentList().size());
 	 					}
 						// 새로운 납입 정보 추가
 						if(!cardinal.getPaymentList().isEmpty()) {
 							courseDao.gisuPaymentReg(cardinal);
 						}
 					}
 	 			}
			}
        }
        return result;
	}

	// 연수과정 삭제
	public int trainProcessDel(CourseVO course) throws Exception {
		return courseDao.trainProcessDel(course);
	}
	
	// 연수과정 선택삭제
	public int trainProcessSelectDel(List<CourseVO> courseList) throws Exception {
		return courseDao.trainProcessSelectDel(courseList);
	}
	
	// 챕터 리스트 조회
	public List<ChapterVO> chapterList(ChapterVO chapter) throws Exception {
		return courseDao.chapterList(chapter);
	}
	
	// 챕터 등록
	public void chapterReg(ChapterVO chapter) throws Exception {
		courseDao.chapterReg(chapter);
	}
	// 목차 excel 파일 읽어오기
	public List<SubChapVO> xlsToVOList(MultipartFile excelFile) {
		List<SubChapVO> list = new ArrayList<SubChapVO>();
		
		try {
			OPCPackage opcPackage = OPCPackage.open(excelFile.getInputStream());
			@SuppressWarnings("resource")
			XSSFWorkbook workbook = new XSSFWorkbook(opcPackage);
			
			//첫번째 시트를 불러옴
			XSSFSheet sheet = workbook.getSheetAt(0);
			
			for(int i=1; i < sheet.getLastRowNum() + 1; i++) {
				SubChapVO vo = new SubChapVO();
				
				XSSFRow row = sheet.getRow(i);
				
				if(row == null) continue;
				
				
				//첫번째는 순번이기때문에 제외함 2열 차시부터 시작
				//1열 순번(화면상에서 편집할 때 사용함, DB에 넣을때는 별개의 시퀀스)
				XSSFCell cell = row.getCell(0);
				if(cell != null) vo.setSeq((int)cell.getNumericCellValue());
				//2열 차시
				cell = row.getCell(1);
				if(cell != null) vo.setOcc_num((int)cell.getNumericCellValue());
				//3열 목차명
				cell = row.getCell(2);
				if(cell != null) vo.setName(cell.getStringCellValue());
				//4열 pc파일경로
				cell = row.getCell(3);
				if(cell != null) vo.setFilepath(cell.getStringCellValue());
				//5열 depth
				cell = row.getCell(4);
				if(cell != null) vo.setDepth((int)cell.getNumericCellValue());
				//6열 컨텐츠 순서 
				cell = row.getCell(5);
				if(cell != null) vo.setOrder((int)cell.getNumericCellValue());
				//7열 컨텐츠 유형
				cell = row.getCell(6);
				if(cell != null) vo.setContent_type(cell.getStringCellValue());
				
				list.add(vo);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	// 챕터 등록
	public void newChapterReg(ChapterVO chapter) throws Exception {
		courseDao.newChapterReg(chapter);
	}
	//목차 및 페이지 일괄등록
	public void insertChap(List<SubChapVO> list) throws Exception {
		List<SubChapVO> chapList = new ArrayList<SubChapVO>();
		List<SubChapVO> pageList = new ArrayList<SubChapVO>();
		for(SubChapVO s : list) {
			if(s.getDepth() == 2) chapList.add(s);
			else if(s.getDepth() == 3) pageList.add(s);
		}
		for(SubChapVO s : chapList) courseDao.insertChap(s);
		for(SubChapVO s : pageList) courseDao.insertPage(s);
	}
	
	//목차 리스트 조회
	List<SubChapVO> subChapterList(SubChapVO vo) throws Exception {
		return courseDao.subChapterList(vo);
	}
	
	//페이지 리스트 조회
	List<SubChapVO> subPageList(SubChapVO vo) throws Exception {
		return courseDao.subPageList(vo);
	}
	//목차 및 페이지 일괄반환
	public List<SubChapVO> chapPageList(SubChapVO vo) throws Exception {
		List<SubChapVO> chapList = subChapterList(vo);
		List<SubChapVO> result = new ArrayList<SubChapVO>();
		for(SubChapVO s : chapList) {
			s.setDepth(2);
			result.add(s);
			List<SubChapVO> pageList = subPageList(s);
			for(SubChapVO s2 : pageList) result.add(s2);
		}
		return result;
	}
	//페이지 삭제
	public void delSubPage(SubChapVO vo) throws Exception {
		courseDao.delSubPage(vo);
	}
	//목차 삭제
	public void delSubChap(SubChapVO vo) throws Exception {
		courseDao.delSubChap(vo);
	}
	// 챕터 삭제
	public int chapterDel(ChapterVO chapter) throws Exception {
	    int result = courseDao.chapterDel(chapter);
	    
	    return result;
	}
	
	// 기수 리스트 조회
	public List<CardinalVO> cardinalList(CardinalVO cardinal) throws Exception {
		return courseDao.cardinalList(cardinal);
	}

	// 기수 리스트 총 갯수
	public int cardinalTotalCnt(CardinalVO cardinal) throws Exception {
		return courseDao.cardinalTotalCnt(cardinal);
	}

	// 기수 상세 조회
	public CardinalVO cardinalInfo(CardinalVO cardinal) throws Exception {
		return courseDao.cardinalInfo(cardinal);
	}
	
	// 기수 추가
	public void cardinalReg(CardinalVO cardinal) throws Exception {
		courseDao.cardinalReg(cardinal);
		
		// ID가 생성 또는 update 라면 detail insert 또는 update
        if(!StringUtil.isEmpty(cardinal.getId())) {
        	// 해당 기수에 매핑된 연수설문 삭제 후 저장
        	courseDao.cardinalSurveyDel(cardinal);
        	
        	// 만족도 연수설문 저장
        	if(cardinal.getSatisfaction() != null && !StringUtil.isEmpty(cardinal.getSatisfaction().getId()))	{
 				courseDao.cardinalSatisfactionReg(cardinal);
 			}
        	
        	// 강의평가 연수설문 저장
        	if(cardinal.getEvaluation() != null && !StringUtil.isEmpty(cardinal.getEvaluation().getId()))	{
 				courseDao.cardinalEvaluationReg(cardinal);
 			}
        	
        	// 태그에 테이블 명이 존재 하기 때문에 공통으로 처리 하지 않고 페이지에 종속적으로 처리함. 단 resultMap만 CommonDAO에서 사용함.
			//courseDao.cardinalCourseDel(cardinal);
			
			// 삭제는 모든 경우 삭제 시키지만 매칭 등록은 선택과목서비스일때만 등록 시킨다.
 			/*if(cardinal.getCourseType().equals("S") && cardinal.getCourseList() != null && cardinal.getCourseList().size() > 0)	{
 				courseDao.cardinalCourseReg(cardinal);
 			}*/
        }
	}
	
	// 기수 수정
	public int cardinalUpd(CardinalVO cardinal) throws Exception {
		int result = courseDao.cardinalUpd(cardinal);

		// ID가 생성 또는 update 라면 detail insert 또는 upadate
        if(result > 0) {
        	// 해당 기수에 매핑된 연수설문 삭제 후 저장
        	courseDao.cardinalSurveyDel(cardinal);
        	
        	// 만족도 연수설문 저장
        	if(cardinal.getSatisfaction() != null && !StringUtil.isEmpty(cardinal.getSatisfaction().getId()))	{
 				courseDao.cardinalSatisfactionReg(cardinal);
 			}
        	
        	// 강의평가 연수설문 저장
        	if(cardinal.getEvaluation() != null && !StringUtil.isEmpty(cardinal.getEvaluation().getId()))	{
 				courseDao.cardinalEvaluationReg(cardinal);
 			}
        	
        	// 태그에 테이블 명이 존재 하기 때문에 공통으로 처리 하지 않고 페이지에 종속적으로 처리함. 단 resultMap만 CommonDAO에서 사용함.
			// 기수 수정하고 저장시 과정과의 매핑관계가 사라지기 때문에 주석처리
        	//courseDao.cardinalCourseDel(cardinal);
			
			// 삭제는 모든 경우 삭제 시키지만 매칭 등록은 선택과목서비스일때만 등록 시킨다.
 			/*if(cardinal.getCourseType().equals("S") && cardinal.getCourseList() != null && cardinal.getCourseList().size() > 0)	{
 				courseDao.cardinalCourseReg(cardinal);
 			}*/
        }
        
        return result;
	}

	// 기수 삭제
	public int cardinalDel(CardinalVO cardinal) throws Exception {
	    return courseDao.cardinalDel(cardinal);
	}
	
	// 기수 선택 삭제
	public int cardinalSelectDel(List<CardinalVO> cardinalList) throws Exception {
	    return courseDao.cardinalSelectDel(cardinalList);
	}
	
	// 단체연수 리스트 조회
	public List<GroupLearnVO> groupLearnList(GroupLearnVO groupLearn) throws Exception {
		return courseDao.groupLearnList(groupLearn);
	}

	// 단체연수 리스트 총 갯수
	public int groupLearnTotalCnt(GroupLearnVO groupLearn) throws Exception {
		return courseDao.groupLearnTotalCnt(groupLearn);
	}

	// 단체연수 상세 조회
	public GroupLearnVO groupLearnInfo(GroupLearnVO groupLearn) throws Exception {
		return courseDao.groupLearnInfo(groupLearn);
	}
	
	// 단체연수 등록
	public void groupLearnReg(GroupLearnVO groupLearn) throws Exception {
		courseDao.groupLearnReg(groupLearn);
		
		// ID가 생성 또는 update 라면 detail insert 또는 upadate
        if(groupLearn.getId() > 0) {
        	// 파일 사용 가능 상태로 변경 처리
            // useYn을 Y로 바꾼다.
            List<AttachFileVO> attachFileList = new ArrayList<AttachFileVO>();
            
 			if(groupLearn.getBanner() != null && !StringUtil.isEmpty(groupLearn.getBanner().getFileId())) {
 				attachFileList.add(groupLearn.getBanner());
 			}
 			
			// 파일 사용 가능 상태로 변경
			if(attachFileList.size() > 0) {
				fileDao.attachFileUse(attachFileList);
			}
			
			// 진행 단체연수 기수 삭제 후 등록
			courseDao.groupCardinalDel(groupLearn);

 			if(groupLearn.getCardinalList() != null && groupLearn.getCardinalList().size() > 0)	{
 				courseDao.groupCardinalReg(groupLearn);
 			}
        }
	}

	// 단체연수 삭제
	public int groupLearnDel(GroupLearnVO groupLearn) throws Exception {
	    int result = courseDao.groupLearnDel(groupLearn);
	    
	    return result;
	}

 
     //code에 따른 name 출력 
	 public List<CodeVO> getCodeNameList(CodeVO code) throws Exception{
		List<CodeVO> result = courseDao.getCodeNameList(code);
		return result;
	}

	 //대분류 코드 삭제1- 과정테이블의 학습영역 코드 삭제
	 public int subCourseDeleteRelatedCode(CodeVO code) throws Exception{
			int result = courseDao.subCourseDeleteRelatedCode(code);	
			return result;
		}
	 
	//대분류 코드 삭제2- 코드테이블의 대분류,학습영역 코드 삭제 
	public int subCourseDelete(CodeVO code) throws Exception{
		int result = courseDao.subCourseDelete(code);
		return result;
	}

	//대분류 selectbox 선택시 해당 학습영역리스트 출력
	public List<CodeVO> selectCourseList(CodeVO code) throws Exception{
		List<CodeVO> result= courseDao.selectCourseList(code);
		return result;
	}

	//학습영역 코드 삭제1- 과정테이블의 학습영역 코드 삭제
	public int studyRangeDeleteRelatedCode(CodeVO code) throws Exception{
		int result = courseDao.studyRangeDeleteRelatedCode(code);
		return result;
	}
	
	public List<CardinalVO> selectCourseCardinalList2(HashMap<String,Object> param) throws Exception {
		return courseDao.selectCourseCardinalList2(param);
	}
	
	public int selectCourseCardinalList2TotCnt(HashMap<String,Object> param)throws Exception {
		return courseDao.selectCourseCardinalList2TotCnt(param);
	}
	
	//LMS 연수정보의 실수강 종료기간 변경(복습기간 변경)
	public int realEndDateUpd(CourseVO course) {
		return courseDao.realEndDateUpd(course);
	}

	//기수별 분납 기초정보 조회
	public List<PaymentAdminVO> selectPaymentAdminInfo(CourseVO course) {
		return courseDao.selectPaymentAdminInfo(course);
	}
	
	// 기수별 납입 정보 삭제
	public void deleteGisuPayment(int pay) {
		courseDao.deleteGisuPayment(pay);
	}
}