package forFaith.dev.vo;

/**
 * @Class Name : NoticeVO.java
 * @Description : 게시물 정보
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
public class NoticeVO extends CommonVO {
    // 검색조건(자기자신과 동일한 형태의 객체)
    private NoticeVO search;

	private Integer id;			// 게시물 ID
	private String lang;		// 게시물 언어(코드 든 타입이든.. 현재는 타입으로 설정되어있음)
	private String title;		// 게시물 명
	private String name;		// 작성자
	private String phone;		// 연락처
	private String email;		// 이메일
	private String comment;		// 게시물 내용
	private int hits;			// 조회수
	private int recommend;		// 추천수
	private int nonrecommend;	// 비추천수
	private int share;			// 공유횟수

	private BoardVO board;             // 게시판 형태
	private CodeVO noticeCode;         // 게시물 구분 코드
	private CodeVO inquiryCode;        // 문의 구분 코드(문의게시판인 경우 문의 구분)
	private AttachFileVO uploadFile;   // 업로드 이미지

    public NoticeVO getSearch() {
        return search;
    }

    public void setSearch(NoticeVO search) {
        this.search = search;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getLang() {
        return lang;
    }

    public void setLang(String lang) {
        this.lang = lang;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public int getHits() {
        return hits;
    }

    public void setHits(int hits) {
        this.hits = hits;
    }

    public int getRecommend() {
        return recommend;
    }

    public void setRecommend(int recommend) {
        this.recommend = recommend;
    }

    public int getNonrecommend() {
        return nonrecommend;
    }

    public void setNonrecommend(int nonrecommend) {
        this.nonrecommend = nonrecommend;
    }

    public int getShare() {
        return share;
    }

    public void setShare(int share) {
        this.share = share;
    }

    public BoardVO getBoard() {
        return board;
    }

    public void setBoard(BoardVO board) {
        this.board = board;
    }

    public CodeVO getNoticeCode() {
        return noticeCode;
    }

    public void setNoticeCode(CodeVO noticeCode) {
        this.noticeCode = noticeCode;
    }

    public CodeVO getInquiryCode() {
		return inquiryCode;
	}

	public void setInquiryCode(CodeVO inquiryCode) {
		this.inquiryCode = inquiryCode;
	}

	public AttachFileVO getUploadFile() {
        return uploadFile;
    }

    public void setUploadFile(AttachFileVO uploadFile) {
        this.uploadFile = uploadFile;
    }
}
