package com.changbi.tt.dev.data.vo;

import forFaith.dev.vo.AttachFileVO;
import forFaith.dev.vo.CodeVO;
import forFaith.dev.vo.CommonVO;

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
public class UserVO extends CommonVO {
	// 검색조건
    private UserVO search;
    
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
	private int grade;                          // 멤버 등급(1 : 교원회원, 2 : 일반회원)
	private String belongTo;					// 소속단체 명
	private String profile;						// 약력
	private String schoolName;					// 학교/기관명
	private String sType;						// 학교구분(1:초등, 2:중학교, 3:고등학교, 4:유치원, 5:특수학교, 6:기관)
	private String eType;						// 설립구분(1:국립, 2:공립, 3:사립)
	private String position;					// 직위(교사, 수석교사, 부장교사, 교감, 교장, 장학/연구사, 장학/연구관, 원장, 원감, 기타)
	private String positionEtc;					// 직위 기타 설명
	private String appYear;						// 임용년도
	private String jurisdiction;				// 관할교육청
	private String subject;						// 담당과목
	private String schoolTel;					// 일반전화(학교)
	private String schoolFax;					// 팩스번호(학교)
	private String schoolPostCode;				// 우편번호(신:5자리, 구:6자리)
	private String schoolAddr1;					// 주소1: 우편번호에 연결된 주소
	private String schoolAddr2;					// 주소2: 상세주소 (사용자 입력)
	private String neisNum;						// NEIS 개인번호
	private String userFlag;                        // 멤버 등급(fap DB설계 A01 참고)
	private AttachFileVO photoFile;				// 사진 파일
	private CodeVO regionCode;					// 지역 시도 교육청 분류 코드
	private CodeVO deptCode;					// 사무실 분류 코드
	
    public UserVO getSearch() {
        return search;
    }

    public void setSearch(UserVO search) {
        this.search = search;
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

	public String getSchoolName() {
		return schoolName;
	}

	public void setSchoolName(String schoolName) {
		this.schoolName = schoolName;
	}

	public String getsType() {
		return sType;
	}

	public void setsType(String sType) {
		this.sType = sType;
	}

	public String geteType() {
		return eType;
	}

	public void seteType(String eType) {
		this.eType = eType;
	}

	public String getPosition() {
		return position;
	}

	public void setPosition(String position) {
		this.position = position;
	}

	public String getPositionEtc() {
		return positionEtc;
	}

	public void setPositionEtc(String positionEtc) {
		this.positionEtc = positionEtc;
	}

	public String getAppYear() {
		return appYear;
	}

	public void setAppYear(String appYear) {
		this.appYear = appYear;
	}

	public String getJurisdiction() {
		return jurisdiction;
	}

	public void setJurisdiction(String jurisdiction) {
		this.jurisdiction = jurisdiction;
	}

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public String getSchoolTel() {
		return schoolTel;
	}

	public void setSchoolTel(String schoolTel) {
		this.schoolTel = schoolTel;
	}

	public String getSchoolFax() {
		return schoolFax;
	}

	public void setSchoolFax(String schoolFax) {
		this.schoolFax = schoolFax;
	}

	public String getSchoolPostCode() {
		return schoolPostCode;
	}

	public void setSchoolPostCode(String schoolPostCode) {
		this.schoolPostCode = schoolPostCode;
	}

	public String getSchoolAddr1() {
		return schoolAddr1;
	}

	public void setSchoolAddr1(String schoolAddr1) {
		this.schoolAddr1 = schoolAddr1;
	}

	public String getSchoolAddr2() {
		return schoolAddr2;
	}

	public void setSchoolAddr2(String schoolAddr2) {
		this.schoolAddr2 = schoolAddr2;
	}

	public String getNeisNum() {
		return neisNum;
	}

	public void setNeisNum(String neisNum) {
		this.neisNum = neisNum;
	}

	public AttachFileVO getPhotoFile() {
		return photoFile;
	}

	public void setPhotoFile(AttachFileVO photoFile) {
		this.photoFile = photoFile;
	}

	public CodeVO getRegionCode() {
		return regionCode;
	}

	public void setRegionCode(CodeVO regionCode) {
		this.regionCode = regionCode;
	}

	public CodeVO getDeptCode() {
		return deptCode;
	}

	public void setDeptCode(CodeVO deptCode) {
		this.deptCode = deptCode;
	}
	
	public String getUserFlag() {
		return userFlag;
	}

	public void setUserFlag(String userFlag) {
		this.userFlag = userFlag;
	}

	@Override
	public String toString() {
		return "UserVO [search=" + search + ", id=" + id + ", pw=" + pw + ", name=" + name + ", locale=" + locale
				+ ", snsCd=" + snsCd + ", snsId=" + snsId + ", snsUrl=" + snsUrl + ", acceptSns=" + acceptSns
				+ ", acceptEmail=" + acceptEmail + ", acceptSms=" + acceptSms + ", tel=" + tel + ", phone=" + phone
				+ ", fax=" + fax + ", email=" + email + ", emailYn=" + emailYn + ", gender=" + gender + ", birthDay="
				+ birthDay + ", postCode=" + postCode + ", addr1=" + addr1 + ", addr2=" + addr2 + ", lastLogin="
				+ lastLogin + ", authKey=" + authKey + ", sessionId=" + sessionId + ", grade=" + grade + ", belongTo="
				+ belongTo + ", profile=" + profile + ", schoolName=" + schoolName + ", sType=" + sType + ", eType="
				+ eType + ", position=" + position + ", positionEtc=" + positionEtc + ", appYear=" + appYear
				+ ", jurisdiction=" + jurisdiction + ", subject=" + subject + ", schoolTel=" + schoolTel
				+ ", schoolFax=" + schoolFax + ", schoolPostCode=" + schoolPostCode + ", schoolAddr1=" + schoolAddr1
				+ ", schoolAddr2=" + schoolAddr2 + ", neisNum=" + neisNum + ", userFlag=" + userFlag + ", photoFile="
				+ photoFile + ", regionCode=" + regionCode + ", deptCode=" + deptCode + "]";
	}

	 
	
}
