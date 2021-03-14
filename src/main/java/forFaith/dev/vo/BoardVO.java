package forFaith.dev.vo;

/**
 * @Class Name : BoardVO.java
 * @Description : 게시판 정보
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

@SuppressWarnings("serial")
public class BoardVO extends CommonVO {
    // 검색조건(자기자신의 검색 조건을 객체로 가지고 있음)
    private BoardVO search;

	private String id;             // BOARD_ID
	private String boardType;      // 게시판 유형(N:일반게시판, B:블로그, G:갤러리)-당장 사용안함
	private String title;          // 다국어가 필요한 경우 다국어 테이블 객체를 가짐
	private String answerYn;       // 답글 여부(Y/N)
	private String commentYn;      // 댓글 여부(Y/N)
	private String recommendYn;    // 추천 여부(Y/N)
	private String nonrecommendYn; // 비추천 여부(Y/N)
	private String snsYn;          // SNS 사용여부(Y/N)
	private String listAuth;       // 목록보기 권한(1 : 모두, 2 : 회원, 3 : 관리자)
	private String readAuth;   	   // 읽기 권한(1 : 모두, 2 : 회원, 3 : 관리자)
	private String commentAuth;    // 댓글쓰기 권한(1 : 모두, 2 : 회원, 3 : 관리자)
	private String writeAuth;      // 글쓰기 권한(1 : 모두, 2 : 회원, 3 : 관리자)
	private int fileCnt;           // 업로드 파일 갯수
	private int fileSize;          // 업로드 파일 용량(M)

    public BoardVO getSearch() {
        return search;
    }

    public void setSearch(BoardVO search) {
        this.search = search;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getBoardType() {
        return boardType;
    }

    public void setBoardType(String boardType) {
        this.boardType = boardType;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getAnswerYn() {
        return answerYn;
    }

    public void setAnswerYn(String answerYn) {
        this.answerYn = answerYn;
    }

    public String getCommentYn() {
        return commentYn;
    }

    public void setCommentYn(String commentYn) {
        this.commentYn = commentYn;
    }

    public String getRecommendYn() {
        return recommendYn;
    }

    public void setRecommendYn(String recommendYn) {
        this.recommendYn = recommendYn;
    }

    public String getNonrecommendYn() {
        return nonrecommendYn;
    }

    public void setNonrecommendYn(String nonrecommendYn) {
        this.nonrecommendYn = nonrecommendYn;
    }

    public String getSnsYn() {
        return snsYn;
    }

    public void setSnsYn(String snsYn) {
        this.snsYn = snsYn;
    }

    public String getListAuth() {
        return listAuth;
    }

    public void setListAuth(String listAuth) {
        this.listAuth = listAuth;
    }

    public String getReadAuth() {
        return readAuth;
    }

    public void setReadAuth(String readAuth) {
        this.readAuth = readAuth;
    }

    public String getCommentAuth() {
        return commentAuth;
    }

    public void setCommentAuth(String commentAuth) {
        this.commentAuth = commentAuth;
    }

    public String getWriteAuth() {
        return writeAuth;
    }

    public void setWriteAuth(String writeAuth) {
        this.writeAuth = writeAuth;
    }

    public int getFileCnt() {
        return fileCnt;
    }

    public void setFileCnt(int fileCnt) {
        this.fileCnt = fileCnt;
    }

    public int getFileSize() {
        return fileSize;
    }

    public void setFileSize(int fileSize) {
        this.fileSize = fileSize;
    }
}
