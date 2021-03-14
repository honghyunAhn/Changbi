package com.changbi.tt.dev.data.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.changbi.tt.dev.data.dao.BoardDAO;
import com.changbi.tt.dev.data.vo.BoardCommentVO;
import com.changbi.tt.dev.data.vo.BoardReplyVO;
import com.changbi.tt.dev.data.vo.BoardVO;
import com.changbi.tt.dev.data.vo.CardinalVO;
import com.changbi.tt.dev.data.vo.NoteVO;
import com.changbi.tt.dev.data.vo.SurveyItemVO;
import com.changbi.tt.dev.data.vo.SurveyVO;

import forFaith.dev.dao.AttachFileDAO;
import forFaith.dev.vo.AttachFileVO;
import forFaith.util.StringUtil;

@Service(value="data.boardService")
public class BoardService {

	@Autowired
	private BoardDAO boardDao;
	
	@Autowired
    private AttachFileDAO fileDao;

	// 게시판관리 목록
	public List<BoardVO> boardList(BoardVO board) throws Exception{
		return boardDao.boardList(board);
	}

	// 게시판 리스트 총 갯수
    public int boardTotalCnt(BoardVO board) throws Exception {
        return boardDao.boardTotalCnt(board);
    }

	// 게시판 관리  정보
	public BoardVO boardInfo(BoardVO board) throws Exception {
	    return boardDao.boardInfo(board);
	}

	// 게시판관리 등록
	public void boardReg(BoardVO board) throws Exception {
		// ID 가 존재하지 않으면 저장 있으면 update
		boardDao.boardReg(board);
		
		if(board.getId() > 0) {
        	// 파일 사용 가능 상태로 변경 처리
            // useYn을 Y로 바꾼다.
            List<AttachFileVO> attachFileList = new ArrayList<AttachFileVO>();
            
 			if(board.getFile1() != null && !StringUtil.isEmpty(board.getFile1().getFileId())) {
 				attachFileList.add(board.getFile1());
 			}
 			
 			if(board.getFile2() != null && !StringUtil.isEmpty(board.getFile2().getFileId())) {
 				attachFileList.add(board.getFile2());
 			}
            
			// 파일 사용 가능 상태로 변경
			if(attachFileList.size() > 0) {
				fileDao.attachFileUse(attachFileList);
			}
        }
	}

	// 게시판관리 삭제
	public int boardDel(BoardVO board) throws Exception{
		return boardDao.boardDel(board);
	}

	// 답글 등록
	public void boardReplyReg(BoardReplyVO boardReply) throws Exception {
		// ID 가 존재하지 않으면 저장 있으면 update
		boardDao.boardReplyReg(boardReply);
	}
	
	// 답글 상세정보
	public BoardReplyVO boardReplyInfo(BoardReplyVO boardReply) throws Exception {
	    return boardDao.boardReplyInfo(boardReply);
	}
	
	// 답글 삭제
	public int boardReplyDel(BoardReplyVO boardReply) throws Exception{
		return boardDao.boardReplyDel(boardReply);
	}
	
	// 팝업용 게시판관리 목록
	public List<BoardVO> popupBoardList(BoardVO board) throws Exception{
		return boardDao.popupBoardList(board);
	}

	// 팝업용 게시판 리스트 총 갯수
    public int popupBoardTotalCnt(BoardVO board) throws Exception {
        return boardDao.popupBoardTotalCnt(board);
    }
    
    // 팝업용 게시판 관리  정보
  	public BoardVO popupBoardInfo(BoardVO board) throws Exception {
  	    return boardDao.popupBoardInfo(board);
  	}
	
	// 연수설문관리 리스트
	public List<SurveyVO> surveyList(SurveyVO survey) throws Exception {
		return boardDao.surveyList(survey);
	}
	
	// 연수설문관리 리스트 총 갯수
	public int surveyTotalCnt(SurveyVO survey) throws Exception {
		return boardDao.surveyTotalCnt(survey);
	}
	
	// 연수설문관리 상세
	public SurveyVO surveyInfo(SurveyVO survey) throws Exception {
		return boardDao.surveyInfo(survey);
	}
	
	// 연수설문과 매핑된 기수리스트
	public List<CardinalVO> surveyCardinalList(SurveyVO survey) throws Exception {
		return boardDao.surveyCardinalList(survey);
	}
	
	// 연수설문관리 등록
	public void surveyReg(SurveyVO survey) throws Exception {
		boardDao.surveyReg(survey);
	}
		
	// 연수설문관리 삭제
	public int surveyDel(SurveyVO survey) throws Exception {
		
		// TODO : 설문마스터 삭제시 설문아이템 모두를 삭제 하는지 확인필요
		
		return boardDao.surveyDel(survey);
	}
	
	// 연수설문 문항 리스트
	public List<SurveyItemVO> surveyItemList(SurveyItemVO surveyItem) throws Exception {
		return boardDao.surveyItemList(surveyItem);
	}
	
	// 연수설문 문항 상세
	public SurveyItemVO surveyItemInfo(SurveyItemVO surveyItem) throws Exception {
		return boardDao.surveyItemInfo(surveyItem);
	}
	
	// 연수설문 문항 등록
	public void surveyItemReg(SurveyItemVO surveyItem) throws Exception {
		boardDao.surveyItemReg(surveyItem);
	}
	
	// 연수설문 연수만족도 문항 등록 개수
	public int surveyItemVerification(SurveyItemVO surveyItem) throws Exception {
		return boardDao.surveyItemVerification(surveyItem);
	}
	
	// 연수설문 문항 삭제
	public int surveyItemDel(SurveyItemVO surveyItem) throws Exception {
		return boardDao.surveyItemDel(surveyItem);
	}
	
	// 쪽지 리스트
	public List<NoteVO> noteList(NoteVO note) throws Exception {
		return boardDao.noteList(note);
	}
	
	// 쪽지 리스트 총 갯수
	public int noteTotalCnt(NoteVO note) throws Exception {
		return boardDao.noteTotalCnt(note);
	}
	
	// 쪽지 상세
	public NoteVO noteInfo(NoteVO note) throws Exception {
		return boardDao.noteInfo(note);
	}
	
	// 쪽지 발송
	public void noteReg(NoteVO note) throws Exception {
		boardDao.noteReg(note);
	}
	
	// 쪽지 읽음
	public int noteReadUdt(NoteVO note) throws Exception {
		return boardDao.noteReadUdt(note);
	}
	
	// 과정별 게시물 리스트
	public List<BoardVO> courseBoardList(BoardVO board) throws Exception {
		return boardDao.courseBoardList(board);
	}
	
	// 과정별 게시물 리스트 카운트
	public int courseBoardTotalCnt(BoardVO board) throws Exception {
		return boardDao.courseBoardTotalCnt(board);
	}
	
	// 과정별 게시물 상세
	public BoardVO courseBoardInfo(BoardVO board) throws Exception {
		return boardDao.courseBoardInfo(board);
	}
	
	//댓글 입력	
	public int boardCommentReg(BoardCommentVO boardComment) throws Exception {
		int result = 0;
		result = boardDao.boardCommentReg(boardComment);
		return result;
	}
	
	//댓글 조회
	public List<BoardCommentVO> boardCommentList(BoardCommentVO boardComment) throws Exception {	
		return boardDao.boardCommentList(boardComment);
	}

	//댓글 수정 
	public int boardCommentUpdate(BoardCommentVO boardComment) throws Exception  {
		int result = 0;
		result = boardDao.boardCommentUpdate(boardComment);
		return result;
	}
	
	//댓글 삭제
	public int boardCommentDel(int id) throws Exception{
		int result =0;
		result = boardDao.boardCommentDel(id);
		return result;
	}

	//자유게시판 답글 수정
	public int freeBoardReplyUpdate(BoardReplyVO boardReply) throws Exception {
		int result = 0;
		result =boardDao.freeBoardReplyUpdate(boardReply);
		return result;
	}
	//FAQ 리스트 가져오기
	public List<HashMap<String, Object>> getFaqList(HashMap<String, Object> params) throws Exception {
		return boardDao.getFaqList(params);
	}
	//FAQ 신규생성
	public int insertFaq(HashMap<String, Object> params) throws Exception {
		return boardDao.insertFaq(params);
	}
	//FAQ 삭제
	public int deleteFaq(HashMap<String, Object> params) throws Exception {
		return boardDao.deleteFaq(params);
	}
	//전체 공지사항 리스트 가져오기
	public List<HashMap<String, Object>> selectNotice(HashMap<String, Object> params) throws Exception {
		return boardDao.selectNotice(params);
	}
	
	//전체 공지사항 신규생성
	public int insertNotice(HashMap<String, Object> params) throws Exception {
		return boardDao.insertNotice(params);
	}
	//전체 공지사항 삭제
	public int deleteNotice(HashMap<String, Object> params) throws Exception {
		return boardDao.deleteNotice(params);
	}

	//전체 공지사항 첨부파일 정보생성
	public int insertNoticeFileInfo(HashMap<String, Object> params) throws Exception {
		return boardDao.insertNoticeFileInfo(params);
	}
}