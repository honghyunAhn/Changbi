-- DATETIME에 DEFAULT CURRENT_TIMESTAMP 는 mysql 5.6버전 이상부터 가능
-- AUTO_INCREMENT 와 DEFAULT 는 5버전 이상부터는 같이 사용 불가
CREATE TABLE CB_QUIZ_ITEM (
	ID					INT(12)			AUTO_INCREMENT	PRIMARY KEY	COMMENT '시험지 문항 ID',
	QUIZ_POOL_ID		INT(12)			NOT NULL					COMMENT '시험지 풀 ID',
	QUIZ_BANK_ID		INT(12)			NOT NULL					COMMENT '문제 은행 ID',
	ORDER_NUM			INT(3)			DEFAULT 1					COMMENT '문제순서',
	USE_YN				CHAR(1)			DEFAULT 'Y'					COMMENT '사용여부(Y : 사용, N : 미사용)',
	REG_USER        	VARCHAR(100)                             	COMMENT '등록자 ID',
	REG_DATE			DATETIME		DEFAULT CURRENT_TIMESTAMP()	COMMENT '등록일자',
  	UPD_USER        	VARCHAR(100)                             	COMMENT '수정자 ID',
	UPD_DATE		  	DATETIME		DEFAULT CURRENT_TIMESTAMP()	COMMENT '수정일자'
) COMMENT='시험지 문제 관리 테이블';