package com.changbi.tt.dev.data.vo;

import forFaith.dev.vo.AttachFileVO;
import forFaith.dev.vo.CommonVO;

@SuppressWarnings("serial")
public class BoardReplyVO extends CommonVO {
	// 검색조건
    private BoardReplyVO search;
    
    private String category;	//게시글, 댓글 분류를 위한 카테고리
    
    private int id; //답글 마스터 ID(SEQ로 ID저장)
    private int boardId; //게시글 ID
    private int parentId; //부모 답글 ID(답글에 답글을 다는 경우)
    private String userId; //작성자 USER ID(사용자가 답글 남긴 경우)
    private int depth; //답글 뎁스
    private String attach1File; //첨부 #1 파일
    private String attach2File; //첨부 #2 파일
    private String title; //게시물 제목
    private String comment; //게시물 내용
    private int hits; //조회수
    private int recommend; //추천수
    private int nonrecommend; //비추천수
    private int share; //공유횟수
    private int orderNum; //DISPLAY순서(게시판 기준으로 ORDER)
    
    private String boardType; //게시물 유형
    
	private AttachFileVO file1; // 파일1
	private AttachFileVO file2; // 파일2
    
    
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
	public BoardReplyVO getSearch() {
		return search;
	}
	public void setSearch(BoardReplyVO search) {
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
	public int getBoardId() {
		return boardId;
	}
	public void setBoardId(int boardId) {
		this.boardId = boardId;
	}
	public int getParentId() {
		return parentId;
	}
	public void setParentId(int parentId) {
		this.parentId = parentId;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public int getDepth() {
		return depth;
	}
	public void setDepth(int depth) {
		this.depth = depth;
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
	public int getOrderNum() {
		return orderNum;
	}
	public void setOrderNum(int orderNum) {
		this.orderNum = orderNum;
	}
	public String getBoardType() {
		return boardType;
	}
	public void setBoardType(String boardType) {
		this.boardType = boardType;
	}
}
