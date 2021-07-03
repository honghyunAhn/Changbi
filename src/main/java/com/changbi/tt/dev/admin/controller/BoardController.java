/**
 * Admin 화면 호출 Controller
 * admin Home은 세션 객체 생성 때문에 HomeController에 공통으로 넣지 않았음.
 * 세션 생성이 필요한 경우에는 따로 Contoller를 만들어서 사용하면 좋겠음.
 * 같은 세션인 경우는 HomeController에 공통으로 넣어도 됨.
 * @author : 김준석(2015-06-03)
 */

package com.changbi.tt.dev.admin.controller;

import java.util.ArrayList;
import java.util.HashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.changbi.tt.dev.data.service.BoardService;
import com.changbi.tt.dev.data.vo.BoardCommentVO;
import com.changbi.tt.dev.data.vo.BoardReplyVO;
import com.changbi.tt.dev.data.vo.BoardVO;
import com.changbi.tt.dev.data.vo.NoteVO;
import com.changbi.tt.dev.data.vo.SurveyVO;

import forFaith.dev.service.BaseService;
import forFaith.dev.util.LoginHelper;
import forFaith.dev.vo.CodeVO;
import forFaith.dev.vo.MemberVO;

@Controller(value = "admin.boardController") // Controller value는 중복되면 안된다. value 값을 지정하지 않으면 클래스명이 value가 되므로 같은 클래스명이
												// 존재하면 중복으로 인식
@RequestMapping("/admin/board") // 해당 클래스를 호출 하기 위한 Mapping 기본 값 뒤에 붙는 값에 의해 필요한 함수가 호출 된다.
public class BoardController {

	/**
	 * log를 남기는 객체 생성
	 * 
	 * @author : 김준석(2015-06-03)
	 */
	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);

	@Autowired
	private BoardService boardService;

	@Autowired
	private BaseService baseService;
	/**
	 * file.propertices 의 등록된 모집홍보 공지사항 파일 경로
	 */
	@Value("#{props['edu.apply.board_file']}")
	private String eduApplyBoardFile;

	/**
	 * 게시판 리스트 페이지
	 * 
	 * @throws Exception
	 */
	@RequestMapping(value = "/boardList")
	public void boardList(@ModelAttribute("search") BoardVO board, ModelMap model) throws Exception {

		// 자주묻는질문인경우 FAQ 분류 코드 리스트 저장
		if ("3".equals(board.getBoardType())) {
			// 자주묻는질문인경우 FAQ 분류 코드 리스트 저장
			CodeVO code = new CodeVO();
			code.getCodeGroup().setId("faq");
			code.setUseYn("Y");
			code.setPagingYn("N");
			model.addAttribute("faq", baseService.codeList(code));
		}
	}

	@RequestMapping(value = "/boardEdit")
	public void boardEdit(BoardVO board, ModelMap model) throws Exception {
		if (board != null && board.getId() > 0) {
			// 선택 된 ID가 없으면 바로 edit 화면으로 이동하고 선택 된 ID가 있으면 해당 정보를 가지고 간다.
			model.addAttribute("board", boardService.boardInfo(board));
		}

		// 검색 조건 저장(리스트 페이지로 이동 시 검색 조건을 그대로 유지하기 위해)
		model.addAttribute("search", board);

		// 자주묻는질문인경우 FAQ 분류 코드 리스트 저장
		if ("3".equals(board.getBoardType())) {
			CodeVO code = new CodeVO();
			code.getCodeGroup().setId("faq");
			code.setUseYn("Y");
			code.setPagingYn("N");
			model.addAttribute("faq", baseService.codeList(code));
		}
	}

	@RequestMapping(value = "/boardReplyEdit")
	public void boardReplyEdit(BoardReplyVO boardReply, ModelMap model) throws Exception {
		// if(boardReply != null && boardReply.getId() > 0) {
		if (boardReply != null && "S".equals(boardReply.getCategory())) {
			// 선택 된 ID가 없으면 바로 edit 화면으로 이동하고 선택 된 ID가 있으면 해당 정보를 가지고 간다.
			model.addAttribute("boardReply", boardService.boardReplyInfo(boardReply));
		}

		BoardVO board = new BoardVO();
		board.setId(boardReply.getSearch().getBoardId());
		model.addAttribute("board", boardService.boardInfo(board));

		// 검색 조건 저장(리스트 페이지로 이동 시 검색 조건을 그대로 유지하기 위해)
		model.addAttribute("search", boardReply);
	}

	// 전체 공지사항 리스트 페이지
	@RequestMapping(value = "/noticeList")
	public void noticeList(@RequestParam HashMap<String, Object> params, ModelMap model) throws Exception {
		model.addAttribute("search", params);
	}

	// 전체 공지사항 상세페이지
	@RequestMapping(value = "/noticeEdit")
	public void noticeEdit(@RequestParam HashMap<String, Object> params, ModelMap model) throws Exception {
		model.addAttribute("search", params);
	}

	// faq 리스트 페이지
	@RequestMapping(value = "/faqList")
	public void faqList(@RequestParam HashMap<String, Object> params, ModelMap model) throws Exception {
		model.addAttribute("search", params);
	}

	// faq 상세페이지
	@RequestMapping(value = "/faqEdit")
	public void faqEdit(@RequestParam HashMap<String, Object> params, ModelMap model) throws Exception {
		model.addAttribute("search", params);
	}

	/**
	 * 연수설문관리 리스트 페이지
	 * 
	 * @throws Exception
	 */
	@RequestMapping(value = "/surveyList")
	public void surveyList(@ModelAttribute("search") SurveyVO survey, ModelMap model) throws Exception {

	}

	/**
	 * 연수설문관리 등록(수정) 페이지
	 * 
	 * @throws Exception
	 */
	@RequestMapping(value = "/surveyEdit")
	public void surveyEdit(SurveyVO survey, ModelMap model) throws Exception {
		if (survey != null && survey.getSeq() > 0) {
			// 선택 된 ID가 없으면 바로 edit 화면으로 이동하고 선택 된 ID가 있으면 해당 정보를 가지고 간다.
			model.addAttribute("survey", boardService.surveyInfo(survey));
		}

		CodeVO code = new CodeVO();
		code.getCodeGroup().setId("survey");
		code.setUseYn("Y");
		code.setPagingYn("N");
		model.addAttribute("surveyCodeList", baseService.codeList(code));

		// 검색 조건 저장(리스트 페이지로 이동 시 검색 조건을 그대로 유지하기 위해)
		model.addAttribute("search", survey);
	}

	/**
	 * 연수설문관리 설문문항 정보 페이지
	 * 
	 * @throws Exception
	 */
	@RequestMapping(value = "/surveyItemInfo")
	public void surveyItemInfo(@ModelAttribute("search") SurveyVO survey, ModelMap model) throws Exception {
		if (survey != null && survey.getSeq() > 0) {
			// 선택 된 ID가 없으면 바로 edit 화면으로 이동하고 선택 된 ID가 있으면 해당 정보를 가지고 간다.
			model.addAttribute("survey", boardService.surveyInfo(survey));
		}
	}

	/**
	 * 쪽지 리스트 페이지
	 * 
	 * @throws Exception
	 */
	@RequestMapping(value = "/noteList")
	public void noteList(@ModelAttribute("search") NoteVO note, ModelMap model) throws Exception {

	}

	/**
	 * 쪽지 보내기
	 * 
	 * @throws Exception
	 */
	@RequestMapping(value = "/noteEdit")
	public void noteEdit(NoteVO note, ModelMap model) throws Exception {
		if (note != null && note.getId() > 0) {
			// 선택 된 ID가 없으면 바로 edit 화면으로 이동하고 선택 된 ID가 있으면 해당 정보를 가지고 간다.
			model.addAttribute("note", boardService.noteInfo(note));

			// 받은쪽지이면서 읽지 않은 경우 읽음처리
			if (note.getSearchCondition().equals("receive") && note.getProcYn().equals("N")) {
				boardService.noteReadUdt(note);
			}
		}

		// 검색 조건 저장(리스트 페이지로 이동 시 검색 조건을 그대로 유지하기 위해)
		model.addAttribute("search", note);
	}

	/**
	 * 과정 게시판 리스트 페이지
	 * 
	 * @throws Exception
	 */
	@RequestMapping(value = "/courseBoardList")
	public void courseBoardList(@ModelAttribute("search") BoardVO board, ModelMap model) throws Exception {

	}

	/**
	 * 과정 게시물 상세 페이지
	 * 
	 * @param board
	 * @param model
	 * @throws Exception
	 */
	@RequestMapping(value = "/courseBoardEdit")
	public void courseBoardEdit(BoardVO board, ModelMap model) throws Exception {

		// 로그인 된 관리자 정보
		board.setLoginUser((MemberVO) LoginHelper.getLoginInfo());

		if (board != null && board.getId() > 0) {
			// 선택 된 ID가 없으면 바로 edit 화면으로 이동하고 선택 된 ID가 있으면 해당 정보를 가지고 간다.
			model.addAttribute("board", boardService.courseBoardInfo(board));
		}

		// 검색 조건 저장(리스트 페이지로 이동 시 검색 조건을 그대로 유지하기 위해)
		model.addAttribute("search", board);
	}

	/**
	 * 과정 1:1 상담 답글 작성페이지
	 * 
	 * @param boardReply
	 * @param model
	 * @throws Exception
	 */
	@RequestMapping(value = "/courseBoardReplyEdit")
	public void courseBoardReplyEdit(BoardVO board, ModelMap model) throws Exception {
		// if(boardReply != null && boardReply.getId() > 0) {
		if (board != null && board.getId() > 0) {
			// 선택 된 ID가 없으면 바로 edit 화면으로 이동하고 선택 된 ID가 있으면 해당 정보를 가지고 간다.
			model.addAttribute("board", boardService.courseBoardInfo(board));
		}

		// 검색 조건 저장(리스트 페이지로 이동 시 검색 조건을 그대로 유지하기 위해)
		model.addAttribute("search", board);
	}

	/**
	 * Exception 처리
	 * 
	 * @param Exception
	 * @return ModelAndView
	 * @author : 김준석 - (2015-06-03)
	 */
	@ExceptionHandler(Exception.class)
	public ModelAndView exceptionHandler(Exception e) {
		logger.info(e.getMessage());

		return new ModelAndView("/error/exception").addObject("msg", e.getMessage());
	}

	/**
	 * 자유게시판 리스트 페이지
	 * 
	 * @throws Exception
	 */
	@RequestMapping(value = "/freeBoardList")
	public void freeBoardList(@ModelAttribute("search") BoardVO board, ModelMap model) throws Exception {

	}

	/**
	 * 자유게시판 수정 페이지
	 * 
	 * @throws Exception
	 */
	@RequestMapping(value = "/freeBoardEdit")
	public void freeBoardEdit(BoardVO board, ModelMap model) throws Exception {

		// 댓글목록
		BoardCommentVO boardComment = new BoardCommentVO();
		boardComment.setBoardId(board.getId());

		// 선택 된 ID가 없으면 바로 edit 화면으로 이동하고 선택 된 ID가 있으면 해당 정보를 가지고 간다.
		if (board != null && board.getId() > 0 && "M".equals(board.getCategory())) {
			model.addAttribute("category", "M");

			model.addAttribute("board", boardService.boardInfo(board));

			boardComment.setCategory("M");
			model.addAttribute("boardCmtList", boardService.boardCommentList(boardComment));
		}

		// 검색 조건 저장(리스트 페이지로 이동 시 검색 조건을 그대로 유지하기 위해)
		model.addAttribute("search", board);
	}

	/**
	 * 자유게시판 답글 등록 폼으로 이동
	 * 
	 * @throws Exception
	 */
	@RequestMapping(value = "/freeBoardReplyReg")
	public String freeBoardReplyReg(BoardVO board, ModelMap model) throws Exception {

		model.addAttribute("category", "S");
		BoardReplyVO boardReply = new BoardReplyVO();
		boardReply.setBoardId(board.getId());
		model.addAttribute("boardReply", boardReply);

		// 검색 조건 저장(리스트 페이지로 이동 시 검색 조건을 그대로 유지하기 위해)
		model.addAttribute("search", board);

		return "/admin/board/freeBoardReplyEdit";
	}

	/**
	 * 자유게시판 답글 수정 폼으로 이동
	 * 
	 * @throws Exception
	 */
	@RequestMapping(value = "/freeBoardReplyEdit")
	public void freeBoardReplyEdit(BoardVO board, ModelMap model) throws Exception {

		// 댓글목록
		BoardCommentVO boardComment = new BoardCommentVO();
		boardComment.setBoardId(board.getId());

		model.addAttribute("category", "S");

		BoardReplyVO boardReply = new BoardReplyVO();
		boardReply.setId(board.getId());
		model.addAttribute("boardReply", boardService.boardReplyInfo(boardReply));

		boardComment.setCategory("S");
		model.addAttribute("boardReplyCmtList", boardService.boardCommentList(boardComment));

		// 검색 조건 저장(리스트 페이지로 이동 시 검색 조건을 그대로 유지하기 위해)
		model.addAttribute("search", board);

	}

	/*
	 * 댓글 조회
	 */
	@RequestMapping(value = "/boardCommentList")
	public void boardCommentList(BoardCommentVO boardComment, ModelMap model) throws Exception {
		model.addAttribute("boardCmtList", boardService.boardCommentList(boardComment));
	}

	@RequestMapping(value = "/allBoardList")
	public void allBoardList(@RequestParam HashMap<String, Object> params, ModelMap model) throws Exception {
		model.addAttribute("search", params);
	}

	@RequestMapping(value = "/boardListBySeq")
	public void boardListByBoardSeq(@RequestParam HashMap<String, Object> params, ModelMap model) throws Exception {
		model.addAttribute("search", params);
	}
	
	
	@RequestMapping(value = "/boardDetail")
	public void boardDetail(@RequestParam HashMap<String, Object> params, ModelMap model) throws Exception {
		logger.debug("공지사항 게시판의 게시글 세부 내용을 호출하는 컨트롤러 시작");
		
		try {
			boardService.board_contents_hit_update(params);
		} catch (Exception e) {
			e.printStackTrace();
		}
		HashMap<String, Object> detail = null;
		detail = boardService.boardDetail(params);

		ArrayList<HashMap<String, Object>> files = null;
		files = boardService.boardFiles(detail.get("board_content_seq").toString());

		model.addAttribute("board_gb", boardService.board_gb_search(params));
		model.addAttribute("search", params);
		model.addAttribute("boardDetail", detail);
		model.addAttribute("files", files);
		model.addAttribute("path", eduApplyBoardFile);

		logger.debug("공지사항 게시판의 게시글 세부 내용을 호출하는 컨트롤러 종료");
	}

	@RequestMapping(value = "/boardInsert")
	public void boardInsert(@RequestParam HashMap<String, Object> params, Model model) {
		logger.debug("공지사항 게시판의 게시글 세부 내용 등록 폼 이동 컨트롤러 시작");

		HashMap<String, Object> board_gb;
		try {
			board_gb = boardService.board_gb_search(params);
			String path = boardService.findPath((String) board_gb.get("board_gb"), (String) board_gb.get("board_tp"));
			String admin = "admin";
			model.addAttribute("path", path);
			model.addAttribute("board_gb", board_gb);
			model.addAttribute("board_content_nm", admin);
			model.addAttribute("search", params);
		} catch (Exception e) {
			e.printStackTrace();
		}

		logger.debug("공지사항 게시판의 게시글 세부 내용 등록 폼 이동 컨트롤러 종료");
	}

	@RequestMapping(value = "/boardUpdate")
	public void boardUpdate(@RequestParam HashMap<String, Object> params, Model model) throws Exception {
		logger.debug("공지사항 게시판의 게시글 세부 내용 수정 폼 이동 컨트롤러 시작");
		try {
			boardService.board_contents_hit_update(params);
		} catch (Exception e) {
			e.printStackTrace();
		}
		HashMap<String, Object> detail = null;
		detail = boardService.boardDetail(params);

		ArrayList<HashMap<String, Object>> files = null;
		files = boardService.boardFiles(detail.get("board_content_seq").toString());
		
		model.addAttribute("board_gb", boardService.board_gb_search(params));
		model.addAttribute("search", params);
		model.addAttribute("boardDetail", detail);
		model.addAttribute("files", files);
		model.addAttribute("path", eduApplyBoardFile);

		logger.debug("공지사항 게시판의 게시글 세부 내용 수정 폼 이동 컨트롤러 종료");
	}
	
	@RequestMapping(value = "/onlineConsulting")
	public void onlineConsulting(@RequestParam HashMap<String, Object> params, ModelMap model) throws Exception {
		logger.debug("온라인 상담 관리 이동 컨트롤러 시작");
		model.addAttribute("search", params);
		logger.debug("온라인 상담 관리 이동 컨트롤러 종료");
	}
}