-- DATETIME에 DEFAULT CURRENT_TIMESTAMP 는 mysql 5.6버전 이상부터 가능
-- AUTO_INCREMENT 와 DEFAULT 는 5버전 이상부터는 같이 사용 불가
CREATE TABLE CB_MEMBER (
	SEQ					INT(12)			AUTO_INCREMENT	UNIQUE		COMMENT 'MEMBER 마스터 SEQ',
	ID					VARCHAR(100)	PRIMARY KEY					COMMENT 'MEMBER ID',
	PW					VARCHAR(100)								COMMENT 'MEMBER 계정 비밀번호',
	NAME				VARCHAR(50)									COMMENT 'MEMBER명',
	LOCALE				CHAR(2)			DEFAULT 'ko' 				COMMENT '사용자 언어 (ko/en/zh/ja)',
	SNS_CD				CHAR(2) 									COMMENT 'SNS 서비스: 페이스북 FB/ 인스타그램 IG/ 카카오스토리 KS/ 트위터 TW/ 구글플러스 GP/ 네이버 NV',
  	SNS_ID				VARCHAR(50) 								COMMENT 'SNS 사용자 ID',
  	SNS_URL				VARCHAR(255) 								COMMENT 'SNS 프로파일 URL',
  	ACCEPT_SNS			CHAR(1) 		DEFAULT 'Y' 				COMMENT 'SNS 연결 여부 (Y/N)',
  	ACCEPT_EMAIL		CHAR(1)			DEFAULT 'N' 				COMMENT 'EMAIL 수신 여부 (Y/N)',
  	ACCEPT_SMS			CHAR(1)			DEFAULT 'N' 				COMMENT 'SMS 수신 여부 (Y/N)',
  	TEL					VARCHAR(50)									COMMENT '연락처',
	PHONE				VARCHAR(50)									COMMENT '핸드폰',
	FAX					VARCHAR(50)									COMMENT '팩스',
	EMAIL				VARCHAR(100)								COMMENT '이메일',
	EMAIL_YN			CHAR(1) 		DEFAULT 'N'					COMMENT '이메일 인증 여부(Y/N)',
	GENDER 				CHAR(1) 		DEFAULT 'M' 				COMMENT '성별: 남자(M), 여자(F)',
  	BIRTH_DAY 			VARCHAR(10) 								COMMENT '생년월일: 1999-01-01',
  	POST_CODE 			VARCHAR(8) 									COMMENT '우편번호(신:5자리, 구:6자리)',
  	ADDR1 				VARCHAR(200)								COMMENT '주소1: 우편번호에 연결된 주소',
  	ADDR2 				VARCHAR(200) 								COMMENT '주소2: 상세주소 (사용자 입력)',
	LAST_LOGIN			VARCHAR(14)									COMMENT '마지막 접속일',
	AUTH_KEY			VARCHAR(20)									COMMENT '랜덤 인증번호',
	SESSION_ID			VARCHAR(100)								COMMENT '생셩 된 세션 ID',
	GRADE				INT(1)			DEFAULT 1					COMMENT '멤버 등급(1 : 교원회원, 2 : 일반회원)',
	DEPT_CODE			VARCHAR(20)									COMMENT '부서코드',
	BELONG_TO			VARCHAR(500)								COMMENT '소속명칭',
	PHOTO_FILE			VARCHAR(20)									COMMENT	'사진첨부',
	PROFILE				TEXT										COMMENT '약력',
	SCHOOL_NAME			VARCHAR(255)								COMMENT '학교/기관명',
	S_TYPE				CHAR(1)										COMMENT '학교구분(1:초등, 2:중학교, 3:고등학교, 4:유치원, 5:특수학교, 6:기관)',
	E_TYPE				CHAR(1)										COMMENT '설립구분(1:국립, 2:공립, 3:사립)',
	REGION_CODE			VARCHAR(12)									COMMENT '지역 시도 교육청 분류 코드',
	POSITION			VARCHAR(10)									COMMENT '직위(교사, 수석교사, 부장교사, 교감, 교장, 장학/연구사, 장학/연구관, 원장, 원감, 기타)',
	POSITION_ETC		VARCHAR(50)									COMMENT '직위 기타',
	APP_YEAR			VARCHAR(4)									COMMENT '임용년도',
	JURISDICTION		VARCHAR(50)									COMMENT '관할교육청',
	SUBJECT				VARCHAR(50)									COMMENT '담당과목',
	SCHOOL_TEL			VARCHAR(50)									COMMENT '일반전화(학교)',
	SCHOOL_FAX			VARCHAR(50)									COMMENT '팩스번호(학교)',
	SCHOOL_POST_CODE	VARCHAR(8) 									COMMENT '우편번호(신:5자리, 구:6자리)',
  	SCHOOL_ADDR1 		VARCHAR(200)								COMMENT '주소1: 우편번호에 연결된 주소',
  	SCHOOL_ADDR2 		VARCHAR(200) 								COMMENT '주소2: 상세주소 (사용자 입력)',
	NEIS_NUM			VARCHAR(100)								COMMENT 'NEIS 개인번호',
	ORDER_NUM			INT(3)			DEFAULT 1					COMMENT '순서(필요없음)',
	USE_YN				CHAR(1)			DEFAULT 'Y'					COMMENT '사용여부(Y : 사용, N : 미사용)',
	REG_DATE			VARCHAR(14)									COMMENT '등록일자',
	UPD_DATE		  	VARCHAR(14)									COMMENT '수정일자'
) COMMENT='MEMBER MASTER TABLE';