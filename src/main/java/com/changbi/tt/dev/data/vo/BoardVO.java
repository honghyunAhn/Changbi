package com.changbi.tt.dev.data.vo;

import forFaith.dev.vo.AttachFileVO;
import forFaith.dev.vo.CodeVO;
import forFaith.dev.vo.CommonVO;

@SuppressWarnings("serial")
public class BoardVO extends CommonVO {
	// 검색조건
    private BoardVO search;
    
    private String category;	//게시글, 댓글 분류를 위한 카테고리
    
    private int id; 			//게시글 마스터 ID(SEQ로 ID저장)
    private String lang = "ko"; //다국어 코드(ko:한국어, en:영어, zh:중국어, ja:일본어)
    private String boardType; 	//게시글 타입(1:공지사항, 2:자료실, 3:FAQ, 4:1:1상담, 5:연수후기)
    private String noticeType; 	//공지구분(1:모집, 2:환영, 3:신설, 4:필독, 5:일반, 6:평가, 7:공문)
    private String faqCode; 	//FAQ인 경우 분류코드
    private String cardinalId;	//기수ID
    private String courseId; 	//과정ID
    private String teacherId; 	//강사ID
    private String userId; 		//작성자 USER ID
    private String attach1File; //첨부 #1 파일
    private String attach2File; //첨부 #2 파일
    private String icon;		//아이콘(1:New, 2:Hot)
    private String topYn = "N"; //탑 고정 YN
    private String title; 		//게시물 제목
    private String comment; 	//게시물 내용
    private int hits; 			//조회수
    private int recommend; 		//추천수
    private int nonrecommend; 	//비추천수
    private int share; 			//공유횟수
    
    private CodeVO faq;			//묻고답하기 분류코드
    
    private BoardReplyVO boardReply;
    private BoardCommentVO boardComment;
    private UserVO user;
    
	private AttachFileVO file1; // 파일1
	private AttachFileVO file2; // 파일2
    
	// 코드성 네임 멤버
	private String noticeTypeName; // 게시글 타입
	
	private CourseVO course; // 과정정보
	
	public BoardVO getSearch() {
		return search;
	}
	public void setSearch(BoardVO search) {
		this.search = search;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getLang() {
		return lang;
	}
	public void setLang(String lang) {
		this.lang = lang;
	}
	public String getBoardType() {
		return boardType;
	}
	public void setBoardType(String boardType) {
		this.boardType = boardType;
	}
	public String getNoticeType() {
		return noticeType;
	}
	public void setNoticeType(String noticeType) {
		this.noticeType = noticeType;
	}
	public String getFaqCode() {
		return faqCode;
	}
	public void setFaqCode(String faqCode) {
		this.faqCode = faqCode;
	}
	public String getCardinalId() {
		return cardinalId;
	}
	public void setCardinalId(String cardinalId) {
		this.cardinalId = cardinalId;
	}
	public String getCourseId() {
		return courseId;
	}
	public void setCourseId(String courseId) {
		this.courseId = courseId;
	}
	public String getTeacherId() {
		return teacherId;
	}
	public void setTeacherId(String teacherId) {
		this.teacherId = teacherId;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getAttach1File() {
		return attach1File;
	}
	public void setAttach1File(String attach1File) {
		this.attach1File = attach1File;
	}
	public String getAttach2File() {
		return attach2File;
	}
	public void setAttach2File(String attach2File) {
		this.attach2File = attach2File;
	}
	public String getIcon() {
		return icon;
	}
	public void setIcon(String icon) {
		this.icon = icon;
	}
	public String getTopYn() {
		return topYn;
	}
	public void setTopYn(String topYn) {
		this.topYn = topYn;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getComment() {
		return comment;
	}
	public void setComment(String comment) {
		this.comment = comment;
	}
	public int getHits() {
		return hits;
	}
	public void setHits(int hits) {
		this.hits = hits;
	}
	public int getRecommend() {
		return recommend;
	}
	public void setRecommend(int recommend) {
		this.recommend = recommend;
	}
	public int getNonrecommend() {
		return nonrecommend;
	}
	public void setNonrecommend(int nonrecommend) {
		this.nonrecommend = nonrecommend;
	}
	public int getShare() {
		return share;
	}
	public void setShare(int share) {
		this.share = share;
	}
	public CodeVO getFaq() {
		return faq;
	}
	public void setFaq(CodeVO faq) {
		this.faq = faq;
	}
	public BoardReplyVO getBoardReply() {
		return boardReply;
	}
	public void setBoardReply(BoardReplyVO boardReply) {
		this.boardReply = boardReply;
	}
	public BoardCommentVO getBoardComment() {
		return boardComment;
	}
	public void setBoardComment(BoardCommentVO boardComment) {
		this.boardComment = boardComment;
	}
	public UserVO getUser() {
		return user;
	}
	public void setUser(UserVO user) {
		this.user = user;
	}
	public AttachFileVO getFile1() {
		return file1;
	}
	public void setFile1(AttachFileVO file1) {
		this.file1 = file1;
	}
	public AttachFileVO getFile2() {
		return file2;
	}
	public void setFile2(AttachFileVO file2) {
		this.file2 = file2;
	}
	public String getNoticeTypeName() {
		return noticeTypeName;
	}
	public void setNoticeTypeName(String noticeTypeName) {
		this.noticeTypeName = noticeTypeName;
	}
	public CourseVO getCourse() {
		return course;
	}
	public void setCourse(CourseVO course) {
		this.course = course;
	}
}
