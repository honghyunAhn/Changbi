package forFaith.dev.vo;

import java.util.List;

/**
 * @Class Name : MemberVO.java
 * @Description : 사용자정보
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
public class MemberVO extends CommonVO {
	// 검색조건
    private MemberVO search;
    private String searchMemberCode;            // 조회 용 그룹 코드 ID

    // 사용자 정보(고객, 관리자 공통)
	private String id;	    					// 사용자 접속 ID
	private String pw;							// 사용자 비밀번호
	private String name;						// 사용자 명
	private String locale;						// 사용자언어(ko/en/ch/ja default ko)
	private String snsCd;						// SNS 서비스(페북 : fb / 인스타그램 : ig / 카카오스토리 : ks / 트위터 : tw / 구글플러스 : gp / 네이버 : nv / 제주올레 jo)
	private String snsId;						// SNS 사용자 ID
	private String snsUrl;						// SNS 프로파일 URL
	private String acceptSns = "Y";				// SNS 연결여부(Y/N)
	private String acceptEmail = "N";			// eMail 수신여부(Y/N)
	private String acceptSms = "N";				// SMS 수신여부(Y/N)
	private String tel;							// 전화번호
	private String phone;						// 핸드폰
	private String fax;							// 팩스번호
	private String email;						// 이메일
	private String emailYn = "N";				// 이메일 인증여부(Y/N)
	private String gender = "M";				// 성별(남 : M / 여 : F)
	private String birthDay;					// 생년월일(19990101)
	private String postCode;					// 우편번호
	private String addr1;						// 주소1
	private String addr2;						// 주소2
	private String lastLogin;					// 마지막 접속일(1년 경과시 휴면처리)
	private String authKey;						// 랜덤 인증번호
	private String sessionId;					// 세션 ID
	private int grade;                          // 멤버 등급(1 : 일반사용자, 8 : 일반관리자, 9 : 최고관리자)
	private String belongTo;					// 소속단체 명
	private String profile;						// 약력
	private String ipAddress;					// 접속 IP 주소

	private AttachFileVO photoFile;				// 사진 파일
	private CodeVO courseCode;					// 과정분류
	private CodeVO deptCode;                    // 관리자인 경우 부서 코드

	private List<CodeVO> memberGroupList;		// 멤버 그룹 코드 리스트

    public MemberVO getSearch() {
        return search;
    }

    public void setSearch(MemberVO search) {
        this.search = search;
    }

    public String getSearchMemberCode() {
        return searchMemberCode;
    }

    public void setSearchMemberCode(String searchMemberCode) {
        this.searchMemberCode = searchMemberCode;
    }

    public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPw() {
		return pw;
	}

	public void setPw(String pw) {
		this.pw = pw;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getLocale() {
        return locale;
    }

    public void setLocale(String locale) {
        this.locale = locale;
    }

    public String getSnsCd() {
        return snsCd;
    }

    public void setSnsCd(String snsCd) {
        this.snsCd = snsCd;
    }

    public String getSnsId() {
        return snsId;
    }

    public void setSnsId(String snsId) {
        this.snsId = snsId;
    }

    public String getSnsUrl() {
        return snsUrl;
    }

    public void setSnsUrl(String snsUrl) {
        this.snsUrl = snsUrl;
    }

    public String getAcceptSns() {
        return acceptSns;
    }

    public void setAcceptSns(String acceptSns) {
        this.acceptSns = acceptSns;
    }

    public String getAcceptEmail() {
        return acceptEmail;
    }

    public void setAcceptEmail(String acceptEmail) {
        this.acceptEmail = acceptEmail;
    }

    public String getAcceptSms() {
        return acceptSms;
    }

    public void setAcceptSms(String acceptSms) {
        this.acceptSms = acceptSms;
    }

    public String getTel() {
		return tel;
	}

	public void setTel(String tel) {
		this.tel = tel;
	}

	public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getFax() {
		return fax;
	}

	public void setFax(String fax) {
		this.fax = fax;
	}

	public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getEmailYn() {
        return emailYn;
    }

    public void setEmailYn(String emailYn) {
        this.emailYn = emailYn;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getBirthDay() {
        return birthDay;
    }

    public void setBirthDay(String birthDay) {
        this.birthDay = birthDay;
    }

    public String getPostCode() {
        return postCode;
    }

    public void setPostCode(String postCode) {
        this.postCode = postCode;
    }

    public String getAddr1() {
        return addr1;
    }

    public void setAddr1(String addr1) {
        this.addr1 = addr1;
    }

    public String getAddr2() {
        return addr2;
    }

    public void setAddr2(String addr2) {
        this.addr2 = addr2;
    }

	public String getLastLogin() {
        return lastLogin;
    }

    public void setLastLogin(String lastLogin) {
        this.lastLogin = lastLogin;
    }

    public String getAuthKey() {
        return authKey;
    }

    public void setAuthKey(String authKey) {
        this.authKey = authKey;
    }

    public String getSessionId() {
		return sessionId;
	}

	public void setSessionId(String sessionId) {
		this.sessionId = sessionId;
	}

	public int getGrade() {
        return grade;
    }

    public void setGrade(int grade) {
        this.grade = grade;
    }
    
    public String getBelongTo() {
		return belongTo;
	}

	public void setBelongTo(String belongTo) {
		this.belongTo = belongTo;
	}
	
    public String getProfile() {
		return profile;
	}

	public void setProfile(String profile) {
		this.profile = profile;
	}

	public String getIpAddress() {
		return ipAddress;
	}

	public void setIpAddress(String ipAddress) {
		this.ipAddress = ipAddress;
	}

	public AttachFileVO getPhotoFile() {
		return photoFile;
	}

	public void setPhotoFile(AttachFileVO photoFile) {
		this.photoFile = photoFile;
	}

	public CodeVO getCourseCode() {
		return courseCode;
	}

	public void setCourseCode(CodeVO courseCode) {
		this.courseCode = courseCode;
	}

	public CodeVO getDeptCode() {
        return deptCode;
    }

    public void setDeptCode(CodeVO deptCode) {
        this.deptCode = deptCode;
    }

	public List<CodeVO> getMemberGroupList() {
		return memberGroupList;
	}

	public void setMemberGroupList(List<CodeVO> memberGroupList) {
		this.memberGroupList = memberGroupList;
	}

	@Override
	public String toString() {
		return "MemberVO [search=" + search + ", searchMemberCode=" + searchMemberCode + ", id=" + id + ", pw=" + pw
				+ ", name=" + name + ", locale=" + locale + ", snsCd=" + snsCd + ", snsId=" + snsId + ", snsUrl="
				+ snsUrl + ", acceptSns=" + acceptSns + ", acceptEmail=" + acceptEmail + ", acceptSms=" + acceptSms
				+ ", tel=" + tel + ", phone=" + phone + ", fax=" + fax + ", email=" + email + ", emailYn=" + emailYn
				+ ", gender=" + gender + ", birthDay=" + birthDay + ", postCode=" + postCode + ", addr1=" + addr1
				+ ", addr2=" + addr2 + ", lastLogin=" + lastLogin + ", authKey=" + authKey + ", sessionId=" + sessionId
				+ ", grade=" + grade + ", belongTo=" + belongTo + ", profile=" + profile + ", ipAddress=" + ipAddress
				+ ", photoFile=" + photoFile + ", courseCode=" + courseCode + ", deptCode=" + deptCode
				+ ", memberGroupList=" + memberGroupList + "]";
	}
	
	
}
