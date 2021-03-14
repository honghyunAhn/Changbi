-- DATETIME에 DEFAULT CURRENT_TIMESTAMP 는 mysql 5.6버전 이상부터 가능
-- AUTO_INCREMENT 와 DEFAULT 는 5버전 이상부터는 같이 사용 불가
CREATE TABLE CB_QUIZ_POOL (
	ID					INT(12)			AUTO_INCREMENT	PRIMARY KEY	COMMENT '시험지 POOL ID',
	COURSE_ID			VARCHAR(12)		NOT NULL					COMMENT '과정 ID',
	TITLE				VARCHAR(100)	NOT NULL					COMMENT '시험지 풀 명',
	QUIZ_TYPE			CHAR(1)			DEFAULT '2'					COMMENT '시험 종류(1:출석고사, 2:온라인평가, 3:온라인과제)',
	ORDER_NUM			INT(3)			DEFAULT 1					COMMENT '순서(필요없음)',
	USE_YN				CHAR(1)			DEFAULT 'Y'					COMMENT '시험상태(Y : 사용, N : 사용안함)',
	REG_USER        	VARCHAR(100)                             	COMMENT '등록자 ID',
	REG_DATE			DATETIME		DEFAULT CURRENT_TIMESTAMP()	COMMENT '등록일자',
  	UPD_USER        	VARCHAR(100)                             	COMMENT '수정자 ID',
	UPD_DATE		  	DATETIME		DEFAULT CURRENT_TIMESTAMP()	COMMENT '수정일자'
) COMMENT='시험지 풀 관리(과정별로 관리) 테이블';