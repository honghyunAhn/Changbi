package forFaith.dev.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import forFaith.dev.service.BoardService;
import forFaith.dev.util.LoginHelper;
import forFaith.dev.vo.BoardVO;
import forFaith.dev.vo.MemberVO;
import forFaith.dev.vo.NoticeVO;
import forFaith.domain.MultiRequest;
import forFaith.util.StringUtil;

/**
 * @Class Name : BoardController.java
 * @Description : 게시판 기능 제공
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

@Controller("forFaith.boardController")
@RequestMapping("/forFaith/board")
public class BoardController {

	@Autowired
    private BoardService boardService;

	/**
	 * 게시판관리
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/boardList")
	public void boardList(@ModelAttribute("search") BoardVO board, ModelMap model) throws Exception {
	    // 페이징 처리는 board 객체 내에 Paging 객체를 상속 받기 때문에 view 화면에서 search로 페이징 처리하면 됨.
	    // 페이징 처리를 하려면 VO 객체 내에 Common 객체를 상속해서 쓰면 됨.
        if(board.getPagingYn().equals("Y")) {
            board.setTotalCount(boardService.boardTotalCnt(board));
        }

        model.addAttribute("boardList", boardService.boardList(board));
	}

	/**
	 * 게시판관리등록
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/boardEdit")
	public void boardEdit(BoardVO board, ModelMap model) throws Exception {
	    if(board != null && !StringUtil.isEmpty(board.getId())) {
			// 선택 된 ID가 없으면 바로 edit 화면으로 이동하고 선택 된 ID가 있으면 해당 아카데미 정보를 가지고 간다.
			model.addAttribute("board", boardService.boardInfo(board));
		}

        // 검색 조건 저장
        model.addAttribute("search", board);
	}

	/**
	 * 게시판관리 추가 or 수정
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/boardReg", method=RequestMethod.POST)
	public String boardReg(BoardVO board, RedirectAttributes redirectAttr) throws Exception {
		// 로그인 된 정보
		MemberVO loginUser = (MemberVO)LoginHelper.getLoginInfo();

		// 메일 발송과 별개로 올레측 DB에 저장한다.
		board.setRegUser(loginUser);
		board.setUpdUser(loginUser);

		boardService.boardReg(board);

		// 검색 조건 저장(board자체는 저장용 데이터, board내 동일한 객체 타입의 search는 조회용 데이터 저장 됨)
        redirectAttr.addFlashAttribute("search", board.getSearch());
		return "redirect:/board/boardList";
	}

	/**
	 * 게시판관리삭제
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/boardDel", method=RequestMethod.POST)
	public String boardDel(BoardVO board, RedirectAttributes redirectAttr) throws Exception {
	    boardService.boardDel(board);

        // 검색 조건 저장
        redirectAttr.addFlashAttribute("search", board);
        return "redirect:/board/boardList";
    }

	/**
     * 게시판 사용 여부 상태값 변경 API
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/boardUseChange", method=RequestMethod.POST)
    public @ResponseBody int boardUseChange(@RequestBody MultiRequest<BoardVO> multiRequest) throws Exception {
        int result = 0;

        if(multiRequest.getList() != null && multiRequest.getList().size() > 0) {
            // 로그인 된 정보
            MemberVO loginUser = (MemberVO)LoginHelper.getLoginInfo();

            // 로그인 된 유저 정보 입력
            multiRequest.getList().get(0).setUpdUser(loginUser);

            // 변경처리
            result = boardService.boardUseChange(multiRequest.getList());
        }

        return result;
    }

	/**
	 * 게시물관리
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/noticeList")
	public void noticeList(@ModelAttribute("search") NoticeVO notice, ModelMap model) throws Exception {
	    // 페이징 처리는 member 객체 내에 Paging 객체를 상속 받기 때문에 view 화면에서 search로 페이징 처리하면 됨.
        // 페이징 처리를 하려면 VO 객체 내에 Common 객체를 상속해서 쓰면 됨.
        if(notice.getPagingYn().equals("Y")) {
            notice.setTotalCount(boardService.noticeTotalCnt(notice));
        }

        model.addAttribute("noticeList", boardService.noticeList(notice));
	}

	/**
	 * 게시물 상세보기(상세보기가 있는 경우 사용)
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/noticeView")
	public String noticeView(NoticeVO notice, ModelMap model, RedirectAttributes redirectAttr) throws Exception {
	    if(notice != null && notice.getId() != null && notice.getId() > 0) {
	        // 선택 된 ID가 없으면 바로 edit 화면으로 이동하고 선택 된 ID가 있으면 해당 아카데미 정보를 가지고 간다.
	        NoticeVO noticeInfo = boardService.noticeInfo(notice);

	        // 게시물 정보가 제대로 조회가 된경우에만 View 페이지로 이동
	        if(noticeInfo != null && !StringUtil.isEmpty(noticeInfo.getId())) {
	            // 게시물 상세 내용 저장
	            model.addAttribute("notice", noticeInfo);

    	        // 검색 조건 저장(상세페이지로 전환)
                model.addAttribute("search", notice);
                return "/board/noticeView";
	        } else {
	            // 검색 조건 저장
	            redirectAttr.addFlashAttribute("search", notice);
	            // ID가 존재 하지 않을 때는 리스트 화면으로 이동시킨다.
	            return "redirect:/board/noticeList";
	        }
		} else {
            // 검색 조건 저장
            redirectAttr.addFlashAttribute("search", notice);
            // ID가 존재 하지 않을 때는 리스트 화면으로 이동시킨다.
            return "redirect:/board/noticeList";
        }
	}

	/**
	 * 게시물등록/수정 화면
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/noticeEdit")
	public void noticeEdit(NoticeVO notice, ModelMap model) throws Exception {
	    if(notice != null && notice.getId() != null && notice.getId() > 0) {
            model.addAttribute("notice", boardService.noticeInfo(notice));
        }

	    // 검색 조건 저장(리스트 화면에서 조회 내용을 그대로 유지하기 위해 사용)
        model.addAttribute("search", notice);
	}

	/**
	 * 게시판관리 추가 or 수정
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/noticeReg", method=RequestMethod.POST)
	public String noticeReg(NoticeVO notice, RedirectAttributes redirectAttr) throws Exception {
		// 로그인 된 정보
		MemberVO loginUser = (MemberVO)LoginHelper.getLoginInfo();

		// 메일 발송과 별개로 올레측 DB에 저장한다.
		notice.setRegUser(loginUser);
		notice.setUpdUser(loginUser);

		boardService.noticeReg(notice);

		// 검색 조건 저장(notice 자체는 저장용 데이터를 가지고 있으므로 검색용 데이터를 내부에 search 변수로 저장 시켜둠)
        redirectAttr.addFlashAttribute("search", notice.getSearch());
		return "redirect:/board/noticeList";
	}

	/**
	 * 게시물 삭제
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/noticeDel", method=RequestMethod.POST)
    public String noticeDel(NoticeVO notice, RedirectAttributes redirectAttr) throws Exception {
        boardService.noticeDel(notice);

        // 검색 조건 저장
        redirectAttr.addFlashAttribute("search", notice);
        return "redirect:/board/noticeList";
    }

	/**
     * 게시물 사용 여부 상태값 변경 API
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/noticeUseChange", method=RequestMethod.POST)
    public @ResponseBody int noticeUseChange(@RequestBody MultiRequest<NoticeVO> multiRequest) throws Exception {
        int result = 0;

        if(multiRequest.getList() != null && multiRequest.getList().size() > 0) {
            // 로그인 된 정보
            MemberVO loginUser = (MemberVO)LoginHelper.getLoginInfo();

            // 로그인 된 유저 정보 입력
            multiRequest.getList().get(0).setUpdUser(loginUser);

            // 변경처리
            result = boardService.noticeUseChange(multiRequest.getList());
        }

        return result;
    }
}

