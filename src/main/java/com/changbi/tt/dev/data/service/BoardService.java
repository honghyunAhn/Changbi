package com.changbi.tt.dev.data.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.changbi.tt.dev.data.controller.BoardController;
import com.changbi.tt.dev.data.dao.BoardDAO;
import com.changbi.tt.dev.data.vo.BoardCommentVO;
import com.changbi.tt.dev.data.vo.BoardFileVO;
import com.changbi.tt.dev.data.vo.BoardReplyVO;
import com.changbi.tt.dev.data.vo.BoardVO;
import com.changbi.tt.dev.data.vo.CardinalVO;
import com.changbi.tt.dev.data.vo.NoteVO;
import com.changbi.tt.dev.data.vo.OnlineConsultingVO;
import com.changbi.tt.dev.data.vo.SurveyItemVO;
import com.changbi.tt.dev.data.vo.SurveyVO;
import com.changbi.tt.dev.util.FileService;

import forFaith.dev.dao.AttachFileDAO;
import forFaith.dev.vo.AttachFileVO;
import forFaith.util.StringUtil;

@Service(value="data.boardService")
public class BoardService {
	
	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);

	@Autowired
	private BoardDAO boardDao;
	
	@Autowired
    private AttachFileDAO fileDao;
	
	/**
	 * file.propertices 의 등록된 도서관리 공지사항 파일 경로
	 */
	@Value("#{props['edu.book.board_file']}")
	private String eduBookBoardFile;
	
	/**
	 * file.propertices 의 등록된 도서관리 동영상 게시판 파일 경로
	 */
	@Value("#{props['edu.book.board_movie']}")
	private String eduBookBoardMovie;
	
	/**
	 * file.propertices 의 등록된 도서관리 사진 게시판 파일 경로
	 */
	@Value("#{props['edu.book.board_photo']}")
	private String eduBookBoardPhoto;
	
	/**
	 * file.propertices 의 등록된 도서관리 질문 게시판 파일 경로
	 */
	@Value("#{props['edu.book.board_question']}")
	private String eduBookBoardQuestion;
	
	/**
	 * file.propertices 의 등록된 모집홍보 공지사항 파일 경로
	 */
	@Value("#{props['edu.apply.board_file']}")
	private String eduApplyBoardFile;

	/**
	 * file.propertices 의 등록된 모집홍보 동영상 게시판 파일 경로
	 */
	@Value("#{props['edu.apply.board_movie']}")
	private String eduApplyBoardMovie;

	/**
	 * file.propertices 의 등록된 모집홍보 사진 게시판 파일 경로
	 */
	@Value("#{props['edu.apply.board_photo']}")
	private String eduApplyBoardPhoto;

	/**
	 * file.propertices 의 등록된 모집홍보 질문 게시판 파일 경로
	 */
	@Value("#{props['edu.apply.board_question']}")
	private String eduApplyBoardQuestion;

	/**
	 * file.propertices 의 등록된 과정 기수 등록 이미지 파일 경로
	 */
	@Value("#{props['edu.apply.curriculum_gisu_insert_image']}")
	private String eduApplyCurriculumGisuInsertImage;
	
	/**
	 * file.propertices 의 등록된 서브 배너 등록 이미지 파일 경로
	 */
	@Value("#{props['edu.admin.subbanner_save_image']}")
	private String eduAdminSubbanerSaveImage;
	
	/**
	 * file.propertices 의 등록된 배너 등록 이미지 파일 경로
	 */
	@Value("#{props['edu.admin.banner_save_image']}")
	private String eduAdminBannerSaveImage;
	
	/**
	 * file.propertices 의 등록된 과정 기수 세부 등록 이미지 파일 경로
	 */
	@Value("#{props['edu.admin.curriculum_gisu_insert_image']}")
	private String eduAdminCurriculumGisuInsertImage;
	
	/**
	 * file.propertices 의 등록된 메일 관련 파일 경로
	 */
	@Value("#{props['edu.apply.mail']}")
	private String eduApplyMailPath;

	/**
	 * file.propertices 의 등록된 잡페어 기업메인 공지사항 파일
	 */
	@Value("#{props['fap.company.board_file']}")
	private String fapCompanyBoardFile;
	
	/**
	 * file.propertices 의 등록된 잡페어 기업메인 공지사항 동영상
	 */
	@Value("#{props['fap.company.board_movie']}")
	private String fapCompanyBoardMovie;
	
	/**
	 * file.propertices 의 등록된 잡페어 기업메인 공지사항 사진
	 */
	@Value("#{props['fap.company.board_photo']}")
	private String fapCompanyBoardPhoto;
	
	/**
	 * file.propertices 의 등록된 잡페어 기업메인 공지사항 질문
	 */
	@Value("#{props['fap.company.board_question']}")
	private String fapCompanyBoardQuestion;
	
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
	public List<HashMap<String, Object>> allBoardList(HashMap<String, Object> params) throws Exception {
		return boardDao.allBoardList(params);
	}
	
	public int allBoardListTotalCnt(HashMap<String, Object> params) throws Exception {
		return boardDao.allBoardListTotalCnt(params);
	}
	public List<HashMap<String, Object>> boardListBySeq(HashMap<String, Object> params) throws Exception {
		return boardDao.boardListBySeq(params);
	}
	
	public int boardListBySeqTotalCnt(HashMap<String, Object> params) throws Exception {
		return boardDao.boardListBySeqTotalCnt(params);
	}
	public HashMap<String, Object> board_gb_search(HashMap<String, Object> params) throws Exception {
		return boardDao.board_gb_search(params);
	}
	//게시글 상세
	public HashMap<String, Object> boardDetail(HashMap<String, Object> params) throws Exception {
		return boardDao.boardDetail(params);
	}
	
	//조회수 업데이트
	public int board_contents_hit_update(HashMap<String, Object> params) throws Exception {
		return boardDao.board_contents_hit_update(params);
	}
	
	public ArrayList<HashMap<String, Object>> boardFiles(String seq) {

		HashMap<String, Object> param = new HashMap<String, Object>();
		param.put("boardSeq", seq);
		return boardDao.boardFile(param);
	}

	public HashMap<String, Object> boardFileDetail(String seq) {
		HashMap<String, Object> param = new HashMap<String, Object>();
		param.put("fileSeq", seq);
		return boardDao.boardFileDetail(param);
	}
	
	/**
	 * @Method Name : findPath
	 * @Date : 2017. 9. 20.
	 * @User : 이종호
	 * @Param : 공통 그룹코드(공지사항 그룹, 공지사항 타입)
	 * @Return : 해당 게시판의 파일 저장 경로
	 * @Method 설명 : 각각의 파일을 저장할 경로를 구하는 함수
	 */
	public String findPath(String gb, String tp) {
		String path = "";
		// FS
		if (gb.equals("A0300")) {

		}
		// 모집홍보
		else if (gb.equals("A0301")) {
			// 공지사항
			if (tp.equals("A0400")) {
				path = eduApplyBoardFile;
			}
			// 동영상
			else if (tp.equals("A0401")) {
				path = eduApplyBoardMovie;
			}
			// 사진
			else if (tp.equals("A0402")) {
				path = eduApplyBoardPhoto;
			}
			// 질문
			else if (tp.equals("A0403")) {
				path = eduApplyBoardQuestion;
			}
		}
		return path;
	}
	
	//게시글 등록
	public int boardInsert(HashMap<String, Object> params) {
		logger.debug("게시글 세부 내용 등록 서비스 시작");
		int result = boardDao.boardInsert(params);
		logger.debug("게시글 세부 내용 등록 서비스 종료");
		return result;
	}
	
	//게시글 파일 등록
	public void board_file_insert(BoardFileVO boardFile) {
		logger.debug("해당 게시글 파일 정보 등록 서비스 함수 시작");
		boardDao.board_file_insert(boardFile);
		logger.debug("해당 게시글 파일 정보 등록 서비스 함수 종료");
	}
	
	//게시글 삭제
	public int board_contents_delete(int board_content_seq) {
		logger.debug("게시글 세부 내용 삭제 서비스 시작");
		int result = boardDao.board_contents_delete(board_content_seq);
		logger.debug("게시글 세부 내용 삭제 서비스 시작");
		return result;
	}
		
	//	게시글 파일 리스트 삭제
	public void board_file_delete(ArrayList<Integer> board_file_seq_list, ArrayList<String> board_file_saved_list) {
		logger.debug("모집홍보 관리자 게시글 파일 리스트 삭제 서비스 시작");
		String path = "edu/apply/board_file";
		for(int i=0; i<board_file_seq_list.size(); i++){
			FileService.deleteFile(board_file_saved_list.get(i), path);
			boardDao.delete_board_file(board_file_seq_list.get(i));
		}
		logger.debug("모집홍보 관리자 게시글 파일 리스트 삭제 서비스 종료");
	}
	
	/*
	 * 게시글 파일 삭제
	 */
	public void delete_board_file(int board_file_seq, String board_file_saved) {
		logger.debug("모집홍보 관리자 게시글 파일 삭제 서비스 시작");
		String path = "edu/apply/board_file";
		FileService.deleteFile(board_file_saved, path);
		boardDao.delete_board_file(board_file_seq);
		logger.debug("모집홍보 관리자 게시글 파일 삭제 서비스 시작");
	}
	
	/*
	 * 게시글 수정
	 */
	public int board_content_update(HashMap<String, Object> param) {
		logger.debug("게시글 세부 내용 수정 서비스 시작");
		int result = boardDao.board_content_update(param);
		logger.debug("게시글 세부 내용 수정 서비스 종료");
		return result;
	}
	
	/*
	 * 온라인 상담 목록
	 */
	public ArrayList<HashMap<String, Object>> onlineConsultingList(HashMap<String, Object> params) {
		logger.debug("온라인 상담 관리 목록 서비스 시작");
		ArrayList<HashMap<String, Object>> result = boardDao.onlineConsultingList(params);
		logger.debug("온라인 상담 관리 목록 서비스 종료");
		return result;
	}

	public int onlineConsultingListCnt(HashMap<String, Object> params) {
		logger.debug("온라인 상담 관리 목록 카운트 서비스 시작");
		int result = boardDao.onlineConsultingListCnt(params);
		logger.debug("온라인 상담 관리 목록 카운트 서비스 종료");
		return result;
	}
}