package forFaith.dev.dao;

import java.util.List;

import org.springframework.stereotype.Service;

import forFaith.dev.vo.BoardVO;
import forFaith.dev.vo.NoticeVO;

@Service("forFaith.boardDAO")
public interface BoardDAO {

    //게시판관리 리스트
	List<BoardVO> boardList(BoardVO board) throws Exception;

	// 게시판 총 갯수
	int boardTotalCnt(BoardVO board) throws Exception;

	// 게시판관리 정보
	BoardVO boardInfo(BoardVO board) throws Exception;

	// 게시판관리 등록
	void boardReg(BoardVO board) throws Exception;

	//게시판관리 삭제
	int boardDel(BoardVO board) throws Exception;

	// 게시판 사용 여부 변경
    int boardUseChange(List<BoardVO> boardList) throws Exception;

	//게시물 목록
	List<NoticeVO> noticeList(NoticeVO notice) throws Exception;

	//게시물 총 갯수
	int noticeTotalCnt(NoticeVO notice) throws Exception;

	//게시물 정보
	NoticeVO noticeInfo(NoticeVO notice) throws Exception;

	//게시물 등록
	void noticeReg(NoticeVO notice) throws Exception;

	//게시물 삭제
	int noticeDel(NoticeVO notice) throws Exception;

	// 게시물 사용 여부 변경
    int noticeUseChange(List<NoticeVO> noticeList) throws Exception;
}
