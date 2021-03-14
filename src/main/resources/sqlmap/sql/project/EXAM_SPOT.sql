-- DATETIME에 DEFAULT CURRENT_TIMESTAMP 는 mysql 5.6버전 이상부터 가능
-- AUTO_INCREMENT 와 DEFAULT 는 5버전 이상부터는 같이 사용 불가
CREATE TABLE CB_EXAM_SPOT (
	SEQ					INT(12)			AUTO_INCREMENT	UNIQUE		COMMENT '고사장 마스터 SEQ',
	ID					VARCHAR(3)		PRIMARY KEY					COMMENT '고사장 ID(무조건 3자리 숫자로만듬)',
	MAP_FILE			VARCHAR(20)									COMMENT '약도이미지 파일',
	NAME				VARCHAR(100)	NOT NULL					COMMENT '고사장명',
	SPOT				VARCHAR(100)								COMMENT '장소명',
	POST_CODE 			VARCHAR(8) 									COMMENT '우편번호(신:5자리, 구:6자리)',
  	ADDR1 				VARCHAR(200)								COMMENT '주소1: 우편번호에 연결된 주소',
  	ADDR2 				VARCHAR(200) 								COMMENT '주소2: 상세주소 (사용자 입력)',
  	TEL					VARCHAR(50)									COMMENT '연락처',
  	LIMIT_NUM			INT(3)			DEFAULT 0					COMMENT '신청제한인원(0이면 제한없음)',
  	APP_AREA			VARCHAR(500)								COMMENT '해당지역(인근 응시가능지역을 참조로 적는 항목일 뿐 어떠한 제한기능도 포함되어 있지 않음)',
  	TRAFFIC				TEXT										COMMENT '교통안내',	
	ORDER_NUM			INT(3)			DEFAULT 1					COMMENT '순서',
	USE_YN				CHAR(1)			DEFAULT 'Y'					COMMENT '서비스상태(Y : 사용, N : 미사용)',
	REG_USER        	VARCHAR(100)                             	COMMENT '등록자 ID',
	REG_DATE			DATETIME		DEFAULT CURRENT_TIMESTAMP()	COMMENT '등록일자',
  	UPD_USER        	VARCHAR(100)                             	COMMENT '수정자 ID',
	UPD_DATE		  	DATETIME		DEFAULT CURRENT_TIMESTAMP()	COMMENT '수정일자'
) COMMENT='고사장 관리 테이블';