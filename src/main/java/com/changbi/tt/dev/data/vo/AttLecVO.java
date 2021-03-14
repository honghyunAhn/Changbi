package com.changbi.tt.dev.data.vo;

import java.util.List;

import forFaith.dev.vo.CommonVO;
import forFaith.dev.vo.SubChapVO;

/**
 * @Class Name : AttLecVO.java
 * @Description : 수강이력
 * @Modification Information
 * @
 * @  수정일                 수정자                       수정내용
 * @ -------    --------    ---------------------------
 * @ 2017.03.21   김준석                      최초 생성
 *
 *  @author kjs
 *  @since 2017.03.21
 *  @version 1.0
 *  @see
 *
 */

@SuppressWarnings("serial")
public class AttLecVO extends CommonVO {
	// 검색조건
    private AttLecVO search;
    
	private int id;		    					// 수강이력 마스터 ID
	private int chasi;							// 차시
	private int study;							// 교육시간(분)
	private int chk;							// 체크(분)
	private int learnTime;						// 학습시간(초단위)
	private String progYn;						// 차시별 체크(분)가 지나면 Y로 변경 시켜줌(진도 완료)

	private LearnAppVO learnApp;				// 수강신청 ID
	private UserVO user;						// 사용자
	private CardinalVO cardinal;				// 기수ID
	private CourseVO course;					// 과정ID
	private ChapterVO chapter;					// 챕터ID
	private SubChapVO subchap;					// 세부차시 정보
	
	private List<AttLecHistoryVO> historyList;	// 수강이력 히스토리 
	
    public AttLecVO getSearch() {
        return search;
    }

    public void setSearch(AttLecVO search) {
        this.search = search;
    }

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getChasi() {
		return chasi;
	}

	public void setChasi(int chasi) {
		this.chasi = chasi;
	}

	public int getStudy() {
		return study;
	}

	public void setStudy(int study) {
		this.study = study;
	}

	public int getChk() {
		return chk;
	}

	public void setChk(int chk) {
		this.chk = chk;
	}

	public int getLearnTime() {
		return learnTime;
	}

	public void setLearnTime(int learnTime) {
		this.learnTime = learnTime;
	}

	public String getProgYn() {
		return progYn;
	}

	public void setProgYn(String progYn) {
		this.progYn = progYn;
	}

	public LearnAppVO getLearnApp() {
		return learnApp;
	}

	public void setLearnApp(LearnAppVO learnApp) {
		this.learnApp = learnApp;
	}

	public UserVO getUser() {
		return user;
	}

	public void setUser(UserVO user) {
		this.user = user;
	}

	public CardinalVO getCardinal() {
		return cardinal;
	}

	public void setCardinal(CardinalVO cardinal) {
		this.cardinal = cardinal;
	}

	public CourseVO getCourse() {
		return course;
	}

	public void setCourse(CourseVO course) {
		this.course = course;
	}

	public ChapterVO getChapter() {
		return chapter;
	}

	public void setChapter(ChapterVO chapter) {
		this.chapter = chapter;
	}

	public List<AttLecHistoryVO> getHistoryList() {
		return historyList;
	}

	public void setHistoryList(List<AttLecHistoryVO> historyList) {
		this.historyList = historyList;
	}

	public SubChapVO getSubchap() {
		return subchap;
	}

	public void setSubchap(SubChapVO subchap) {
		this.subchap = subchap;
	}
	
	
}
