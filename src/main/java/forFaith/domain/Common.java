package forFaith.domain;

import forFaith.dev.vo.MemberVO;

/**
 * @Class Name : Common.java
 * @Description : 조회 데이터 기본 구성(조회조건이 따라 붙음)
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
public class Common extends Search {

    /** Hyperlink(연결 시킬 URL) */
    private String link;

    /** 메시지(화면에 뿌려줄 메시지 저장) */
    private String msg;
    
    /** 로그인 멤버 정보 */
    private MemberVO loginUser;
    
    /** 스프링 파일 업로드 기능 제공 */
    private SpringFileUpload springFileUpload;

	public String getLink() {
        return link;
    }

    public void setLink(String link) {
        this.link = link;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

	public MemberVO getLoginUser() {
		return loginUser;
	}

	public void setLoginUser(MemberVO loginUser) {
		this.loginUser = loginUser;
	}

	public SpringFileUpload getSpringFileUpload() {
		return springFileUpload;
	}

	public void setSpringFileUpload(SpringFileUpload springFileUpload) {
		this.springFileUpload = springFileUpload;
	}
}