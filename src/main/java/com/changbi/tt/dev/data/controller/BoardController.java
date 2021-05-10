/**
 * 회원관리 화면 호출 Controller
 * @author : 김준석(2018-02-17)
 */

package com.changbi.tt.dev.data.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.changbi.tt.dev.data.service.BoardService;
import com.changbi.tt.dev.data.vo.BoardCommentVO;
import com.changbi.tt.dev.data.vo.BoardFile;
import com.changbi.tt.dev.data.vo.BoardReplyVO;
import com.changbi.tt.dev.data.vo.BoardVO;
import com.changbi.tt.dev.data.vo.NoteVO;
import com.changbi.tt.dev.data.vo.SurveyItemVO;
import com.changbi.tt.dev.data.vo.SurveyVO;
import com.google.gson.Gson;

import forFaith.dev.service.AttachFileService;
import forFaith.dev.util.LoginHelper;
import forFaith.dev.vo.MemberVO;
import forFaith.util.DataList;
import forFaith.util.StringUtil;

@Controller(value="data.boardController")      // Controller value는 중복되면 안된다. value 값을 지정하지 않으면 클래스명이 value가 되므로 같은 클래스명이 존재하면 중복으로 인식
@RequestMapping("/data/board")       // 해당 클래스를 호출 하기 위한 Mapping 기본 값 뒤에 붙는 값에 의해 필요한 함수가 호출 된다.
public class BoardController {

	@Autowired
	private BoardService boardService;
	
    /**
     * log를 남기는 객체 생성
     * @author : 김준석(2018-02-17)
     */
    private static final Logger logger = LoggerFactory.getLogger(BoardController.class);
    
    @Autowired
	AttachFileService fileService;
    
    @Value("#{props['edu.apply.ckeditor']}")
	private String eduApplyCkeditor;

    /**
     * 게시물 리스트
     */
    @RequestMapping(value = "/boardList", method = RequestMethod.POST)
    public @ResponseBody ModelMap boardList(BoardVO board) throws Exception {
    	ModelMap map = new ModelMap();
    	
    	// 일반 게시물 리스트 가져오기
    	DataList<BoardVO> boardList = new DataList<BoardVO>();

    	boardList.setPagingYn(board.getPagingYn());
    	// 페이징 처리인 경우만 페이지 번호와 토탈 갯수를 저장한다.
		if(boardList.getPagingYn().equals("Y")) {
			boardList.setNumOfNums(board.getNumOfNums());
			boardList.setNumOfRows(board.getNumOfRows());
			boardList.setPageNo(board.getPageNo());
			boardList.setTotalCount(boardService.boardTotalCnt(board));
		}

		// 결과 리스트를 저장
		boardList.setList(boardService.boardList(board));
		
		map.addAttribute("baseList", boardList); // 일반게시물
    	
		if(StringUtil.isEmpty(board.getBoardType()) || board.getBoardType().equals("1")) {
			// 주요 게시물 리스트 가져오기
			DataList<BoardVO> boardTopList = new DataList<BoardVO>();
			board.setPagingYn("N");
			board.setTopYn("Y");
	
			// 결과 리스트를 저장
			boardTopList.setList(boardService.boardList(board));
		
			map.addAttribute("topList", boardTopList); // 주요게시물
		}
		
    	return map;
    }

    /**
     * 게시물 등록
     */
    @RequestMapping(value="/boardReg", method=RequestMethod.POST)
    public @ResponseBody BoardVO boardReg(BoardVO board) throws Exception {
        if(board != null) {
            // 로그인 된 관리자 정보
        	MemberVO loginUser = (MemberVO)LoginHelper.getLoginInfo();

        	board.setRegUser(loginUser);
        	board.setUpdUser(loginUser);
        	
        	boardService.boardReg(board);
        }

        return board;
    }
    
    /**
     * 게시물 삭제
     */
    @RequestMapping(value="/boardDel", method=RequestMethod.POST)
    public @ResponseBody int boardDel(BoardVO board) throws Exception {
    	int result = boardService.boardDel(board);
    	return result;
    }
    
    /**
     * 답글 등록
     */
    @RequestMapping(value="/boardReplyReg", method=RequestMethod.POST)
    public @ResponseBody BoardReplyVO boardReplyReg(BoardReplyVO boardReply) throws Exception {
        if(boardReply != null) {
            // 로그인 된 관리자 정보
        	MemberVO loginUser = (MemberVO)LoginHelper.getLoginInfo();

        	boardReply.setRegUser(loginUser);
        	boardReply.setUpdUser(loginUser);
        	
        	boardService.boardReplyReg(boardReply);
        }

        return boardReply;
    }
    
    /**
     * 답글 삭제
     */
    @RequestMapping(value="/boardReplyDel", method=RequestMethod.POST)
    public @ResponseBody int boardReplyDel(BoardReplyVO boardReply) throws Exception {
    	int result = boardService.boardReplyDel(boardReply);
    	return result;
    }
    
    //faq 리스트 받아오기
    @RequestMapping(value="/faqList", method=RequestMethod.POST)
    public @ResponseBody Object faqList(@RequestParam HashMap<String, Object> params) throws Exception {
    	List<HashMap<String, Object>> result = new ArrayList<>();
    	result = boardService.getFaqList(params);
    	return result;
    }
    //FAQ 신규등록
    @RequestMapping(value="/insertFaq", method=RequestMethod.POST)
    public @ResponseBody Object insertFaq(@RequestParam HashMap<String, Object> params, HttpSession session) throws Exception {
    	MemberVO loginUser = (MemberVO)LoginHelper.getLoginInfo();
    	String user_id = loginUser.getId();
    	params.put("user_id", user_id);
    	int result = 0;
    	result = boardService.insertFaq(params);
    	if(result == 0) return false;
    	return true;
    }
    //FAQ 삭제
    @RequestMapping(value="/deleteFaq", method=RequestMethod.POST)
    public @ResponseBody Object deleteFaq(@RequestParam HashMap<String, Object> params) throws Exception {
    	int result = 0;
    	result = boardService.deleteFaq(params);
    	if(result == 0) return false;
    	return true;
    }
    //전체 공지사항 리스트 받아오기
    @RequestMapping(value="/noticeList", method=RequestMethod.POST)
    public @ResponseBody Object noticeList(@RequestParam HashMap<String, Object> params) throws Exception {
    	List<HashMap<String, Object>> result = new ArrayList<>();
    	result = boardService.selectNotice(params);
    	return result;
    }
    //전체 공지사항 신규등록
    @Transactional
    @SuppressWarnings("unchecked")
	@RequestMapping(value="/insertNotice", method=RequestMethod.POST)
    public @ResponseBody Object insertNotice(@RequestParam HashMap<String, Object> obj) throws Exception {
    	MemberVO loginUser = (MemberVO)LoginHelper.getLoginInfo();
    	String user_id = loginUser.getId();
    	
    	Gson gson = new Gson();
    	HashMap<String, Object> params = new HashMap<String, Object>();
    	HashMap<String, Object> file = new HashMap<String, Object>();
    	params = (HashMap<String, Object>) gson.fromJson((String) obj.get("params"), params.getClass());
    	file = (HashMap<String, Object>) gson.fromJson((String) obj.get("file"), params.getClass());
    	params.put("user_id", user_id);
    	Boolean result = true;
    	try {
    		boardService.insertNotice(params);
    		if(!file.isEmpty()) {
    			for(int i=0; i < file.size(); i++) {
    				params.put("board_file_saved", (String)params.get("file"+(i+1)+".fileId"));
    				params.put("board_file_origin",(String)file.get("file"+i));
		    		boardService.insertNoticeFileInfo(params);
    			}
    		}
    	} catch (Exception e) {
    		return false;
    	}
    	return result;
    }
    //전체 공지사항 삭제
    @RequestMapping(value="/deleteNotice", method=RequestMethod.POST)
    public @ResponseBody Object deleteNotice(@RequestParam HashMap<String, Object> params) throws Exception {
    	int result = 0;
    	result = boardService.deleteNotice(params);
    	if(result == 0) return false;
    	return true;
    }
    /**
     * 팝업 게시물 리스트
     */
    @RequestMapping(value = "/popup/boardList", method = RequestMethod.POST)
    public @ResponseBody DataList<BoardVO> popupBoardList(BoardVO board) throws Exception {
    	// 일반 게시물 리스트 가져오기
    	DataList<BoardVO> result = new DataList<BoardVO>();

    	result.setPagingYn(board.getPagingYn());
    	
    	// 페이징 처리인 경우만 페이지 번호와 토탈 갯수를 저장한다.
		if(result.getPagingYn().equals("Y")) {
			result.setNumOfNums(board.getNumOfNums());
			result.setNumOfRows(board.getNumOfRows());
			result.setPageNo(board.getPageNo());
			result.setTotalCount(boardService.popupBoardTotalCnt(board));
		}

		// 결과 리스트를 저장
		result.setList(boardService.popupBoardList(board));
		
		return result;
    }
    
    /**
     * 팝업용 게시물 등록
     */
    @RequestMapping(value="/popup/boardReg", method=RequestMethod.POST)
    public @ResponseBody BoardVO popupBoardReg(BoardVO board) throws Exception {
        if(board != null) {
            // 로그인 된 관리자 정보
        	MemberVO loginUser = (MemberVO)LoginHelper.getLoginInfo();

        	// QnA인 경우는 답글을 저장 나머지는 원문을 저장
        	if(board.getBoardType().equals("4")) {
        		BoardReplyVO boardReply = board.getBoardReply();
        		
        		// board ID 저장
        		boardReply.setBoardId(board.getId());
        		
            	boardReply.setRegUser(loginUser);
            	boardReply.setUpdUser(loginUser);
            	
            	boardService.boardReplyReg(boardReply);
        	} else {
	        	board.setRegUser(loginUser);
	        	board.setUpdUser(loginUser);
	        	
	        	boardService.boardReg(board);
        	}
        }

        return board;
    }
    
    /**
     * 팝업용 게시물 삭제
     */
    @RequestMapping(value="/popup/boardDel", method=RequestMethod.POST)
    public @ResponseBody int popupBoardDel(BoardVO board) throws Exception {
    	int result = 0;
    	
    	if(board.getBoardType().equals("4")) {
    		BoardReplyVO boardReply = board.getBoardReply();
    		
    		result = boardService.boardReplyDel(boardReply);
    	} else {
    		result = boardService.boardDel(board);
    	}

    	return result;
    }
    
    /**
     * 연수설문 정보 리스트
     */
    @RequestMapping(value = "/surveyList", method = RequestMethod.POST)
    public @ResponseBody DataList<SurveyVO> surveyList(SurveyVO survey) throws Exception {
    	DataList<SurveyVO> result = new DataList<SurveyVO>();
    	
    	result.setPagingYn(survey.getPagingYn());
    	
    	// 페이징 처리인 경우만 페이지 번호와 토탈 갯수를 저장한다.
		if(result.getPagingYn().equals("Y")) {
			result.setNumOfNums(survey.getNumOfNums());
			result.setNumOfRows(survey.getNumOfRows());
			result.setPageNo(survey.getPageNo());
			result.setTotalCount(boardService.surveyTotalCnt(survey));
		}
		
		// 결과 리스트를 저장
		result.setList(boardService.surveyList(survey));

		return result;
    }
    
    /**
     * 연수설문 등록
     */
    @RequestMapping(value="/surveyReg", method=RequestMethod.POST)
    public @ResponseBody SurveyVO surveyReg(SurveyVO survey) throws Exception {
        if(survey != null) {
            // 로그인 된 관리자 정보
        	MemberVO loginUser = (MemberVO)LoginHelper.getLoginInfo();

        	survey.setRegUser(loginUser);
        	survey.setUpdUser(loginUser);
        	
        	boardService.surveyReg(survey);
        }

        return survey;
    }
    
    @RequestMapping(value="/surveyItemVerification", method=RequestMethod.POST)
    public @ResponseBody int surveyItemVerification(SurveyItemVO surveyItem) throws Exception {
    	int result = boardService.surveyItemVerification(surveyItem);
    	return result;
    }
    
    /**
     * 연수설문 삭제
     */
    @RequestMapping(value="/surveyDel", method=RequestMethod.POST)
    public @ResponseBody int surveyDel(SurveyVO survey) throws Exception {
    	int result = boardService.surveyDel(survey);
    	return result;
    }
    
    /**
     * 연수설문문항 리스트
     */
    @RequestMapping(value = "/surveyItemList", method = RequestMethod.POST)
    public @ResponseBody DataList<SurveyItemVO> surveyItemList(SurveyItemVO surveyItem) throws Exception {
    	DataList<SurveyItemVO> result = new DataList<SurveyItemVO>();

		// 결과 리스트를 저장
		result.setList(boardService.surveyItemList(surveyItem));

		return result;
    }
    
    /**
     * 연수설문 문항 등록
     */
    @RequestMapping(value="/surveyItemReg", method=RequestMethod.POST)
    public @ResponseBody SurveyItemVO surveyItemReg(SurveyItemVO surveyItem) throws Exception {
        if(surveyItem != null) {
            // 로그인 된 관리자 정보
        	MemberVO loginUser = (MemberVO)LoginHelper.getLoginInfo();

    		// 메일 발송과 별개로 올레측 DB에 저장한다.
        	surveyItem.setRegUser(loginUser);
        	surveyItem.setUpdUser(loginUser);
        	
        	boardService.surveyItemReg(surveyItem);
        }

        return surveyItem;
    }
    
    /**
     * 연수설문 문항 삭제
     */
    @RequestMapping(value="/surveyItemDel", method=RequestMethod.POST)
    public @ResponseBody int surveyItemDel(SurveyItemVO surveyItem) throws Exception {
    	int result = boardService.surveyItemDel(surveyItem);
    	return result;
    }
    
    /**
     * 쪽지 리스트
     */
    @RequestMapping(value = "/noteList", method = RequestMethod.POST)
    public @ResponseBody DataList<NoteVO> noteList(NoteVO note) throws Exception {
    	DataList<NoteVO> result = new DataList<NoteVO>();

    	result.setPagingYn(note.getPagingYn());
    	
    	// 페이징 처리인 경우만 페이지 번호와 토탈 갯수를 저장한다.
		if(result.getPagingYn().equals("Y")) {
			result.setNumOfNums(note.getNumOfNums());
			result.setNumOfRows(note.getNumOfRows());
			result.setPageNo(note.getPageNo());
			result.setTotalCount(boardService.noteTotalCnt(note));
		}
    	
		// 결과 리스트를 저장
		result.setList(boardService.noteList(note));
		
		return result;
    }
    
    /**
     * 쪽지 보내기
     */
    @RequestMapping(value="/noteReg", method=RequestMethod.POST)
    public @ResponseBody NoteVO noteReg(NoteVO note) throws Exception {
        if(note != null) {
        	boardService.noteReg(note);
        }

        return note;
    }
    
    /**
     * 과정별 게시물 리스트
     */
    @RequestMapping(value="/courseBoardList", method = RequestMethod.POST)
    public @ResponseBody DataList<BoardVO> courseBoardList(BoardVO board) throws Exception {
    	// 일반 게시물 리스트 가져오기
    	DataList<BoardVO> result = new DataList<BoardVO>();
    	
    	// 로그인 된 관리자 정보
    	board.setLoginUser((MemberVO)LoginHelper.getLoginInfo());

    	result.setPagingYn(board.getPagingYn());
    	
    	// 페이징 처리인 경우만 페이지 번호와 토탈 갯수를 저장한다.
		if(result.getPagingYn().equals("Y")) {
			result.setNumOfNums(board.getNumOfNums());
			result.setNumOfRows(board.getNumOfRows());
			result.setPageNo(board.getPageNo());
			result.setTotalCount(boardService.courseBoardTotalCnt(board));
		}

		// 결과 리스트를 저장
		result.setList(boardService.courseBoardList(board));
		
		return result;
    }
    
    
    /**
     * 게시물 리스트
     */
    @RequestMapping(value = "/freeBoardList", method = RequestMethod.POST)
    public @ResponseBody ModelMap freeBoardList(BoardVO board) throws Exception {
    	ModelMap map = new ModelMap();
    	
    	// 일반 게시물 리스트 가져오기
    	DataList<BoardVO> boardList = new DataList<BoardVO>();

    	boardList.setPagingYn(board.getPagingYn());
    	// 페이징 처리인 경우만 페이지 번호와 토탈 갯수를 저장한다.
		if(boardList.getPagingYn().equals("Y")) {
			boardList.setNumOfNums(board.getNumOfNums());
			boardList.setNumOfRows(board.getNumOfRows());
			boardList.setPageNo(board.getPageNo());
			boardList.setTotalCount(boardService.boardTotalCnt(board));
		}

		// 결과 리스트를 저장
		boardList.setList(boardService.boardList(board));
		
		map.addAttribute("baseList", boardList); // 일반게시물
    	 
    	return map;
    }
    
    /*
     * 댓글 입력
     */
    @RequestMapping(value="/boardCommentReg" , method=RequestMethod.POST)
    public @ResponseBody int boardCommentReg(BoardCommentVO boardComment) throws Exception{
    	if(boardComment!=null){
    		MemberVO loginUser = (MemberVO)LoginHelper.getLoginInfo();
    		boardComment.setRegUser(loginUser);   	 
    	}
    	int result = 0;
    	result = boardService.boardCommentReg(boardComment);
    	return result;
    }
    
    /*
     * 댓글 조회
     */
    @RequestMapping(value="/boardCommentList" , method=RequestMethod.POST)
    public @ResponseBody DataList<BoardCommentVO> boardCommentList(BoardCommentVO boardComment) throws Exception{
    	DataList<BoardCommentVO> result= new DataList<BoardCommentVO>();
    	result.setList(boardService.boardCommentList(boardComment));
    	return result;
    }
    
    /*
     * 댓글 수정
     */
    @RequestMapping(value="/boardCommentUpdate", method=RequestMethod.POST)
    public @ResponseBody int boardCommentUpdate(BoardCommentVO boardComment) throws Exception{
    	int result = 0;
    	result = boardService.boardCommentUpdate(boardComment);
    	return result;
    }
    
    /*
     * 댓글 삭제
     */
    @RequestMapping(value="/boardCommentDel", method=RequestMethod.POST)
    public @ResponseBody int boardCommentDel(int id) throws Exception{
    	int result = 0;
    	result = boardService.boardCommentDel(id);
    	return result;
    }
    
    /**
     * 자유게시판 답글 등록
     */
    @RequestMapping(value="/freeBoardReplyUpdate", method=RequestMethod.POST)
    public @ResponseBody BoardReplyVO freeBoardReplyUpdate(BoardReplyVO boardReply) throws Exception {
        if(boardReply != null) {
            // 로그인 된 관리자 정보
        	MemberVO loginUser = (MemberVO)LoginHelper.getLoginInfo();

        	boardReply.setRegUser(loginUser);
        	boardReply.setUpdUser(loginUser);
        	
        	boardService.freeBoardReplyUpdate(boardReply);
        }

        return boardReply;
    }
    
    
    /**
     * Exception 처리
     * @param Exception
     * @return ModelAndView
     * @author : 김준석 - (2015-06-03)
     */
    @ExceptionHandler(Exception.class)
    public ModelAndView exceptionHandler(Exception e) {
        logger.info(e.getMessage());

        return new ModelAndView("/error/exception").addObject("msg", e.getMessage());
    }
    
    @RequestMapping(value = "/allBoardList", method = RequestMethod.POST)
    public @ResponseBody Object allBoardList(@RequestParam HashMap<String, Object> params) throws Exception {
    	// 일반 게시물 리스트 가져오기
    	DataList<HashMap<String, Object>> boardList = new DataList<HashMap<String, Object>>();
    	int pageNo = Integer.parseInt((String) params.get("pageNo"));
    	params.put("numOfRows", 10);
    	params.put("firstIndex", (pageNo-1)* 10);
		boardList.setNumOfRows(10);
		boardList.setPageNo(pageNo);
		boardList.setTotalCount(boardService.allBoardListTotalCnt(params));

		// 결과 리스트를 저장
		boardList.setList(boardService.allBoardList(params));
		
    	return boardList;
    }
    @RequestMapping(value = "/boardListBySeq", method = RequestMethod.POST)
    public @ResponseBody Object boardListBySeq(@RequestParam HashMap<String, Object> params) throws Exception {
    	// 일반 게시물 리스트 가져오기
    	DataList<HashMap<String, Object>> boardList = new DataList<HashMap<String, Object>>();
    	int pageNo = Integer.parseInt((String) params.get("pageNo"));
    	params.put("numOfRows", 10);
    	params.put("firstIndex", (pageNo-1)* 10);
		boardList.setNumOfRows(10);
		boardList.setPageNo(pageNo);
		boardList.setTotalCount(boardService.boardListBySeqTotalCnt(params));

		// 결과 리스트를 저장
		boardList.setList(boardService.boardListBySeq(params));
		
    	return boardList;
    }
    
    @ResponseBody
	@RequestMapping(value = "/boardDelete", method = RequestMethod.POST)
	public int board_contents_delete(int board_content_seq) {
		logger.debug("모집홍보 관리자 게시글 삭제 컨트롤러 시작");
		int result = 0;
		result = boardService.board_contents_delete(board_content_seq);
		logger.debug("모집홍보 관리자 게시글 삭제 컨트롤러 종료");
		return result;
	}
    
    @ResponseBody
    @RequestMapping(value = "/boardInsert", method = RequestMethod.POST)
	public int boardInsert(@RequestParam HashMap<String, Object> params) throws IOException{
		logger.debug("모집홍보 관리자 게시글 세부 내용 등록 폼 이동 컨트롤러 시작");
		logger.debug("anh288-params" + params);
//		logger.debug("anh288-multiRequest"+ multiRequest);
		int result = boardService.boardInsert(params);
		
//		List<MultipartFile> fileList = multiRequest.getFiles("uploadFile");
//		logger.debug("anh288-fileList"+ fileList);
//		//업로드한 파일이 없으면 실행되지 않음
//		if(fileList != null){
//		 //파일이 저장될 경로 설정
//		 String path = "/upload/board/files";
//		 File dir = new File(path);
//			 if(!dir.isDirectory()){
//				 dir.mkdirs();
//			 }
//			
//			 if(!fileList.isEmpty()){
//			 //넘어온 파일을 리스트로 저장
//				 for(int i = 0; i < fileList.size() ; i++){
//					 //파일 중복명 처리
//					 String random = UUID.randomUUID().toString();
//					 //원래 파일명
//					 String board_file_origin = fileList.get(i).getOriginalFilename();
//					 //저장되는 파일이름
//					 String saveFileName = random + "_"+ board_file_origin;
//					//저장될 파일 경로
//					 String board_file_saved = path + saveFileName;
//					 //파일사이즈
//	//				 int fileSize = (int) fileList.get(i).getSize();
//					 //파일 저장
//					 fileList.get(i).transferTo(new File(board_file_saved));
//					 BoardFile boardFile = new BoardFile();
//					 boardFile.setBoard_content_seq(Integer.parseInt(String.valueOf(params.get("board_content_seq"))));
//					 boardFile.setBoard_file_origin(board_file_origin);
//					 boardFile.setBoard_file_saved(board_file_saved);
//					 logger.debug("anh288-file" + i + " : " + boardFile);
//				}
//			}
//		}
//		
		
//		List<MultipartFile> fileList = mtfRequest.getFiles("file");
////        String src = mtfRequest.getParameter("src");
////        System.out.println("src value : " + src);
//		System.out.println("fileList : " + fileList);
//        String path = "/upload/board/files/";
//
//        for (MultipartFile mf : fileList) {
//            String board_file_origin = mf.getOriginalFilename(); // 원본 파일 명
////            long fileSize = mf.getSize(); // 파일 사이즈
////
//            System.out.println("board_file_origin : " + board_file_origin);
////            System.out.println("fileSize : " + fileSize);
//            
//            String board_file_saved = path + System.currentTimeMillis() + board_file_origin;
//            System.out.println("board_file_saved : " + board_file_saved);
////            System.out.println("mf"+mf);
//            try {
//                mf.transferTo(new File(board_file_saved));
//                BoardFile boardFile = new BoardFile();
//                boardFile.setBoard_content_seq(Integer.parseInt(String.valueOf(params.get("board_content_seq"))));
//				boardFile.setBoard_file_origin(board_file_origin);
//				boardFile.setBoard_file_saved(board_file_saved);
//				System.out.println("anh288 - boardFile : " + boardFile);
//            } catch (IllegalStateException e) {
//                // TODO Auto-generated catch block
//                e.printStackTrace();
//            } catch (IOException e) {
//                // TODO Auto-generated catch block
//                e.printStackTrace();
//            }
//        }
		logger.debug("모집홍보 관리자 게시글 세부 내용 등록 폼 이동 컨트롤러 종료");
		return result;
	}
    @ResponseBody
    @RequestMapping(value = "/bordFileInsert", method = RequestMethod.POST)
    public int bordFileInsert(MultipartHttpServletRequest multiRequest) throws IOException{
    	logger.debug("모집홍보 관리자 게시글 파일 업로드 컨트롤러 시작");
    	logger.debug("anh288-multiRequest"+ multiRequest);
    	List<MultipartFile> fileList = multiRequest.getFiles("file");
		logger.debug("anh288-fileList"+ fileList);
		//업로드한 파일이 없으면 실행되지 않음
		if(fileList != null){
		 //파일이 저장될 경로 설정
		 String path = "/upload/board/files";
		 File dir = new File(path);
			 if(!dir.isDirectory()){
				 dir.mkdirs();
			 }
			
			 if(!fileList.isEmpty()){
			 //넘어온 파일을 리스트로 저장
				 for(int i = 0; i < fileList.size() ; i++){
					 //파일 중복명 처리
					 String random = UUID.randomUUID().toString();
					 //원래 파일명
					 String board_file_origin = fileList.get(i).getOriginalFilename();
					 //저장되는 파일이름
					 String saveFileName = random + "_"+ board_file_origin;
					//저장될 파일 경로
					 String board_file_saved = path + saveFileName;
					 //파일사이즈
	//				 int fileSize = (int) fileList.get(i).getSize();
					 //파일 저장
					 fileList.get(i).transferTo(new File(board_file_saved));
					 BoardFile boardFile = new BoardFile();
//					 boardFile.setBoard_content_seq(Integer.parseInt(String.valueOf(params.get("board_content_seq"))));
					 boardFile.setBoard_file_origin(board_file_origin);
					 boardFile.setBoard_file_saved(board_file_saved);
					 logger.debug("anh288-file" + i + " : " + boardFile);
				}
			}
		}
		logger.debug("모집홍보 관리자 게시글 파일 업로드 컨트롤러 종료");
    	return 0;
    }
}