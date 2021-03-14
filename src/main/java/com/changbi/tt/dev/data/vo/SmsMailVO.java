package com.changbi.tt.dev.data.vo;

import forFaith.dev.vo.CommonVO;

/**
 * @Class Name : SmsMailVO.java
 * @Description : SMS MAIL 발송 정보
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
public class SmsMailVO extends CommonVO {
	// 검색조건
    private SmsMailVO search;
    
    private String id;					// 수신자 ID
    private String name;				// 수신자 명
	private String phone;				// 수신자 핸드폰
	private String email;				// 수신자 이메일
	private String type;				// EMAIL인 경우 1, SMS 인 경우 2(default로 EMAIL)
	
    public SmsMailVO getSearch() {
        return search;
    }

    public void setSearch(SmsMailVO search) {
        this.search = search;
    }

    public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
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

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}
}
