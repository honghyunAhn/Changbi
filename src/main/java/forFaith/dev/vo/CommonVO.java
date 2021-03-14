package forFaith.dev.vo;

import forFaith.domain.Common;

/**
 * @Class Name : CommonVO.java
 * @Description : 공통 정보
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
public class CommonVO extends Common {

    /** SEQ 번호(ID로 사용해도 됨 : 비추천) */
    private int seq;

    /** 순서 - default 1로 설정 */
	private int orderNum = 1;

	/** 사용여부(Y/N) - default 로 Y로 설정 */
	private String useYn = "Y";

	/** 등록자 계정 ID */
	private MemberVO regUser;

	/** 등록일자 */
	private String regDate;

	/** 수정자 계정 ID */
	private MemberVO updUser;

	/** 수정일자 */
	private String updDate;

	public int getSeq() {
        return seq;
    }

    public void setSeq(int seq) {
        this.seq = seq;
    }

    public int getOrderNum() {
		return orderNum;
	}

	public void setOrderNum(int orderNum) {
		this.orderNum = orderNum;
	}

	public String getUseYn() {
		return useYn;
	}

	public void setUseYn(String useYn) {
		this.useYn = useYn;
	}

	public MemberVO getRegUser() {
		return regUser;
	}

	public void setRegUser(MemberVO regUser) {
		this.regUser = regUser;
	}

	public String getRegDate() {
		return regDate;
	}

	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}

	public MemberVO getUpdUser() {
		return updUser;
	}

	public void setUpdUser(MemberVO updUser) {
		this.updUser = updUser;
	}

	public String getUpdDate() {
		return updDate;
	}

	public void setUpdDate(String updDate) {
		this.updDate = updDate;
	}
}