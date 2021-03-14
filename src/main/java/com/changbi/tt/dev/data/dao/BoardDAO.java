package com.changbi.tt.dev.data.dao;

import java.util.HashMap;
import java.util.List;

import com.changbi.tt.dev.data.vo.BoardCommentVO;
import com.changbi.tt.dev.data.vo.BoardReplyVO;
import com.changbi.tt.dev.data.vo.BoardVO;
import com.changbi.tt.dev.data.vo.CardinalVO;
import com.changbi.tt.dev.data.vo.NoteVO;
import com.changbi.tt.dev.data.vo.SurveyItemVO;
import com.changbi.tt.dev.data.vo.SurveyVO;

//changbi tt상의 게시물관리 탭에서 사용하는 모든 method
public interface BoardDAO {

	// 게시판 리스트 조회
	List<BoardVO> boardList(BoardVO board) throws Exception;
	
	// 게시판 리스트 총 갯수
	int boardTotalCnt(BoardVO board) throws Exception;
	
	// 게시판 상세 조회
	BoardVO boardInfo(BoardVO board) throws Exception;
	
	// 게시판 등록
	void boardReg(BoardVO board) throws Exception;
	
	// 게시판 삭제
	int boardDel(BoardVO board) throws Exception;
	
	// 답글 등록
	void boardReplyReg(BoardReplyVO boardReply) throws Exception;
	
	// 답글 상세조회
	BoardReplyVO boardReplyInfo(BoardReplyVO boardReply) throws Exception;
	
	// 답글 삭제
	int boardReplyDel(BoardReplyVO boardReply) throws Exception;
	
	// 팝업용 게시판관리 목록
	List<BoardVO> popupBoardList(BoardVO board) throws Exception;

	// 팝업용 게시판 리스트 총 갯수
    int popupBoardTotalCnt(BoardVO board) throws Exception;
	
    //팝업용 게시판 관리  정보
  	BoardVO popupBoardInfo(BoardVO board) throws Exception;
  	
	// 연수설문관리 리스트
	List<SurveyVO> surveyList(SurveyVO survey) throws Exception;
	
	// 연수설문관리 리스트 총 갯수
	int surveyTotalCnt(SurveyVO survey) throws Exception;

	// 연수설문관리 상세
	SurveyVO surveyInfo(SurveyVO survey) throws Exception;
	
	// 연수설문과 매핑된 기수리스트
	List<CardinalVO> surveyCardinalList(SurveyVO survey) throws Exception;
	
	// 연수설문관리 등록
	void surveyReg(SurveyVO survey) throws Exception;
	
	// 연수설문관리 삭제
	int surveyDel(SurveyVO survey) throws Exception;
	
	// 연수설문 문항 리스트
	List<SurveyItemVO> surveyItemList(SurveyItemVO surveyItem) throws Exception;
	
	// 연수설문 문항 상세
	SurveyItemVO surveyItemInfo(SurveyItemVO surveyItem) throws Exception;
	
	// 연수설문 문항 등록
	void surveyItemReg(SurveyItemVO surveyItem) throws Exception;
	
	// 연수설문 문항 삭제
	int surveyItemDel(SurveyItemVO surveyItem) throws Exception;
	
	// 연수설문 연수만족도 문항 등록 개수
	int surveyItemVerification(SurveyItemVO surveyItem) throws Exception;
	
	// 쪽지 리스트
	List<NoteVO> noteList(NoteVO note) throws Exception;
	
	// 쪽지 리스트 총 갯수
	int noteTotalCnt(NoteVO note) throws Exception;	
	
	// 쪽지 상세
	NoteVO noteInfo(NoteVO note) throws Exception;
	
	// 쪽지 발송
	void noteReg(NoteVO note) throws Exception;
	
	// 쪽지 읽음
	int noteReadUdt(NoteVO note) throws Exception;
	
	// 과정별 게시물 리스트
	List<BoardVO> courseBoardList(BoardVO board) throws Exception;
	
	// 과정별 게시물 리스트 카운트
	int courseBoardTotalCnt(BoardVO board) throws Exception;
	
	// 과정별 게시물 상세
	BoardVO courseBoardInfo(BoardVO board) throws Exception;
	
	//댓글 입력
    int boardCommentReg(BoardCommentVO boardComment) throws Exception;

	//댓글 조회
	List<BoardCommentVO> boardCommentList(BoardCommentVO boardComment) throws Exception;
	
	//댓글 수정 
	int boardCommentUpdate(BoardCommentVO boardComment) throws Exception;

	//댓글 삭제
	int boardCommentDel(int id) throws Exception;

	//자유게시판 답글 수정
	int freeBoardReplyUpdate(BoardReplyVO boardReply) throws Exception;

	//FAQ 리스트 가져오기
	List<HashMap<String, Object>> getFaqList(HashMap<String, Object> params) throws Exception;
	
	//FAQ 신규생성
	int insertFaq(HashMap<String, Object> params) throws Exception;
	
	//FAQ 삭제
	int deleteFaq(HashMap<String, Object> params) throws Exception;
	
	//전체 공지사항 리스트 가져오기
	List<HashMap<String, Object>> selectNotice(HashMap<String, Object> params) throws Exception;
	
	//전체 공지사항 신규생성
	int insertNotice(HashMap<String, Object> params) throws Exception;
	
	//전체 공지사항 삭제
	int deleteNotice(HashMap<String, Object> params) throws Exception;
	
	//전체 공지사항 첨부파일 정보생성
	int insertNoticeFileInfo(HashMap<String, Object> params) throws Exception;

}