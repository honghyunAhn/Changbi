package com.changbi.tt.dev.data.vo;

import forFaith.dev.vo.CommonVO;

@SuppressWarnings("serial")
public class BoardCommentVO extends CommonVO {
	// 검색조건
    private BoardCommentVO search;
    
    private int id; 			//게시글 마스터 ID(SEQ로 ID저장)
    private int boardId; 		//게시글 ID
    private String userId;		//작성자 USER ID(사용자가 답글 남긴 경우)
    private String comment;		//댓글 내용
    private String category; //원글의 댓글(M)/답글의 댓글(S)
    
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public BoardCommentVO getSearch() {
		return search;
	}
	public void setSearch(BoardCommentVO search) {
		this.search = search;
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
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getComment() {
		return comment;
	}
	public void setComment(String comment) {
		this.comment = comment;
	}
}
