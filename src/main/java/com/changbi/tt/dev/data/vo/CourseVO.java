package com.changbi.tt.dev.data.vo;

import java.util.List;

import forFaith.dev.vo.AttachFileVO;
import forFaith.dev.vo.CodeVO;
import forFaith.dev.vo.CommonVO;
import forFaith.dev.vo.MemberVO;

@SuppressWarnings("serial")
public class CourseVO extends CommonVO {
	// 검색조건
    private CourseVO search;
    
    // 검색용 기수 ID(기수ID가 존재 할때 과정 리스트를 불러오기 위해 필요)
    private String cardinalId;
    private String cardinalName;
    // 검색용 기수 의 신청 가능 학점을 보낸다.
    private String appPossibles;	// 기수에서 넘겨 준 신청가능학점
    // 기수에서 넘겨준 가능학점으로 과정의 학점과 IN 시킬 List 생성
    private List<Integer> creditList;
    
    //검색용 연수과정 ID
    private String trainProcessId;
    
   
	// 관리자 지정 과정 인 경우 배당인원을 입력 받는다.
    public int persons;				// 배당인원
    
    private String id; 				// 연수과정 ID
    private String comCal; 			// 업체 정산지급(%)
    private String teachCal; 		// 강사 정산지급(%)
    private String tutorCal; 		// 튜터 정산지급(%)
    private String name; 			// 과정명
    private String shortName;		// 과정줄임말
    private String mainYn; 			// 메인표시여부
    private String mainDisplay; 	// 메인표시(1:창비추천, 2:초등추천, 3:중등추천)
    private String iconDisplays; 	// 아이콘표시 다중표시(1:NEW, 2:BEST, 3:인기, 4:업그레이드, 5:우수)
    private int completeTime; 		// 이수시간(학점별 15시간)
    private String learnTypes; 		// 연수타입(J : 직무, S : 자율, M : 집합, G : 단체)
    private String targetTypes;		// 대상타입(1:유아, 2:초등, 3:중등, 4:전문직)
    private int credit; 			// 학점(1~4)
    private String learnTarget; 	// 연수대상
    private int price; 				// 수강금액
    private String mileageYn;		// 마일리지 사용가능 여부
    private int progCheck; 			// 진도체크(차시당 분)
    private String openDate; 		// 과정오픈일
    private String appDate; 		// 심사신청일
    private int recruit; 			// 모집인원
    private int examPeriod; 		// 시험교시(4학점 출석시험인 경우 사용)
    private int mainPrice; 			// 주교재 가격
    private int subPrice; 			// 교구 가격
    private int linkServer; 		// 창비링크서버(1~2)
    private String groupYn; 		// 단체연수신청여부
    private String mobileYn; 		// 모바일 서비스 여부
    private String indexUrl; 		// 인덱스
    private String tastingUrl; 		// 맛보기
    private String sampleUrl; 		// 교재샘플
    private String width; 			// 넓이
    private String height; 			// 높이
    private int selpPeriod; 		// 자율 연수인 경우 연수기간(인증일로부터 00일)
    private String dupDisYn; 		// 중복할인 허용 여부
    private String acceptYn; 		// 접수상태
    private String purpose; 		// 과정목표
    private String curriculum; 		// 커리큘럼
    private String summary; 		// 과정개요
    private String instructor; 		// 강사진 안내
    private String note; 			// 유의사항
    private String mobileSummary;	// 모바일 과정개요
    private String codeTxt;			// 페이지 코드
    private String developer;		// 과정개발자
    private String resTel;			// 담당전화
    private String comName;			// 제작업체명
    private String comTel;			// 업체 전화
    private String produceDate;		// 제작일
    private String storageLoc;		// 보관위치
    private String history;			// 제작히스토리
    private String remarks;			// 특이사항 및 비고
    private String portYn;			// 포팅컨텐츠 여부
    
    private MemberVO company;		// 업체 관리자
    private MemberVO teacher;		// 강사 관리자
    private BookVO mainBook;		// 메인 교재
    private BookVO subBook;			// 교구
    private CodeVO bookCode;		// 교재출판사코드  
   
	private CodeVO courseCode;		// 과정분류(학습영역)
	private CodeVO subCourseCode;       // 대분류
   
	private AttachFileVO mainImg;	// 메인 이미지 파일
	private AttachFileVO curriculumFile; //커리큘럼 파일
    
    private List<CardinalVO> cardinalList;	// 과정에서도 기수 여러개 선택해서 저장 가능
    private List<ChapterVO> chapterList;	// 과정에 포함되는 챕터리스트를 가져온다.
    
    private int reviewPeriod;		// 복습기간
    private int compPercentQuiz;		// 수료조건 반영비율 : 과제
    private int compPercentExam;		// 수료조건 반영비율 : 시험
    private int compPercentProg;		// 수료조건 반영비율 : 진도율
    private int compScoreQuiz;		// 수료조건 배점 : 과제
    private int compScoreExam;		// 수료조건 배점 : 시험
    private int compScoreProg;		// 수료조건 배점 : 진도율
    private int completeTotal;		// 수료 조건 총점
    
    private String checkOnline;		// 온라인 ・ 오프라인 강좌 여부.. " 'offline' || 'online' " 둘중 하나 insert
    private String applyFormYn;		// 지원서 유무 여부
    private String recordYn;		// 성적 처리 여부
    
    private String surveyYn;			// 설문 자동배포 여부
    private String surveyTemplateTitle; // 설문 템플릿 제목
    
	private List<PaymentAdminVO> paymentList;
	
	public String getCardinalName() {
		return cardinalName;
	}
	public void setCardinalName(String cardinalName) {
		this.cardinalName = cardinalName;
	}
	public String getRecordYn() {
		return recordYn;
	}
	public void setRecordYn(String recordYn) {
		this.recordYn = recordYn;
	}
	public String getApplyFormYn() {
		return applyFormYn;
	}
	public void setApplyFormYn(String applyFormYn) {
		this.applyFormYn = applyFormYn;
	}
	public CourseVO getSearch() {
		return search;
	}
	public void setSearch(CourseVO search) {
		this.search = search;
	}
	public String getCardinalId() {
		return cardinalId;
	}
	public void setCardinalId(String cardinalId) {
		this.cardinalId = cardinalId;
	}
	public String getAppPossibles() {
		return appPossibles;
	}
	public void setAppPossibles(String appPossibles) {
		this.appPossibles = appPossibles;
	}
	public List<Integer> getCreditList() {
		return creditList;
	}
	public void setCreditList(List<Integer> creditList) {
		this.creditList = creditList;
	}
	public int getPersons() {
		return persons;
	}
	public void setPersons(int persons) {
		this.persons = persons;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getTargetTypes() {
		return targetTypes;
	}
	public void setTargetTypes(String targetTypes) {
		this.targetTypes = targetTypes;
	}
	public String getComCal() {
		return comCal;
	}
	public void setComCal(String comCal) {
		this.comCal = comCal;
	}
	public String getTeachCal() {
		return teachCal;
	}
	public void setTeachCal(String teachCal) {
		this.teachCal = teachCal;
	}
	public String getTutorCal() {
		return tutorCal;
	}
	public void setTutorCal(String tutorCal) {
		this.tutorCal = tutorCal;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getShortName() {
		return shortName;
	}
	public void setShortName(String shortName) {
		this.shortName = shortName;
	}
	public String getMainYn() {
		return mainYn;
	}
	public void setMainYn(String mainYn) {
		this.mainYn = mainYn;
	}
	public String getMainDisplay() {
		return mainDisplay;
	}
	public void setMainDisplay(String mainDisplay) {
		this.mainDisplay = mainDisplay;
	}
	public String getIconDisplays() {
		return iconDisplays;
	}
	public void setIconDisplays(String iconDisplays) {
		this.iconDisplays = iconDisplays;
	}
	public int getCompleteTime() {
		return completeTime;
	}
	public void setCompleteTime(int completeTime) {
		this.completeTime = completeTime;
	}
	public String getLearnTypes() {
		return learnTypes;
	}
	public void setLearnTypes(String learnTypes) {
		this.learnTypes = learnTypes;
	}
	public int getCredit() {
		return credit;
	}
	public void setCredit(int credit) {
		this.credit = credit;
	}
	public String getLearnTarget() {
		return learnTarget;
	}
	public void setLearnTarget(String learnTarget) {
		this.learnTarget = learnTarget;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public int getProgCheck() {
		return progCheck;
	}
	public void setProgCheck(int progCheck) {
		this.progCheck = progCheck;
	}
	public String getOpenDate() {
		return openDate;
	}
	public void setOpenDate(String openDate) {
		this.openDate = openDate;
	}
	public String getAppDate() {
		return appDate;
	}
	public void setAppDate(String appDate) {
		this.appDate = appDate;
	}
	public int getRecruit() {
		return recruit;
	}
	public void setRecruit(int recruit) {
		this.recruit = recruit;
	}
	public int getExamPeriod() {
		return examPeriod;
	}
	public void setExamPeriod(int examPeriod) {
		this.examPeriod = examPeriod;
	}
	public int getMainPrice() {
		return mainPrice;
	}
	public void setMainPrice(int mainPrice) {
		this.mainPrice = mainPrice;
	}
	public int getSubPrice() {
		return subPrice;
	}
	public void setSubPrice(int subPrice) {
		this.subPrice = subPrice;
	}
	public int getLinkServer() {
		return linkServer;
	}
	public void setLinkServer(int linkServer) {
		this.linkServer = linkServer;
	}
	public String getGroupYn() {
		return groupYn;
	}
	public void setGroupYn(String groupYn) {
		this.groupYn = groupYn;
	}
	public String getMobileYn() {
		return mobileYn;
	}
	public void setMobileYn(String mobileYn) {
		this.mobileYn = mobileYn;
	}
	public String getIndexUrl() {
		return indexUrl;
	}
	public void setIndexUrl(String indexUrl) {
		this.indexUrl = indexUrl;
	}
	public String getTastingUrl() {
		return tastingUrl;
	}
	public void setTastingUrl(String tastingUrl) {
		this.tastingUrl = tastingUrl;
	}
	public String getSampleUrl() {
		return sampleUrl;
	}
	public void setSampleUrl(String sampleUrl) {
		this.sampleUrl = sampleUrl;
	}
	public String getWidth() {
		return width;
	}
	public void setWidth(String width) {
		this.width = width;
	}
	public String getHeight() {
		return height;
	}
	public void setHeight(String height) {
		this.height = height;
	}
	public int getSelpPeriod() {
		return selpPeriod;
	}
	public void setSelpPeriod(int selpPeriod) {
		this.selpPeriod = selpPeriod;
	}
	public String getDupDisYn() {
		return dupDisYn;
	}
	public void setDupDisYn(String dupDisYn) {
		this.dupDisYn = dupDisYn;
	}
	public String getAcceptYn() {
		return acceptYn;
	}
	public void setAcceptYn(String acceptYn) {
		this.acceptYn = acceptYn;
	}
	public String getPurpose() {
		return purpose;
	}
	public void setPurpose(String purpose) {
		this.purpose = purpose;
	}
	public String getCurriculum() {
		return curriculum;
	}
	public void setCurriculum(String curriculum) {
		this.curriculum = curriculum;
	}
	public String getSummary() {
		return summary;
	}
	public void setSummary(String summary) {
		this.summary = summary;
	}
	public String getInstructor() {
		return instructor;
	}
	public void setInstructor(String instructor) {
		this.instructor = instructor;
	}
	public String getNote() {
		return note;
	}
	public void setNote(String note) {
		this.note = note;
	}
	public String getMobileSummary() {
		return mobileSummary;
	}
	public void setMobileSummary(String mobileSummary) {
		this.mobileSummary = mobileSummary;
	}
	public String getDeveloper() {
		return developer;
	}
	public void setDeveloper(String developer) {
		this.developer = developer;
	}
	public String getResTel() {
		return resTel;
	}
	public void setResTel(String resTel) {
		this.resTel = resTel;
	}
	public String getComName() {
		return comName;
	}
	public void setComName(String comName) {
		this.comName = comName;
	}
	public String getComTel() {
		return comTel;
	}
	public void setComTel(String comTel) {
		this.comTel = comTel;
	}
	public String getProduceDate() {
		return produceDate;
	}
	public void setProduceDate(String produceDate) {
		this.produceDate = produceDate;
	}
	public String getStorageLoc() {
		return storageLoc;
	}
	public void setStorageLoc(String storageLoc) {
		this.storageLoc = storageLoc;
	}
	public String getHistory() {
		return history;
	}
	public void setHistory(String history) {
		this.history = history;
	}
	public String getRemarks() {
		return remarks;
	}
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
	public MemberVO getCompany() {
		return company;
	}
	public void setCompany(MemberVO company) {
		this.company = company;
	}
	public MemberVO getTeacher() {
		return teacher;
	}
	public void setTeacher(MemberVO teacher) {
		this.teacher = teacher;
	}
	public BookVO getMainBook() {
		return mainBook;
	}
	public void setMainBook(BookVO mainBook) {
		this.mainBook = mainBook;
	}
	public BookVO getSubBook() {
		return subBook;
	}
	public void setSubBook(BookVO subBook) {
		this.subBook = subBook;
	}
	public AttachFileVO getMainImg() {
		return mainImg;
	}
	public CodeVO getBookCode() {
		return bookCode;
	}
	public void setBookCode(CodeVO bookCode) {
		this.bookCode = bookCode;
	}
	public CodeVO getCourseCode() {
		return courseCode;
	}
	public void setCourseCode(CodeVO courseCode) {
		this.courseCode = courseCode;
	}
	public void setMainImg(AttachFileVO mainImg) {
		this.mainImg = mainImg;
	}
	public List<CardinalVO> getCardinalList() {
		return cardinalList;
	}
	public void setCardinalList(List<CardinalVO> cardinalList) {
		this.cardinalList = cardinalList;
	}
	public List<ChapterVO> getChapterList() {
		return chapterList;
	}
	public void setChapterList(List<ChapterVO> chapterList) {
		this.chapterList = chapterList;
	}
	public CodeVO getSubCourseCode() {
		return subCourseCode;
	}
	public void setSubCourseCode(CodeVO subCourseCode) {
		this.subCourseCode = subCourseCode;
	}
	public String getTrainProcessId() {
		return trainProcessId;
	}
	public void setTrainProcessId(String trainProcessId) {
		this.trainProcessId = trainProcessId;
	}
	public int getReviewPeriod() {
		return reviewPeriod;
	}
	public void setReviewPeriod(int reviewPeriod) {
		this.reviewPeriod = reviewPeriod;
	}
	public int getCompPercentQuiz() {
		return compPercentQuiz;
	}
	public void setCompPercentQuiz(int compPercentQuiz) {
		this.compPercentQuiz = compPercentQuiz;
	}
	public int getCompPercentExam() {
		return compPercentExam;
	}
	public void setCompPercentExam(int compPercentExam) {
		this.compPercentExam = compPercentExam;
	}
	public int getCompPercentProg() {
		return compPercentProg;
	}
	public void setCompPercentProg(int compPercentProg) {
		this.compPercentProg = compPercentProg;
	}
	public int getCompleteTotal() {
		return completeTotal;
	}
	public int getCompScoreQuiz() {
		return compScoreQuiz;
	}
	public void setCompScoreQuiz(int compScoreQuiz) {
		this.compScoreQuiz = compScoreQuiz;
	}
	public int getCompScoreExam() {
		return compScoreExam;
	}
	public void setCompScoreExam(int compScoreExam) {
		this.compScoreExam = compScoreExam;
	}
	public int getCompScoreProg() {
		return compScoreProg;
	}
	public void setCompScoreProg(int compScoreProg) {
		this.compScoreProg = compScoreProg;
	}
	public void setCompleteTotal(int completeTotal) {
		this.completeTotal = completeTotal;
	}
	public String getCheckOnline() {
		return checkOnline;
	}
	public void setCheckOnline(String checkOnline) {
		this.checkOnline = checkOnline;
	}
	public List<PaymentAdminVO> getPaymentList() {
		return paymentList;
	}
	public void setPaymentList(List<PaymentAdminVO> paymentList) {
		this.paymentList = paymentList;
	}
	public String getSurveyYn() {
		return surveyYn;
	}
	public void setSurveyYn(String surveyYn) {
		this.surveyYn = surveyYn;
	}
	public String getSurveyTemplateTitle() {
		return surveyTemplateTitle;
	}
	public void setSurveyTemplateTitle(String surveyTemplateTitle) {
		this.surveyTemplateTitle = surveyTemplateTitle;
	}
	public String getPortYn() {
		return portYn;
	}
	public void setPortYn(String portYn) {
		this.portYn = portYn;
	}
	public String getCodeTxt() {
		return codeTxt;
	}
	public void setCodeTxt(String codeTxt) {
		this.codeTxt = codeTxt;
	}
	public AttachFileVO getCurriculumFile() {
		return curriculumFile;
	}
	public void setCurriculumFile(AttachFileVO curriculumFile) {
		this.curriculumFile = curriculumFile;
	}
	public String getMileageYn() {
		return mileageYn;
	}
	public void setMileageYn(String mileageYn) {
		this.mileageYn = mileageYn;
	}
	
}
