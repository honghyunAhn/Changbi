package forFaith.dev.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import forFaith.dev.dao.AttachFileDAO;
import forFaith.dev.dao.BoardDAO;
import forFaith.dev.vo.AttachFileVO;
import forFaith.dev.vo.BoardVO;
import forFaith.dev.vo.NoticeVO;
import forFaith.util.StringUtil;

@Service(value="forFaith.boardService")
public class BoardService {

	@Autowired
	private BoardDAO boardDao;

	@Autowired
	private AttachFileDAO fileDao;

	//게시판관리 목록
	public List<BoardVO> boardList(BoardVO board) throws Exception{
		return boardDao.boardList(board);
	}

	// 게시판 리스트 총 갯수
    public int boardTotalCnt(BoardVO board) throws Exception {
        return boardDao.boardTotalCnt(board);
    }

	//게시판 관리  정보
	public BoardVO boardInfo(BoardVO board) throws Exception {
	    return boardDao.boardInfo(board);
	}

	//게시판관리 등록
	public void boardReg(BoardVO board) throws Exception {
		// ID 가 존재하지 않으면 저장 있으면 update
		boardDao.boardReg(board);
	}

	//게시판관리 삭제
	public int boardDel(BoardVO board) throws Exception{
		return boardDao.boardDel(board);
	}

	// 게시판 사용 여부 변경
    public int boardUseChange(List<BoardVO> boardList) throws Exception {
        return boardDao.boardUseChange(boardList);
    }

    //게시물목록
	public List<NoticeVO> noticeList(NoticeVO notice) throws Exception{
		return boardDao.noticeList(notice);
	}

    //게시물 토탈 카운트
	public int noticeTotalCnt(NoticeVO notice) throws Exception{
		return boardDao.noticeTotalCnt(notice);
	}

	//게시물상세정보
	public NoticeVO noticeInfo(NoticeVO notice) throws Exception {
		return boardDao.noticeInfo(notice);
	}

	//게시물 등록
	public void noticeReg(NoticeVO notice) throws Exception {
		// ID 가 존재하지 않으면 저장 있으면 update
		boardDao.noticeReg(notice);

		// ID가 생성 또는 update 라면 detail insert 또는 upadate
		if(!StringUtil.isEmpty(notice)) {
		    // 파일 사용 가능 상태로 변경 처리
            // useYn을 Y로 바꾼다.
            List<AttachFileVO> attachFileList = new ArrayList<AttachFileVO>();

            // 파일 ID가 정상적으로 insert 되고 나면 useYn 을 Y로 바꿔준다.(파일을 사용한다는 의미)
            if(notice.getUploadFile() != null && !StringUtil.isEmpty(notice.getUploadFile().getFileId())) {
                attachFileList.add(notice.getUploadFile());
            }

            // 파일 사용 가능 상태로 변경
            if(attachFileList.size() > 0) {
                fileDao.attachFileUse(attachFileList);
            }
		}

	}

	//게시물 삭제
	public int noticeDel(NoticeVO notice) throws Exception{
	    return boardDao.noticeDel(notice);
	}

	// 게시물 사용 여부 변경
    public int noticeUseChange(List<NoticeVO> noticeList) throws Exception {
        return boardDao.noticeUseChange(noticeList);
    }
}
